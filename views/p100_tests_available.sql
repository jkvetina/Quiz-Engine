CREATE OR REPLACE VIEW p100_tests_available AS
SELECT a.test_id
FROM quiz_tests_auth a
JOIN users u
    ON u.user_id        = a.user_id
    AND u.is_active     = 'Y'
WHERE a.user_id         = sess.get_user_id()
UNION
SELECT t.test_id
FROM quiz_topics_auth a
JOIN quiz_tests t
    ON t.test_topic     = a.topic_id
JOIN users u
    ON u.user_id        = a.user_id
    AND u.is_active     = 'Y'
WHERE a.user_id         = sess.get_user_id()
UNION
SELECT t.test_id
FROM quiz_tests t
JOIN users u
    ON u.user_id        = t.dedicated_to
    AND u.is_active     = 'Y'
WHERE t.dedicated_to    = sess.get_user_id();
