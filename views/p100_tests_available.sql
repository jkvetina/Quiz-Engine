CREATE OR REPLACE VIEW p100_tests_available AS
SELECT a.test_id
FROM quiz_tests_auth a
WHERE a.user_id         = sess.get_user_id()
UNION
SELECT t.test_id
FROM quiz_topics_auth a
JOIN quiz_tests t
    ON t.test_topic     = a.topic_id
WHERE a.user_id         = sess.get_user_id()
UNION
SELECT t.test_id
FROM quiz_tests t
WHERE t.dedicated_to    = sess.get_user_id();
