-- --------------------------------------------------------------------------------
-- 
-- Oracle APEX source export file
-- 
-- The contents of this file are intended for review and analysis purposes only.
-- Developers must use the Application Builder to make modifications to an
-- application. Changes to this file will not be reflected in the application.
-- 
-- --------------------------------------------------------------------------------

-- ----------------------------------------
-- Page 125: Correct Answers (for topic)
-- Region: Left
-- PL/SQL Code

BEGIN
    FOR q IN (
        SELECT q.*
        FROM p120_correct_questions q
        WHERE q.third = 1
        ORDER BY q.test_id, q.question_id
    ) LOOP
        htp.p('<h4>' || q.question_id || ') ' || q.question || '</h4>');
        htp.p('<ul>');
        --
        FOR a IN (
            SELECT a.*
            FROM p120_correct_answers a
            WHERE a.test_id         = q.test_id
                AND a.question_id   = q.question_id
            ORDER BY a.answer_id
        ) LOOP
            htp.p('<li>' || a.answer || '</li>');
        END LOOP;
        --
        htp.p('</ul>');
    END LOOP;
END;


-- ----------------------------------------
-- Page 125: Correct Answers (for topic)
-- Region: Middle
-- PL/SQL Code

BEGIN
    FOR q IN (
        SELECT q.*
        FROM p120_correct_questions q
        WHERE q.third = 2
        ORDER BY q.test_id, q.question_id
    ) LOOP
        htp.p('<h4>' || q.question_id || ') ' || q.question || '</h4>');
        htp.p('<ul>');
        --
        FOR a IN (
            SELECT a.*
            FROM p120_correct_answers a
            WHERE a.test_id         = q.test_id
                AND a.question_id   = q.question_id
            ORDER BY a.answer_id
        ) LOOP
            htp.p('<li>' || a.answer || '</li>');
        END LOOP;
        --
        htp.p('</ul>');
    END LOOP;
END;


-- ----------------------------------------
-- Page 125: Correct Answers (for topic)
-- Region: Right
-- PL/SQL Code

BEGIN
    FOR q IN (
        SELECT q.*
        FROM p120_correct_questions q
        WHERE q.third = 3
        ORDER BY q.test_id, q.question_id
    ) LOOP
        htp.p('<h4>' || q.question_id || ') ' || q.question || '</h4>');
        htp.p('<ul>');
        --
        FOR a IN (
            SELECT a.*
            FROM p120_correct_answers a
            WHERE a.test_id         = q.test_id
                AND a.question_id   = q.question_id
            ORDER BY a.answer_id
        ) LOOP
            htp.p('<li>' || a.answer || '</li>');
        END LOOP;
        --
        htp.p('</ul>');
    END LOOP;
END;


