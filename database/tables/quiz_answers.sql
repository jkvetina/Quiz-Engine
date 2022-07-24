CREATE TABLE quiz_answers (
    test_id                         NUMBER(4,0)     NOT NULL,
    question_id                     NUMBER(8,0)     NOT NULL,
    answer_id                       NUMBER(2,0)     NOT NULL,
    answer                          VARCHAR2(4000)  NOT NULL,
    is_correct                      VARCHAR2(1),
    --
    CONSTRAINT pk_quiz_answers
        PRIMARY KEY (test_id, question_id, answer_id),
    --
    CONSTRAINT fk_quiz_answers
        FOREIGN KEY (test_id, question_id)
        REFERENCES quiz_questions (test_id, question_id)
);
--
COMMENT ON TABLE quiz_answers IS '';
--
COMMENT ON COLUMN quiz_answers.test_id          IS '';
COMMENT ON COLUMN quiz_answers.question_id      IS '';
COMMENT ON COLUMN quiz_answers.answer_id        IS '';
COMMENT ON COLUMN quiz_answers.answer           IS '';
COMMENT ON COLUMN quiz_answers.is_correct       IS '';

