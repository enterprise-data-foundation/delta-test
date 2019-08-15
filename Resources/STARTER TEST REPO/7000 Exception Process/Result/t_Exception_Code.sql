EXEC dbo.[usp_Core_Query] 
    @TableSchema = 'dbo',
    @TableName = 't_Exception_Code',
    @ColumnAction = 'E',
    @ColumnList = '%RUNID,CADIS\_SYSTEM\_%',
    @Where = 'ExceptionType = ''TEST''',
    @OrderBy = 'ExceptionCode'

