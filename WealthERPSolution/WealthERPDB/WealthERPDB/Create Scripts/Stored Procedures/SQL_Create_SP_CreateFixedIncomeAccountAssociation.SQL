/****** Object:  StoredProcedure [dbo].[SP_CreateFixedIncomeAccountAssociation]    Script Date: 06/24/2009 11:13:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CreateFixedIncomeAccountAssociation]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_CreateFixedIncomeAccountAssociation]
GO
/****** Object:  StoredProcedure [dbo].[SP_CreateFixedIncomeAccountAssociation]    Script Date: 06/24/2009 11:13:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CreateFixedIncomeAccountAssociation]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CreateFixedIncomeAccountAssociation]
@CFIA_AccountId INT,
@CA_AssociateId INT,
@CFIAA_AssociationType VARCHAR(30),
@CFIAA_CreatedBy INT,
@CFIAA_ModifiedBy INT
AS
INSERT INTO CustomerFixedIncomeAcccountAssociates 
(
CFIA_AccountId,
CA_AssociateId,
CFIAA_AssociationType,
CFIAA_CreatedBy,
CFIAA_CreatedOn,
CFIAA_ModifiedBy,
CFIAA_ModifiedOn
)
VALUES
(
@CFIA_AccountId,
@CA_AssociateId,
@CFIAA_AssociationType,
@CFIAA_CreatedBy,
CURRENT_TIMESTAMP,
@CFIAA_ModifiedBy,
CURRENT_TIMESTAMP
)
' 
END
GO
