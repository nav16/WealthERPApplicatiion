/****** Object:  StoredProcedure [dbo].[SP_GetBranchTerminals]    Script Date: 06/24/2009 11:58:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetBranchTerminals]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetBranchTerminals]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetBranchTerminals]    Script Date: 06/24/2009 11:58:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetBranchTerminals]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SP_GetBranchTerminals

@AB_BranchId INT

AS

SELECT * FROM dbo.AdviserTerminal WHERE AB_BranchId=@AB_BranchId' 
END
GO
