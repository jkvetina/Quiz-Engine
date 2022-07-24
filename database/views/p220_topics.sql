CREATE OR REPLACE VIEW p220_topics AS
SELECT
    t.topic_id,
    --
    apex.get_item('$USER_ID') AS user_id,
    --
    CASE WHEN a.user_id IS NOT NULL THEN 'Y' ELSE 'N' END AS is_available,
    --
    a.created_by,
    a.created_at
FROM quiz_topics t
LEFT JOIN quiz_topics_auth a
    ON a.topic_id       = t.topic_id
    AND a.user_id       = apex.get_item('$USER_ID');

