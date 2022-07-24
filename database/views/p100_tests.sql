CREATE OR REPLACE VIEW p100_tests AS
SELECT
    t.test_id,
    t.test_name,
    --
    t.questions || ' questions, ' || t.explanations || ' explanations, ' ||
        NVL(FLOOR(100 * (t.is_correct / t.questions)), 0) || '% completed'
        AS supplemental,
    --
    CASE WHEN t.is_to_verify > 0 THEN t.is_to_verify || ' to verify' END AS to_verify,
    --
    CASE WHEN t.is_correct > 0
        THEN NVL(FLOOR(100 - 100 * (t.is_bookmarked / t.questions)), 0) || '%'
        END AS count_,
    --
    CASE WHEN t.test_id = apex.get_item('$TEST_ID')
        THEN 'bold'
        END AS css_class
FROM (
    SELECT
        t.test_id,
        t.test_name,
        COUNT(q.question_id)                                            AS questions,
        SUM(CASE WHEN q.explanation     IS NOT NULL THEN 1 ELSE 0 END)  AS explanations,
        SUM(CASE WHEN a.is_correct      = 'Y'       THEN 1 ELSE 0 END)  AS is_correct,
        SUM(CASE WHEN a.is_bookmarked   = 'Y'       THEN 1 ELSE 0 END)  AS is_bookmarked,
        COUNT(q.is_to_verify)                                           AS is_to_verify,
        t.dedicated_to
    FROM quiz_questions q
    JOIN quiz_tests t
        ON t.test_id        = q.test_id
    JOIN p100_tests_available a
        ON a.test_id        = t.test_id
    LEFT JOIN quiz_attempts a
        ON a.user_id        = sess.get_user_id()
        AND a.test_id       = q.test_id
        AND a.question_id   = q.question_id
    WHERE t.test_topic      = apex.get_item('$TOPIC_ID')
    GROUP BY t.test_id, t.test_name, t.dedicated_to
) t
ORDER BY t.dedicated_to NULLS FIRST, t.test_id;
