prompt --application/pages/page_00210
begin
--   Manifest
--     PAGE: 00210
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.04.12'
,p_release=>'22.1.2'
,p_default_workspace_id=>123132524645685789
,p_default_application_id=>666
,p_default_id_offset=>0
,p_default_owner=>'DEV'
);
wwv_flow_imp_page.create_page(
 p_id=>210
,p_user_interface_id=>wwv_flow_imp.id(123675636937713302)
,p_name=>'Management'
,p_alias=>'MANAGEMENT'
,p_step_title=>'Management'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(142404407822658913)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'h2 {',
'  font-size: 140%;',
'  margin-top: 2rem;',
'}',
'',
'button.t-Button:first-child {',
'  margin-left: 2rem;',
'}',
''))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'21'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(138603958930602746)
,p_plug_name=>'Questions'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(156812568237340614)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'TABLE'
,p_query_table=>'QUIZ_QUESTIONS'
,p_query_where=>wwv_flow_string.join(wwv_flow_t_varchar2(
'test_id = COALESCE(TO_NUMBER(apex.get_item(''$TEST_ID'')), test_id)',
'AND question_id = COALESCE(TO_NUMBER(apex.get_item(''$QUESTION_ID'')), question_id)',
''))
,p_include_rowid_column=>true
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P210_TEST_ID'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Questions'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(138604148955602748)
,p_name=>'TEST_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TEST_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(138604200018602749)
,p_name=>'QUESTION_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'QUESTION_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Question Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>40
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(138604318017602750)
,p_name=>'QUESTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'QUESTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Question'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143430796143904401)
,p_name=>'EXPLANATION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EXPLANATION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Explanation'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143430840370904402)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>70
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143431798468904411)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143431880101904412)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(138604050944602747)
,p_internal_uid=>138604050944602747
,p_is_editable=>true
,p_edit_operations=>'u:d'
,p_lost_update_check_type=>'VALUES'
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(143436380839905156)
,p_interactive_grid_id=>wwv_flow_imp.id(138604050944602747)
,p_static_id=>'1434364'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(143436581258905156)
,p_report_id=>wwv_flow_imp.id(143436380839905156)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143437085003905169)
,p_view_id=>wwv_flow_imp.id(143436581258905156)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(138604148955602748)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143437982781905172)
,p_view_id=>wwv_flow_imp.id(143436581258905156)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(138604200018602749)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>118.20499999999998
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143438824656905175)
,p_view_id=>wwv_flow_imp.id(143436581258905156)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(138604318017602750)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143439734007905178)
,p_view_id=>wwv_flow_imp.id(143436581258905156)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(143430796143904401)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143440641248905181)
,p_view_id=>wwv_flow_imp.id(143436581258905156)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(143430840370904402)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143448040947954320)
,p_view_id=>wwv_flow_imp.id(143436581258905156)
,p_display_seq=>0
,p_column_id=>wwv_flow_imp.id(143431798468904411)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(143430934763904403)
,p_plug_name=>'Answers'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(156812568237340614)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'TABLE'
,p_query_table=>'QUIZ_ANSWERS'
,p_query_where=>wwv_flow_string.join(wwv_flow_t_varchar2(
'test_id = COALESCE(TO_NUMBER(apex.get_item(''$TEST_ID'')), test_id)',
'AND question_id = COALESCE(TO_NUMBER(apex.get_item(''$QUESTION_ID'')), question_id)',
''))
,p_include_rowid_column=>true
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P210_QUESTION_ID'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Answers'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143431131034904405)
,p_name=>'TEST_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TEST_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143431260926904406)
,p_name=>'QUESTION_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'QUESTION_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143431357477904407)
,p_name=>'ANSWER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ANSWER_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Answer Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>50
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143431462233904408)
,p_name=>'ANSWER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ANSWER'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Answer'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143431587620904409)
,p_name=>'IS_CORRECT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_CORRECT'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Is Correct'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143432026778904414)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143432146840904415)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(143432395697904417)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>80
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(143431038984904404)
,p_internal_uid=>143431038984904404
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(143441934397950427)
,p_interactive_grid_id=>wwv_flow_imp.id(143431038984904404)
,p_static_id=>'1434420'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(143442122750950428)
,p_report_id=>wwv_flow_imp.id(143441934397950427)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143442616963950430)
,p_view_id=>wwv_flow_imp.id(143442122750950428)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(143431131034904405)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143443510347950434)
,p_view_id=>wwv_flow_imp.id(143442122750950428)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(143431260926904406)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143444436084950437)
,p_view_id=>wwv_flow_imp.id(143442122750950428)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(143431357477904407)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>113.19900000000001
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143445342342950440)
,p_view_id=>wwv_flow_imp.id(143442122750950428)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(143431462233904408)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143446210802950444)
,p_view_id=>wwv_flow_imp.id(143442122750950428)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(143431587620904409)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>96.577
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143451822454956015)
,p_view_id=>wwv_flow_imp.id(143442122750950428)
,p_display_seq=>0
,p_column_id=>wwv_flow_imp.id(143432026778904414)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(143455636083957045)
,p_view_id=>wwv_flow_imp.id(143442122750950428)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(143432395697904417)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(156721077671686224)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(138603958930602746)
,p_button_name=>'PREV'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillStart'
,p_button_template_id=>wwv_flow_imp.id(123652233540713199)
,p_button_image_alt=>'Prev'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_redirect_url=>'f?p=&APP_ID.:210:&SESSION.::&DEBUG.::P210_TEST_ID,P210_QUESTION_ID:&P210_TEST_ID.,&P210_PREV_ID.'
,p_button_condition=>'P210_PREV_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-arrow-left'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(156721131698686225)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(138603958930602746)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pill'
,p_button_template_id=>wwv_flow_imp.id(123652233540713199)
,p_button_image_alt=>'Next'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_redirect_url=>'f?p=&APP_ID.:210:&SESSION.::&DEBUG.::P210_TEST_ID,P210_QUESTION_ID:&P210_TEST_ID.,&P210_NEXT_ID.'
,p_button_condition=>'P210_NEXT_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-arrow-right'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(156721657410686230)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(138603958930602746)
,p_button_name=>'TEST_QUESTION'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillStart'
,p_button_template_id=>wwv_flow_imp.id(123652233540713199)
,p_button_image_alt=>'Test Question'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_redirect_url=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.:CR,:P110_TEST_ID,P110_QUESTION_ID,P110_SHOW_CORRECT:&P210_TEST_ID.,&P210_QUESTION_ID.,'
,p_icon_css_classes=>'fa-play'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(156720678690686220)
,p_name=>'P210_TEST_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(138603958930602746)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(156720734076686221)
,p_name=>'P210_QUESTION_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(138603958930602746)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(156720948007686223)
,p_name=>'P210_TOPIC_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(138603958930602746)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(156721215094686226)
,p_name=>'P210_PREV_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(138603958930602746)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(156721382276686227)
,p_name=>'P210_NEXT_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(138603958930602746)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(143431950915904413)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(138603958930602746)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Questions - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(143432206758904416)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(143430934763904403)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Answers - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(156721421378686228)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'GET_ID'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FOR c IN (',
'    SELECT MIN(q.question_id) AS next_id',
'    FROM quiz_questions q',
'    WHERE q.test_id         = apex.get_item(''$TEST_ID'')',
'        AND q.question_id   > apex.get_item(''$QUESTION_ID'')',
') LOOP',
'    apex.set_item(''$NEXT_ID'', c.next_id);',
'END LOOP;',
'--',
'FOR c IN (',
'    SELECT MAX(q.question_id) AS prev_id',
'    FROM quiz_questions q',
'    WHERE q.test_id         = apex.get_item(''$TEST_ID'')',
'        AND q.question_id   < apex.get_item(''$QUESTION_ID'')',
') LOOP',
'    apex.set_item(''$PREV_ID'', c.prev_id);',
'END LOOP;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp.component_end;
end;
/
