EXEC dbo.[USP_Core_DumpData] 
	@TableSchema = 'dbo',
	@TableName = 't_Exception_Process',
	@ColumnAction = 'E',
	@ColumnList = '%RUNID,CADIS\_SYSTEM\_%',
    @OrderBy = 'ProcessToken'

