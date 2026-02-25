CREATE OR REPLACE PROCEDURE update_emp_salary
(
   p_emp_id      IN NUMBER,
   p_new_salary  IN NUMBER,
   p_status      OUT VARCHAR2
)
IS
   v_count NUMBER;
BEGIN
   -- validation
   SELECT COUNT(*)
   INTO v_count
   FROM emp
   WHERE emp_id = p_emp_id;

   IF v_count = 0 THEN
      p_status := 'EMPLOYEE NOT FOUND';
      RETURN;
   END IF;

   -- update
   UPDATE emp
   SET salary = p_new_salary,
       last_updated = SYSDATE
   WHERE emp_id = p_emp_id;

   p_status := 'SUCCESS';

EXCEPTION
   WHEN OTHERS THEN
      p_status := 'FAILED';
END;
/