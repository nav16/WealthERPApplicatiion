/****** Object:  StoredProcedure [dbo].[SP_CheckIsPANNew]    Script Date: 06/24/2009 10:59:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CheckIsPANNew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_CheckIsPANNew]
GO
/****** Object:  StoredProcedure [dbo].[SP_CheckIsPANNew]    Script Date: 06/24/2009 10:59:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CheckIsPANNew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE SP_CheckIsPANNew
@PAN VARCHAR(20)

AS

SET NOCOUNT ON

	SELECT COUNT(*) AS CNT
	FROM dbo.Customer
	WHERE C_PANNum = @PAN

SET NOCOUNT OFF
' 
END
GO
