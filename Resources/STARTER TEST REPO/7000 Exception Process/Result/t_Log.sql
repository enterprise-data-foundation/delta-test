DECLARE @Where NVARCHAR(MAX) = '1 = 0';

SELECT TOP (1) @Where = 'CADIS_SYSTEM_TOPRUNID = ' + CAST(CADIS_SYSTEM_TOPRUNID AS NVARCHAR(MAX))
FROM dbo.t_Exception_Stage
WHERE ExceptionCode = 999999
ORDER BY ExceptionStageId DESC

EXEC dbo.[USP_Core_DumpData] 
	@TableSchema = 'dbo',
	@TableName = 't_Log',
	@ColumnAction = 'E',
	@ColumnList = 'LogId, %RUNID, CADIS\_SYSTEM\_%',
    @Where = @Where,
    @OrderBy = 'LogId'

