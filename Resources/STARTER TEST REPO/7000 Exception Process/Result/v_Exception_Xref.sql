EXEC dbo.[USP_Core_DumpData] 
	@TableSchema = 'dbo',
	@TableName = 'v_Exception_Xref',
	@ColumnAction = 'E',
	@ColumnList = 'StatusDate, ExceptionStageId, %RUNID, CADIS\_SYSTEM\_%',
    @OrderBy = 'ExceptionStageId, XrefToken'

