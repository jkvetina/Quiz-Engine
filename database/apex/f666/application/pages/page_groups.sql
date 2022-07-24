prompt --application/pages/page_groups
begin
--   Manifest
--     PAGE GROUPS: 666
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.04.12'
,p_release=>'22.1.2'
,p_default_workspace_id=>123132524645685789
,p_default_application_id=>666
,p_default_id_offset=>0
,p_default_owner=>'DEV'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(157555888025214138)
,p_group_name=>'PLAN'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(142404407822658913)
,p_group_name=>'QUIZ'
);
wwv_flow_imp.component_end;
end;
/
