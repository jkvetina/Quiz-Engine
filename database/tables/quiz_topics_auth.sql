CREATE TABLE quiz_topics_auth (
    topic_id                        VARCHAR2(30)    NOT NULL,
    user_id                         VARCHAR2(240)   NOT NULL,
    is_available                    CHAR(1),
    created_by                      VARCHAR2(240),
    created_at                      DATE,
    --
    CONSTRAINT pk_quiz_topics_auth
        PRIMARY KEY (topic_id, user_id),
    --
    CONSTRAINT fk_quiz_topics_topic
        FOREIGN KEY (topic_id)
        REFERENCES quiz_topics (topic_id)
);
--
COMMENT ON TABLE quiz_topics_auth IS '';
--
COMMENT ON COLUMN quiz_topics_auth.topic_id         IS '';
COMMENT ON COLUMN quiz_topics_auth.user_id          IS '';
COMMENT ON COLUMN quiz_topics_auth.is_available     IS '';

