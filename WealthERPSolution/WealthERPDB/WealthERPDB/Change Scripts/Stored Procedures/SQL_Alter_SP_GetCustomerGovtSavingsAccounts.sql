﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetCustomerGovtSavingsAccounts]
@CP_PortfolioId INT,
@PAG_AssetGroupCode varchar(5),
@PAIC_AssetInstrumentCategoryCode varchar(5)

AS

SELECT * FROM CustomerGovtSavingAccount WHERE CP_PortfolioId=@CP_PortfolioId AND PAG_AssetGroupCode=@PAG_AssetGroupCode AND PAIC_AssetInstrumentCategoryCode=@PAIC_AssetInstrumentCategoryCode 