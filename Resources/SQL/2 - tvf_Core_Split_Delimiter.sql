SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE FUNCTION dbo.[tvf_Core_Split_Delimiter]
(
   @String NVARCHAR(MAX),
   @Delimiter NVARCHAR(255)
)
RETURNS TABLE
RETURN
(
	WITH Start(i) AS (
		SELECT S.i + CASE S.i WHEN 1 THEN 0 ELSE DATALENGTH(@Delimiter) / 2 END 
		FROM dbo.tvf_Core_Rows(DATALENGTH(@String) / 2) S
		WHERE 
			S.i = 1
			OR (
				SUBSTRING(@String, S.i, DATALENGTH(@Delimiter) / 2) = @Delimiter 
				AND DATALENGTH(SUBSTRING(@String, S.i, DATALENGTH(@Delimiter) / 2)) = DATALENGTH(@Delimiter) 
			)
	)
	SELECT
		i = ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), 
		Item = SUBSTRING(@String, S.i, ISNULL(E.i - DATALENGTH(@Delimiter) / 2, DATALENGTH(@String) / 2 + 1) - S.i)
	FROM 
		Start S
		OUTER APPLY (SELECT TOP 1 i FROM Start WHERE i > S.i) E
)

GO
