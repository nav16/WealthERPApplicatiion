/****** Object:  StoredProcedure [dbo].[SP_UpdateCamsProfileStagingIsCustomerNew]    Script Date: 06/24/2009 12:06:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_UpdateCamsProfileStagingIsCustomerNew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_UpdateCamsProfileStagingIsCustomerNew]
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateCamsProfileStagingIsCustomerNew]    Script Date: 06/24/2009 12:06:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_UpdateCamsProfileStagingIsCustomerNew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[SP_UpdateCamsProfileStagingIsCustomerNew]
@adviserId INT,
@processId INT
AS
    update CustomerMFCAMSXtrnlProfileStaging
     set CMGCXPS_IsCustomerNew = 0,C_CustomerId = c.C_CustomerId,CP_PortfolioId = cp.CP_PortfolioId
     from CustomerMFCAMSXtrnlProfileStaging s,Customer c,CustomerPortfolio cp,AdviserRM ar
     where s.CMGCXPS_PAN_NO=c.C_PANNum and s.CMGCXPS_IsCustomerNew=1 
     and (ar.A_AdviserId=@adviserId and c.AR_RMID=ar.AR_RMId and c.C_CustomerId = cp.C_CustomerId and cp.CP_IsMainPortfolio=1)
     AND s.ADUL_ProcessId = @processId
     

' 
END
GO
