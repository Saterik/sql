


CREATE TRIGGER check_new_communites 
BEFORE insert
ON Communities FOR EACH ROW
	BEGIN
   IF (LENGTH(new.name) < 5) THEN
       SIGNAL SQLSTATE '5000'
	   SET MESSAGE_TEXT = 'Длина названия сообщества (поле name) должна быть не менее 5 символов';
       INSERT INTO CommunityNameTrigger_exception_table VALUES();
   END IF; 
END; // 

