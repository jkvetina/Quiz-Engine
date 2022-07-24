prompt --application/pages/page_groups
begin
--   Manifest
--     PAGE GROUPS: 666
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.6'
,p_default_workspace_id=>123132524645685789
,p_default_application_id=>666
,p_default_id_offset=>0
,p_default_owner=>'DEV'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(157555888025214138)
,p_group_name=>'PLAN'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(142404407822658913)
,p_group_name=>'QUIZ'
);
wwv_flow_api.component_end;
end;
/
