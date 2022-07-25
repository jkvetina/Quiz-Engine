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
-- Page 120: Correct Answers
-- Region: Left
-- PL/SQL Code

BEGIN
    FOR q IN (
        SELECT q.*
        FROM (
            SELECT q.*, NTILE(3) OVER (ORDER BY q.question_id) AS third
            FROM quiz_questions q
            WHERE q.test_id         = app.get_item('$TEST_ID')
        ) q
        WHERE q.third = 1
        ORDER BY q.question_id
    ) LOOP
        htp.p('<h4>' || q.question_id || ') ' || q.question || '</h4>');
        htp.p('<ul>');
        --
        FOR a IN (
            SELECT a.*
            FROM quiz_answers a
            WHERE a.test_id         = app.get_item('$TEST_ID')
                AND a.question_id   = q.question_id
                AND a.is_correct    IN ('X', 'Y')
            ORDER BY a.answer_id
        ) LOOP
            htp.p('<li>' || a.answer || '</li>');
        END LOOP;
        --
        htp.p('</ul>');
    END LOOP;
END;


-- ----------------------------------------
-- Page 120: Correct Answers
-- Region: Right
-- PL/SQL Code

BEGIN
    FOR q IN (
        SELECT q.*
        FROM (
            SELECT q.*, NTILE(3) OVER (ORDER BY q.question_id) AS third
            FROM quiz_questions q
            WHERE q.test_id         = app.get_item('$TEST_ID')
        ) q
        WHERE q.third = 3
        ORDER BY q.question_id
    ) LOOP
        htp.p('<h4>' || q.question_id || ') ' || q.question || '</h4>');
        htp.p('<ul>');
        --
        FOR a IN (
            SELECT a.*
            FROM quiz_answers a
            WHERE a.test_id         = app.get_item('$TEST_ID')
                AND a.question_id   = q.question_id
                AND a.is_correct    IN ('X', 'Y')
            ORDER BY a.answer_id
        ) LOOP
            htp.p('<li>' || a.answer || '</li>');
        END LOOP;
        --
        htp.p('</ul>');
    END LOOP;
END;


-- ----------------------------------------
-- Page 120: Correct Answers
-- Region: Middle
-- PL/SQL Code

BEGIN
    FOR q IN (
        SELECT q.*
        FROM (
            SELECT q.*, NTILE(3) OVER (ORDER BY q.question_id) AS third
            FROM quiz_questions q
            WHERE q.test_id         = app.get_item('$TEST_ID')
        ) q
        WHERE q.third = 2
        ORDER BY q.question_id
    ) LOOP
        htp.p('<h4>' || q.question_id || ') ' || q.question || '</h4>');
        htp.p('<ul>');
        --
        FOR a IN (
            SELECT a.*
            FROM quiz_answers a
            WHERE a.test_id         = app.get_item('$TEST_ID')
                AND a.question_id   = q.question_id
                AND a.is_correct    IN ('X', 'Y')
            ORDER BY a.answer_id
        ) LOOP
            htp.p('<li>' || a.answer || '</li>');
        END LOOP;
        --
        htp.p('</ul>');
    END LOOP;
END;


