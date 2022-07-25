prompt --application/pages/page_00125
begin
--   Manifest
--     PAGE: 00125
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
 p_id=>125
,p_user_interface_id=>wwv_flow_imp.id(123675636937713302)
,p_name=>'Correct Answers (for topic)'
,p_alias=>'ANSWERS-ALL'
,p_step_title=>'Correct Answers (for topic)'
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
 p_id=>wwv_flow_imp.id(286600257237137941)
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
'        FROM p120_correct_questions q',
'        WHERE q.third = 1',
'        ORDER BY q.test_id, q.question_id',
'    ) LOOP',
'        htp.p(''<h4>'' || q.question_id || '') '' || q.question || ''</h4>'');',
'        htp.p(''<ul>'');',
'        --',
'        FOR a IN (',
'            SELECT a.*',
'            FROM p120_correct_answers a',
'            WHERE a.test_id         = q.test_id',
'                AND a.question_id   = q.question_id',
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
 p_id=>wwv_flow_imp.id(286600981152137948)
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
'        FROM p120_correct_questions q',
'        WHERE q.third = 3',
'        ORDER BY q.test_id, q.question_id',
'    ) LOOP',
'        htp.p(''<h4>'' || q.question_id || '') '' || q.question || ''</h4>'');',
'        htp.p(''<ul>'');',
'        --',
'        FOR a IN (',
'            SELECT a.*',
'            FROM p120_correct_answers a',
'            WHERE a.test_id         = q.test_id',
'                AND a.question_id   = q.question_id',
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
 p_id=>wwv_flow_imp.id(286601194834137950)
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
'        FROM p120_correct_questions q',
'        WHERE q.third = 2',
'        ORDER BY q.test_id, q.question_id',
'    ) LOOP',
'        htp.p(''<h4>'' || q.question_id || '') '' || q.question || ''</h4>'');',
'        htp.p(''<ul>'');',
'        --',
'        FOR a IN (',
'            SELECT a.*',
'            FROM p120_correct_answers a',
'            WHERE a.test_id         = q.test_id',
'                AND a.question_id   = q.question_id',
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
 p_id=>wwv_flow_imp.id(143433903431904433)
,p_name=>'P125_TOPIC_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(286600257237137941)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(148000534642535293)
,p_name=>'P125_TEST_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(286600257237137941)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(148001678531535404)
,p_computation_sequence=>10
,p_computation_item=>'P125_TEST_ID'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'EXPRESSION'
,p_computation_language=>'PLSQL'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'COALESCE(:P110_TEST_ID, :P125_TEST_ID)',
''))
,p_computation_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'USE GLOBAL ITEM INSTEAD',
''))
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(143434014540904434)
,p_computation_sequence=>20
,p_computation_item=>'P125_TOPIC_ID'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'EXPRESSION'
,p_computation_language=>'PLSQL'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'COALESCE(:P100_TOPIC_ID, :P110_TOPIC_ID, :P125_TOPIC_ID)',
''))
,p_computation_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'USE GLOBAL ITEM INSTEAD',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(148001805470535406)
,p_name=>'AUTO_SUBMIT'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P125_TEST_ID'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(148002306714535415)
,p_event_id=>wwv_flow_imp.id(148001805470535406)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp.component_end;
end;
/
