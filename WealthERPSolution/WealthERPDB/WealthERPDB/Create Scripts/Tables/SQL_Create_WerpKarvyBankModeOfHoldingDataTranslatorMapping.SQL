/****** Object:  Table [dbo].[WerpKarvyBankModeOfHoldingDataTranslatorMapping]    Script Date: 06/23/2009 19:01:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WerpKarvyBankModeOfHoldingDataTranslatorMapping]') AND type in (N'U'))
DROP TABLE [dbo].[WerpKarvyBankModeOfHoldingDataTranslatorMapping]
GO
/****** Object:  Table [dbo].[WerpKarvyBankModeOfHoldingDataTranslatorMapping]    Script Date: 06/23/2009 19:01:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WerpKarvyBankModeOfHoldingDataTranslatorMapping]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WerpKarvyBankModeOfHoldingDataTranslatorMapping](
	[WKBMOHDTM_ModeofHolding] [int] NULL,
	[XMOH_ModeOfHoldingCode] [varchar](5) NULL,
	[WKBMOHDTM_CreatedBy] [int] NULL,
	[WKBMOHDTM_CreatedOn] [datetime] NULL,
	[WKBMOHDTM_ModifiedBy] [int] NULL,
	[WKBMOHDTM_ModifiedOn] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WerpKarvyBankModeOfHoldingDataTranslatorMapping_XMLModeOfHolding]') AND parent_object_id = OBJECT_ID(N'[dbo].[WerpKarvyBankModeOfHoldingDataTranslatorMapping]'))
ALTER TABLE [dbo].[WerpKarvyBankModeOfHoldingDataTranslatorMapping]  WITH CHECK ADD  CONSTRAINT [FK_WerpKarvyBankModeOfHoldingDataTranslatorMapping_XMLModeOfHolding] FOREIGN KEY([XMOH_ModeOfHoldingCode])
REFERENCES [dbo].[XMLModeOfHolding] ([XMOH_ModeOfHoldingCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WerpKarvyBankModeOfHoldingDataTranslatorMapping_XMLModeOfHolding]') AND parent_object_id = OBJECT_ID(N'[dbo].[WerpKarvyBankModeOfHoldingDataTranslatorMapping]'))
ALTER TABLE [dbo].[WerpKarvyBankModeOfHoldingDataTranslatorMapping] CHECK CONSTRAINT [FK_WerpKarvyBankModeOfHoldingDataTranslatorMapping_XMLModeOfHolding]
GO
