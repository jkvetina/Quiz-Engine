CREATE OR REPLACE PACKAGE quiz AS

    PROCEDURE prepare_items;



    PROCEDURE process_answer (
        in_answer           VARCHAR2,
        in_bookmarked       VARCHAR2
    );



    PROCEDURE clear_bookmarks;



    PROCEDURE clear_progress;



    FUNCTION get_prev_next_question (
        in_test_id          quiz_questions.test_id%TYPE,
        in_question_id      quiz_questions.question_id%TYPE,
        in_bookmarked       CHAR                                := 'Y',
        in_unanswered       CHAR                                := 'Y',
        in_direction        VARCHAR2                            := 'NEXT',
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
        in_test_group       quiz_tests.test_topic%TYPE,
        in_user_id          quiz_attempts.user_id%TYPE
    );

END;
/
