/****** Object:  StoredProcedure [dbo].[SP_GetUserDetails]    Script Date: 06/24/2009 12:05:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetUserDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetUserDetails]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserDetails]    Script Date: 06/24/2009 12:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetUserDetails]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_GetUserDetails]
@U_UserId int
as
select * from [User] where U_UserId=@U_UserId
' 
END
GO
