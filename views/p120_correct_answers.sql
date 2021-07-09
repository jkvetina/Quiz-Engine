CREATE OR REPLACE VIEW p120_correct_answers AS
SELECT
    a.test_id,
    a.question_id,
    a.answer_id,
    a.answer,
    a.is_correct
FROM quiz_answers a
WHERE a.is_correct      IN ('X', 'Y');
