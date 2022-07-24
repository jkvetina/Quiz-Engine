CREATE TABLE quiz_tests_auth (
    test_id                         NUMBER(4,0)     NOT NULL,
    user_id                         VARCHAR2(240)   NOT NULL,
    is_available                    CHAR(1),
    created_by                      VARCHAR2(240),
    created_at                      DATE,
    --
    CONSTRAINT pk_quiz_tests_auth
        PRIMARY KEY (test_id, user_id),
    --
    CONSTRAINT fk_quiz_tests_test
        FOREIGN KEY (test_id)
        REFERENCES quiz_tests (test_id)
);
--
COMMENT ON TABLE quiz_tests_auth IS '';
--
COMMENT ON COLUMN quiz_tests_auth.test_id           IS '';
COMMENT ON COLUMN quiz_tests_auth.user_id           IS '';
COMMENT ON COLUMN quiz_tests_auth.is_available      IS '';

