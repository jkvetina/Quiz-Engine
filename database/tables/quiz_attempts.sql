CREATE TABLE quiz_attempts (
    user_id                         VARCHAR2(240)   NOT NULL,
    test_id                         NUMBER(4,0)     NOT NULL,
    question_id                     NUMBER(8,0)     NOT NULL,
    answers                         VARCHAR2(100),
    is_correct                      VARCHAR2(1),
    is_bookmarked                   VARCHAR2(1),
    updated_at                      DATE,
    counter                         NUMBER(4,0),
    private_note                    VARCHAR2(4000),
    --
    CONSTRAINT pk_quiz_attempts
        PRIMARY KEY (user_id, test_id, question_id),
    --
    CONSTRAINT fk_quiz_attempts_questions
        FOREIGN KEY (test_id, question_id)
        REFERENCES quiz_questions (test_id, question_id)
);
--
COMMENT ON TABLE quiz_attempts IS '';
--
COMMENT ON COLUMN quiz_attempts.user_id         IS '';
COMMENT ON COLUMN quiz_attempts.test_id         IS '';
COMMENT ON COLUMN quiz_attempts.question_id     IS '';
COMMENT ON COLUMN quiz_attempts.answers         IS '';
COMMENT ON COLUMN quiz_attempts.is_correct      IS '';
COMMENT ON COLUMN quiz_attempts.is_bookmarked   IS '';
COMMENT ON COLUMN quiz_attempts.counter         IS '';
COMMENT ON COLUMN quiz_attempts.private_note    IS '';

