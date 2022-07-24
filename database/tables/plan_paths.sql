CREATE TABLE plan_paths (
    path_id                         VARCHAR2(30)    NOT NULL,
    path_name                       VARCHAR2(100)   NOT NULL,
    --
    CONSTRAINT pk_plan_paths
        PRIMARY KEY (path_id)
    --
    CONSTRAINT fk_plan_certifications_topic
        FOREIGN KEY (path_id)
        REFERENCES quiz_topics (topic_id)
);
--
COMMENT ON TABLE plan_paths IS '';
--
COMMENT ON COLUMN plan_paths.path_id        IS '';
COMMENT ON COLUMN plan_paths.path_name      IS '';

