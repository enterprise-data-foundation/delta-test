SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE dbo.[usp_Core_DumpData] 
	@TableSchema nvarchar(128) = 'dbo',
	@TableName nvarchar(128),
	@ColumnAction CHAR(1) = 'E', -- [I]nclude | [E]xclude
	@ColumnList nvarchar(max) = '%RunId,CADIS\_SYSTEM\_%',
	@Where nvarchar(max) = NULL,
	@OrderBy nvarchar(max) = NULL
AS
	
BEGIN
	SET NOCOUNT ON;

	DECLARE
		@Columns nvarchar(max) = '',
		@newline nchar(1) = char(10),
		@tab nchar(1) = char(9),
		@Sql nvarchar(max) = ''

	SELECT 
		@Columns = @Columns + ',' + @newline + @tab + '[' + C.COLUMN_NAME + ']'
	FROM
		INFORMATION_SCHEMA.COLUMNS C
		LEFT JOIN dbo.tvf_Core_Split_Delimiter(@ColumnList, ',') E ON C.COLUMN_NAME LIKE LTRIM(RTRIM(E.Item)) ESCAPE '\'
	WHERE
		C.TABLE_SCHEMA = @TableSchema
		AND C.TABLE_NAME = @TableName
		AND (
			(@ColumnAction = 'I' AND E.Item IS NOT NULL)
			OR (@ColumnAction = 'E' AND E.Item IS NULL)
		)
	ORDER BY
		C.ORDINAL_POSITION

	SET @Columns = STUFF(@Columns, 1, 3, '')

	SET @Sql = '
SELECT
	{Columns}
FROM
	[{TableSchema}].[{TableName}]'

	IF @Where IS NOT NULL SET @Sql = @Sql + '
WHERE {Where}'

	IF @OrderBy IS NOT NULL SET @Sql = @Sql + '
ORDER BY {OrderBy}'

	SET @Sql = REPLACE(@Sql, '{Columns}', @Columns)
	SET @Sql = REPLACE(@Sql, '{TableSchema}', @TableSchema)
	SET @Sql = REPLACE(@Sql, '{TableName}', @TableName)
	SET @Sql = REPLACE(@Sql, '{Where}', ISNULL(@Where, ''))
	SET @Sql = REPLACE(@Sql, '{OrderBy}', ISNULL(@OrderBy, ''))

	EXEC sp_executesql @Sql
END
GO
