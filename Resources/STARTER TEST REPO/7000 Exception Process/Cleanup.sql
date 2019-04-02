DELETE X
FROM
    dbo.t_Exception_Xref X
    INNER JOIN dbo.t_Exception E ON E.HashKey = X.HashKey
    INNER JOIN dbo.t_Exception_Code C ON C.ExceptionCode = E.ExceptionCode
WHERE C.ExceptionType = 'TEST'

DELETE E 
FROM 
    dbo.t_Exception E
    INNER JOIN dbo.t_Exception_Code C ON C.ExceptionCode = E.ExceptionCode
WHERE C.ExceptionType = 'TEST'

DELETE S
FROM 
    dbo.t_Exception_Stage S
    INNER JOIN dbo.t_Exception_Code C ON C.ExceptionCode = S.ExceptionCode
WHERE C.ExceptionType = 'TEST'

DELETE R
FROM 
    dbo.t_Exception_Rule R
    INNER JOIN dbo.t_Exception_Code C ON C.ExceptionCode = R.ExceptionCode
WHERE C.ExceptionType = 'TEST'

DELETE dbo.t_Exception_Code 
WHERE ExceptionType = 'TEST'

DELETE dbo.t_Exception_Step
WHERE ProcessToken = 'TEST'

DELETE dbo.t_Exception_Status
WHERE ProcessToken = 'TEST'

DELETE dbo.t_Exception_Process
WHERE ProcessToken = 'TEST'
