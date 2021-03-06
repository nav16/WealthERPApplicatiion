/****** Object:  StoredProcedure [dbo].[sproc_AlertDiscoveryForTrans]    Script Date: 06/24/2009 12:08:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sproc_AlertDiscoveryForTrans]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sproc_AlertDiscoveryForTrans]
GO
/****** Object:  StoredProcedure [dbo].[sproc_AlertDiscoveryForTrans]    Script Date: 06/24/2009 12:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sproc_AlertDiscoveryForTrans]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE Procedure [dbo].[sproc_AlertDiscoveryForTrans]  
--@ID   nvarchar(20)  
AS  
  
Declare    
  @bTran AS INT,        
  @lErrCode AS INT,   
  @Id AS INT, -- this one is being used for the cursor   
  @cycleID AS TINYINT,      
  @nextOccurence AS DATETIME, -- this is the next occurence of the event  
  /* The Following Variables are used for the sp call where insertions into the  
     notification table is made */  
  @aes_EventSetupId   BIGINT,  
  @ael_EventId SMALLINT,  
  @aen_EventMessage VARCHAR(500),  
  @aen_SchemeId int,  
  @aen_TargetId int,
  @aen_CreatedBy Varchar(50),
  @aen_CreatedFor Varchar(50),  
  @ael_EventCode Varchar(50),  
  @modes VARCHAR(8),  
  @ael_FieldName VARCHAR(1000),  
  @ael_TableName VARCHAR(1000),  
  @triggerConditionMatch int,
  @dayAddForNextOccurence int  
  
-- Set Default Values  
SET @triggerConditionMatch = 0;  
SET @dayAddForNextOccurence = 0;
  
  
/* Create Temp Table*/  
        
-- Create Temp Tables  
If (object_id(N''tempdb..[#DataEvents]'')) Is Null      
  Create Table [#DataEvents]      
  (     
 [Id] [int] IDENTITY (1, 1) NOT NULL,  
 [EL_AEL_EventID] [smallint] NOT NULL,  
 [EL_AEL_EventCode] [varchar] (50) NOT NULL,  
 [EL_AEL_EventType] [char] (20) NOT NULL,  
 [EL_AEL_Reminder] [bit] NOT NULL,  
 [EL_AEL_DefaultMessage] [varchar] (200) NULL,  
 [EL_AEL_TriggerCondition] [varchar](50) NOT NULL,  
 [EL_CL_CycleID] [tinyint] NULL,  
 [EL_AEL_IsAvailable] [bit] NOT NULL,  
 [EL_AEL_DataConditionField] [varchar] (150) NULL,-- For this Event Type insert null  
 [EL_AEL_FieldName] [varchar] (1000) NOT NULL,  
 [EL_AEL_TableName] [varchar] (1000) NOT NULL,  
 [ES_AES_EventSetupID] [bigint] NOT NULL,  
 [ES_AES_EventMessage] [varchar](500) NULL,  
 [ES_AES_SchemeID] [int] NOT NULL,  
 [ES_AES_TargetId] [int] NOT NULL,
 [ES_AES_CreatedFor] [int]  NULL,
 [ES_AES_CreatedBy] [int]  NULL,  
 [ES_AES_NextOccurence] [datetime] NULL,  
 [ES_AES_LastOccurence] [datetime] NULL,  
 [ES_AES_EndDate] [datetime] NULL,  
 [ES_CL_CycleID] [tinyint] NULL,  
 [ES_AES_DeliveryMode][varchar] (8) NOT NULL,  
 [ES_AES_SentToQueue] [bit] NOT NULL,  
 [FinalMessage] [varchar] (500) NULL,  
 [Processed] [int] NOT NULL,  
 [CreatedDate] [datetime] NULL,  
 [ModifiedDate] [datetime] NULL,  
 [NextCalculatedOccurene] [datetime] NULL  
  )  
  
/* Step 1 -  Insert Data into the Temp Table */  
INSERT INTO [#DataEvents]([EL_AEL_EventID],[EL_AEL_EventCode],[EL_AEL_EventType] ,[EL_AEL_Reminder],  
[EL_AEL_DefaultMessage],[EL_AEL_TriggerCondition] ,  
[EL_CL_CycleID],[EL_AEL_IsAvailable],[EL_AEL_DataConditionField], [EL_AEL_FieldName],[EL_AEL_TableName],  
[ES_AES_EventSetupID],[ES_AES_EventMessage],  
[ES_AES_SchemeID],[ES_AES_TargetId],[ES_AES_CreatedFor],[ES_AES_CreatedBy],[ES_AES_NextOccurence] ,[ES_AES_LastOccurence],  
[ES_AES_EndDate],[ES_CL_CycleID],[ES_AES_DeliveryMode],[ES_AES_SentToQueue],[FinalMessage],  
[Processed],[CreatedDate],[ModifiedDate],[NextCalculatedOccurene])  
  
Select EL.AEL_EventID,EL.AEL_EventCode,EL.AEL_EventType,EL.AEL_Reminder,EL.AEL_DefaultMessage,  
EL.AEL_TriggerCondition,EL.CL_CycleId,EL.AEL_IsAvailable,EL.AEL_DataConditionField,EL.AEL_FieldName,EL.AEL_TableName,  
ES.AES_EventSetupID,ES.AES_EventMessage,ES.AES_SchemeID,ES.AES_TargetId,ES.AES_CreatedFor,ES.AES_CreatedBy,ES.AES_NextOccurence,  
ES.AES_LastOccurence,ES.AES_EndDate,ES.CL_CycleID,ES.AES_DeliveryMode,ES.AES_SentToQueue,  
CASE When (ES.[AES_EventMessage] IS NULL) THEN EL.[AEL_DefaultMessage] Else ES.[AES_EventMessage] END  
,0,GETDATE(),NULL,NULL  
  
From AlertEventSetup ES   
  
Inner Join AlertEventLookup EL  ON ES.AEL_EventId = EL.AEL_EventID  
  
Where   
  
(  
 (EL.AEL_EventType = ''Transactional'') AND (EL.AEL_IsAvailable = 1) AND   
 ((ES.AES_NextOccurence IS  NULL) OR (dbo.GetStartOfDay(ES.AES_NextOccurence) = dbo.GetStartOfDay(GETDATE()))) AND   
 ((ES.AES_EndDate IS NULL) OR (ES.AES_EndDate > GETDATE())) AND  
  (ES.AES_SentToQueue = ''False'')   
)  
  
-- Start the Transaction     
                     
If (@@Trancount = 0)                        
Begin                        
 Set @bTran = 1                        
 Begin Transaction                        
End   
  
/* Step 2 - Do a sanity check on the data and delete all the dirty data - TBD */  
Select * From #DataEvents  
  
  
/* Step 3 -  Handle Insertions in AlertEventNotification     */  
-- Start a cursor    
Declare SL_Cursor CURSOR LOCAL FAST_FORWARD READ_ONLY    
For Select [Id],[ES_AES_NextOccurence],[ES_CL_CycleID],[ES_AES_EventSetupID],  
[EL_AEL_EventID], [FinalMessage],[ES_AES_SchemeID],[ES_AES_TargetId],[ES_AES_CreatedFor],[ES_AES_CreatedBy],  
[ES_AES_DeliveryMode],[EL_AEL_FieldName],[EL_AEL_TableName],[EL_AEL_EventCode]  
  
From #DataEvents    
    
-- Open the cursor    
Open SL_Cursor    
     
 -- Fetch    
 Fetch Next From SL_Cursor Into @Id , @nextOccurence, @cycleID,  
 @aes_EventSetupId,@ael_EventId ,@aen_EventMessage,@aen_SchemeId,  
 @aen_TargetId ,@aen_CreatedFor,@aen_CreatedBy,@modes,@ael_FieldName,  
 @ael_TableName,@ael_EventCode  
  
 While @@FETCH_STATUS = 0    
 Begin   
       
  -- 3(a)(i)  - Get the new table.column from EventLookup Table (ValueToBeMatched]  
    exec sproc_ProcessConditionFieldsForTransEvent @aen_TargetId,@aen_SchemeId,@ael_EventCode ,@ael_FieldName,@ael_TableName,@triggerConditionMatch  out  
    Select @aen_TargetId,@aen_SchemeId,@ael_EventCode ,@ael_FieldName,@ael_TableName,@triggerConditionMatch  out  
 -- This is  done for testing purpose. Uncomment it only when debugging  
    Select @aen_TargetId,@aen_SchemeId,@ael_FieldName,@ael_EventCode,@ael_TableName,@triggerConditionMatch  
  
     -- 3(a)(ii) - Does Nothing  
   
  
  -- 3(a) (iv) - Call the Stored Procedure to make entries into the AlertEventNotification.  
  -- This stored procedure will take the basic columns and the mode as an input  
  
     IF(@triggerConditionMatch =1)  
  BEGIN  
   exec sproc_AlertInsertModeBasedNotification @aes_EventSetupId,@ael_EventId,@aen_EventMessage ,@aen_SchemeId ,@modes, @aen_CreatedBy,@aen_CreatedFor
  END  
   
  
  -- 3(b) Calculate NextOccurence (Not required for Data Type  
 IF(@triggerConditionMatch =1)  
	 BEGIN
		SET @dayAddForNextOccurence = 0
	 END
 ELSE
	 BEGIN
		SET @dayAddForNextOccurence  = 1
	 END

 Update #DataEvents  
 SET [NextCalculatedOccurene] = dbo.GetStartOfDay(DATEADD(d,@dayAddForNextOccurence,GETDATE()))  
 Where ID = @Id   
  
  -- 3(c) Now Set the Processed = 1 for the particular row as it will tell which records were processed  
  Update #DataEvents  
  Set Processed = 1,ModifiedDate = GETDATE()   
  Where ID = @Id   
  
  --- Fetch Next    
    Fetch Next From SL_Cursor Into @Id , @nextOccurence, @cycleID,  
   @aes_EventSetupId,@ael_EventId ,@aen_EventMessage,@aen_SchemeId,  
   @aen_TargetId ,@aen_CreatedFor,@aen_CreatedBy,@modes,@ael_FieldName,  
   @ael_TableName,@ael_EventCode  
 End    
     
 Close SL_Cursor    
 Deallocate SL_Cursor   
     
  
/* Step 4 -  After Insertion  Modify Table AlertEventSetup and SET AES_SentToQueue = 1  
  Do this for records for which Processed = 1*/  

Update AlertEventSetup  
Set AES_SentToQueue = 1,AES_LastOccurence = DE.ModifiedDate  
From [#DataEvents] DE  
Inner Join AlertEventSetup ES ON DE.[ES_AES_EventSetupID] = ES.[AES_EventSetupID]  
Where DE.Processed = 1  
  
  
  
/* Step 5 -  Re-calculate the NextOccurence Depending on the Cycle Id. Also Set AES_SentToQueue = 0*/  
Update AlertEventSetup  
Set AES_SentToQueue = 0,AES_NextOccurence =  DE.[NextCalculatedOccurene]  
From [#DataEvents] DE  
Inner Join AlertEventSetup ES ON DE.[ES_AES_EventSetupID] = ES.[AES_EventSetupID]  
Where DE.Processed = 1  
  
/* Step - 6 - Check Data */  

Select * From AlertEventSetup ES INNER JOIN  AlertEventLookUP EL ON ES.AEL_EventID = EL.AEL_EventID  
Where AEL_EventType = ''Transactional''  

  
Success:        
 If (@bTran = 1 And @@Trancount > 0)        
 Begin                                      
  Commit Tran        
 End        
 Return 0        
        
 Goto Done        
        
Error:        
 If (@bTran = 1 And @@Trancount > 0)        
 Begin        
  Rollback Transaction        
 End        
 Return @lErrCode        
  
          
Done:      
 
-- exec sproc_AlertDiscoveryForTrans

' 
END
GO
