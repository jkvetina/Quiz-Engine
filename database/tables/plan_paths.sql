--DROP TABLE plan_paths;
CREATE TABLE plan_paths (
    path_id             VARCHAR2(30)    NOT NULL,
    path_name           VARCHAR2(100)   NOT NULL,
    --
    CONSTRAINT pk_plan_paths
        PRIMARY KEY (path_id),
    --
    CONSTRAINT fk_plan_certifications_topic
        FOREIGN KEY (path_id)
        REFERENCES quiz_topics (topic_id)
);

