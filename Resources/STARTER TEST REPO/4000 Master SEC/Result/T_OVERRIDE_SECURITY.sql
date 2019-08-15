DECLARE @Where nvarchar(max)

EXEC dbo.[usp_Core_Query] 
	@TableSchema = 'dbo',
	@TableName = 'T_OVERRIDE_SECURITY',
	@ColumnAction = 'E',
	@ColumnList = '%RUNID,CADIS\_SYSTEM\_%',
	@Where = 'SEC_ID BETWEEN 1000 AND 1007',
	@OrderBy = 'SEC_ID'

