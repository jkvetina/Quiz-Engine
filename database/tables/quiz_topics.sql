CREATE TABLE quiz_topics (
    topic_id                        VARCHAR2(30)    NOT NULL,
    topic_name                      VARCHAR2(100)   NOT NULL,
    badge_name                      VARCHAR2(100),
    note                            VARCHAR2(4000),
    badge_file                      BLOB,
    badge_mime                      VARCHAR2(256),
    created_at                      DATE,
    --
    CONSTRAINT pk_quiz_topics
        PRIMARY KEY (topic_id)
);
--
COMMENT ON TABLE quiz_topics IS '';
--
COMMENT ON COLUMN quiz_topics.topic_id      IS '';
COMMENT ON COLUMN quiz_topics.topic_name    IS '';
COMMENT ON COLUMN quiz_topics.badge_name    IS '';
COMMENT ON COLUMN quiz_topics.note          IS '';
COMMENT ON COLUMN quiz_topics.badge_file    IS '';
COMMENT ON COLUMN quiz_topics.badge_mime    IS '';

