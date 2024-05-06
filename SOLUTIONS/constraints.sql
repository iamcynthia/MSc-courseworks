DELIMITER //
CREATE TRIGGER startTransition BEFORE INSERT ON crimes2015
  FOR EACH ROW
  BEGIN
	-- Part 2.1
    IF NEW.status IN (select distinct status from crimes2015) AND
    (NEW.status_desc NOT IN (select distinct status_desc from crimes2015 where status = NEW.status)
        OR
        NEW.status NOT IN (select distinct status from crimes2015 where status_desc = NEW.status_desc)
      )
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid combination status, status_desc';        
	-- Part 2.2
    ELSEIF NEW.status != 'UNK'
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid status transition';
    END IF;
  END//
DELIMITER ;

--------------------------------

DELIMITER //
CREATE TRIGGER updateTransition BEFORE UPDATE ON crimes2015
  FOR EACH ROW
  BEGIN
	-- Part 2.1
	IF (NEW.status_desc NOT IN (select distinct status_desc from crimes2015 where status = NEW.status)
        OR
        NEW.status NOT IN (select distinct status from crimes2015 where status_desc = NEW.status_desc)
      )
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid combination status, status_desc';

    -- Part 2.2
    ELSEIF (OLD.status = 'UNK' AND NEW.status NOT IN ('UNK', 'IC'))
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid status transition';

    ELSEIF (OLD.status = 'IC' AND NEW.status NOT IN ('IC', 'AO', 'JO'))
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid status transition';

    ELSEIF (OLD.status = 'AO' AND NEW.status NOT IN ('AO', 'AA'))
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid status transition';

    ELSEIF (OLD.status = 'JO' AND NEW.status NOT IN ('JO', 'JA'))
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid status transition';

    ELSEIF (OLD.status = 'JA' AND NEW.status != 'JA')
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid status transition';

    ELSEIF (OLD.status = 'AA' AND NEW.status != 'AA')
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid status transition';    
    END IF;
  END//
DELIMITER ;

--------------------------------
-- Delete only when an arrest has been made
DELIMITER //
CREATE TRIGGER deleteOnArrest BEFORE DELETE ON crimes2015
  FOR EACH ROW
  BEGIN
	-- Part 2.2 
    IF OLD.status IN ('UNK', 'IC', 'AO', 'JO')
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid status transition';
    END IF;
  END//
DELIMITER ;
