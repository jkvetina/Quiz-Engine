prompt --application/pages/page_00110
begin
--   Manifest
--     PAGE: 00110
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
 p_id=>110
,p_user_interface_id=>wwv_flow_imp.id(123675636937713302)
,p_name=>'Questions'
,p_alias=>'QUESTION'
,p_step_title=>'Question &P110_QUESTION_ID./&P110_QUESTIONS.'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(142404407822658913)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#P110_ANSWER {',
'  padding         : 0;',
'  margin          : 1rem 0 0 1.5rem;',
'}',
'',
'#QUESTION {',
'  padding         : 1.5rem 0 0;',
'}',
'.col.QUESTION {',
'  line-height     : 200%;',
'}',
'#P110_QUESTION_DISPLAY {',
'  font-size       : 2rem !important;',
'}',
'#P110_ANSWER_CONTAINER label {',
'  font-size       : 1.6rem !important;',
'  line-height     : 1.4;',
'}',
'',
'#P110_SKIP_CORRECT_CONTAINER {',
'  margin-left     : 1rem !important;',
'}',
'',
'.a-CardView.has-body.has-actions.has-actions--full,',
'.a-CardView-subContent {',
'  text-align      : right;',
'}',
'',
'.bold {',
'  font-weight     : bold;',
'}',
'',
'/** to align test results to the right */',
'.t-HeroRegion-col--content {',
'  flex-grow       : 1000;',
'}',
''))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'23'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(119237602062121148)
,p_plug_name=>'&P110_TEST_NAME. <div style="float: right;">&P110_RESULT.</div>'
,p_icon_css_classes=>'fa-question-square'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(123563463431712967)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>'Question &P110_QUESTION_ID./&P110_QUESTIONS.<span style="display: none;"> (pick &P110_EXPECTED.)</span>'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(125299989539847006)
,p_plug_name=>'Question'
,p_region_name=>'QUESTION'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(123590440289713011)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>6
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P110_QUESTION'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(125300247184847009)
,p_plug_name=>'Explanation'
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(123590440289713011)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'&P110_EXPLANATION.',
''))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P110_SHOW_CORRECT_FLAG'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(125303235319847039)
,p_plug_name=>'Bookmarked Questions (&P110_BOOKMARKED_PERC.%)'
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(123590440289713011)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(125302672452847033)
,p_plug_name=>'Questions'
,p_parent_plug_id=>wwv_flow_imp.id(125303235319847039)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(123562248546712965)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    q.*,',
'    CASE WHEN q.question_id = app.get_item(''$QUESTION_ID'')',
'        THEN ''bold''',
'        END AS css_class',
'FROM quiz_questions q',
'JOIN quiz_attempts t',
'    ON t.user_id        = app.get_user_id()',
'    AND t.test_id       = q.test_id',
'    AND t.question_id   = q.question_id',
'    AND t.is_bookmarked = ''Y''',
'WHERE q.test_id         = app.get_item(''$TEST_ID'')',
'ORDER BY 1, 2;',
''))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CARDS'
,p_plug_query_num_rows=>40
,p_plug_query_num_rows_type=>'SET'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_show_total_row_count=>true
);
wwv_flow_imp_page.create_card(
 p_id=>wwv_flow_imp.id(125302780384847034)
,p_region_id=>wwv_flow_imp.id(125302672452847033)
,p_layout_type=>'GRID'
,p_grid_column_count=>4
,p_title_adv_formatting=>false
,p_sub_title_adv_formatting=>false
,p_body_adv_formatting=>false
,p_second_body_adv_formatting=>false
,p_second_body_column_name=>'QUESTION_ID'
,p_second_body_css_classes=>'&CSS_CLASS.'
,p_media_adv_formatting=>false
,p_pk1_column_name=>'TEST_ID'
,p_pk2_column_name=>'QUESTION_ID'
);
wwv_flow_imp_page.create_card_action(
 p_id=>wwv_flow_imp.id(125302877209847035)
,p_card_id=>wwv_flow_imp.id(125302780384847034)
,p_action_type=>'FULL_CARD'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.::P110_TEST_ID,P110_QUESTION_ID,P110_ANSWER,P110_ERROR,P110_SKIP_CORRECT:&TEST_ID.,&QUESTION_ID.,,,Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(125303438397847041)
,p_plug_name=>'Unanswered Questions (&P110_UNANSWERED_PERC.%)'
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(123590440289713011)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(125303510916847042)
,p_plug_name=>'Questions'
,p_parent_plug_id=>wwv_flow_imp.id(125303438397847041)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(123562248546712965)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    q.*,',
'    CASE WHEN q.question_id = app.get_item(''$QUESTION_ID'')',
'        THEN ''bold''',
'        END AS css_class',
'FROM quiz_questions q',
'WHERE q.test_id         = app.get_item(''$TEST_ID'')',
'    AND q.question_id   NOT IN (',
'        SELECT q.question_id',
'        FROM quiz_questions q',
'        JOIN quiz_attempts t',
'            ON t.user_id        = app.get_user_id()',
'            AND t.test_id       = q.test_id',
'            AND t.question_id   = q.question_id',
'        WHERE q.test_id         = app.get_item(''$TEST_ID'')',
'            AND t.is_correct    = ''Y''',
'    )',
'ORDER BY 1, 2;',
''))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CARDS'
,p_plug_query_num_rows=>40
,p_plug_query_num_rows_type=>'SET'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_show_total_row_count=>true
);
wwv_flow_imp_page.create_card(
 p_id=>wwv_flow_imp.id(125303615721847043)
,p_region_id=>wwv_flow_imp.id(125303510916847042)
,p_layout_type=>'GRID'
,p_grid_column_count=>4
,p_title_adv_formatting=>false
,p_sub_title_adv_formatting=>false
,p_body_adv_formatting=>false
,p_second_body_adv_formatting=>false
,p_second_body_column_name=>'QUESTION_ID'
,p_second_body_css_classes=>'&CSS_CLASS.'
,p_media_adv_formatting=>false
,p_pk1_column_name=>'TEST_ID'
,p_pk2_column_name=>'QUESTION_ID'
);
wwv_flow_imp_page.create_card_action(
 p_id=>wwv_flow_imp.id(125303791360847044)
,p_card_id=>wwv_flow_imp.id(125303615721847043)
,p_action_type=>'FULL_CARD'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.::P110_TEST_ID,P110_QUESTION_ID,P110_BOOKMARKED,P110_ANSWER,P110_ERROR,P110_SKIP_CORRECT:&TEST_ID.,&QUESTION_ID.,N,,,Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(143434289536904436)
,p_plug_name=>'Correct Wrong Anwers'
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(123590440289713011)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_source=>'When you submit page with following button it will change correct answers to selected ones.'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P110_SHOW_CORRECT_FLAG'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(157355148505057706)
,p_plug_name=>'Questions to Verify (shared)'
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(123590440289713011)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(157355342085057708)
,p_plug_name=>'Questions'
,p_parent_plug_id=>wwv_flow_imp.id(157355148505057706)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(123562248546712965)
,p_plug_display_sequence=>70
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    q.*,',
'    CASE WHEN q.question_id = app.get_item(''$QUESTION_ID'')',
'        THEN ''bold''',
'        END AS css_class',
'FROM quiz_questions q',
'WHERE q.test_id         = app.get_item(''$TEST_ID'')',
'    AND q.is_to_verify  = ''Y''',
'ORDER BY 1, 2;',
''))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CARDS'
,p_plug_query_num_rows=>40
,p_plug_query_num_rows_type=>'SET'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_show_total_row_count=>true
);
wwv_flow_imp_page.create_card(
 p_id=>wwv_flow_imp.id(157355506882057710)
,p_region_id=>wwv_flow_imp.id(157355342085057708)
,p_layout_type=>'GRID'
,p_grid_column_count=>4
,p_title_adv_formatting=>false
,p_sub_title_adv_formatting=>false
,p_body_adv_formatting=>false
,p_second_body_adv_formatting=>false
,p_second_body_column_name=>'QUESTION_ID'
,p_second_body_css_classes=>'&CSS_CLASS.'
,p_media_adv_formatting=>false
,p_pk1_column_name=>'TEST_ID'
,p_pk2_column_name=>'QUESTION_ID'
);
wwv_flow_imp_page.create_card_action(
 p_id=>wwv_flow_imp.id(157355680264057711)
,p_card_id=>wwv_flow_imp.id(157355506882057710)
,p_action_type=>'FULL_CARD'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.::P110_TEST_ID,P110_QUESTION_ID,P110_ANSWER,P110_ERROR,P110_SKIP_CORRECT:&TEST_ID.,&QUESTION_ID.,,,Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(138600171193602708)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(125302672452847033)
,p_button_name=>'CLEAR_BOOKMARKS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(123652925875713205)
,p_button_image_alt=>'Clear Bookmarks'
,p_button_position=>'BELOW_BOX'
,p_button_condition=>'P110_BOOKMARKED_PERC'
,p_button_condition_type=>'ITEM_IS_NOT_ZERO'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(138601492651602721)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_button_name=>'SHOW_CORRECT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(123652233540713199)
,p_button_image_alt=>'Show Correct'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_button_redirect_url=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.::P110_TEST_ID,P110_QUESTION_ID,P110_SHOW_CORRECT,P110_ERROR:&P110_TEST_ID.,&P110_QUESTION_ID.,Y,'
,p_button_condition=>'P110_SHOW_CORRECT_FLAG'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_icon_css_classes=>'fa-question'
,p_button_cattributes=>'style="margin: 2rem 1.5rem 0 0;" title="Expecting: &P110_EXPECTED. answer(s)"'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(156720819081686222)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(143434289536904436)
,p_button_name=>'EDIT_QUESTION'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(123652233540713199)
,p_button_image_alt=>'Edit Question'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:210:&SESSION.::&DEBUG.:CR,:P210_TEST_ID,P210_QUESTION_ID:&P110_TEST_ID.,&P110_QUESTION_ID.'
,p_icon_css_classes=>'fa-edit'
,p_button_cattributes=>'style="margin: 2rem 0 0 1.5rem;"'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(138600422622602711)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(125303510916847042)
,p_button_name=>'CLEAR_PROGRESS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(123652925875713205)
,p_button_image_alt=>'Clear Progress'
,p_button_position=>'BELOW_BOX'
,p_button_condition=>'P110_PROGRESS_PERC'
,p_button_condition_type=>'ITEM_IS_NOT_ZERO'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(143434495252904438)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(143434289536904436)
,p_button_name=>'FIX_ANSWERS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(123652925875713205)
,p_button_image_alt=>'Overwrite Answers'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_cattributes=>'style="margin: 2rem 0 0 1.5rem;"'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(156720125706686215)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_button_name=>'PREV_ALL'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(123652233540713199)
,p_button_image_alt=>'Previous in List'
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-arrow-left'
,p_button_cattributes=>'style="margin: 2rem 0 0 1.5rem;"'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(157355217251057707)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_button_name=>'NEXT_ALL'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--pill'
,p_button_template_id=>wwv_flow_imp.id(123652233540713199)
,p_button_image_alt=>'Next in a List'
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-arrow-right'
,p_button_cattributes=>'style="margin: 2rem 0 0 1.5rem;"'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(125300026494847007)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_button_name=>'NEXT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_imp.id(123653030927713205)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'BELOW_BOX'
,p_icon_css_classes=>'fa-arrow-right'
,p_button_cattributes=>'style="margin: 2rem 0 0 1.5rem;"'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(125300578086847012)
,p_branch_name=>'REDIRECT'
,p_branch_action=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.::P110_TEST_ID,P110_QUESTION_ID,P110_BOOKMARKED,P110_ERROR:&P110_TEST_ID.,&P110_QUESTION_ID.,&P110_BOOKMARKED.,&P110_ERROR.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(143432819543904422)
,p_branch_name=>'REDIRECT_HOME'
,p_branch_action=>'f?p=&APP_ID.:HOME:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_HEADER'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'ITEM_IS_NULL'
,p_branch_condition=>'P110_TEST_ID'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(10947393675990539)
,p_branch_name=>'CHECK_ACCESS'
,p_branch_action=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.:CR,::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_HEADER'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>20
,p_branch_condition_type=>'NOT_EXISTS'
,p_branch_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1',
'FROM p100_tests_available a',
'WHERE a.test_id = :P100_TEST_ID;'))
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(119237738241121149)
,p_name=>'P110_QUESTION_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(119237602062121148)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(119237848181121150)
,p_name=>'P110_QUESTION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_prompt=>' '
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_grid_column_css_classes=>'QUESTION'
,p_read_only_when_type=>'ALWAYS'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(125299628598847003)
,p_name=>'P110_TEST_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(119237602062121148)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(125299750628847004)
,p_name=>'P110_TOPIC_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(119237602062121148)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(125299823496847005)
,p_name=>'P110_TEST_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(119237602062121148)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(125300391986847010)
,p_name=>'P110_EXPLANATION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(125300247184847009)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(125300820640847015)
,p_name=>'P110_ANSWER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.answer, a.answer_id',
'FROM quiz_answers a',
'WHERE a.test_id = app.get_item(''$TEST_ID'')',
'    AND a.question_id = app.get_item(''$QUESTION_ID'')',
'ORDER BY DBMS_RANDOM.VALUE();',
''))
,p_field_template=>wwv_flow_imp.id(123651838042713193)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'1'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(125302968374847036)
,p_name=>'P110_BOOKMARKED'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_prompt=>'Bookmark'
,p_display_as=>'NATIVE_YES_NO'
,p_grid_column=>10
,p_field_template=>wwv_flow_imp.id(123651838042713193)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(125303081926847037)
,p_name=>'P110_QUESTIONS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(119237602062121148)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(125303154096847038)
,p_name=>'P110_EXPECTED'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(119237602062121148)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(125303825420847045)
,p_name=>'P110_BOOKMARKED_PERC'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(125304098221847047)
,p_name=>'P110_UNANSWERED_PERC'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(138599676823602703)
,p_name=>'P110_ERROR'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(119237602062121148)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(138599962324602706)
,p_name=>'P110_PROGRESS_PERC'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(138600025986602707)
,p_name=>'P110_SKIP_CORRECT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(138601534030602722)
,p_name=>'P110_SHOW_CORRECT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(119237602062121148)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(143432413462904418)
,p_name=>'P110_SHOW_CORRECT_FLAG'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(119237602062121148)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(157355059261057705)
,p_name=>'P110_TO_VERIFY'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_prompt=>'Verify (shared)'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_grid_column=>11
,p_field_template=>wwv_flow_imp.id(123651838042713193)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(157581159288398850)
,p_name=>'P110_PUBLIC_NOTE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_prompt=>'Public Note'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_imp.id(123651838042713193)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(157813919505227901)
,p_name=>'P110_PRIVATE_NOTE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(125299989539847006)
,p_prompt=>'Private Note'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(123651838042713193)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(157814735789227909)
,p_name=>'P110_RESULT'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(119237602062121148)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(157814873025227910)
,p_computation_sequence=>20
,p_computation_item=>'P110_RESULT'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    app.get_item(''$PROGRESS_PERC'') || ''% done, '' ||',
'    (100 - app.get_item(''$BOOKMARKED_PERC'')) || ''% correct'' ||',
'    CASE',
'        WHEN (100 - app.get_item(''$BOOKMARKED_PERC'')) > c.pass_ratio THEN '' = PASS''',
'        WHEN c.pass_ratio IS NOT NULL THEN '' = FAIL''',
'        END AS result_',
'FROM DUAL',
'LEFT JOIN plan_certifications c',
'    ON c.path_id = app.get_item(''$TOPIC_ID'');',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(138599797885602704)
,p_name=>'SHOW_ERROR'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P110_ERROR'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(138599863314602705)
,p_event_id=>wwv_flow_imp.id(138599797885602704)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
' apex.message.showErrors([{',
'    type:       "error",',
'    location:   [ "page" ],',
'    message:    $v(''P110_ERROR''),',
'    unsafe:     true',
'}]);',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(156721773710686231)
,p_name=>'CONFIRM_AND_SUBMIT'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(143434495252904438)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(156721895836686232)
,p_event_id=>wwv_flow_imp.id(156721773710686231)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CONFIRM'
,p_attribute_01=>'Are you sure?'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(156721951454686233)
,p_event_id=>wwv_flow_imp.id(156721773710686231)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'FIX_ANSWERS'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(138600208045602709)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CLEAR_BOOKMARKS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'quiz.clear_bookmarks();',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(138600171193602708)
,p_process_success_message=>'Bookmarks cleared'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(138600545339602712)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CLEAR_PROGRESS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'quiz.clear_progress();',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(138600422622602711)
,p_process_success_message=>'Progress cleared'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(125302463944847031)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PROCESS_ANSWER'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'quiz.process_answer (',
'    in_answer           => :P110_ANSWER,',
'    in_bookmarked       => :P110_BOOKMARKED,',
'    in_to_verify        => :P110_TO_VERIFY,',
'    in_public_note      => :P110_PUBLIC_NOTE,',
'    in_private_note     => :P110_PRIVATE_NOTE',
');',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(125299592129847002)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PREPARE_ITEMS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'quiz.prepare_items();',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp.component_end;
end;
/
