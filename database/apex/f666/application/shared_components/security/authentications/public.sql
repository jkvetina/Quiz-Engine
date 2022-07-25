prompt --application/shared_components/security/authentications/public
begin
--   Manifest
--     AUTHENTICATION: PUBLIC
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
 p_id=>wwv_flow_imp.id(124199700238750337)
,p_name=>'PUBLIC'
,p_scheme_type=>'NATIVE_DAD'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
wwv_flow_imp.component_end;
end;
/
