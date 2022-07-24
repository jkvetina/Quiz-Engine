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
-- Authorization: IS_DEVELOPER
-- PL/SQL Function Body

RETURN LOWER(sess.get_user_id()) IN (
    'jan.kvetina@gmail.com'
);

