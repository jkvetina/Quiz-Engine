CREATE TABLE quiz_tests (
    test_id                         NUMBER(4,0)     NOT NULL,
    test_name                       VARCHAR2(100)   NOT NULL,
    test_topic                      VARCHAR2(30)    NOT NULL,
    dump                            CLOB,
    dedicated_to                    VARCHAR2(240),
    created_at                      DATE,
    --
    CONSTRAINT pk_quiz_tests
        PRIMARY KEY (test_id)
    --
    CONSTRAINT fk_quiz_tests_group
        FOREIGN KEY (test_topic)
        REFERENCES quiz_topics (topic_id)
);
--
COMMENT ON TABLE quiz_tests IS '';
--
COMMENT ON COLUMN quiz_tests.test_id        IS '';
COMMENT ON COLUMN quiz_tests.test_name      IS '';
COMMENT ON COLUMN quiz_tests.test_topic     IS '';
COMMENT ON COLUMN quiz_tests.dump           IS '';
COMMENT ON COLUMN quiz_tests.dedicated_to   IS '';

