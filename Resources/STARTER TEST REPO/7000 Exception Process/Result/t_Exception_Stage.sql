EXEC dbo.[usp_Core_Query] 
	@TableSchema = 'dbo',
	@TableName = 't_Exception_Stage',
	@ColumnAction = 'E',
	@ColumnList = 'ExceptionStageId,%RUNID,CADIS\_SYSTEM\_%,Batch%',
    @Where = 'ExceptionCode = 999999',
    @OrderBy = 'ExceptionStageId'

