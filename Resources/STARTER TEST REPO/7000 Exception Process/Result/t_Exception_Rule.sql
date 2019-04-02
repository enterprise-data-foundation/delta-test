EXEC dbo.[USP_Core_DumpData] 
	@TableSchema = 'dbo',
	@TableName = 't_Exception_Rule',
	@ColumnAction = 'E',
	@ColumnList = 'ExceptionRuleId,%RUNID,CADIS\_SYSTEM\_%',
    @OrderBy = 'ExceptionCode, SourceComponent, SourceColumn'

