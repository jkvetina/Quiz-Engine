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
-- Page 210: Management
-- Process: GET_ID
-- PL/SQL Code

FOR c IN (
    SELECT MIN(q.question_id) AS next_id
    FROM quiz_questions q
    WHERE q.test_id         = app.get_item('$TEST_ID')
        AND q.question_id   > app.get_item('$QUESTION_ID')
) LOOP
    app.set_item('$NEXT_ID', c.next_id);
END LOOP;
--
FOR c IN (
    SELECT MAX(q.question_id) AS prev_id
    FROM quiz_questions q
    WHERE q.test_id         = app.get_item('$TEST_ID')
        AND q.question_id   < app.get_item('$QUESTION_ID')
) LOOP
    app.set_item('$PREV_ID', c.prev_id);
END LOOP;


