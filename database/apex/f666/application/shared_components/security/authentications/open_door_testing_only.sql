prompt --application/shared_components/security/authentications/open_door_testing_only
begin
--   Manifest
--     AUTHENTICATION: OPEN_DOOR (TESTING ONLY)
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.04.12'
,p_release=>'22.1.2'
,p_default_workspace_id=>9014660246496943
,p_default_application_id=>666
,p_default_id_offset=>0
,p_default_owner=>'QUIZ'
);
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(143713614190744339)
,p_name=>'OPEN_DOOR (TESTING ONLY)'
,p_scheme_type=>'NATIVE_OPEN_DOOR'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
wwv_flow_imp.component_end;
end;
/
