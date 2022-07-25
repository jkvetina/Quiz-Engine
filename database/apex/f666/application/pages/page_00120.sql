prompt --application/pages/page_00120
begin
--   Manifest
--     PAGE: 00120
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.04.12'
,p_release=>'22.1.2'
,p_default_workspace_id=>9014660246496943
,p_default_application_id=>666
,p_default_id_offset=>0
,p_default_owner=>'QUIZ'
);
wwv_flow_imp_page.create_page(
 p_id=>120
,p_user_interface_id=>wwv_flow_imp.id(123675636937713302)
,p_name=>'Correct Answers'
,p_alias=>'ANSWERS'
,p_step_title=>'Correct Answers'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(142404407822658913)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'h4 {',
'  margin-top: 2rem;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'10'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(138600318092602710)
,p_plug_name=>'Left'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(123590440289713011)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>4
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    FOR q IN (',
'        SELECT q.*',
'        FROM (',
'            SELECT q.*, NTILE(3) OVER (ORDER BY q.question_id) AS third',
'            FROM quiz_questions q',
'            WHERE q.test_id         = app.get_item(''$TEST_ID'')',
'        ) q',
'        WHERE q.third = 1',
'        ORDER BY q.question_id',
'    ) LOOP',
'        htp.p(''<h4>'' || q.question_id || '') '' || q.question || ''</h4>'');',
'        htp.p(''<ul>'');',
'        --',
'        FOR a IN (',
'            SELECT a.*',
'            FROM quiz_answers a',
'            WHERE a.test_id         = app.get_item(''$TEST_ID'')',
'                AND a.question_id   = q.question_id',
'                AND a.is_correct    IN (''X'', ''Y'')',
'            ORDER BY a.answer_id',
'        ) LOOP',
'            htp.p(''<li>'' || a.answer || ''</li>'');',
'        END LOOP;',
'        --',
'        htp.p(''</ul>'');',
'    END LOOP;',
'END;',
''))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(138601042007602717)
,p_plug_name=>'Right'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(123590440289713011)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    FOR q IN (',
'        SELECT q.*',
'        FROM (',
'            SELECT q.*, NTILE(3) OVER (ORDER BY q.question_id) AS third',
'            FROM quiz_questions q',
'            WHERE q.test_id         = app.get_item(''$TEST_ID'')',
'        ) q',
'        WHERE q.third = 3',
'        ORDER BY q.question_id',
'    ) LOOP',
'        htp.p(''<h4>'' || q.question_id || '') '' || q.question || ''</h4>'');',
'        htp.p(''<ul>'');',
'        --',
'        FOR a IN (',
'            SELECT a.*',
'            FROM quiz_answers a',
'            WHERE a.test_id         = app.get_item(''$TEST_ID'')',
'                AND a.question_id   = q.question_id',
'                AND a.is_correct    IN (''X'', ''Y'')',
'            ORDER BY a.answer_id',
'        ) LOOP',
'            htp.p(''<li>'' || a.answer || ''</li>'');',
'        END LOOP;',
'        --',
'        htp.p(''</ul>'');',
'    END LOOP;',
'END;',
''))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(138601255689602719)
,p_plug_name=>'Middle'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(123590440289713011)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    FOR q IN (',
'        SELECT q.*',
'        FROM (',
'            SELECT q.*, NTILE(3) OVER (ORDER BY q.question_id) AS third',
'            FROM quiz_questions q',
'            WHERE q.test_id         = app.get_item(''$TEST_ID'')',
'        ) q',
'        WHERE q.third = 2',
'        ORDER BY q.question_id',
'    ) LOOP',
'        htp.p(''<h4>'' || q.question_id || '') '' || q.question || ''</h4>'');',
'        htp.p(''<ul>'');',
'        --',
'        FOR a IN (',
'            SELECT a.*',
'            FROM quiz_answers a',
'            WHERE a.test_id         = app.get_item(''$TEST_ID'')',
'                AND a.question_id   = q.question_id',
'                AND a.is_correct    IN (''X'', ''Y'')',
'            ORDER BY a.answer_id',
'        ) LOOP',
'            htp.p(''<li>'' || a.answer || ''</li>'');',
'        END LOOP;',
'        --',
'        htp.p(''</ul>'');',
'    END LOOP;',
'END;',
''))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(138600625989602713)
,p_name=>'P120_TEST_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(138600318092602710)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(138600966412602716)
,p_computation_sequence=>10
,p_computation_item=>'P120_TEST_ID'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'EXPRESSION'
,p_computation_language=>'PLSQL'
,p_computation=>'NVL(:P110_TEST_ID, :P120_TEST_ID)'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(138600767229602714)
,p_name=>'AUTO_SUBMIT'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P120_TEST_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(138600890719602715)
,p_event_id=>wwv_flow_imp.id(138600767229602714)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp.component_end;
end;
/
