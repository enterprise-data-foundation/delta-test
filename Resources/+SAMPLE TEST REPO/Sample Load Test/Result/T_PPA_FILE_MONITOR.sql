DECLARE @Where nvarchar(max)

SELECT TOP 1 
	@Where = 'TOP_LEVEL_RUN_ID = ' + CAST(TOP_LEVEL_RUN_ID AS nvarchar)
FROM T_FILE_MONITOR 
WHERE FILE_NAME = 'equity_namr.dif.20180917'
ORDER BY ID DESC

EXEC dbo.[usp_Core_DumpData] 
	@TableSchema = 'dbo',
	@TableName = 'T_FILE_MONITOR',
	@ColumnAction = 'E',
	@ColumnList = 'ID,%RUN\_ID,FILE\_EFFECTIVE\_DATE,%RUNID,CADIS\_SYSTEM\_%',
	@Where = @Where,
	@OrderBy = NULL

