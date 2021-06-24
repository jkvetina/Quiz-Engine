--DROP TABLE quiz_questions;
CREATE TABLE quiz_questions (
    test_id         NUMBER(4)       NOT NULL,
    question_id     NUMBER(8)       NOT NULL,
    question        VARCHAR2(4000)  NOT NULL,
    explanation     VARCHAR2(4000),
    --
    CONSTRAINT pk_quiz_questions
        PRIMARY KEY (test_id, question_id),
    --
    CONSTRAINT fk_quiz_questions_tests
        FOREIGN KEY (test_id)
        REFERENCES quiz_tests (test_id)
);

