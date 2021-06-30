CREATE OR REPLACE VIEW p100_topics AS
SELECT
    t.topic_id,
    t.topic_name            AS name,
    --
    NULL                    AS supplemental,
    q.count_                AS counter,
    --
    CASE WHEN t.topic_id = apex.get_item('$TEST_GROUP')
        THEN 'bold'
        END AS css_class
FROM quiz_topics t
LEFT JOIN (
    SELECT
        t.test_topic,
        COUNT(*)            AS count_
    FROM quiz_tests t
    GROUP BY t.test_topic
) q
    ON q.test_topic         = t.topic_id
ORDER BY 1;
