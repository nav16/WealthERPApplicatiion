/****** Object:  StoredProcedure [dbo].[SP_GetProofCodes]    Script Date: 06/24/2009 12:04:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetProofCodes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetProofCodes]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProofCodes]    Script Date: 06/24/2009 12:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetProofCodes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SP_GetProofCodes
@WPFC_FilterCategoryCode VARCHAR(50)

AS

SELECT * FROM WerpProofMandatoryLookup
WHERE
WPFC_FilterCategoryCode=@WPFC_FilterCategoryCode' 
END
GO
