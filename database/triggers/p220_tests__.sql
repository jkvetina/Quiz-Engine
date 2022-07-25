CREATE OR REPLACE TRIGGER p220_tests__
INSTEAD OF UPDATE OR INSERT OR DELETE ON p220_tests
BEGIN

    IF INSERTING OR UPDATING THEN
        DELETE FROM quiz_tests_auth a
        WHERE a.test_id     = :NEW.test_id
            AND a.user_id   = :NEW.user_id;
        --
        IF :NEW.is_available = 'Y' THEN
            INSERT INTO quiz_tests_auth (test_id, user_id, created_by, created_at)
            VALUES (
                :NEW.test_id,
                :NEW.user_id,
                app.get_user_id(),
                SYSDATE
            );
        END IF;
    ELSE
        DELETE FROM quiz_tests_auth a
        WHERE a.test_id     = :OLD.test_id
            AND a.user_id   = :OLD.user_id;
    END IF;

EXCEPTION
WHEN app.app_exception THEN
    RAISE;
WHEN OTHERS THEN
    app.raise_error('TESTS_AUTH_FAILED');
END;
/

