CREATE OR REPLACE TRIGGER p220_topics__
INSTEAD OF UPDATE OR INSERT OR DELETE ON p220_topics
BEGIN

    IF INSERTING OR UPDATING THEN
        DELETE FROM quiz_topics_auth a
        WHERE a.topic_id    = :NEW.topic_id
            AND a.user_id   = :NEW.user_id;
        --
        IF :NEW.is_available = 'Y' THEN
            INSERT INTO quiz_topics_auth (topic_id, user_id, is_available, created_by, created_at)
            VALUES (
                :NEW.topic_id,
                :NEW.user_id,
                :NEW.is_available,
                app.get_user_id(),
                SYSDATE
            );
        END IF;
    ELSE
        DELETE FROM quiz_topics_auth a
        WHERE a.topic_id    = :OLD.topic_id
            AND a.user_id   = :OLD.user_id;
    END IF;

EXCEPTION
WHEN app.app_exception THEN
    RAISE;
WHEN OTHERS THEN
    app.raise_error('TOPICS_AUTH_FAILED');
END;
/

