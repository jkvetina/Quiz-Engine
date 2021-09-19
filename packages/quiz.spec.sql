CREATE OR REPLACE PACKAGE quiz AS

    prev_button         CONSTANT VARCHAR2(30) := 'PREV';
    prev_all_button     CONSTANT VARCHAR2(30) := 'PREV_ALL';
    next_button         CONSTANT VARCHAR2(30) := 'NEXT';
    next_all_button     CONSTANT VARCHAR2(30) := 'NEXT_ALL';



    PROCEDURE prepare_items;



    PROCEDURE process_answer (
        in_answer           VARCHAR2,
        in_bookmarked       quiz_attempts.is_bookmarked%TYPE,
        in_to_verify        quiz_questions.is_to_verify%TYPE
    );



    PROCEDURE clear_bookmarks;



    PROCEDURE clear_progress;



    FUNCTION get_prev_next_question (
        in_test_id          quiz_questions.test_id%TYPE,
        in_question_id      quiz_questions.question_id%TYPE,
        in_bookmarked       CHAR                                := 'Y',
        in_unanswered       CHAR                                := 'Y',
        in_direction        VARCHAR2                            := quiz.next_button,
        in_user_id          VARCHAR2                            := NULL
    )
    RETURN quiz_questions.question_id%TYPE;



    PROCEDURE import_questions (
        in_test_id              quiz_tests.test_id%TYPE
    );



    PROCEDURE delete_test (
        in_test_id          quiz_tests.test_id%TYPE
    );



    PROCEDURE create_bookmarked_test (
        in_topic_id         quiz_tests.test_topic%TYPE,
        in_user_id          quiz_attempts.user_id%TYPE
    );



    PROCEDURE save_notes (
        in_cert_id          plan_certifications_notes.cert_id%TYPE,
        in_is_done          plan_certifications_notes.is_done%TYPE,
        in_priority         plan_certifications_notes.priority%TYPE,
        in_notes            plan_certifications_notes.notes%TYPE
    );

END;
/
