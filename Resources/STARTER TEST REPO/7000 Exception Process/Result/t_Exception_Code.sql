EXEC dbo.[USP_Core_DumpData] 
    @TableSchema = 'dbo',
    @TableName = 't_Exception_Code',
    @ColumnAction = 'E',
    @ColumnList = '%RUNID,CADIS\_SYSTEM\_%',
    @Where = 'ExceptionType = ''TEST''',
    @OrderBy = 'ExceptionCode'

