CREATE OR REPLACE TRIGGER quiz_tests__
FOR UPDATE OR INSERT OR DELETE ON quiz_tests
COMPOUND TRIGGER

    l_test_id           quiz_tests.test_id%TYPE;



    BEFORE EACH ROW IS
    BEGIN
        IF (INSERTING AND :NEW.dump IS NOT NULL)
            OR (UPDATING AND :NEW.dump IS NOT NULL AND :NEW.dump != NVL(:OLD.dump, '-'))
        THEN
            l_test_id := :NEW.test_id;
        END IF;

        -- delete related rows
        IF DELETING THEN
            DELETE FROM quiz_attempts   WHERE test_id = :OLD.test_id;
            DELETE FROM quiz_answers    WHERE test_id = :OLD.test_id;
            DELETE FROM quiz_questions  WHERE test_id = :OLD.test_id;
        END IF;
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error('TESTS_UPSERT_FAILED');
    END BEFORE EACH ROW;



    AFTER STATEMENT IS
    BEGIN
        IF l_test_id IS NOT NULL THEN
            quiz.import_questions(l_test_id);
        END IF;
    EXCEPTION
    WHEN app.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        app.raise_error('TESTS_FOLLOWUP_FAILED');
    END AFTER STATEMENT;

END;
/

