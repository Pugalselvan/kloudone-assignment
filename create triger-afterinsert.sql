CREATE TRIGGER trgAfterInsert ON [dbo].[employee_details] 
FOR INSERT
AS
	declare @empid int;
	declare @empname varchar(100);
	declare @empsal decimal(10,2);
	declare @audit_action varchar(100);

	select @empid=i.emp_ID from inserted i;	
	select @empname=i.emp_Name from inserted i;	
	select @empsal=i.emp_salary from inserted i;	
	set @audit_action='Inserted Record -- After Insert Trigger.';

	insert into mmployee_details_Audit
           (emp_ID,emp_name,emp_salary,Audit_Action,Audit_Timestamp) 
	values(@empid,@empname,@empsal,@audit_action,getdate());

	PRINT 'AFTER INSERT trigger fired.'
GO