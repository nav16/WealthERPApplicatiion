/****** Object:  Table [dbo].[XMLMaritalStatus]    Script Date: 06/23/2009 19:03:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XMLMaritalStatus]') AND type in (N'U'))
DROP TABLE [dbo].[XMLMaritalStatus]
GO
/****** Object:  Table [dbo].[XMLMaritalStatus]    Script Date: 06/23/2009 19:03:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XMLMaritalStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[XMLMaritalStatus](
	[XMS_MaritalStatusCode] [varchar](5) NOT NULL,
	[XMS_MaritalStatus] [varchar](30) NULL,
	[XMS_CreatedBy] [int] NULL,
	[XMS_CreatedOn] [datetime] NULL,
	[XMS_ModifiedBy] [int] NULL,
	[XMS_ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_XMLMaritalStatus] PRIMARY KEY CLUSTERED 
(
	[XMS_MaritalStatusCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
