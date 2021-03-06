/****** Object:  StoredProcedure [dbo].[SP_GetPersonalNetPositionFromID]    Script Date: 06/24/2009 12:03:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetPersonalNetPositionFromID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetPersonalNetPositionFromID]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPersonalNetPositionFromID]    Script Date: 06/24/2009 12:03:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetPersonalNetPositionFromID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[SP_GetPersonalNetPositionFromID]
@CPNP_PersonalNPId INT

AS

BEGIN
	
	SELECT * FROM 
		dbo.CustomerPersonalNetPosition 
	WHERE 
		CPNP_PersonalNPId = @CPNP_PersonalNPId
	
END
' 
END
GO
