--DROP TABLE quiz_tests;
CREATE TABLE quiz_tests (
    test_id         NUMBER(4)       NOT NULL,
    test_name       VARCHAR2(100)   NOT NULL,
    test_group      VARCHAR2(30)    NOT NULL,
    dump            CLOB,
    --
    CONSTRAINT pk_quiz_tests
        PRIMARY KEY (test_id)
);

