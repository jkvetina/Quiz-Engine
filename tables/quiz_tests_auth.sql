--DROP TABLE quiz_tests_auth;
CREATE TABLE quiz_tests_auth (
    test_id         NUMBER(4)       NOT NULL,
    user_id         VARCHAR2(240)   NOT NULL,
    is_available    CHAR,                       -- just to use view trigger
    --
    created_by      VARCHAR2(240),
    created_at      DATE,
    --
    CONSTRAINT pk_quiz_tests_auth
        PRIMARY KEY (test_id, user_id),
    --
    CONSTRAINT fk_quiz_tests_test
        FOREIGN KEY (test_id)
        REFERENCES quiz_tests (test_id)
);
