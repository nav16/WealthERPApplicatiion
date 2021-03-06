/****** Object:  StoredProcedure [dbo].[SP_GetAdvUploadProcessLogInfo]    Script Date: 06/24/2009 11:58:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetAdvUploadProcessLogInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetAdvUploadProcessLogInfo]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAdvUploadProcessLogInfo]    Script Date: 06/24/2009 11:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetAdvUploadProcessLogInfo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		<Benson>
-- Create date: <9th June 2009>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_GetAdvUploadProcessLogInfo]
@processId bigint
as
SET NOCOUNT ON
SELECT [ADUL_ProcessId]
	  ,[ADUL_FileName]
      ,[XESFT_FileTypeId]
      ,[ADUL_TotalNoOfRecords]
      ,[U_UserId]
      ,[ADUL_XMLFileName]
      ,[A_AdviserId]
      ,[ADUL_Comment]
      ,[ADUL_StartTime]
      ,[ADUL_EndTime]
      ,[ADUL_NoOfCustomersCreated]
      ,[ADUL_NoOfTransactionsCreated]
      ,[ADUL_NoOfFoliosCreated]
      ,[ADUL_NoOfRejectRecords]
      ,[ADUL_IsXMLConvesionComplete]
      ,[ADUL_IsInsertionToInputComplete]
      ,[ADUL_IsInsertionToStagingComplete]
      ,[ADUL_IsInsertionToWerpComplete]
      ,[ADUL_IsInsertionToXtrnlComplete]
       
  FROM AdviserDailyUploadLog
  where [ADUL_ProcessId] = @processId
  SET NOCOUNT OFF
' 
END
GO
