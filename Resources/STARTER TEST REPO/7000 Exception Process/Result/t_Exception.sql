EXEC dbo.[USP_Core_DumpData] 
	@TableSchema = 'dbo',
	@TableName = 't_Exception',
	@ColumnAction = 'E',
	@ColumnList = 'StatusDate, ExceptionStageId, %RUNID, CADIS\_SYSTEM\_%',
    @Where = 'ExceptionCode = 999999',
    @OrderBy = 'ExceptionStageId'

