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
-- Page 110: Questions
-- Region: Questions
-- SQL Query

SELECT
    q.*,
    CASE WHEN q.question_id = apex.get_item('$QUESTION_ID')
        THEN 'bold'
        END AS css_class
FROM quiz_questions q
WHERE q.test_id         = apex.get_item('$TEST_ID')
    AND q.question_id   NOT IN (
        SELECT q.question_id
        FROM quiz_questions q
        JOIN quiz_attempts t
            ON t.user_id        = sess.get_user_id()
            AND t.test_id       = q.test_id
            AND t.question_id   = q.question_id
        WHERE q.test_id         = apex.get_item('$TEST_ID')
            AND t.is_correct    = 'Y'
    )
ORDER BY 1, 2;


-- ----------------------------------------
-- Page 110: Questions
-- Branch: CHECK_ACCESS
-- SQL Query

SELECT 1
FROM p100_tests_available a
WHERE a.test_id = :P100_TEST_ID;

-- ----------------------------------------
-- Page 110: Questions
-- Process: CLEAR_PROGRESS
-- PL/SQL Code

quiz.clear_progress();


-- ----------------------------------------
-- Page 110: Questions
-- Process: CLEAR_BOOKMARKS
-- PL/SQL Code

quiz.clear_bookmarks();


-- ----------------------------------------
-- Page 110: Questions
-- Process: PROCESS_ANSWER
-- PL/SQL Code

quiz.process_answer (
    in_answer           => :P110_ANSWER,
    in_bookmarked       => :P110_BOOKMARKED,
    in_to_verify        => :P110_TO_VERIFY,
    in_public_note      => :P110_PUBLIC_NOTE,
    in_private_note     => :P110_PRIVATE_NOTE
);


-- ----------------------------------------
-- Page 110: Questions
-- Process: PREPARE_ITEMS
-- PL/SQL Code

quiz.prepare_items();


-- ----------------------------------------
-- Page 110: Questions
-- Computation: P110_RESULT
-- SQL Query

SELECT
    apex.get_item('$PROGRESS_PERC') || '% done, ' ||
    (100 - apex.get_item('$BOOKMARKED_PERC')) || '% correct' ||
    CASE
        WHEN (100 - apex.get_item('$BOOKMARKED_PERC')) > c.pass_ratio THEN ' = PASS'
        WHEN c.pass_ratio IS NOT NULL THEN ' = FAIL'
        END AS result_
FROM DUAL
LEFT JOIN plan_certifications c
    ON c.path_id = apex.get_item('$TOPIC_ID');


-- ----------------------------------------
-- Page 110: Questions
-- Page Item: P110_ANSWER
-- SQL Query

SELECT a.answer, a.answer_id
FROM quiz_answers a
WHERE a.test_id = apex.get_item('$TEST_ID')
    AND a.question_id = apex.get_item('$QUESTION_ID')
ORDER BY DBMS_RANDOM.VALUE();


-- ----------------------------------------
-- Page 110: Questions
-- Region: Questions
-- SQL Query

SELECT
    q.*,
    CASE WHEN q.question_id = apex.get_item('$QUESTION_ID')
        THEN 'bold'
        END AS css_class
FROM quiz_questions q
JOIN quiz_attempts t
    ON t.user_id        = sess.get_user_id()
    AND t.test_id       = q.test_id
    AND t.question_id   = q.question_id
    AND t.is_bookmarked = 'Y'
WHERE q.test_id         = apex.get_item('$TEST_ID')
ORDER BY 1, 2;


-- ----------------------------------------
-- Page 110: Questions
-- Region: Questions
-- SQL Query

SELECT
    q.*,
    CASE WHEN q.question_id = apex.get_item('$QUESTION_ID')
        THEN 'bold'
        END AS css_class
FROM quiz_questions q
WHERE q.test_id         = apex.get_item('$TEST_ID')
    AND q.is_to_verify  = 'Y'
ORDER BY 1, 2;


