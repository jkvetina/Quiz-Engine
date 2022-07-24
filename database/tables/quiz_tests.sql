--DROP TABLE quiz_tests;
CREATE TABLE quiz_tests (
    test_id         NUMBER(4)       NOT NULL,
    test_name       VARCHAR2(100)   NOT NULL,
    test_topic      VARCHAR2(30)    NOT NULL,
    dump            CLOB,
    --
    dedicated_to    VARCHAR2(240),
    created_at      DATE,
    --
    CONSTRAINT pk_quiz_tests
        PRIMARY KEY (test_id),
    --
    CONSTRAINT fk_quiz_tests_topic
        FOREIGN KEY (test_topic)
        REFERENCES quiz_topics (topic_id)
);

