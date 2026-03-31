DELIMITER //

DROP PROCEDURE IF EXISTS PrintCustomers;

CREATE PROCEDURE PrintCustomers(IN MYCOUNTRY VARCHAR(50))
BEGIN
    DECLARE total INT DEFAULT 0;
    DECLARE avgscore FLOAT DEFAULT 0;

    SELECT COUNT(*), AVG(score)
    INTO total, avgscore
    FROM customers
    WHERE country = MYCOUNTRY COLLATE utf8mb4_general_ci;

    SELECT 
        CONCAT('Total customers from ', MYCOUNTRY, ': ', total) AS message,
        CONCAT('Average Score: ', avgscore) AS Score_Info;
END //

DELIMITER ;



call PrintCustomers('germany');