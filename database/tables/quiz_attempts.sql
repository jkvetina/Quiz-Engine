--DROP TABLE quiz_attempts;
CREATE TABLE quiz_attempts (
    user_id         VARCHAR2(240)   NOT NULL,
    test_id         NUMBER(4)       NOT NULL,
    question_id     NUMBER(8)       NOT NULL,
    answers         VARCHAR2(100),
    is_correct      VARCHAR2(1),
    is_bookmarked   VARCHAR2(1),
    --
    updated_at      DATE,
    counter         NUMBER(4),
    private_note    VARCHAR2(4000),
    --
    CONSTRAINT pk_quiz_attempts
        PRIMARY KEY (user_id, test_id, question_id),
    --
    CONSTRAINT fk_quiz_attempts_questions
        FOREIGN KEY (test_id, question_id)
        REFERENCES quiz_questions (test_id, question_id)
);

