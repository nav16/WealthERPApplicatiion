/****** Object:  StoredProcedure [dbo].[SP_CreateCustomerInsuranceAccount]    Script Date: 06/24/2009 11:12:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CreateCustomerInsuranceAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_CreateCustomerInsuranceAccount]
GO
/****** Object:  StoredProcedure [dbo].[SP_CreateCustomerInsuranceAccount]    Script Date: 06/24/2009 11:12:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CreateCustomerInsuranceAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[SP_CreateCustomerInsuranceAccount]
@CP_PortfolioId INT,
@CIA_PolicyNum	varchar(30),
@PAIC_AssetInstrumentCategoryCode	VARCHAR(4),
@CIA_AccountNum	varchar(30),
@PAG_AssetGroupCode	VARCHAR(2),
@CIA_CreatedBy	INT,
@CIA_ModifiedBy	INT,
@CIA_AccountId INT output

AS

INSERT INTO CustomerInsuranceAccount
(
	CP_PortfolioId,
	CIA_PolicyNum,
	PAIC_AssetInstrumentCategoryCode,
	CIA_AccountNum,
	PAG_AssetGroupCode,
	CIA_CreatedBy,
	CIA_CreatedOn,
	CIA_ModifiedBy,
	CIA_ModifiedOn
)
VALUES
(
	@CP_PortfolioId,
	@CIA_PolicyNum,
	@PAIC_AssetInstrumentCategoryCode,
	@CIA_AccountNum,
	@PAG_AssetGroupCode,
	@CIA_CreatedBy,
	CURRENT_TIMESTAMP,
	@CIA_ModifiedBy,
	CURRENT_TIMESTAMP
)

SELECT @CIA_AccountId=SCOPE_IDENTITY()' 
END
GO
