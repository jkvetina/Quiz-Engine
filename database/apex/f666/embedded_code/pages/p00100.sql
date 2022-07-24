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
-- Page 100: Home
-- Region: Activity Check
-- SQL Query

SELECT
    a.user_id           AS name,
    COUNT(*)            AS counter,
    --
    TO_CHAR(MAX(a.updated_at), 'YYYY-MM-DD, HH24:MI') AS supplement
FROM quiz_attempts a
JOIN quiz_tests t
    ON t.test_id        = a.test_id
WHERE t.test_topic      = NVL(apex.get_item('$TOPIC_ID'), t.test_topic)
GROUP BY a.user_id
ORDER BY 1;


-- ----------------------------------------
-- Page 100: Home
-- Process: CREATE_BOOKMARKED
-- PL/SQL Code

quiz.create_bookmarked_test (
    in_topic_id         => apex.get_item('$TOPIC_ID'),
    in_user_id          => sess.get_user_id()
);


-- ----------------------------------------
-- Page 100: Home
-- Computation: P100_TOPIC_ID
-- SQL Query

SELECT MIN(t.test_topic) KEEP (DENSE_RANK FIRST ORDER BY a.updated_at DESC) AS last_topic
FROM quiz_attempts a
JOIN quiz_tests t
    ON t.test_id        = a.test_id
WHERE a.user_id         = sess.get_user_id();


-- ----------------------------------------
-- Page 100: Home
-- Computation: P100_BADGE_NAME_HEADER
-- SQL Query

SELECT t.badge_name
FROM quiz_topics t
WHERE t.topic_id = apex.get_item('$TOPIC_ID');


-- ----------------------------------------
-- Page 100: Home
-- Computation: P100_TEST_ID
-- SQL Query

SELECT MIN(a.test_id) KEEP (DENSE_RANK FIRST ORDER BY a.updated_at DESC) AS last_test
FROM quiz_attempts a
JOIN quiz_tests t
    ON t.test_id        = a.test_id
WHERE a.user_id         = sess.get_user_id()
    AND t.test_topic    = apex.get_item('$TOPIC_ID');


-- ----------------------------------------
-- Page 100: Home
-- Computation: P100_BOOKMARKED_COUNT
-- SQL Query

SELECT COUNT(*) AS count_
FROM quiz_attempts a
WHERE a.user_id         = sess.get_user_id()
    AND a.is_bookmarked = 'Y'
    AND a.test_id       IN (
        SELECT t.test_id
        FROM quiz_tests t
        WHERE t.test_topic      = apex.get_item('$TOPIC_ID')
            AND t.test_name     != 'BOOKMARKED'
    );


