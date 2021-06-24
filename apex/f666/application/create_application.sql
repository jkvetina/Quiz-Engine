prompt --application/create_application
begin
--   Manifest
--     FLOW: 666
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>123132524645685789
,p_default_application_id=>666
,p_default_id_offset=>0
,p_default_owner=>'DEV'
);
wwv_flow_api.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'DEV')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Quiz Engine')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'QUIZ')
,p_page_view_logging=>'NO'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'806CB40F48CEEB979D9EA3C2682DAD665FFA2BA8FD1AFCEF83B9CDE9841889F2'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'19.2'
,p_flow_language=>'en-us'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_date_format=>'DS'
,p_timestamp_format=>'DS'
,p_timestamp_tz_format=>'DS'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_documentation_banner=>'Application created from create application wizard 2021.06.13.'
,p_authentication=>'PLUGIN'
,p_authentication_id=>wwv_flow_api.id(124199700238750337)
,p_application_tab_set=>0
,p_logo_type=>'T'
,p_logo_text=>'Quiz Engine'
,p_app_builder_icon_name=>'app-icon.svg'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>'This application is currently unavailable at this time.'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_error_handling_function=>'#OWNER#.tree.log_apex_error'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'Quiz Engine'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20210624095131'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>3
,p_ui_type_name => null
,p_print_server_type=>'NATIVE'
);
wwv_flow_api.component_end;
end;
/
