CREATE TRIGGER trgAfterUpdate ON [dbo].[employee_details] 
FOR UPDATE
AS
	declare @empid int;
	declare @empname varchar(100);
	declare @empsalary decimal(10,2);
	declare @audit_action varchar(100);

	select @empid=i.emp_ID from inserted i;	
	select @empname=i.emp_name from inserted i;	
	select @empsal=i.emp_salary from inserted i;	
	
	if update(emp_name)
		set @audit_action='Updated Record -- After Update Trigger.';
	if update(emp_salary)
		set @audit_action='Updated Record -- After Update Trigger.';

	insert into employee_details_Audit(emp_ID,emp_name,emp_salary,Audit_Action,Audit_Timestamp) 
	values(@empid,@empname,@empsalary,@audit_action,getdate());

	PRINT 'AFTER UPDATE Trigger fired.'
GO
