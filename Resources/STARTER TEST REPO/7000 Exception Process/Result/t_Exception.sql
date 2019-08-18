EXEC dbo.[usp_Core_Query] 
	@TableSchema = 'dbo',
	@TableName = 't_Exception',
	@ColumnAction = 'E',
	@ColumnList = 'StatusDate, ExceptionStageId, %RUNID, CADIS\_SYSTEM\_%',
    @Where = 'ExceptionCode = 999999',
    @OrderBy = 'ExceptionStageId'

