/****** Object:  StoredProcedure [dbo].[SP_GetEqutiyAggregate]    Script Date: 06/24/2009 12:02:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetEqutiyAggregate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetEqutiyAggregate]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEqutiyAggregate]    Script Date: 06/24/2009 12:02:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetEqutiyAggregate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'	-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE SP_GetEqutiyAggregate  
  
@A_AdviserId INT,  
@AB_BranchId INT  
  
  
AS  
  
SELECT ISNULL( SUM(CENP_NetHoldings * CENP_MarketPrice),0) 
FROM dbo.ViewEquityNP AS VENP
Inner Join dbo.AdviserBranch AS AB ON VENP.A_AdviserId=AB.A_AdviserId
WHERE AB_BranchId=@AB_BranchId  ' 
END
GO
