CREATE TABLE plan_certifications (
    cert_id                         VARCHAR2(20)    NOT NULL,
    cert_name                       VARCHAR2(100)   NOT NULL,
    path_id                         VARCHAR2(30),
    exam_page_link                  VARCHAR2(256),
    questions                       NUMBER(4,0),
    minutes                         NUMBER(4,0),
    pass_ratio                      NUMBER(4,0),
    price                           NUMBER(8,0),
    credly_link                     VARCHAR2(256),
    study_link                      VARCHAR2(256),
    study_hours                     VARCHAR2(10),
    --
    CONSTRAINT pk_plan_certifications
        PRIMARY KEY (cert_id),
    --
    CONSTRAINT fk_plan_certifications_path
        FOREIGN KEY (path_id)
        REFERENCES plan_paths (path_id) DISABLE
);
--
COMMENT ON TABLE plan_certifications IS '';
--
COMMENT ON COLUMN plan_certifications.cert_id           IS '';
COMMENT ON COLUMN plan_certifications.cert_name         IS '';
COMMENT ON COLUMN plan_certifications.path_id           IS '';
COMMENT ON COLUMN plan_certifications.exam_page_link    IS '';
COMMENT ON COLUMN plan_certifications.questions         IS '';
COMMENT ON COLUMN plan_certifications.minutes           IS '';
COMMENT ON COLUMN plan_certifications.pass_ratio        IS '';
COMMENT ON COLUMN plan_certifications.price             IS '';
COMMENT ON COLUMN plan_certifications.credly_link       IS '';
COMMENT ON COLUMN plan_certifications.study_link        IS '';
COMMENT ON COLUMN plan_certifications.study_hours       IS '';

