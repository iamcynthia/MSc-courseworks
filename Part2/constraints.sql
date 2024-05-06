-- Part 2.1 constraints.sql
--
-- Submitted by: Hsin -Ju, Chan
-- 


--  2.1: Status Description Consistency
DELIMITER //
CREATE TRIGGER consistency BEFORE INSERT ON crimes2015
FOR EACH ROW
BEGIN
IF NEW.status IN (SELECT DISTINCT status FROM crimes2015 C WHERE status_desc = C.status_desc) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid status description';
END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER consistency BEFORE UPDATE ON crimes2015
FOR EACH ROW
BEGIN
IF NEW.status IN (SELECT status FROM crimes2015 C WHERE status_desc = C.status_desc) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid status description';
END IF;
END //
DELIMITER ;

--  2.2: Status Transition
DELIMITER //
CREATE TRIGGER DEFAULT_status BEFORE INSERT ON crimes2015
FOR EACH ROW
BEGIN
IF NEW.status IS NULL THEN
SET NEW.status = 'UNK';
END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER status_Transition AFTER UPDATE ON crimes2015
FOR EACH ROW
BEGIN
IF (OLD.status = 'UNK' AND NEW.status != 'UNK' AND NEW.status != 'IC') THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Please input the valid value!';
ELSEIF (OLD.status = 'IC' AND NEW.status != 'IC' AND NEW.status !='AO' AND NEW.status != 'JO') THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Please input the valid value!';
ELSEIF (OLD.status = 'AO' AND NEW.status != 'AO' AND NEW.status != 'AA') THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Please input the valid value!';
ELSEIF (OLD.status = 'JO' AND NEW.status != 'JO' AND NEW.status != 'JA') THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Please input the valid value!';
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Del_status BEFORE DELETE ON crimes2015
FOR EACH ROW
BEGIN
IF (OLD.status != 'JA' OR OLD.status != 'AA') THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete it!';
END IF;
END//
DELIMITER ;
