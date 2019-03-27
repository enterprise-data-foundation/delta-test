DECLARE @Where nvarchar(max)

SELECT TOP 1 
	@Where = 'TOP_LEVEL_RUN_ID = ' + CAST(TOP_LEVEL_RUN_ID AS nvarchar)
FROM T_FILE_MONITOR 
WHERE FILE_NAME = 'equity_namr.dif.20180917'
ORDER BY ID DESC

EXEC dbo.[usp_Core_DumpData] 
	@TableSchema = 'dbo',
	@TableName = 'T_EXCEPTION_LOAD',
	@ColumnAction = 'E',
	@ColumnList = 'ROW\_NUMBER,SOURCE\_KEY,CADIS\_ID,EXCEPTION\_DATE,HAS\_VALUE\_CHANGED,OCCURRENCE,EXCEPTION\_AGE,%RUN\_ID,%RUNID,CADIS\_SYSTEM\_%',
	@Where = @Where,
	@OrderBy = 'ISIN'

