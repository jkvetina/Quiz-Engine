--DROP TABLE quiz_topics_auth;
CREATE TABLE quiz_topics_auth (
    topic_id        VARCHAR2(30)    NOT NULL,
    user_id         VARCHAR2(240)   NOT NULL,
    is_available    CHAR,                       -- just to use view trigger
    --
    created_by      VARCHAR2(240),
    created_at      DATE,
    --
    CONSTRAINT pk_quiz_topics_auth
        PRIMARY KEY (topic_id, user_id),
    --
    CONSTRAINT fk_quiz_topics_topic
        FOREIGN KEY (topic_id)
        REFERENCES quiz_topics (topic_id)
);
