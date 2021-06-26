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
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'QUIZ_DEV'
,p_last_upd_yyyymmddhh24miss=>'20210626045449'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(262636895176854000)
,p_plug_name=>'PSPO I'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(123588534616713005)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    t.test_id,',
'    t.test_name,',
'    t.test_group,',
'    --',
'    t.questions || '' questions, '' || t.explanations || '' explanations'' AS supplemental,',
'    --',
'    NVL(FLOOR(100 * (t.is_correct / t.questions)), 0) || ''%'' AS progress',
'FROM (',
'    SELECT',
'        t.test_id,',
'        t.test_name,',
'        t.test_group,',
'        COUNT(q.question_id)                                        AS questions,',
'        SUM(CASE WHEN q.explanation IS NOT NULL THEN 1 ELSE 0 END)  AS explanations,',
'        SUM(CASE WHEN a.is_correct = ''Y'' THEN 1 ELSE 0 END)         AS is_correct',
'    FROM quiz_questions q',
'    JOIN quiz_tests t',
'        ON t.test_id        = q.test_id',
'    LEFT JOIN quiz_attempts a',
'        ON a.user_id        = sess.get_user_id()',
'        AND a.test_id       = q.test_id',
'        AND a.question_id   = q.question_id',
'    WHERE t.test_group      = ''PSPO I''',
'    GROUP BY t.test_id, t.test_name, t.test_group',
') t',
'ORDER BY 1;',
''))
,p_plug_source_type=>'NATIVE_JQM_LIST_VIEW'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_02=>'TEST_NAME'
,p_attribute_06=>'SUPPLEMENTAL'
,p_attribute_08=>'PROGRESS'
,p_attribute_16=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.::P110_TEST_ID,P110_QUESTION_ID,P110_ERROR,P110_SKIP_CORRECT,P110_BOOKMARKED,P110_ANSWER:&TEST_ID.,,,Y,N,'
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
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282002255787335588)
,p_plug_name=>'PSPO II'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(123588534616713005)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    t.test_id,',
'    t.test_name,',
'    t.test_group,',
'    --',
'    t.questions || '' questions, '' || t.explanations || '' explanations'' AS supplemental,',
'    --',
'    NVL(FLOOR(100 * (t.is_correct / t.questions)), 0) || ''%'' AS progress',
'FROM (',
'    SELECT',
'        t.test_id,',
'        t.test_name,',
'        t.test_group,',
'        COUNT(q.question_id)                                        AS questions,',
'        SUM(CASE WHEN q.explanation IS NOT NULL THEN 1 ELSE 0 END)  AS explanations,',
'        SUM(CASE WHEN a.is_correct = ''Y'' THEN 1 ELSE 0 END)         AS is_correct',
'    FROM quiz_questions q',
'    JOIN quiz_tests t',
'        ON t.test_id        = q.test_id',
'    LEFT JOIN quiz_attempts a',
'        ON a.user_id        = sess.get_user_id()',
'        AND a.test_id       = q.test_id',
'        AND a.question_id   = q.question_id',
'    WHERE t.test_group      = ''PSPO II''',
'    GROUP BY t.test_id, t.test_name, t.test_group',
') t',
'ORDER BY 1;',
''))
,p_plug_source_type=>'NATIVE_JQM_LIST_VIEW'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_02=>'TEST_NAME'
,p_attribute_06=>'SUPPLEMENTAL'
,p_attribute_08=>'PROGRESS'
,p_attribute_16=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.::P110_TEST_ID,P110_QUESTION_ID,P110_ERROR,P110_SKIP_CORRECT,P110_BOOKMARKED,P110_ANSWER:&TEST_ID.,,,Y,N,'
);
wwv_flow_api.component_end;
end;
/
