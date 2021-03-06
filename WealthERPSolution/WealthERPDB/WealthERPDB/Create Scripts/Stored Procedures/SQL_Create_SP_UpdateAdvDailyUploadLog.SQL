/****** Object:  StoredProcedure [dbo].[SP_UpdateAdvDailyUploadLog]    Script Date: 06/24/2009 12:05:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_UpdateAdvDailyUploadLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_UpdateAdvDailyUploadLog]
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateAdvDailyUploadLog]    Script Date: 06/24/2009 12:05:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_UpdateAdvDailyUploadLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateAdvDailyUploadLog]


@ADUL_ProcessId int,
@ADUL_FileName	varchar(50),
@XESFT_FileTypeId int,
@ADUL_NoOfTotalRecords int,
@U_UserId int,
@ADUL_XMLFileName	varchar(50),
@A_AdviserId	int,
@ADUL_Comment	varchar(50),
@ADUL_StartTime	datetime,
@ADUL_EndTime	datetime,
@ADUL_NoOfRejectRecords	int,
@ADUL_NoOfCustomersCreated INT,
@ADUL_NoOfTransactionsCreated int,
@ADUL_NoOfFoliosCreated int,
@ADUL_IsInsertionToInputComplete	tinyint,
@ADUL_IsInsertionToStagingComplete	tinyint,
@ADUL_IsInsertionToWerpComplete tinyint,
@ADUL_ModifiedBy	int

as
SET NoCount On
BEGIN
	
		Update AdviserDailyUploadLog set
		
			ADUL_FileName = @ADUL_FileName,
			XESFT_FileTypeId = @XESFT_FileTypeId,
			ADUL_TotalNoOfRecords = @ADUL_NoOfTotalRecords,
			U_UserId = @U_UserId,
			ADUL_XMLFileName = @ADUL_XMLFileName,
			A_AdviserId = @A_AdviserId,
			ADUL_Comment = @ADUL_Comment,
			ADUL_StartTime = @ADUL_StartTime,
			ADUL_EndTime = @ADUL_EndTime,
			ADUL_NoOfRejectRecords = @ADUL_NoOfRejectRecords,
			ADUL_NoOfCustomersCreated = @ADUL_NoOfCustomersCreated,
			ADUL_NoOfTransactionsCreated = @ADUL_NoOfTransactionsCreated,
			ADUL_NoOfFoliosCreated = @ADUL_NoOfFoliosCreated,
			ADUL_IsInsertionToInputComplete = @ADUL_IsInsertionToInputComplete,
			ADUL_IsInsertionToStagingComplete = @ADUL_IsInsertionToStagingComplete,
			ADUL_IsInsertionToWerpComplete = @ADUL_IsInsertionToWerpComplete,
			ADUL_ModifiedBy = @ADUL_ModifiedBy,
			ADUL_ModifiedOn = CURRENT_TIMESTAMP

		where  ADUL_ProcessId = @ADUL_ProcessId
	
END




' 
END
GO
