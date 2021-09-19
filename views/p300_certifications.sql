CREATE OR REPLACE VIEW p300_certifications AS
SELECT
    c.cert_id,
    c.cert_name,
    c.path_id,
    c.exam_page_link,
    c.credly_link,
    c.questions,
    c.minutes,
    c.pass_ratio,
    c.price,
    t.tests
FROM plan_certifications c
LEFT JOIN (
    SELECT
        t.test_topic,
        COUNT(*)                AS tests
    FROM quiz_tests t
    WHERE t.dedicated_to        IS NULL
    GROUP BY t.test_topic
    HAVING COUNT(*) > 0
)t
    ON t.test_topic             = c.path_id;
