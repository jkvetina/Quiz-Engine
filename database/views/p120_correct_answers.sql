CREATE OR REPLACE FORCE VIEW p120_correct_answers AS
SELECT
    a.test_id,
    a.question_id,
    a.answer_id,
    a.answer,
    a.is_correct
FROM quiz_answers a
JOIN p100_tests_available t
    ON t.test_id        = a.test_id
WHERE a.is_correct      IN ('X', 'Y');
--
COMMENT ON TABLE p120_correct_answers IS '';

