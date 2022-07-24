CREATE TABLE quiz_questions (
    test_id                         NUMBER(4,0)     NOT NULL,
    question_id                     NUMBER(8,0)     NOT NULL,
    question                        VARCHAR2(4000)  NOT NULL,
    explanation                     VARCHAR2(4000),
    is_to_verify                    VARCHAR2(1),
    public_note                     VARCHAR2(4000),
    --
    CONSTRAINT pk_quiz_questions
        PRIMARY KEY (test_id, question_id),
    --
    CONSTRAINT fk_quiz_questions_tests
        FOREIGN KEY (test_id)
        REFERENCES quiz_tests (test_id)
);
--
COMMENT ON TABLE quiz_questions IS '';
--
COMMENT ON COLUMN quiz_questions.test_id        IS '';
COMMENT ON COLUMN quiz_questions.question_id    IS '';
COMMENT ON COLUMN quiz_questions.question       IS '';
COMMENT ON COLUMN quiz_questions.explanation    IS '';
COMMENT ON COLUMN quiz_questions.is_to_verify   IS '';
COMMENT ON COLUMN quiz_questions.public_note    IS '';

