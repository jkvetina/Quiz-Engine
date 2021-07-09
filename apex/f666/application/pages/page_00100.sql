prompt --application/pages/page_00100
begin
--   Manifest
--     PAGE: 00100
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>123132524645685789
,p_default_application_id=>666
,p_default_id_offset=>0
,p_default_owner=>'DEV'
);
wwv_flow_api.create_page(
 p_id=>100
,p_user_interface_id=>wwv_flow_api.id(123675636937713302)
,p_name=>'Home'
,p_alias=>'HOME'
,p_step_title=>'Home'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(142404407822658913)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.bold {',
'  font-weight: bold;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'QUIZ_DEV'
,p_last_upd_yyyymmddhh24miss=>'20210705190929'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(143432731519904421)
,p_plug_name=>'&P100_BADGE_NAME.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(123590440289713011)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>6
,p_plug_display_column=>7
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FOR c IN (',
'    SELECT t.*',
'    FROM quiz_topics t',
'    WHERE t.topic_id        = apex.get_item(''$TEST_GROUP'')',
'        AND t.badge_name    IS NOT NULL',
') LOOP',
'    htp.p(''<img src="#APP_IMAGES#'' || c.badge_image || ''" width="180" style="float: left; clear: none; padding: 2rem 3rem 2rem 2rem;" />'');',
'    htp.p(''<p style="line-height: 150%;">'' || c.note || ''</p>'');',
'END LOOP;',
''))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P100_TEST_GROUP'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(143433243775904426)
,p_plug_name=>'Tests'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(123590440289713011)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P100_TEST_GROUP'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282002255787335588)
,p_plug_name=>'Tests'
,p_parent_plug_id=>wwv_flow_api.id(143433243775904426)
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(123562018608712965)
,p_plug_display_sequence=>10
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'P100_TESTS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_JQM_LIST_VIEW'
,p_plug_query_num_rows=>30
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P100_TEST_GROUP'
,p_attribute_01=>'ADVANCED_FORMATTING'
,p_attribute_05=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<span class="&CSS_CLASS.">&TEST_NAME.</span>',
''))
,p_attribute_07=>'&SUPPLEMENTAL.'
,p_attribute_08=>'COUNT_'
,p_attribute_16=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.::P110_TEST_ID,P110_QUESTION_ID,P110_ERROR,P110_SKIP_CORRECT,P110_BOOKMARKED,P110_ANSWER:&TEST_ID.,,,Y,N,'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(143434133281904435)
,p_plug_name=>'Activity Check'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(123562018608712965)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    a.user_id           AS name,',
'    COUNT(*)            AS counter,',
'    --',
'    TO_CHAR(MAX(a.updated_at), ''YYYY-MM-DD, HH24:MI'') AS supplement',
'FROM quiz_attempts a',
'JOIN quiz_tests t',
'    ON t.test_id        = a.test_id',
'WHERE t.test_topic      = NVL(apex.get_item(''$TEST_GROUP''), t.test_topic)',
'GROUP BY a.user_id',
'ORDER BY 1;',
''))
,p_plug_source_type=>'NATIVE_JQM_LIST_VIEW'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_required_role=>wwv_flow_api.id(123678145775713360)
,p_attribute_02=>'NAME'
,p_attribute_06=>'SUPPLEMENT'
,p_attribute_08=>'COUNTER'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(262636895176854000)
,p_plug_name=>'Topics'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(123590440289713011)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'P100_TOPICS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_JQM_LIST_VIEW'
,p_plug_query_num_rows=>30
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'ADVANCED_FORMATTING'
,p_attribute_05=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<span class="&CSS_CLASS.">&NAME.</span>',
''))
,p_attribute_07=>'&SUPPLEMENTAL.'
,p_attribute_08=>'COUNTER'
,p_attribute_16=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.::P100_TEST_GROUP:&TOPIC_ID.'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268704768338579914)
,p_plug_name=>'Available Exam Preps'
,p_icon_css_classes=>'fa-clipboard-list'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(123563463431712967)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(143432941306904423)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(282002255787335588)
,p_button_name=>'CREATE_FROM_BOOKMARKED'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(123652925875713205)
,p_button_image_alt=>'Create new from &P100_BOOKMARKED_COUNT. bookmarked q.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P100_BOOKMARKED_COUNT'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_button_cattributes=>'style="margin: 2rem 0 0;"'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143432627833904420)
,p_name=>'P100_TEST_GROUP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(262636895176854000)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143433096446904424)
,p_name=>'P100_BOOKMARKED_COUNT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(262636895176854000)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143433541437904429)
,p_name=>'P100_TEST_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(262636895176854000)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143433743077904431)
,p_name=>'P100_BADGE_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(262636895176854000)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(143433180107904425)
,p_computation_sequence=>10
,p_computation_item=>'P100_BOOKMARKED_COUNT'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COUNT(*) AS count_',
'FROM quiz_attempts a',
'WHERE a.user_id         = sess.get_user_id()',
'    AND a.is_bookmarked = ''Y''',
'    AND a.test_id       IN (',
'        SELECT t.test_id',
'        FROM quiz_tests t',
'        WHERE t.test_topic      = apex.get_item(''$TEST_GROUP'')',
'            AND t.test_name     != ''BOOKMARKED''',
'    );',
''))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(143433821407904432)
,p_computation_sequence=>20
,p_computation_item=>'P100_BADGE_NAME'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT t.badge_name',
'FROM quiz_topics t',
'WHERE t.topic_id = apex.get_item(''$TEST_GROUP'');',
''))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(143433635334904430)
,p_computation_sequence=>10
,p_computation_item=>'P100_TEST_ID'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT MIN(a.test_id) KEEP (DENSE_RANK FIRST ORDER BY a.updated_at DESC) AS last_test',
'FROM quiz_attempts a',
'JOIN quiz_tests t',
'    ON t.test_id        = a.test_id',
'WHERE a.user_id         = sess.get_user_id()',
'    AND t.test_topic    = apex.get_item(''$TEST_GROUP'');',
''))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143433449856904428)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CREATE_BOOKMARKED'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'quiz.create_bookmarked_test (',
'    in_test_group       => apex.get_item(''$TEST_GROUP''),',
'    in_user_id          => sess.get_user_id()',
');',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(143432941306904423)
,p_process_success_message=>'Test from bookmarked questions created/updated'
);
wwv_flow_api.component_end;
end;
/
