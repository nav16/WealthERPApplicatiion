/****** Object:  StoredProcedure [dbo].[SP_GetSchemePlanPrice]    Script Date: 06/24/2009 12:04:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetSchemePlanPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetSchemePlanPrice]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSchemePlanPrice]    Script Date: 06/24/2009 12:04:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetSchemePlanPrice]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_GetSchemePlanPrice]
@PASP_SchemePlanCode int,
@PSP_PostDate datetime
as
select PSP_NetAssetValue from ProductAMCSchemePlanPrice 
where PASP_SchemePlanCode=@PASP_SchemePlanCode 
and PSP_PostDate=(select Max(PSP_PostDate) from ProductAMCSchemePlanPrice
where (PSP_PostDate<@PSP_PostDate or PSP_PostDate=@PSP_PostDate) and PASP_SchemePlanCode=@PASP_SchemePlanCode)




' 
END
GO
