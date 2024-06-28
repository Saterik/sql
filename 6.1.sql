USE vk; 
 
DROP FUNCTION IF EXISTS func_del_user; 
 
DELIMITER //  
CREATE FUNCTION func_del_user (check_user_id BIGINT UNSIGNED) 
RETURNS BIGINT DETERMINISTIC 
  BEGIN 
    DECLARE res BIGINT; 
    IF check_user_id NOT IN (SELECT id FROM vk.users) THEN   
  SET res := -1; 
 ELSE  
        SET res := check_user_id; 
  BEGIN 
	  
	  

   DELETE  
   FROM messages m 
   WHERE m.from_user_id = check_user_id 
   OR m.to_user_id = check_user_id; 

   DELETE  
   FROM likes l 
   WHERE l.user_id = check_user_id; 
	SET FOREIGN_KEY_CHECKS=0;
   DELETE  
   FROM media md 
   WHERE md.user_id = check_user_id; 

   DELETE  
   FROM profiles p 
   WHERE p.user_id = check_user_id; 
 
   DELETE  
   FROM users u 
   WHERE u.id = check_user_id; 
  END; 
 END IF;
SET FOREIGN_KEY_CHECKS=1;
 RETURN res; 
  END//  
DELIMITER ; 
 
SELECT func_del_user(1) AS id_deleted;



