/****** Object:  StoredProcedure [dbo].[SP_PopulateDDScrip]    Script Date: 06/24/2009 12:05:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_PopulateDDScrip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_PopulateDDScrip]
GO
/****** Object:  StoredProcedure [dbo].[SP_PopulateDDScrip]    Script Date: 06/24/2009 12:05:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_PopulateDDScrip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SP_PopulateDDScrip

@CP_PortfolioId int
 
AS

SELECT DISTINCT PEM_ScripCode FROM dbo.CustomerEquityTransaction 
INNER JOIN 
dbo.CustomerEquityTradeAccount
ON
dbo.CustomerEquityTransaction.CETA_AccountId = dbo.CustomerEquityTradeAccount.CETA_AccountId
WHERE CP_PortfolioId=@CP_PortfolioId' 
END
GO
