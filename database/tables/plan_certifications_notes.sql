--DROP TABLE plan_certifications_notes;
CREATE TABLE plan_certifications_notes (
    user_id             VARCHAR2(240)   NOT NULL,
    cert_id             VARCHAR2(20)    NOT NULL,
    --
    is_done             VARCHAR2(1),
    priority            NUMBER(2),
    notes               VARCHAR2(4000),
    --
    CONSTRAINT pk_plan_certifications_notes
        PRIMARY KEY (user_id, cert_id),
    --
    CONSTRAINT fk_plan_certifications_notes_cert
        FOREIGN KEY (cert_id)
        REFERENCES plan_certifications (cert_id)
    --
    --CONSTRAINT fk_plan_certifications_notes_user
    --    FOREIGN KEY (user_id)
    --    REFERENCES users (user_id)
);
