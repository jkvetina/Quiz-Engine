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
-- Shared Component
-- Entry: Correct Answers (test)
-- PL/SQL Function Body

RETURN apex.get_item('$TEST_ID') IS NOT NULL AND sess.get_page_id() = 110;


-- ----------------------------------------
-- Shared Component
-- Entry: Correct Answers (topic)
-- PL/SQL Function Body

RETURN apex.get_item('$TOPIC_ID') IS NOT NULL AND sess.get_page_id() = 100;


