--DROP TABLE plan_certifications;
CREATE TABLE plan_certifications (
    cert_id             VARCHAR2(20)    NOT NULL,
    cert_name           VARCHAR2(100)   NOT NULL,
    path_id             VARCHAR2(30),
    --
    exam_page_link      VARCHAR2(256),
    credly_link         VARCHAR2(256),
    --
    questions           NUMBER(4),
    minutes             NUMBER(4),
    pass_ratio          NUMBER(4),
    price               NUMBER(8),
    --
    CONSTRAINT pk_plan_certifications
        PRIMARY KEY (cert_id),
    --
    CONSTRAINT fk_plan_certifications_path
        FOREIGN KEY (path_id)
        REFERENCES plan_paths (path_id)
);

