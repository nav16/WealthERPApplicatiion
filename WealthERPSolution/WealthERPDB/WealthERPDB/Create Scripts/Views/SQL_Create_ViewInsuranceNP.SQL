/****** Object:  View [dbo].[ViewInsuranceNP]    Script Date: 06/24/2009 14:45:27 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ViewInsuranceNP]'))
DROP VIEW [dbo].[ViewInsuranceNP]
GO
/****** Object:  View [dbo].[ViewInsuranceNP]    Script Date: 06/24/2009 14:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ViewInsuranceNP]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW dbo.ViewInsuranceNP
AS
SELECT     dbo.CustomerInsuranceNetPosition.CINP_InsuranceNPId, dbo.CustomerInsuranceNetPosition.PAIC_AssetInstrumentCategoryCode, 
                      dbo.CustomerInsuranceNetPosition.PAG_AssetGroupCode, dbo.CustomerInsuranceNetPosition.CIA_AccountId, 
                      dbo.CustomerInsuranceNetPosition.XII_InsuranceIssuerCode, dbo.CustomerInsuranceNetPosition.XF_PremiumFrequencyCode, 
                      dbo.CustomerInsuranceNetPosition.CINP_Name, dbo.CustomerInsuranceNetPosition.CINP_PremiumAmount, 
                      dbo.CustomerInsuranceNetPosition.CINP_PremiumDuration, dbo.CustomerInsuranceNetPosition.CINP_SumAssured, 
                      dbo.CustomerInsuranceNetPosition.CINP_StartDate, dbo.CustomerInsuranceNetPosition.CINP_PolicyPeriod, 
                      dbo.CustomerInsuranceNetPosition.CINP_PremiumAccumalated, dbo.CustomerInsuranceNetPosition.CINP_PolicyEpisode, 
                      dbo.CustomerInsuranceNetPosition.CINP_BonusAccumalated, dbo.CustomerInsuranceNetPosition.CINP_SurrenderValue, 
                      dbo.CustomerInsuranceNetPosition.CINP_Remark, dbo.CustomerInsuranceNetPosition.CINP_MaturityValue, 
                      dbo.CustomerInsuranceNetPosition.CINP_EndDate, dbo.CustomerInsuranceNetPosition.CINP_GracePeriod, 
                      dbo.CustomerInsuranceNetPosition.CINP_ULIPCharges, dbo.CustomerInsuranceNetPosition.CINP_PremiumPaymentDate, 
                      dbo.CustomerInsuranceNetPosition.CINP_ApplicationNum, dbo.CustomerInsuranceNetPosition.CINP_ApplicationDate, 
                      dbo.CustomerInsuranceNetPosition.CINP_CreatedOn, dbo.CustomerInsuranceNetPosition.CINP_CreatedBy, 
                      dbo.CustomerInsuranceNetPosition.CINP_ModifiedBy, dbo.CustomerInsuranceNetPosition.CINP_ModifiedOn, dbo.Adviser.A_AdviserId, 
                      dbo.AdviserRM.AR_RMId, dbo.Customer.C_CustomerId, dbo.CustomerPortfolio.CP_PortfolioId, 
                      dbo.ProductAssetInstrumentCategory.PAIC_AssetInstrumentCategoryName, dbo.ProductAssetGroup.PAG_AssetGroupName
FROM         dbo.Adviser INNER JOIN
                      dbo.AdviserRM ON dbo.Adviser.A_AdviserId = dbo.AdviserRM.A_AdviserId INNER JOIN
                      dbo.Customer ON dbo.AdviserRM.AR_RMId = dbo.Customer.AR_RMId INNER JOIN
                      dbo.CustomerPortfolio ON dbo.Customer.C_CustomerId = dbo.CustomerPortfolio.C_CustomerId INNER JOIN
                      dbo.CustomerInsuranceAccount ON dbo.CustomerPortfolio.CP_PortfolioId = dbo.CustomerInsuranceAccount.CP_PortfolioId INNER JOIN
                      dbo.ProductAssetInstrumentCategory ON 
                      dbo.CustomerInsuranceAccount.PAIC_AssetInstrumentCategoryCode = dbo.ProductAssetInstrumentCategory.PAIC_AssetInstrumentCategoryCode AND 
                      dbo.CustomerInsuranceAccount.PAG_AssetGroupCode = dbo.ProductAssetInstrumentCategory.PAG_AssetGroupCode INNER JOIN
                      dbo.CustomerInsuranceNetPosition ON dbo.CustomerInsuranceAccount.CIA_AccountId = dbo.CustomerInsuranceNetPosition.CIA_AccountId AND 
                      dbo.ProductAssetInstrumentCategory.PAIC_AssetInstrumentCategoryCode = dbo.CustomerInsuranceNetPosition.PAIC_AssetInstrumentCategoryCode AND
                       dbo.ProductAssetInstrumentCategory.PAG_AssetGroupCode = dbo.CustomerInsuranceNetPosition.PAG_AssetGroupCode INNER JOIN
                      dbo.ProductAssetGroup ON dbo.ProductAssetInstrumentCategory.PAG_AssetGroupCode = dbo.ProductAssetGroup.PAG_AssetGroupCode
' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'ViewInsuranceNP', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[54] 4[8] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Adviser"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AdviserRM"
            Begin Extent = 
               Top = 6
               Left = 298
               Bottom = 121
               Right = 505
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer"
            Begin Extent = 
               Top = 6
               Left = 543
               Bottom = 121
               Right = 768
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CustomerPortfolio"
            Begin Extent = 
               Top = 126
               Left = 337
               Bottom = 241
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CustomerInsuranceAccount"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 241
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductAssetInstrumentCategory"
            Begin Extent = 
               Top = 126
               Left = 546
               Bottom = 241
               Right = 809
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CustomerInsuranceNetPosition"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 361
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewInsuranceNP'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane2' , N'SCHEMA',N'dbo', N'VIEW',N'ViewInsuranceNP', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'          Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductAssetGroup"
            Begin Extent = 
               Top = 246
               Left = 337
               Bottom = 354
               Right = 526
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewInsuranceNP'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'ViewInsuranceNP', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewInsuranceNP'
GO
