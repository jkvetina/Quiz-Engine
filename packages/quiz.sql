CREATE OR REPLACE PACKAGE BODY quiz AS

    PROCEDURE prepare_items AS
    BEGIN
        -- find first empty, then bookmarked question
        IF apex.get_item('$QUESTION_ID') IS NULL THEN
            apex.set_item('$QUESTION_ID', quiz.get_prev_next_question (
                in_test_id      => apex.get_item('$TEST_ID'),
                in_question_id  => 0,
                in_bookmarked   => NULL,
                in_unanswered   => 'Y'
            ));
            --
            IF apex.get_item('$QUESTION_ID') IS NULL THEN
                apex.set_item('$QUESTION_ID', quiz.get_prev_next_question (
                    in_test_id      => apex.get_item('$TEST_ID'),
                    in_question_id  => 0,
                    in_bookmarked   => 'Y',
                    in_unanswered   => NULL
                ));
            END IF;
        END IF;

        -- load data
        apex.set_item('$QUESTION',      '');
        apex.set_item('$ANSWER',        '');
        apex.set_item('$EXPLANATION',   '');
        --
        FOR c IN (
            SELECT t.*
            FROM quiz_tests t
            WHERE t.test_id         = apex.get_item('$TEST_ID')
        ) LOOP
            apex.set_item('$TEST_NAME',     c.test_name);
            apex.set_item('$TEST_GROUP',    c.test_group);
        END LOOP;
        --
        FOR c IN (
            SELECT q.*
            FROM quiz_questions q
            WHERE q.test_id         = apex.get_item('$TEST_ID')
                AND q.question_id   = apex.get_item('$QUESTION_ID')
        ) LOOP
            apex.set_item('$QUESTION',      c.question);
            apex.set_item('$EXPLANATION',   c.explanation);
        END LOOP;
        --
        FOR c IN (
            SELECT COUNT(*) AS questions
            FROM quiz_questions q
            WHERE q.test_id         = apex.get_item('$TEST_ID')
        ) LOOP
            apex.set_item('$QUESTIONS',     c.questions);
        END LOOP;

        -- previous answers
        FOR c IN (
            SELECT a.answers, a.is_bookmarked
            FROM quiz_attempts a
            WHERE a.user_id         = sess.get_user_id()
                AND a.test_id       = apex.get_item('$TEST_ID')
                AND a.question_id   = apex.get_item('$QUESTION_ID')
        ) LOOP
            apex.set_item('$BOOKMARKED', c.is_bookmarked);
            --
            IF NVL(c.is_bookmarked, '-') != 'Y' THEN
            --IF (NVL(c.is_bookmarked, '-') != 'Y' OR apex.get_item('$ERROR') IS NOT NULL) THEN
                apex.set_item('$ANSWER', c.answers);
            END IF;
        END LOOP;

        -- correct answers
        IF (APEX_APPLICATION.G_REQUEST = 'SHOW_CORRECT' OR apex.get_item('$SHOW_CORRECT') = 'Y') THEN
            FOR c IN (
                SELECT LISTAGG(a.answer_id, ':') WITHIN GROUP (ORDER BY a.answer_id) AS answers
                FROM quiz_answers a
                WHERE a.test_id         = apex.get_item('$TEST_ID')
                    AND a.question_id   = apex.get_item('$QUESTION_ID')
                    AND a.is_correct    = 'Y'
            ) LOOP
                apex.set_item('$BOOKMARKED',    'Y');
                apex.set_item('$ANSWER',        c.answers);
                apex.set_item('$ERROR',         '');
            END LOOP;
        END IF;

        -- calculate percentages
        FOR c IN (
            SELECT CASE WHEN COUNT(*) > 0 THEN ROUND(100 * (COUNT(a.is_bookmarked) / COUNT(*)), 0) ELSE 0 END AS perc
            FROM quiz_attempts a
            WHERE a.user_id         = sess.get_user_id()
                AND a.test_id       = apex.get_item('$TEST_ID')
        ) LOOP
            apex.set_item('$BOOKMARKED_PERC', c.perc);
        END LOOP;
        --
        FOR c IN (
            SELECT NVL(ROUND(100 * (q.total - a.correct) / q.total, 0), 100) AS perc
            FROM (
                SELECT COUNT(*) AS total
                FROM quiz_questions q
                WHERE q.test_id         = apex.get_item('$TEST_ID')
            ) q
            CROSS JOIN (
                SELECT COUNT(*) AS correct
                FROM quiz_attempts a
                WHERE a.user_id         = sess.get_user_id()
                    AND a.test_id       = apex.get_item('$TEST_ID')
                    AND a.is_correct    = 'Y'
            ) a
        ) LOOP
            apex.set_item('$UNANSWERED_PERC', c.perc);
            apex.set_item('$PROGRESS_PERC',   100 - c.perc);
        END LOOP;

        -- number of expected answers (as a hint or for radio/checkbox switch)
        FOR c IN (
            SELECT COUNT(*) AS answers
            FROM quiz_answers a
            WHERE a.test_id       = apex.get_item('$TEST_ID')
                AND a.question_id = apex.get_item('$QUESTION_ID')
                AND a.is_correct  IN ('X', 'Y')
        ) LOOP
            apex.set_item('$EXPECTED', c.answers);
        END LOOP;

        -- clear items after init
        apex.set_item('$SHOW_CORRECT', '');
    END;



    PROCEDURE process_answer (
        in_answer       VARCHAR2,
        in_bookmarked   VARCHAR2
    ) AS
        rec             quiz_attempts%ROWTYPE;
    BEGIN
        rec.user_id         := sess.get_user_id();
        rec.test_id         := apex.get_item('$TEST_ID');
        rec.question_id     := apex.get_item('$QUESTION_ID');
        rec.updated_at      := SYSDATE;
        rec.is_bookmarked   := NULLIF(in_bookmarked, 'N');
        rec.counter         := 1;

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
                AND a.is_correct    IN ('X', 'Y')
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
            apex.set_item('$BOOKMARKED',    'Y');
            apex.set_item('$ERROR',         'INCORRECT_ANSWER');
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
            apex.set_item('$QUESTION_ID', quiz.get_prev_next_question (
                in_test_id      => rec.test_id,
                in_question_id  => rec.question_id,
                in_bookmarked   => apex.get_item('$SKIP_CORRECT'),
                in_unanswered   => apex.get_item('$SKIP_CORRECT'),
                in_direction    => APEX_APPLICATION.G_REQUEST
            ));

            -- clear answers for next question, clear bookmarks
            apex.set_item('$ANSWER',        '');
            apex.set_item('$BOOKMARKED',    '');
            apex.set_item('$ERROR',         '');
        END IF;
    END;



    PROCEDURE clear_bookmarks
    AS
        first_question      quiz_questions.question_id%TYPE := 0;
    BEGIN
        FOR c IN (
            SELECT a.question_id, a.ROWID AS rid
            FROM quiz_questions q
            JOIN quiz_attempts a
                ON a.user_id            = sess.get_user_id()
                AND a.test_id           = q.test_id
                AND a.question_id       = q.question_id
                AND a.is_bookmarked     = 'Y'
            WHERE q.test_id             = apex.get_item('$TEST_ID')
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
                ON a.user_id            = sess.get_user_id()
                AND a.test_id           = q.test_id
                AND a.question_id       = q.question_id
            WHERE q.test_id             = apex.get_item('$TEST_ID')
                AND a.question_id       IS NULL;
        END IF;

        -- set first empty question
        apex.redirect (
            in_names    => 'P' || sess.get_page_id() || '_QUESTION_ID,P' || sess.get_page_id() || '_SKIP_CORRECT',
            in_values   => first_question || ',Y'
        );
    END;



    PROCEDURE clear_progress
    AS
        first_question      quiz_questions.question_id%TYPE := 0;
    BEGIN
        DELETE FROM quiz_attempts a
        WHERE a.user_id         = sess.get_user_id()
            AND a.test_id       = apex.get_item('$TEST_ID')
            AND a.is_bookmarked IS NULL;
        --
        UPDATE quiz_attempts a
        SET a.answers           = NULL,
            a.is_correct        = NULL
        WHERE a.user_id         = sess.get_user_id()
            AND a.test_id       = apex.get_item('$TEST_ID')
            AND a.is_bookmarked = 'Y';
        --
        SELECT MIN(q.question_id) INTO first_question
        FROM quiz_questions q
        WHERE q.test_id             = apex.get_item('$TEST_ID');

        -- set first empty question
        apex.redirect (
            in_names    => 'P' || sess.get_page_id() || '_QUESTION_ID,P' || sess.get_page_id() || '_SKIP_CORRECT',
            in_values   => first_question || ',Y'
        );
    END;



    FUNCTION get_prev_next_question (
        in_test_id          quiz_questions.test_id%TYPE,
        in_question_id      quiz_questions.question_id%TYPE,
        in_bookmarked       CHAR                                := 'Y',
        in_unanswered       CHAR                                := 'Y',
        in_direction        VARCHAR2                            := 'NEXT',
        in_user_id          VARCHAR2                            := NULL
    )
    RETURN quiz_questions.question_id%TYPE
    AS
        out_id              quiz_questions.question_id%TYPE;
    BEGIN
        SELECT
            CASE
                WHEN in_direction = 'PREV' THEN MAX(q.question_id)
                WHEN in_direction = 'NEXT' THEN MIN(q.question_id)
                END INTO out_id
        FROM quiz_questions q
        LEFT JOIN quiz_attempts a
            ON a.user_id            = COALESCE(in_user_id, sess.get_user_id())
            AND a.test_id           = q.test_id
            AND a.question_id       = q.question_id
        WHERE q.test_id             = in_test_id
            AND 1 = CASE
                WHEN in_direction = 'PREV' AND q.question_id < in_question_id THEN 1
                WHEN in_direction = 'NEXT' AND q.question_id > in_question_id THEN 1
                ELSE 0 END
            AND 1 = CASE
                WHEN in_unanswered = 'Y' AND a.answers          IS NULL THEN 1
                WHEN in_bookmarked = 'Y' AND a.is_bookmarked    = 'Y'   THEN 1
                ELSE 0 END;
        --
        RETURN out_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL;
    END;

END;
/
