CREATE TRIGGER trgInsteadOfDelete ON [dbo].[employee_details] 
INSTEAD OF DELETE
AS
	declare @emp_id int;
	declare @emp_name varchar(100);
	declare @emp_salary int;
	
	select @emp_id=d.emp_ID from deleted d;
	select @emp_name=d.emp_name from deleted d;
	select @emp_sal=d.emp_salary from deleted d;

	BEGIN
		if(@emp_salary>1200)
		begin
			RAISERROR('Cannot delete where salary > 1200',16,1);
			ROLLBACK;
		end
		else
		begin
			delete from employee_details where emp_ID=@emp_id;
			COMMIT;
			insert into employee_details_Audit(emp_ID,emp_name,emp_salary,Audit_Action,Audit_Timestamp)
			values(@emp_id,@emp_name,@emp_salary,'Deleted -- Instead Of Delete Trigger.',getdate());
			PRINT 'Record Deleted -- Instead Of Delete Trigger.'
		end
	END
GO