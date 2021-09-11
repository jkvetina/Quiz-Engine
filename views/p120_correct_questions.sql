CREATE OR REPLACE VIEW p120_correct_questions AS
SELECT
    q.test_id,
    q.question_id,
    q.question,
    q.third
FROM (
    SELECT
        q.test_id,
        q.question_id,
        q.question,
        NTILE(3) OVER (ORDER BY q.test_id, q.question_id) AS third
    FROM quiz_questions q
    JOIN quiz_tests t
        ON t.test_id        = q.test_id
    WHERE (
        q.test_id           = apex.get_item('$TEST_ID')
        OR t.test_topic     = apex.get_item('$TOPIC_ID')
    )
) q;

