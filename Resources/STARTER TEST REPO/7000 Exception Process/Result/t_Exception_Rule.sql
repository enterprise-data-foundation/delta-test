EXEC dbo.[usp_Core_Query] 
	@TableSchema = 'dbo',
	@TableName = 't_Exception_Rule',
	@ColumnAction = 'E',
	@ColumnList = 'ExceptionRuleId,%RUNID,CADIS\_SYSTEM\_%',
    @OrderBy = 'ExceptionCode, SourceComponent, SourceColumn'

