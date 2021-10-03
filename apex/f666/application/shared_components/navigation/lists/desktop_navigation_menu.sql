prompt --application/shared_components/navigation/lists/desktop_navigation_menu
begin
--   Manifest
--     LIST: Desktop Navigation Menu
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>123132524645685789
,p_default_application_id=>666
,p_default_id_offset=>0
,p_default_owner=>'DEV'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(123535914125712870)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(123685438105713450)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Home'
,p_list_item_link_target=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(157674760706448639)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Correct Answers (test)'
,p_list_item_link_target=>'f?p=&APP_ID.:120:&SESSION.::&DEBUG.::::'
,p_list_item_disp_cond_type=>'FUNCTION_BODY'
,p_list_item_disp_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'RETURN apex.get_item(''$TEST_ID'') IS NOT NULL AND sess.get_page_id() = 110;',
''))
,p_list_item_disp_condition2=>'PLSQL'
,p_parent_list_item_id=>wwv_flow_api.id(123685438105713450)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(157675226684462604)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Correct Answers (topic)'
,p_list_item_link_target=>'f?p=&APP_ID.:125:&SESSION.::&DEBUG.::P125_TOPIC_ID:&P100_TOPIC_ID.:'
,p_list_item_disp_cond_type=>'FUNCTION_BODY'
,p_list_item_disp_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'RETURN apex.get_item(''$TOPIC_ID'') IS NOT NULL AND sess.get_page_id() = 100;',
''))
,p_list_item_disp_condition2=>'PLSQL'
,p_parent_list_item_id=>wwv_flow_api.id(123685438105713450)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(157422883934597000)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Roadmap'
,p_list_item_link_target=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-road'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.component_end;
end;
/
