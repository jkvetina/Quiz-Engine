--DROP TABLE quiz_answers;
CREATE TABLE quiz_answers (
    test_id         NUMBER(4)       NOT NULL,
    question_id     NUMBER(8)       NOT NULL,
    answer_id       NUMBER(2)       NOT NULL,
    answer          VARCHAR2(4000)  NOT NULL,
    is_correct      VARCHAR2(1),
    --
    CONSTRAINT pk_quiz_answers
        PRIMARY KEY (test_id, question_id, answer_id),
    --
    CONSTRAINT fk_quiz_answers_questions
        FOREIGN KEY (test_id, question_id)
        REFERENCES quiz_questions (test_id, question_id)
);

