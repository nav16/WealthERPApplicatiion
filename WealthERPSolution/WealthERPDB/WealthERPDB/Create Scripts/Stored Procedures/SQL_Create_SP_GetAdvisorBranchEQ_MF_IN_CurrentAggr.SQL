/****** Object:  StoredProcedure [dbo].[SP_GetAdvisorBranchEQ_MF_IN_CurrentAggr]    Script Date: 06/24/2009 11:57:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetAdvisorBranchEQ_MF_IN_CurrentAggr]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetAdvisorBranchEQ_MF_IN_CurrentAggr]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAdvisorBranchEQ_MF_IN_CurrentAggr]    Script Date: 06/24/2009 11:57:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetAdvisorBranchEQ_MF_IN_CurrentAggr]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SP_GetAdvisorBranchEQ_MF_IN_CurrentAggr]
@A_AdviserId INT

AS

BEGIN
	
	WITH CurrentAggr AS
	(
		SELECT
			A_AdviserId,
			AB_BranchName,
			AB_BranchCode,
			[dbo].[AdviserBranch].[AB_BranchId],
			dbo.Fn_GetBranchEQAssetAgr(AB_BranchId)AS EquityAggr,
			dbo.Fn_GetBranchMFAssetAgr(AB_BranchId) AS MFAggr,
			dbo.Fn_GetBranchInsuranceAssetAgr(AB_BranchId) AS InsuranceAggr
			
		FROM
		dbo.AdviserBranch	
		GROUP BY [dbo].[AdviserBranch].[AB_BranchId],
		[dbo].[AdviserBranch].[A_AdviserId],
		AB_BranchName,
			AB_BranchCode,
			[dbo].[AdviserBranch].[AB_BranchId],
 dbo.Fn_GetBranchEQAssetAgr(AB_BranchId),
		 	dbo.Fn_GetBranchMFAssetAgr(AB_BranchId),
		 dbo.Fn_GetBranchInsuranceAssetAgr(AB_BranchId)
		
	)
	
	SELECT * FROM CurrentAggr WHERE A_AdviserId = @A_AdviserId;
	
END
' 
END
GO
