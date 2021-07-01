--DROP TABLE quiz_topics;
CREATE TABLE quiz_topics (
    topic_id        VARCHAR2(30)    NOT NULL,
    topic_name      VARCHAR2(100)   NOT NULL,
    badge_name      VARCHAR2(100),
    badge_image     VARCHAR2(100),
    note            VARCHAR2(4000),
    --
    CONSTRAINT pk_quiz_topics
        PRIMARY KEY (topic_id)
);

