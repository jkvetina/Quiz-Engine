-- --------------------------------------------------------------------------------
-- 
-- Oracle APEX source export file
-- 
-- The contents of this file are intended for review and analysis purposes only.
-- Developers must use the Application Builder to make modifications to an
-- application. Changes to this file will not be reflected in the application.
-- 
-- --------------------------------------------------------------------------------

-- ----------------------------------------
-- Page 300: Roadmap
-- Computation: P300_DAYS_LEFT
-- SQL Query

SELECT TO_DATE('2021-12-31', 'YYYY-MM-DD') - TRUNC(SYSDATE) FROM DUAL;

-- ----------------------------------------
-- Page 300: Roadmap
-- Process: RESORT
-- PL/SQL Code

quiz.resort_priorities();


-- ----------------------------------------
-- Page 300: Roadmap
-- Process: SAVE_NOTES_DONE
-- PL/SQL Code to Insert/Update/Delete

quiz.save_notes (
    in_cert_id      => :CERT_ID,
    in_is_done      => :IS_DONE,
    in_priority     => :PRIORITY,
    in_notes        => :NOTES
);


-- ----------------------------------------
-- Page 300: Roadmap
-- Process: SAVE_NOTES
-- PL/SQL Code to Insert/Update/Delete

quiz.save_notes (
    in_cert_id      => :CERT_ID,
    in_is_done      => :IS_DONE,
    in_priority     => :PRIORITY,
    in_notes        => :NOTES
);


