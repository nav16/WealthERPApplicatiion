/****** Object:  StoredProcedure [dbo].[SP_DeleteBranchTerminal]    Script Date: 06/24/2009 11:14:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_DeleteBranchTerminal]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_DeleteBranchTerminal]
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteBranchTerminal]    Script Date: 06/24/2009 11:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_DeleteBranchTerminal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SP_DeleteBranchTerminal

@AT_Id INT

AS

DELETE FROM dbo.AdviserTerminal WHERE AT_Id=@AT_Id
' 
END
GO
