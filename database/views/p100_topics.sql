CREATE OR REPLACE FORCE VIEW p100_topics AS
SELECT
    t.topic_id,
    t.topic_name            AS name,
    --
    q.questions || ' questions, ' || q.explanations || ' explanations' AS supplemental,
    --
    q.tests                 AS counter,
    --
    CASE WHEN t.topic_id = apex.get_item('$TOPIC_ID')
        THEN 'bold'
        END AS css_class
FROM quiz_topics t
JOIN (
    SELECT
        t.test_topic,
        COUNT(q.question_id)                                            AS questions,
        SUM(CASE WHEN q.explanation     IS NOT NULL THEN 1 ELSE 0 END)  AS explanations,
        COUNT(DISTINCT t.test_id)                                       AS tests
    FROM quiz_questions q
    JOIN quiz_tests t
        ON t.test_id        = q.test_id
    JOIN p100_tests_available a
        ON a.test_id        = t.test_id
    GROUP BY t.test_topic
) q
    ON q.test_topic         = t.topic_id
ORDER BY 1;
--
COMMENT ON TABLE p100_topics IS '';

