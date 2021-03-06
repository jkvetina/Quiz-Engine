CREATE OR REPLACE PACKAGE BODY quiz AS

    PROCEDURE prepare_items AS
    BEGIN
        app.log_module();

        -- find first empty, then bookmarked question
        IF app.get_item('$QUESTION_ID') IS NULL THEN
            app.set_item('$QUESTION_ID', quiz.get_prev_next_question (
                in_test_id      => app.get_item('$TEST_ID'),
                in_question_id  => 0,
                in_bookmarked   => NULL,
                in_unanswered   => 'Y'
            ));
            --
            IF app.get_item('$QUESTION_ID') IS NULL THEN
                app.set_item('$QUESTION_ID', quiz.get_prev_next_question (
                    in_test_id      => app.get_item('$TEST_ID'),
                    in_question_id  => 0,
                    in_bookmarked   => 'Y',
                    in_unanswered   => NULL
                ));
            END IF;
        END IF;

        -- load data
        app.set_item('$QUESTION',          '');
        app.set_item('$ANSWER',            '');
        app.set_item('$EXPLANATION',       '');
        app.set_item('$SHOW_CORRECT_FLAG', '');
        app.set_item('$TO_VERIFY',         '');
        app.set_item('$PUBLIC_NOTE',       '');
        app.set_item('$PRIVATE_NOTE',      '');
        --
        FOR c IN (
            SELECT t.test_name, t.test_topic
            FROM quiz_tests t
            WHERE t.test_id         = app.get_item('$TEST_ID')
        ) LOOP
            app.set_item('$TEST_NAME',     c.test_name);
            app.set_item('$TOPIC_ID',      c.test_topic);
        END LOOP;
        --
        FOR c IN (
            SELECT q.question, q.explanation, q.is_to_verify, q.public_note
            FROM quiz_questions q
            WHERE q.test_id         = app.get_item('$TEST_ID')
                AND q.question_id   = app.get_item('$QUESTION_ID')
        ) LOOP
            app.set_item('$QUESTION',      c.question);
            app.set_item('$EXPLANATION',   c.explanation);
            app.set_item('$TO_VERIFY',     c.is_to_verify);
            app.set_item('$PUBLIC_NOTE',   c.public_note);
        END LOOP;
        --
        FOR c IN (
            SELECT COUNT(*) AS questions
            FROM quiz_questions q
            WHERE q.test_id         = app.get_item('$TEST_ID')
        ) LOOP
            app.set_item('$QUESTIONS',     c.questions);
        END LOOP;

        -- previous answers
        FOR c IN (
            SELECT a.answers, a.is_bookmarked, a.private_note
            FROM quiz_attempts a
            WHERE a.user_id         = app.get_user_id()
                AND a.test_id       = app.get_item('$TEST_ID')
                AND a.question_id   = app.get_item('$QUESTION_ID')
        ) LOOP
            app.set_item('$BOOKMARKED',    c.is_bookmarked);
            app.set_item('$PRIVATE_NOTE',  c.private_note);
            --
            IF NVL(c.is_bookmarked, '-') != 'Y' THEN
            --IF (NVL(c.is_bookmarked, '-') != 'Y' OR app.get_item('$ERROR') IS NOT NULL) THEN
                app.set_item('$ANSWER', c.answers);
            END IF;
        END LOOP;

        -- correct answers
        IF (APEX_APPLICATION.G_REQUEST = 'SHOW_CORRECT' OR app.get_item('$SHOW_CORRECT') = 'Y') THEN
            FOR c IN (
                SELECT LISTAGG(a.answer_id, ':') WITHIN GROUP (ORDER BY a.answer_id) AS answers
                FROM quiz_answers a
                WHERE a.test_id         = app.get_item('$TEST_ID')
                    AND a.question_id   = app.get_item('$QUESTION_ID')
                    AND a.is_correct    = 'Y'
            ) LOOP
                app.set_item('$BOOKMARKED',    'Y');
                app.set_item('$ANSWER',        c.answers);
                app.set_item('$ERROR',         '');
            END LOOP;
            --
            IF app.get_item('$EXPLANATION') IS NOT NULL THEN
                app.set_item('$SHOW_CORRECT_FLAG', 'Y');
            END IF;
        END IF;

        -- show explanation when answer is correct, but dont flip Bookmark switch
        IF app.get_item('$ANSWER') IS NOT NULL THEN
            app.set_item('$SHOW_CORRECT',      'Y');
            app.set_item('$SHOW_CORRECT_FLAG', 'Y');
        END IF;

        -- calculate percentages
        FOR c IN (
            SELECT CASE WHEN COUNT(*) > 0 THEN ROUND(100 * (COUNT(a.is_bookmarked) / COUNT(*)), 0) ELSE 0 END AS perc
            FROM quiz_attempts a
            WHERE a.user_id         = app.get_user_id()
                AND a.test_id       = app.get_item('$TEST_ID')
        ) LOOP
            app.set_item('$BOOKMARKED_PERC', c.perc);
        END LOOP;
        --
        FOR c IN (
            SELECT NVL(ROUND(100 * (q.total - a.correct) / q.total, 0), 100) AS perc
            FROM (
                SELECT COUNT(*) AS total
                FROM quiz_questions q
                WHERE q.test_id         = app.get_item('$TEST_ID')
            ) q
            CROSS JOIN (
                SELECT COUNT(*) AS correct
                FROM quiz_attempts a
                WHERE a.user_id         = app.get_user_id()
                    AND a.test_id       = app.get_item('$TEST_ID')
                    AND a.is_correct    = 'Y'
            ) a
        ) LOOP
            app.set_item('$UNANSWERED_PERC', c.perc);
            app.set_item('$PROGRESS_PERC',   100 - c.perc);
        END LOOP;

        -- number of expected answers (as a hint or for radio/checkbox switch)
        FOR c IN (
            SELECT COUNT(*) AS answers
            FROM quiz_answers a
            WHERE a.test_id       = app.get_item('$TEST_ID')
                AND a.question_id = app.get_item('$QUESTION_ID')
                AND a.is_correct  = 'Y'
        ) LOOP
            app.set_item('$EXPECTED', c.answers);
        END LOOP;

        -- clear items after init
        app.set_item('$SHOW_CORRECT', '');
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE process_answer (
        in_answer           VARCHAR2,
        in_bookmarked       quiz_attempts.is_bookmarked%TYPE,
        in_to_verify        quiz_questions.is_to_verify%TYPE,
        in_public_note      quiz_questions.public_note%TYPE     := NULL,
        in_private_note     quiz_attempts.private_note%TYPE     := NULL
    ) AS
        rec                 quiz_attempts%ROWTYPE;
    BEGIN
        app.log_module(APEX_APPLICATION.G_REQUEST, in_answer, in_bookmarked, in_to_verify);
        --
        rec.user_id         := app.get_user_id();
        rec.test_id         := app.get_item('$TEST_ID');
        rec.question_id     := app.get_item('$QUESTION_ID');
        rec.updated_at      := SYSDATE;
        rec.is_bookmarked   := NULLIF(in_bookmarked,    'N');
        rec.counter         := 1;
        rec.private_note    := in_private_note;

        -- fix answers feature
        IF APEX_APPLICATION.G_REQUEST = 'FIX_ANSWERS' THEN  -- button name in APEX
            -- clear current answers
            UPDATE quiz_answers a
            SET a.is_correct        = NULL
            WHERE a.test_id         = rec.test_id
                AND a.question_id   = rec.question_id;

            -- add new answers
            FOR c IN (
                SELECT REGEXP_SUBSTR(':' || in_answer || ':', '([^:]+)', 1, LEVEL) AS answer
                FROM DUAL
                CONNECT BY LEVEL <= REGEXP_COUNT(in_answer, '[:]') + 1
            ) LOOP
                UPDATE quiz_answers a
                SET a.is_correct        = 'Y'
                WHERE a.test_id         = rec.test_id
                    AND a.question_id   = rec.question_id
                    AND a.answer_id     = c.answer;
                --
                app.log_warning('FIX_ANSWERS', rec.test_id, rec.question_id, c.answer, SQL%ROWCOUNT);
            END LOOP;

            -- clear verify flag
            IF NULLIF(in_to_verify, 'N') IS NULL THEN
                UPDATE quiz_questions q
                SET q.is_to_verify      = NULL,
                    q.public_note       = in_public_note
                WHERE q.test_id         = rec.test_id
                    AND q.question_id   = rec.question_id;
            END IF;
        END IF;

        -- set verify flag
        IF in_to_verify = 'Y' THEN
            UPDATE quiz_questions q
            SET q.is_to_verify      = 'Y',
                q.public_note       = in_public_note
            WHERE q.test_id         = rec.test_id
                AND q.question_id   = rec.question_id;
        ELSE
            UPDATE quiz_questions q
            SET q.public_note       = in_public_note
            WHERE q.test_id         = rec.test_id
                AND q.question_id   = rec.question_id;
        END IF;

        -- reorder answers
        SELECT LISTAGG(a.answer, ':') WITHIN GROUP (ORDER BY a.answer) INTO rec.answers
        FROM (
            SELECT REGEXP_SUBSTR(':' || in_answer || ':', '([^:]+)', 1, LEVEL) AS answer
            FROM DUAL
            CONNECT BY LEVEL <= REGEXP_COUNT(in_answer, '[:]') + 1
        ) a;

        -- check correct answer
        SELECT MAX('Y') INTO rec.is_correct
        FROM DUAL
        WHERE rec.answers IN (
            SELECT LISTAGG(a.answer_id, ':') WITHIN GROUP (ORDER BY a.answer_id) AS correct
            FROM quiz_answers a
            WHERE a.test_id         = rec.test_id
                AND a.question_id   = rec.question_id
                AND a.is_correct    = 'Y'
        );

        -- mark incorrect answer for repetition
        IF NVL(rec.is_correct, '-') != 'Y' AND rec.answers IS NOT NULL THEN
            rec.is_bookmarked   := 'Y';
        END IF;

        -- store in table
        BEGIN
            INSERT INTO quiz_attempts VALUES rec;
        EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            SELECT
                NVL(a.counter, 0) + 1,
                COALESCE(a.is_bookmarked, rec.is_bookmarked)
            INTO rec.counter, rec.is_bookmarked
            FROM quiz_attempts a
            WHERE a.user_id         = rec.user_id
                AND a.test_id       = rec.test_id
                AND a.question_id   = rec.question_id;
            --
            IF NVL(in_bookmarked, 'N') = 'N' AND rec.is_correct = 'Y' THEN
                rec.is_bookmarked   := NULL;
            END IF;
            --
            UPDATE quiz_attempts a
            SET ROW                 = rec
            WHERE a.user_id         = rec.user_id
                AND a.test_id       = rec.test_id
                AND a.question_id   = rec.question_id;
        END;

        -- throw error in learning mode
        IF NVL(rec.is_correct, '-') != 'Y' AND rec.answers IS NOT NULL THEN
            app.set_item('$BOOKMARKED',    'Y');
            app.set_item('$ERROR',         'INCORRECT_ANSWER');
            --
            --RAISE_APPLICATION_ERROR(-20000, 'INCORRECT_ANSWER');
            /*
            APEX_ERROR.ADD_ERROR (
                p_message           => 'INCORRECT_ANSWER',
                p_display_location  => APEX_ERROR.C_INLINE_IN_NOTIFICATION
            );
            */
        ELSE
            -- redirect to prev/next question
            app.set_item('$QUESTION_ID', quiz.get_prev_next_question (
                in_test_id      => rec.test_id,
                in_question_id  => rec.question_id,
                in_bookmarked   => app.get_item('$SKIP_CORRECT'),
                in_unanswered   => app.get_item('$SKIP_CORRECT'),
                in_direction    => APEX_APPLICATION.G_REQUEST
            ));

            -- clear answers for next question, clear bookmarks
            app.set_item('$ANSWER',        '');
            app.set_item('$BOOKMARKED',    '');
            app.set_item('$ERROR',         '');
        END IF;
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE clear_bookmarks
    AS
        first_question      quiz_questions.question_id%TYPE := 0;
    BEGIN
        app.log_module();
        --
        FOR c IN (
            SELECT a.question_id, a.ROWID AS rid
            FROM quiz_questions q
            JOIN quiz_attempts a
                ON a.user_id            = app.get_user_id()
                AND a.test_id           = q.test_id
                AND a.question_id       = q.question_id
                AND a.is_bookmarked     = 'Y'
            WHERE q.test_id             = app.get_item('$TEST_ID')
        ) LOOP
            DELETE FROM quiz_attempts a
            WHERE ROWID = c.rid;
            --
            first_question := LEAST(first_question, c.question_id);
        END LOOP;
        --
        first_question := NULLIF(first_question, 0);
        --
        IF first_question IS NULL THEN
            SELECT MIN(q.question_id) INTO first_question
            FROM quiz_questions q
            LEFT JOIN quiz_attempts a
                ON a.user_id            = app.get_user_id()
                AND a.test_id           = q.test_id
                AND a.question_id       = q.question_id
            WHERE q.test_id             = app.get_item('$TEST_ID')
                AND a.question_id       IS NULL;
        END IF;
        --
        app.log_success();

        -- set first empty question
        app.redirect (
            in_names    => 'P' || app.get_page_id() || '_QUESTION_ID,P' || app.get_page_id() || '_SKIP_CORRECT',
            in_values   => first_question || ',Y'
        );
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE clear_progress
    AS
        first_question      quiz_questions.question_id%TYPE := 0;
    BEGIN
        app.log_module();
        --
        DELETE FROM quiz_attempts a
        WHERE a.user_id         = app.get_user_id()
            AND a.test_id       = app.get_item('$TEST_ID')
            AND a.is_bookmarked IS NULL;
        --
        UPDATE quiz_attempts a
        SET a.answers           = NULL,
            a.is_correct        = NULL
        WHERE a.user_id         = app.get_user_id()
            AND a.test_id       = app.get_item('$TEST_ID')
            AND a.is_bookmarked = 'Y';
        --
        SELECT MIN(q.question_id) INTO first_question
        FROM quiz_questions q
        WHERE q.test_id             = app.get_item('$TEST_ID');
        --
        app.log_success();

        -- set first empty question
        app.redirect (
            in_names    => 'P' || app.get_page_id() || '_QUESTION_ID,P' || app.get_page_id() || '_SKIP_CORRECT',
            in_values   => first_question || ',Y'
        );
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    FUNCTION get_prev_next_question (
        in_test_id          quiz_questions.test_id%TYPE,
        in_question_id      quiz_questions.question_id%TYPE,
        in_bookmarked       CHAR                                := 'Y',
        in_unanswered       CHAR                                := 'Y',
        in_direction        VARCHAR2                            := quiz.next_button,
        in_user_id          VARCHAR2                            := NULL
    )
    RETURN quiz_questions.question_id%TYPE
    AS
        out_id              quiz_questions.question_id%TYPE;
    BEGIN
        app.log_module(in_test_id, in_question_id, in_bookmarked, in_unanswered, in_direction, in_user_id);

        -- find questions next on the list
        IF in_direction = next_all_button THEN
            SELECT MIN(q.question_id) INTO out_id
            FROM quiz_questions q
            LEFT JOIN quiz_attempts a
                ON a.user_id            = COALESCE(in_user_id, app.get_user_id())
                AND a.test_id           = q.test_id
                AND a.question_id       = q.question_id
            WHERE q.test_id             = in_test_id
                AND q.question_id       > in_question_id;
            --
            RETURN out_id;
        END IF;
        --
        IF in_direction = prev_all_button THEN
            SELECT MAX(q.question_id) INTO out_id
            FROM quiz_questions q
            LEFT JOIN quiz_attempts a
                ON a.user_id            = COALESCE(in_user_id, app.get_user_id())
                AND a.test_id           = q.test_id
                AND a.question_id       = q.question_id
            WHERE q.test_id             = in_test_id
                AND q.question_id       < in_question_id;
            --
            RETURN out_id;
        END IF;

        -- find empty or bookmarked questions
        SELECT
            CASE
                WHEN in_direction = quiz.prev_button THEN MAX(q.question_id)
                WHEN in_direction = quiz.next_button THEN MIN(q.question_id)
                END INTO out_id
        FROM quiz_questions q
        LEFT JOIN quiz_attempts a
            ON a.user_id            = COALESCE(in_user_id, app.get_user_id())
            AND a.test_id           = q.test_id
            AND a.question_id       = q.question_id
        WHERE q.test_id             = in_test_id
            AND 1 = CASE
                WHEN in_direction = quiz.prev_button AND q.question_id < in_question_id THEN 1
                WHEN in_direction = quiz.next_button AND q.question_id > in_question_id THEN 1
                ELSE 0 END
            AND 1 = CASE
                WHEN in_unanswered = 'Y'                AND a.answers                   IS NULL THEN 1
                WHEN in_bookmarked = 'Y'                AND a.is_bookmarked             = 'Y'   THEN 1
                WHEN NULLIF(in_bookmarked, 'N') IS NULL AND NULLIF(in_unanswered, 'N')  IS NULL THEN 1
                ELSE 0 END;
        --
        RETURN out_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL;
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE import_questions (
        in_test_id              quiz_tests.test_id%TYPE
    ) AS
        TYPE dump_lines_t       IS TABLE OF VARCHAR2(4000);
        --
        l_dump_lines            dump_lines_t := dump_lines_t();
        l_line                  VARCHAR2(4000);
        --
        l_question_id           quiz_questions.question_id%TYPE;
        l_answer_id             quiz_answers.answer_id%TYPE;
        l_search_for            CHAR;
        l_expl_limit            PLS_INTEGER;
        --
        r_question              quiz_questions%ROWTYPE;
        r_answer                quiz_answers%ROWTYPE;
        --
        PROCEDURE clob_to_lines (
            in_clob                         CLOB,
            io_array        IN OUT  NOCOPY  dump_lines_t
        ) AS
            clob_len        PLS_INTEGER     := DBMS_LOB.GETLENGTH(in_clob);
            offset          PLS_INTEGER     := 1;
            amount          PLS_INTEGER     := 32767;
            buffer          VARCHAR2(32767);
        BEGIN
            WHILE offset < clob_len LOOP
                IF INSTR(in_clob, CHR(10), offset) = 0 THEN
                    amount := clob_len - offset + 1;
                ELSE
                    amount := INSTR(in_clob, CHR(10), offset) - offset;
                END IF;
                --
                IF amount = 0 THEN
                    buffer := '';
                ELSE
                    DBMS_LOB.READ(in_clob, amount, offset, buffer);
                END IF;
                --
                io_array.EXTEND;
                io_array(io_array.LAST) := REPLACE(REPLACE(buffer, CHR(13), ''), CHR(10), '');
                --
                IF INSTR(in_clob, CHR(10), offset) = clob_len THEN
                    buffer := '';
                END IF;
                offset := offset + amount + 1;
            END LOOP;
        END;
        --
    BEGIN
        app.log_module(in_test_id);
        --
        SELECT t.data_length INTO l_expl_limit
        FROM user_tab_cols t
        WHERE t.table_name      = 'QUIZ_QUESTIONS'
            AND t.column_name   = 'EXPLANATION';
        --
        FOR c IN (
            SELECT t.*
            FROM quiz_tests t
            WHERE t.test_id = in_test_id
        ) LOOP
            l_question_id   := 0;
            l_dump_lines    := dump_lines_t();
            --
            DELETE FROM quiz_answers        WHERE test_id = c.test_id;
            DELETE FROM quiz_questions      WHERE test_id = c.test_id;
            --
            clob_to_lines(c.dump, l_dump_lines);
            --
            FOR l_row IN 1 .. l_dump_lines.COUNT LOOP
                l_line := l_dump_lines(l_row);
                --
                IF l_line LIKE 'Question %:%' THEN
                    l_search_for    := 'Q';
                    l_question_id   := NVL(l_question_id, 0) + 1;
                    l_answer_id     := 1;
                    --
                    CONTINUE;
                END IF;
                --
                IF l_line LIKE 'Explanation' THEN
                    l_search_for    := 'X';
                    --
                    CONTINUE;
                END IF;

                --
                IF (NVL(LENGTH(LTRIM(RTRIM(l_line))), 0) <= 1 OR l_line LIKE '(Correct)') THEN
                    IF l_search_for = 'Q' AND r_question.question IS NOT NULL THEN
                        DBMS_OUTPUT.PUT_LINE('');
                        DBMS_OUTPUT.PUT_LINE(r_question.question_id || ') ' || r_question.question);
                        BEGIN
                            INSERT INTO quiz_questions VALUES r_question;
                        EXCEPTION
                        WHEN OTHERS THEN
                            app.log_error('QUESTION', r_question.question_id, r_question.question);
                            app.raise_error('QUESTION #' || l_row);
                        END;
                        --
                        r_question.question         := '';
                        r_question.explanation      := '';
                        r_answer.answer             := '';
                        l_search_for                := 'A';
                        --
                    ELSIF ((l_search_for = 'A' AND r_answer.answer IS NOT NULL) OR l_line LIKE '(Correct)') THEN
                        r_answer.is_correct := CASE WHEN l_line LIKE '(Correct)' THEN 'Y' END;
                        --
                        DBMS_OUTPUT.PUT_LINE('    [' || NVL(r_answer.is_correct, '_') || '] ' || r_answer.answer);
                        BEGIN
                            INSERT INTO quiz_answers VALUES r_answer;
                        EXCEPTION
                        WHEN OTHERS THEN
                            app.raise_error('QUESTION/ANSWER', r_question.question_id, r_question.question, r_answer.is_correct, r_answer.answer);
                        END;
                        --
                        r_answer.answer             := '';
                        l_answer_id                 := l_answer_id + 1;
                    ELSIF l_search_for = 'X' THEN
                        UPDATE quiz_questions q
                        SET q.explanation       = r_question.explanation
                        WHERE q.test_id         = c.test_id
                            AND q.question_id   = l_question_id;
                    END IF;
                    --
                    CONTINUE;
                END IF;
                --
                IF l_search_for = 'Q' THEN
                    r_question.test_id      := c.test_id;
                    r_question.question_id  := l_question_id;
                    r_question.question     := LTRIM(r_question.question || CHR(10) || l_line, CHR(10));
                    r_question.explanation  := NULL;
                END IF;
                --
                IF l_search_for = 'A' THEN
                    r_answer.test_id        := c.test_id;
                    r_answer.question_id    := l_question_id;
                    r_answer.answer_id      := l_answer_id;
                    r_answer.answer         := LTRIM(r_answer.answer || CHR(10) || l_line, CHR(10));
                    r_answer.is_correct     := NULL;
                END IF;
                --
                IF l_search_for = 'X' THEN
                    BEGIN
                        r_question.explanation  := SUBSTR(LTRIM(r_question.explanation || CHR(10) || l_line, CHR(10)), 1, l_expl_limit / 2);
                    EXCEPTION
                    WHEN OTHERS THEN
                        app.log_error('EXPLANATION', r_question.question_id, r_question.question, LENGTH(r_question.explanation || CHR(10) || l_line));
                        app.raise_error('EXPLANATION #' || l_row);
                    END;
                END IF;
            END LOOP;
        END LOOP;
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE delete_test (
        in_test_id          quiz_tests.test_id%TYPE
    ) AS
    BEGIN
        app.log_module(in_test_id);

        -- delete previous test
        DELETE FROM quiz_attempts   WHERE test_id = in_test_id;
        DELETE FROM quiz_answers    WHERE test_id = in_test_id;
        DELETE FROM quiz_questions  WHERE test_id = in_test_id;
        DELETE FROM quiz_tests      WHERE test_id = in_test_id;
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE create_bookmarked_test (
        in_topic_id       quiz_tests.test_topic%TYPE,
        in_user_id          quiz_attempts.user_id%TYPE
    )
    AS
        in_test_name        CONSTANT quiz_tests.test_name%TYPE      := 'BOOKMARKED';
        --
        new_test_id         quiz_tests.test_id%TYPE;
        new_question_id     quiz_questions.question_id%TYPE         := 0;
    BEGIN
        app.log_module(in_topic_id, in_user_id);

        -- check if test exists
        SELECT MAX(t.test_id) INTO new_test_id
        FROM quiz_tests t
        WHERE t.test_name       = in_test_name
            AND t.test_topic    = in_topic_id
            AND t.dedicated_to  = in_user_id;

        -- delete previous test
        quiz.delete_test(new_test_id);

        -- create test
        IF new_test_id IS NULL THEN
            SELECT MAX(t.test_id) + 1 INTO new_test_id
            FROM quiz_tests t;
        END IF;
        --
        INSERT INTO quiz_tests (test_id, test_name, test_topic, dedicated_to, created_at)
        VALUES (
            new_test_id,
            in_test_name,
            in_topic_id,
            in_user_id,
            SYSDATE
        );

        -- find all bookmarked questions for whole group/topic
        FOR c IN (
            SELECT q.test_id, q.question_id, q.question, q.explanation
            FROM quiz_attempts a
            JOIN quiz_questions q
                ON q.test_id        = a.test_id
                AND q.question_id   = a.question_id
            WHERE a.user_id         = in_user_id
                AND a.is_bookmarked = 'Y'
                AND a.test_id       IN (
                    SELECT t.test_id
                    FROM quiz_tests t
                    WHERE t.test_topic      = in_topic_id
                        AND t.test_name     != in_test_name
                )
            ORDER BY a.test_id, a.question_id
        ) LOOP
            new_question_id := new_question_id + 1;

            -- create questions
            INSERT INTO quiz_questions (test_id, question_id, question, explanation)
            VALUES (
                new_test_id,
                new_question_id,
                c.question,
                c.explanation
            );

            -- create answers
            FOR d IN (
                SELECT a.answer_id, a.answer, a.is_correct
                FROM quiz_answers a
                WHERE a.test_id         = c.test_id
                    AND a.question_id   = c.question_id
            ) LOOP
                INSERT INTO quiz_answers (test_id, question_id, answer_id, answer, is_correct)
                VALUES (
                    new_test_id,
                    new_question_id,
                    d.answer_id,
                    d.answer,
                    d.is_correct
                );
            END LOOP;
        END LOOP;
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE save_notes (
        in_cert_id          plan_certifications_notes.cert_id%TYPE,
        in_is_done          plan_certifications_notes.is_done%TYPE,
        in_priority         plan_certifications_notes.priority%TYPE,
        in_notes            plan_certifications_notes.notes%TYPE
    ) AS
    BEGIN
        app.log_module(in_cert_id, in_is_done, in_priority, in_notes);
        --
        DELETE FROM plan_certifications_notes n
        WHERE n.user_id     = app.get_user_id()
            AND n.cert_id   = in_cert_id;
        --
        INSERT INTO plan_certifications_notes (user_id, cert_id, is_done, priority, notes)
        VALUES (
            app.get_user_id(),
            in_cert_id,
            in_is_done,
            CASE WHEN in_is_done = 'Y' THEN NULL ELSE in_priority END,
            in_notes
        );
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;



    PROCEDURE resort_priorities AS
    BEGIN
        app.log_module();
        --
        FOR c IN (
            SELECT
                n.cert_id,
                n.user_id,
                ROW_NUMBER() OVER (ORDER BY n.priority, n.cert_id) AS priority
            FROM plan_certifications_notes n
            WHERE n.user_id     = 'JAN.KVETINA@GMAIL.COM'
                AND n.priority  IS NOT NULL
        ) LOOP
            UPDATE plan_certifications_notes n
            SET n.priority      = c.priority
            WHERE n.user_id     = c.user_id
                AND n.cert_id   = c.cert_id;
        END LOOP;
        --
        app.log_success();
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error();
    END;

END;
/

