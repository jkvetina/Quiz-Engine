CREATE OR REPLACE FORCE VIEW p220_tests AS
SELECT
    t.test_topic,
    t.test_name,
    t.test_id,
    --
    app.get_item('$USER_ID') AS user_id,
    --
    CASE WHEN a.user_id IS NOT NULL THEN 'Y' ELSE 'N' END AS is_available,
    --
    a.created_by,
    a.created_at
FROM quiz_tests t
LEFT JOIN quiz_tests_auth a
    ON a.test_id        = t.test_id
    AND a.user_id       = app.get_item('$USER_ID')
WHERE t.dedicated_to    IS NULL;
--
COMMENT ON TABLE p220_tests IS '';

