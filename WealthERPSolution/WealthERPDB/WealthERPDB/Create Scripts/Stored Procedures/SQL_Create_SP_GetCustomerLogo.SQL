/****** Object:  StoredProcedure [dbo].[SP_GetCustomerLogo]    Script Date: 06/24/2009 12:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetCustomerLogo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetCustomerLogo]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCustomerLogo]    Script Date: 06/24/2009 12:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetCustomerLogo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  procedure [dbo].[SP_GetCustomerLogo]
@C_CUSTOMERID BIGINT
as
SELECT A.A_ADVISERLOGO FROM dbo.Adviser A,dbo.AdviserRM R,dbo.Customer C WHERE A.A_ADVISERID=R.A_ADVISERID AND R.AR_RMID=C.AR_RMID AND C.C_CUSTOMERID=@C_CUSTOMERID
' 
END
GO
