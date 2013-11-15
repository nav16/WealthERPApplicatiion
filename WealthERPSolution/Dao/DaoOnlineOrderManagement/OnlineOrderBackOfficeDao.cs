﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.Sql;
using VoOnlineOrderManagemnet;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;
using System.Data.OleDb;
using System.Configuration;
using System.Data.SqlClient;



namespace DaoOnlineOrderManagement
{
    public class OnlineOrderBackOfficeDao
    {
        public DataSet GetExtractType()
        {
            DataSet dsExtractType;
            Database db;
            DbCommand GetGetMfOrderExtractCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                GetGetMfOrderExtractCmd = db.GetStoredProcCommand("SPROC_GetExtractType");

                dsExtractType = db.ExecuteDataSet(GetGetMfOrderExtractCmd);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OperationDao.cs:GetMfOrderExtract()");
                object[] objects = new object[10];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsExtractType;
        }



        public DataSet GetExtractTypeDataForFileCreation(DateTime orderDate, int AdviserId, int extractType)
        {
            DataSet dsExtractType;
            Database db;
            DbCommand GetGetMfOrderExtractCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                GetGetMfOrderExtractCmd = db.GetStoredProcCommand("SPROC_GetExtractTypeDataForFileCreation");
                if (orderDate != DateTime.MinValue)
                    db.AddInParameter(GetGetMfOrderExtractCmd, "@orderDate", DbType.DateTime, orderDate);
                db.AddInParameter(GetGetMfOrderExtractCmd, "@adviserId", DbType.Int32, AdviserId);
                db.AddInParameter(GetGetMfOrderExtractCmd, "@extractType", DbType.Int32, extractType);
                dsExtractType = db.ExecuteDataSet(GetGetMfOrderExtractCmd);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OperationDao.cs:GetMfOrderExtract()");
                object[] objects = new object[10];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsExtractType;
        }

        public DataSet GetMfOrderExtract(DateTime ExecutionDate, int AdviserId, string TransactionType, string RtaIdentifier, int AmcCode)
        {
            DataSet dsGetMfOrderExtract;
            Database db;
            DbCommand cmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_GetAdviserMfOrderExtract");
                db.AddInParameter(cmd, "@WTBD_ExecutionDate", DbType.DateTime, ExecutionDate);
                db.AddInParameter(cmd, "@A_AdviserId", DbType.Int32, AdviserId);
                db.AddInParameter(cmd, "@XES_SourceCode", DbType.String, RtaIdentifier);
                if (string.IsNullOrEmpty(TransactionType) == false && TransactionType.ToUpper() != "ALL") { db.AddInParameter(cmd, "@WMTT_TransactionClassificationCode", DbType.String, TransactionType); }
                if (AmcCode > 0) { db.AddInParameter(cmd, "@PA_AMCCode", DbType.Int32, AmcCode); }

                dsGetMfOrderExtract = db.ExecuteDataSet(cmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetMfOrderExtract(DateTime ExecutionDate, int AdviserId, string TransactionType, string RtaIdentifier)");
                object[] objects = new object[4];
                objects[0] = ExecutionDate;
                objects[1] = AdviserId;
                objects[2] = TransactionType;
                objects[3] = RtaIdentifier;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsGetMfOrderExtract;
        }

        public DataSet GetOrderExtractHeaderMapping(string RtaIdentifier)
        {
            DataSet dsHeaderMapping;
            Database db;
            DbCommand cmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_OrderExtractHeaderMapping");
                db.AddInParameter(cmd, "@XES_SourceCode", DbType.String, RtaIdentifier);

                dsHeaderMapping = db.ExecuteDataSet(cmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OperationDao.cs:GetOrderExtractHeaderMapping(string RtaIdentifier)");
                object[] objects = new object[1];
                objects[0] = RtaIdentifier;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsHeaderMapping;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="ExecutionDate"></param>
        /// <param name="AdviserId"></param>
        /// <param name="XES_SourceCode"></param>
        /// <param name="OrderType"></param>
        /// <returns></returns>
        public int GenerateOrderExtract(int AmcCode, DateTime ExecutionDate, int AdviserId, string XES_SourceCode, string OrderType)
        {
            Database db;
            DbCommand cmd;
            int rowsCreated = 0;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_CreateAdviserMFOrderExtract");
                db.AddInParameter(cmd, "@PA_AMCCode", DbType.Int32, AmcCode);
                db.AddInParameter(cmd, "@WTBD_ExecutionDate", DbType.Date, ExecutionDate);
                db.AddInParameter(cmd, "@A_AdviserId", DbType.Int32, AdviserId);
                db.AddInParameter(cmd, "@XES_SourceCode", DbType.String, XES_SourceCode);
                if (string.IsNullOrEmpty(OrderType) == false && OrderType.ToUpper() != "ALL") { db.AddInParameter(cmd, "@WMTT_TransactionClassificationCode", DbType.String, OrderType); }
                db.AddOutParameter(cmd, "@OrderExtractCreated", DbType.Int32, 0);
                db.ExecuteDataSet(cmd);
                string paramOut = db.GetParameterValue(cmd, "@OrderExtractCreated").ToString();
                if (string.IsNullOrEmpty(paramOut) != true)
                    rowsCreated = int.Parse(paramOut);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GenerateOrderExtract()");
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return rowsCreated;
        }
        public DataSet GetSubCategory(string CategoryCode)
        {
            Database db;
            DataSet dsSubCategory;
            DbCommand SubCategorycmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                SubCategorycmd = db.GetStoredProcCommand("Sproc_BindSubCategory");
                db.AddInParameter(SubCategorycmd, "@CategoryCode", DbType.String, CategoryCode);
                dsSubCategory = db.ExecuteDataSet(SubCategorycmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetSubCategory()");
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsSubCategory;
        }
        public DataSet GetSubSubCategory(string CategoryCode, string SubCategoryCode)
        {
            Database db;
            DataSet dsSubSubCategory;
            DbCommand SubSubCategorycmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                SubSubCategorycmd = db.GetStoredProcCommand("Sproc_BindSubSubCategory");
                db.AddInParameter(SubSubCategorycmd, "@CategoryCode", DbType.String, CategoryCode);
                db.AddInParameter(SubSubCategorycmd, "@SubCategoryCode", DbType.String, SubCategoryCode);
                dsSubSubCategory = db.ExecuteDataSet(SubSubCategorycmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetSubSubCategory()");
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsSubSubCategory;
        }

        public List<int> CreateOnlineSchemeSetUp(MFProductAMCSchemePlanDetailsVo mfProductAMCSchemePlanDetailsVo, int userId)
        {
            List<int> SchemePlancodes = new List<int>();
            int SchemePlancode = 0;

            Database db;
            DbCommand createMFOnlineSchemeSetUpCmd;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createMFOnlineSchemeSetUpCmd = db.GetStoredProcCommand("SPROC_Onl_CreateOnlineSchemeSetUp");
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PA_AMCCode", DbType.Int32, mfProductAMCSchemePlanDetailsVo.AMCCode);
                //db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASP_SchemePlanName", DbType.String, mfProductAMCSchemePlanDetailsVo.SchemePlanName);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASP_SchemePlanName", DbType.String, mfProductAMCSchemePlanDetailsVo.SchemePlanName);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PAISSC_AssetInstrumentSubSubCategoryCode", DbType.String, mfProductAMCSchemePlanDetailsVo.AssetSubSubCategory);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PAISC_AssetInstrumentSubCategoryCode", DbType.String, mfProductAMCSchemePlanDetailsVo.AssetSubCategoryCode);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PAIC_AssetInstrumentCategoryCode", DbType.String, mfProductAMCSchemePlanDetailsVo.AssetCategoryCode);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PAG_AssetGroupCode", DbType.String, mfProductAMCSchemePlanDetailsVo.Product);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASP_Status", DbType.String, mfProductAMCSchemePlanDetailsVo.Status);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASP_IsOnline", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsOnline);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASP_IsDirect", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsDirect);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_FaceValue", DbType.Double, mfProductAMCSchemePlanDetailsVo.FaceValue);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PSLV_LookupValueCodeForSchemeType", DbType.String, mfProductAMCSchemePlanDetailsVo.SchemeType);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PSLV_LookupValueCodeForSchemeOption", DbType.String, mfProductAMCSchemePlanDetailsVo.SchemeOption);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@XF_DividendFrequency", DbType.String, mfProductAMCSchemePlanDetailsVo.DividendFrequency);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_BankName", DbType.String, mfProductAMCSchemePlanDetailsVo.BankName);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_AccountNumber", DbType.String, mfProductAMCSchemePlanDetailsVo.AccountNumber);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_Branch", DbType.String, mfProductAMCSchemePlanDetailsVo.Branch);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_IsNFO", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsNFO);
                if (mfProductAMCSchemePlanDetailsVo.NFOStartDate != DateTime.MinValue)
                {
                    db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_NFOStartDate", DbType.DateTime, mfProductAMCSchemePlanDetailsVo.NFOStartDate);
                }
                else
                {
                    db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_NFOStartDate", DbType.DateTime, DBNull.Value);
                }
                if (mfProductAMCSchemePlanDetailsVo.NFOEndDate != DateTime.MinValue)
                {
                    db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_NFOEndDate", DbType.DateTime, mfProductAMCSchemePlanDetailsVo.NFOEndDate);
                }
                else
                {
                    db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_NFOEndDate", DbType.DateTime, DBNull.Value);
                }
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_LockInPeriod", DbType.Int32, mfProductAMCSchemePlanDetailsVo.LockInPeriod);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_CutOffTime", DbType.String, mfProductAMCSchemePlanDetailsVo.CutOffTime.ToString());
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_EntryLoadPercentag", DbType.Double, mfProductAMCSchemePlanDetailsVo.EntryLoadPercentag);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_EntryLoadRemark", DbType.String, mfProductAMCSchemePlanDetailsVo.EntryLoadRemark);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_ExitLoadPercentage", DbType.Double, mfProductAMCSchemePlanDetailsVo.ExitLoadPercentage);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_ExitLoadRemark", DbType.String, mfProductAMCSchemePlanDetailsVo.ExitLoadRemark);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_IsPurchaseAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsPurchaseAvailable);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_IsRedeemAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsRedeemAvailable);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_IsSIPAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsSIPAvailable);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_IsSWPAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsSWPAvailable);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_IsSwitchAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsSwitchAvailable);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_IsSTPAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsSTPAvailable);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_InitialPurchaseAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.InitialPurchaseAmount);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_InitialMultipleAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.InitialMultipleAmount);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_AdditionalPruchaseAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.AdditionalPruchaseAmount);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_AdditionalMultipleAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.AdditionalMultipleAmount);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_MinRedemptionAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.MinRedemptionAmount);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_RedemptionMultipleAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.RedemptionMultipleAmount);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_MinRedemptionUnits", DbType.Int32, mfProductAMCSchemePlanDetailsVo.MinRedemptionUnits);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_RedemptionMultiplesUnits", DbType.Int32, mfProductAMCSchemePlanDetailsVo.RedemptionMultiplesUnits);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_MinSwitchAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.MinSwitchAmount);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_SwitchMultipleAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.SwitchMultipleAmount);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_MinSwitchUnits", DbType.Int32, mfProductAMCSchemePlanDetailsVo.MinSwitchUnits);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_SwitchMultiplesUnits", DbType.Int32, mfProductAMCSchemePlanDetailsVo.SwitchMultiplesUnits);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@XF_FileGenerationFrequency", DbType.String, mfProductAMCSchemePlanDetailsVo.GenerationFrequency);
                //db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@XES_SourceCode", DbType.String, mfProductAMCSchemePlanDetailsVo.SourceCode);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@XES_SourceCode", DbType.String, DBNull.Value);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@XCST_CustomerSubTypeCode", DbType.String, mfProductAMCSchemePlanDetailsVo.CustomerSubTypeCode);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_SecurityCode", DbType.String, mfProductAMCSchemePlanDetailsVo.SecurityCode);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_MaxInvestment", DbType.Double, mfProductAMCSchemePlanDetailsVo.PASPD_MaxInvestment);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@WERPBM_BankCode", DbType.String, mfProductAMCSchemePlanDetailsVo.WERPBM_BankCode);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@ExternalCode", DbType.String, mfProductAMCSchemePlanDetailsVo.ExternalCode);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@ExternalType", DbType.String, mfProductAMCSchemePlanDetailsVo.ExternalType);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASP_CreatedBy", DbType.Int32, userId);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASP_ModifiedBy", DbType.Int32, userId);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_CreatedBy", DbType.Int32, userId);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASPD_ModifiedBy", DbType.Int32, userId);
                // db.AddOutParameter(createMFOnlineSchemeSetUpCmd, "@PASP_SchemePlanCode", DbType.Int32, 10000);
                db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASP_SchemePlanCode", DbType.Int32, mfProductAMCSchemePlanDetailsVo.SchemePlanCode);
                //db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@XF_DividendFrequency", DbType.String, mfProductAMCSchemePlanDetailsVo.DividendFrequency);
                db.ExecuteNonQuery(createMFOnlineSchemeSetUpCmd);
                //{
                //    SchemePlancode = Convert.ToInt32(db.GetParameterValue(createMFOnlineSchemeSetUpCmd, "PASP_SchemePlanCode").ToString());
                //    SchemePlancodes.Add(SchemePlancode);


                //}
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return SchemePlancodes;
        }
        public MFProductAMCSchemePlanDetailsVo GetOnlineSchemeSetUp(int SchemePlanCode)
        {
            MFProductAMCSchemePlanDetailsVo mfProductAMCSchemePlanDetailsVo = new MFProductAMCSchemePlanDetailsVo();
            Database db;
            DataSet getSchemeSetUpDs;
            DbCommand getSchemeSetUpCmd;

            try
            {

                db = DatabaseFactory.CreateDatabase("wealtherp");
                getSchemeSetUpCmd = db.GetStoredProcCommand("Sproc_getOnlineschemeSetUp");
                db.AddInParameter(getSchemeSetUpCmd, "@PASP_SchemePlanCode", DbType.Int32, SchemePlanCode);
                getSchemeSetUpDs = db.ExecuteDataSet(getSchemeSetUpCmd);
                if (getSchemeSetUpDs.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in getSchemeSetUpDs.Tables[0].Rows)
                    {

                        mfProductAMCSchemePlanDetailsVo.AMCCode = int.Parse(dr["PA_AMCCode"].ToString());
                        mfProductAMCSchemePlanDetailsVo.SchemePlanName = dr["PASP_SchemePlanName"].ToString();
                        mfProductAMCSchemePlanDetailsVo.SchemePlanCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfProductAMCSchemePlanDetailsVo.AssetSubSubCategory = dr["PAISSC_AssetInstrumentSubSubCategoryCode"].ToString();
                        mfProductAMCSchemePlanDetailsVo.AssetSubCategoryCode = dr["PAISC_AssetInstrumentSubCategoryCode"].ToString();
                        mfProductAMCSchemePlanDetailsVo.AssetCategoryCode = dr["PAIC_AssetInstrumentCategoryCode"].ToString();
                        mfProductAMCSchemePlanDetailsVo.Product = dr["PAG_AssetGroupCode"].ToString();
                        mfProductAMCSchemePlanDetailsVo.Status = dr["PASP_Status"].ToString();
                        if (dr["PASP_IsOnline"].ToString() == "True")
                        {
                            mfProductAMCSchemePlanDetailsVo.IsOnline = 1;
                        }
                        else
                        {
                            mfProductAMCSchemePlanDetailsVo.IsOnline = 0;
                        }
                        if (mfProductAMCSchemePlanDetailsVo.IsDirect != 0)
                        {
                            mfProductAMCSchemePlanDetailsVo.IsDirect = int.Parse(dr["PASP_IsDirect"].ToString());
                        }
                        else
                        {
                            mfProductAMCSchemePlanDetailsVo.IsDirect = 0;
                        }
                        if (dr["PASPD_FaceValue"].ToString() != null && dr["PASPD_FaceValue"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.FaceValue = Convert.ToDouble(dr["PASPD_FaceValue"].ToString());
                        mfProductAMCSchemePlanDetailsVo.SchemeType = dr["PSLV_LookupValueCodeForSchemeType"].ToString();
                        mfProductAMCSchemePlanDetailsVo.SchemeOption = dr["PSLV_LookupValueCodeForSchemeOption"].ToString();
                        if (dr["XF_DividendFrequency"].ToString() != null && dr["XF_DividendFrequency"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.DividendFrequency = dr["XF_DividendFrequency"].ToString();
                        mfProductAMCSchemePlanDetailsVo.BankName = dr["PASPD_BankName"].ToString();
                        mfProductAMCSchemePlanDetailsVo.AccountNumber = dr["PASPD_AccountNumber"].ToString();
                        mfProductAMCSchemePlanDetailsVo.Branch = dr["PASPD_Branch"].ToString();
                        if (dr["PASPD_IsNFO"].ToString() == "True")
                        {
                            mfProductAMCSchemePlanDetailsVo.IsNFO = 1;
                        }
                        else
                        {
                            mfProductAMCSchemePlanDetailsVo.IsNFO = 0;
                        }
                        if (mfProductAMCSchemePlanDetailsVo.NFOStartDate != DateTime.MinValue)
                            mfProductAMCSchemePlanDetailsVo.NFOStartDate = DateTime.Parse(dr["PASPD_NFOStartDate"].ToString());
                        if (mfProductAMCSchemePlanDetailsVo.NFOEndDate != DateTime.MinValue)
                            mfProductAMCSchemePlanDetailsVo.NFOEndDate = DateTime.Parse(dr["PASPD_NFOEndDate"].ToString());
                        if (dr["PASPD_LockInPeriod"].ToString() != null && dr["PASPD_LockInPeriod"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.LockInPeriod = int.Parse(dr["PASPD_LockInPeriod"].ToString());
                        if (dr["PASPD_CutOffTime"].ToString() != null && dr["PASPD_CutOffTime"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.CutOffTime = TimeSpan.Parse(dr["PASPD_CutOffTime"].ToString());
                        if (dr["PASPD_EntryLoadPercentage"].ToString() != null && dr["PASPD_EntryLoadPercentage"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.EntryLoadPercentag = Convert.ToDouble(dr["PASPD_EntryLoadPercentage"].ToString());
                        if (dr["PASPD_EntryLoadRemark"].ToString() != null && dr["PASPD_EntryLoadRemark"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.EntryLoadRemark = dr["PASPD_EntryLoadRemark"].ToString();
                        if (dr["PASPD_ExitLoadPercentage"].ToString() != null && dr["PASPD_ExitLoadPercentage"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.ExitLoadPercentage = Convert.ToDouble(dr["PASPD_ExitLoadPercentage"].ToString());
                        if (dr["PASPD_ExitLoadRemark"].ToString() != null && dr["PASPD_ExitLoadRemark"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.ExitLoadRemark = dr["PASPD_ExitLoadRemark"].ToString();
                        if (dr["PASPD_IsPurchaseAvailable"].ToString() == "True")
                        {
                            mfProductAMCSchemePlanDetailsVo.IsPurchaseAvailable = 1;
                        }
                        else
                        {
                            mfProductAMCSchemePlanDetailsVo.IsPurchaseAvailable = 0;
                        }
                        if (dr["PASPD_IsRedeemAvailable"].ToString() == "True")
                        {
                            mfProductAMCSchemePlanDetailsVo.IsRedeemAvailable = 1;
                        }
                        else
                        {
                            mfProductAMCSchemePlanDetailsVo.IsRedeemAvailable = 0;
                        }
                        if (dr["PASPD_IsSIPAvailable"].ToString() == "True")
                        {
                            mfProductAMCSchemePlanDetailsVo.IsSIPAvailable = 1;
                        }
                        else
                        {
                            mfProductAMCSchemePlanDetailsVo.IsSIPAvailable = 0;
                        }
                        if (dr["PASPD_IsSWPAvailable"].ToString() == "True")
                        {
                            mfProductAMCSchemePlanDetailsVo.IsSWPAvailable = 1;
                        }
                        else
                        {
                            mfProductAMCSchemePlanDetailsVo.IsSWPAvailable = 0;
                        }
                        if (dr["PASPD_IsSwitchAvailable"].ToString() == "True")
                        {
                            mfProductAMCSchemePlanDetailsVo.IsSwitchAvailable = 1;
                        }
                        else
                        {
                            mfProductAMCSchemePlanDetailsVo.IsSwitchAvailable = 0;
                        }
                        if (dr["PASPD_IsSTPAvailable"].ToString() == "True")
                        {
                            mfProductAMCSchemePlanDetailsVo.IsSTPAvailable = 1;
                        }
                        else
                        {
                            mfProductAMCSchemePlanDetailsVo.IsSTPAvailable = 0;
                        }
                        if (dr["PASPD_InitialPurchaseAmount"].ToString() != null && dr["PASPD_InitialPurchaseAmount"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.InitialPurchaseAmount = Convert.ToDouble(dr["PASPD_InitialPurchaseAmount"].ToString());
                        if (dr["PASPD_InitialMultipleAmount"].ToString() != null && dr["PASPD_InitialMultipleAmount"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.InitialMultipleAmount = Convert.ToDouble(dr["PASPD_InitialMultipleAmount"].ToString());
                        if (dr["PASPD_InitialMultipleAmount"].ToString() != null && dr["PASPD_InitialMultipleAmount"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.AdditionalPruchaseAmount = Convert.ToDouble(dr["PASPD_InitialMultipleAmount"].ToString());
                        if (dr["PASPD_AdditionalMultipleAmount"].ToString() != null && dr["PASPD_AdditionalMultipleAmount"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.AdditionalMultipleAmount = Convert.ToDouble(dr["PASPD_AdditionalMultipleAmount"].ToString());
                        if (dr["PASPD_MinRedemptionAmount"].ToString() != null && dr["PASPD_MinRedemptionAmount"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.MinRedemptionAmount = Convert.ToDouble(dr["PASPD_MinRedemptionAmount"].ToString());
                        if (dr["PASPD_RedemptionMultipleAmount"].ToString() != null && dr["PASPD_RedemptionMultipleAmount"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.RedemptionMultipleAmount = Convert.ToDouble(dr["PASPD_RedemptionMultipleAmount"].ToString());
                        if (dr["PASPD_MinRedemptionUnits"].ToString() != null && dr["PASPD_MinRedemptionUnits"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.MinRedemptionUnits = int.Parse(dr["PASPD_MinRedemptionUnits"].ToString());
                        if (dr["PASPD_RedemptionMultiplesUnits"].ToString() != null && dr["PASPD_RedemptionMultiplesUnits"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.RedemptionMultiplesUnits = int.Parse(dr["PASPD_RedemptionMultiplesUnits"].ToString());
                        if (dr["PASPD_MinSwitchAmount"].ToString() != null && dr["PASPD_MinSwitchAmount"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.MinSwitchAmount = Convert.ToDouble(dr["PASPD_MinSwitchAmount"].ToString());
                        if (dr["PASPD_SwitchMultipleAmount"].ToString() != null && dr["PASPD_SwitchMultipleAmount"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.SwitchMultipleAmount = Convert.ToDouble(dr["PASPD_SwitchMultipleAmount"].ToString());
                        if (dr["PASPD_MinSwitchUnits"].ToString() != null && dr["PASPD_MinSwitchUnits"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.MinSwitchUnits = int.Parse(dr["PASPD_MinSwitchUnits"].ToString());
                        if (dr["PASPD_SwitchMultiplesUnits"].ToString() != null && dr["PASPD_SwitchMultiplesUnits"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.SwitchMultiplesUnits = int.Parse(dr["PASPD_SwitchMultiplesUnits"].ToString());
                        if (dr["XF_FileGenerationFrequency"].ToString() != null && dr["XF_FileGenerationFrequency"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.GenerationFrequency = dr["XF_FileGenerationFrequency"].ToString();
                        if (!string.IsNullOrEmpty(mfProductAMCSchemePlanDetailsVo.SourceCode))
                        {
                            mfProductAMCSchemePlanDetailsVo.SourceCode = dr["XES_SourceCode"].ToString();
                        }
                        //db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@XES_SourceCode", DbType.String, DBNull.Value);
                        mfProductAMCSchemePlanDetailsVo.CustomerSubTypeCode = dr["XCST_CustomerSubTypeCode"].ToString();
                        if (dr["PASPD_SecurityCode"].ToString() != null && dr["PASPD_SecurityCode"].ToString() != string.Empty)
                            mfProductAMCSchemePlanDetailsVo.SecurityCode = dr["PASPD_SecurityCode"].ToString();
                        if (dr["PASPD_MaxInvestment"].ToString() != null && dr["PASPD_MaxInvestment"].ToString() != string.Empty)
                        {
                            mfProductAMCSchemePlanDetailsVo.PASPD_MaxInvestment = Convert.ToDouble(dr["PASPD_MaxInvestment"].ToString());
                        }
                        else
                        {
                            mfProductAMCSchemePlanDetailsVo.PASPD_MaxInvestment = 0;
                        }
                        if (!string.IsNullOrEmpty(dr["WERPBM_BankCode"].ToString()))
                        {
                            mfProductAMCSchemePlanDetailsVo.WERPBM_BankCode = dr["WERPBM_BankCode"].ToString();
                        }
                        if (!string.IsNullOrEmpty(dr["PASC_AMC_ExternalCode"].ToString()))
                        {
                            mfProductAMCSchemePlanDetailsVo.ExternalCode = dr["PASC_AMC_ExternalCode"].ToString();
                        }
                        if (!string.IsNullOrEmpty(dr["PASC_AMC_ExternalType"].ToString()))
                        {
                            mfProductAMCSchemePlanDetailsVo.ExternalType = dr["PASC_AMC_ExternalType"].ToString();
                        }

                    }
                }

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerBankAccountDao.cs:GetOnlineSchemeSetUp()");


                object[] objects = new object[1];
                objects[0] = SchemePlanCode;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return mfProductAMCSchemePlanDetailsVo;



        }

        public DataSet GetSchemeSetUpFromOverAllCategoryList(int amcCode, string categoryCode)
        {
            DataSet dsSchemeSetUpFromOverAllCategoryList = new DataSet();
            Database db;
            DbCommand CmdSchemeSetUpFromOverAllCategoryList;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                CmdSchemeSetUpFromOverAllCategoryList = db.GetStoredProcCommand("SP_GetSchemeSetUpFromOverAllCategoryList");
                db.AddInParameter(CmdSchemeSetUpFromOverAllCategoryList, "@AmcCode", DbType.Int32, amcCode);
                db.AddInParameter(CmdSchemeSetUpFromOverAllCategoryList, "@CategoryCode", DbType.String, categoryCode);
                dsSchemeSetUpFromOverAllCategoryList = db.ExecuteDataSet(CmdSchemeSetUpFromOverAllCategoryList);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return dsSchemeSetUpFromOverAllCategoryList;
        }
        public bool AMFIduplicateCheck(int schemeplancode, string externalcode)
        {
            Database db;
            DataSet ds;
            DbCommand cmdCodeduplicateCheck;
            bool bResult = false;
            int count = 0;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                //Adding Data to the table 
                cmdCodeduplicateCheck = db.GetStoredProcCommand("SPROC_AMFICodeDuplicate");
                db.AddInParameter(cmdCodeduplicateCheck, "@PASP_SchemePlanName", DbType.Int32, schemeplancode);
                db.AddInParameter(cmdCodeduplicateCheck, "@ExternalCode", DbType.String, externalcode);
                db.AddOutParameter(cmdCodeduplicateCheck, "@count", DbType.Int32, 10);

                ds = db.ExecuteDataSet(cmdCodeduplicateCheck);
                Object objCount = db.GetParameterValue(cmdCodeduplicateCheck, "@count");
                if (objCount != DBNull.Value)
                    count = int.Parse(db.GetParameterValue(cmdCodeduplicateCheck, "@count").ToString());
                else
                    count = 0;
                if (count > 0)
                    bResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "AssociateDAO.cs:AMFIduplicateCheck()");
                object[] objects = new object[2];
                objects[0] = schemeplancode;
                objects[1] = externalcode;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }


        public string GetstrAMCCodeRTName(string AmcCode)
        {
            string strAMCCodeRTName;
            Database db;
            DataSet dsGetMFOrderDetails;
            DbCommand cmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_GetstrAMCCodeRTName");
                db.AddInParameter(cmd, "@AmcCode", DbType.String, AmcCode);


                dsGetMFOrderDetails = db.ExecuteDataSet(cmd);
                strAMCCodeRTName = dsGetMFOrderDetails.Tables[0].Rows[0][0].ToString();
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetMFOrderDetailsForRTAExtract(DateTime ExecutionDate, int AdviserId, string TransactionType, string RtaIdentifier)");
                object[] objects = new object[4];
                objects[0] = AmcCode;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return strAMCCodeRTName;

        }

        public DataSet GetMFOrderDetailsForRTAExtract(int adviserId, string transactionType, string rtaIdentifier, int amcCode, int userId)
        {
            DataSet dsGetMFOrderDetails;
            Database db;
            DbCommand cmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_ONL_DailyAdviserRTAOrderExtract");
                //db.AddInParameter(cmd, "@WTBD_ExecutionDate", DbType.DateTime, ExecutionDate);
                db.AddInParameter(cmd, "@A_AdviserId", DbType.Int32, adviserId);
                db.AddInParameter(cmd, "@XES_SourceCode", DbType.String, rtaIdentifier);
                if (string.IsNullOrEmpty(transactionType) == false && transactionType.ToUpper() != "ALL") { db.AddInParameter(cmd, "@WMTT_TransactionClassificationCode", DbType.String, transactionType); }
                if (amcCode > 0) { db.AddInParameter(cmd, "@PA_AMCCode", DbType.Int32, amcCode); }
                db.AddInParameter(cmd, "@U_UserId", DbType.Int32, userId);

                dsGetMFOrderDetails = db.ExecuteDataSet(cmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetMFOrderDetailsForRTAExtract(DateTime ExecutionDate, int AdviserId, string TransactionType, string RtaIdentifier)");
                object[] objects = new object[4];
                objects[0] = adviserId;
                objects[1] = transactionType;
                objects[2] = rtaIdentifier;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsGetMFOrderDetails;
        }

        public DataTable GetTableScheme(string tableName)
        {
            DataTable dtTableScheme = new DataTable();
            string conString;
            conString = ConfigurationManager.ConnectionStrings["wealtherp"].ConnectionString;
            SqlConnection sqlCon = new SqlConnection(conString);
            string sql = @"select * from " + tableName.ToString() + " WHERE 1 = 2";

            try
            {
                sqlCon.Open();
                SqlCommand cmd = new SqlCommand(sql, sqlCon);
                SqlDataReader reader = cmd.ExecuteReader();
                dtTableScheme = reader.GetSchemaTable();

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetTableScheme");
                object[] objects = new object[1];
                objects[0] = tableName;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            finally
            {
                sqlCon.Close();
            }

            return dtTableScheme;

        }

        public void CreateRTAEctractedOrderList(DataTable dtExtractedOrderList)
        {
            string conString;
            conString = ConfigurationManager.ConnectionStrings["wealtherp"].ConnectionString;
            SqlConnection sqlCon = new SqlConnection(conString);

            try
            {
                SqlCommand cmd = new SqlCommand("SPROC_ONL_CreateRTAExtractOrderList", sqlCon);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter sqlParameterMFNetPositionTable = new SqlParameter();
                sqlParameterMFNetPositionTable.ParameterName = "@AdviserRTAExtractedList";
                sqlParameterMFNetPositionTable.SqlDbType = SqlDbType.Structured;
                sqlParameterMFNetPositionTable.Value = dtExtractedOrderList;
                sqlParameterMFNetPositionTable.TypeName = "AdviserMFOrderExtract";
                cmd.Parameters.Add(sqlParameterMFNetPositionTable);

                sqlCon.Open();
                cmd.ExecuteNonQuery();
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();


            }
            finally
            {
                sqlCon.Close();
            }
        }

        public DataSet GetFrequency()
        {
            Database db;
            DataSet dsFrequency;
            DbCommand Frequencycmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                Frequencycmd = db.GetStoredProcCommand("SProc_onl_BindFrequency");
                dsFrequency = db.ExecuteDataSet(Frequencycmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetFrequency()");
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsFrequency;
        }
        public DataSet GetLookupCategory()
        {
            DataSet dsGetLookupCategory;
            Database db;
            DbCommand cmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_GetLookupCategory");
                dsGetLookupCategory = db.ExecuteDataSet(cmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetLookupCategory()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsGetLookupCategory;
        }

        public DataSet GetWERPValues(int categoryID)
        {
            DataSet dsGetWERPValues;
            Database db;
            DbCommand cmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_GetWERPValues");
                db.AddInParameter(cmd, "@categoryID", DbType.Int32, categoryID);
                dsGetWERPValues = db.ExecuteDataSet(cmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetWERPValues()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsGetWERPValues;
        }
        public DataSet GetRtaWiseMapings(string sourceCode, int categoryID)
        {
            DataSet dsGetRtaWiseMapings;
            Database db;
            DbCommand cmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_GetRtaWiseMapings");
                db.AddInParameter(cmd, "@SourceCode", DbType.String, sourceCode);
                db.AddInParameter(cmd, "@CategoryID", DbType.String, categoryID);

                dsGetRtaWiseMapings = db.ExecuteDataSet(cmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetRtaWiseMapings()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsGetRtaWiseMapings;
        }


        public DataSet GetRTA()
        {
            DataSet dsGetRTA;
            Database db;
            DbCommand cmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_GetRTA");
                dsGetRTA = db.ExecuteDataSet(cmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetRTA()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsGetRTA;
        }
        public bool CreateMapwithRTA(WERPlookupCodeValueManagementVo werplookupCodeValueManagementVo, int userID)
        {
            bool bResult = false;
            Database db;
            DbCommand createCmd;
            int affectedRecords = 0;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createCmd = db.GetStoredProcCommand("SPROC_CreateMapwithRTA");
                db.AddInParameter(createCmd, "@WCMV_LookupId", DbType.Int32, werplookupCodeValueManagementVo.LookupID);
                db.AddInParameter(createCmd, "@XES_SourceCode", DbType.String, werplookupCodeValueManagementVo.SourceCode);
                db.AddInParameter(createCmd, "@WCMVXM_ExternalCode", DbType.String, werplookupCodeValueManagementVo.ExternalCode);
                db.AddInParameter(createCmd, "@WCMVXM_ExternalName", DbType.String, werplookupCodeValueManagementVo.ExternalName);
                db.AddInParameter(createCmd, "@UserId", DbType.Int32, userID);

                db.AddOutParameter(createCmd, "@IsExist", DbType.Int16, 0);
                if (db.ExecuteNonQuery(createCmd) != 0)
                    affectedRecords = int.Parse(db.GetParameterValue(createCmd, "@IsExist").ToString());
                if (affectedRecords == 0)
                    bResult = true;
                else
                    bResult = false;
                //db.ExecuteNonQuery(createCmd);
                //bResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return bResult;
        }
        public bool CreateNewWerpName(WERPlookupCodeValueManagementVo werplookupCodeValueManagementVo, int userID)
        {
            bool bResult = false;
            int affectedRecords = 0;
            Database db;
            DbCommand createCmd;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createCmd = db.GetStoredProcCommand("SPROC_CreateNewWerpName");
                db.AddInParameter(createCmd, "@WCMV_Name", DbType.String, werplookupCodeValueManagementVo.WerpName);
                db.AddInParameter(createCmd, "@WCM_Id", DbType.Int32, werplookupCodeValueManagementVo.CategoryID);
                db.AddInParameter(createCmd, "@UserId", DbType.Int32, userID);
                db.AddOutParameter(createCmd, "@IsSuccess", DbType.Int16, 0);
                if (db.ExecuteNonQuery(createCmd) != 0)
                    affectedRecords = int.Parse(db.GetParameterValue(createCmd, "@IsSuccess").ToString());
                if (affectedRecords == 1)
                    bResult = true;
                else
                    bResult = false;

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return bResult;
        }
        public bool RemoveMapingWIthRTA(WERPlookupCodeValueManagementVo werplookupCodeValueManagementVo)
        {
            bool bResult = false;
            Database db;
            DbCommand createMFOrderTrackingCmd;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createMFOrderTrackingCmd = db.GetStoredProcCommand("SPROC_RemoveMapwithRTA");
                db.AddInParameter(createMFOrderTrackingCmd, "@MapID", DbType.Int32, werplookupCodeValueManagementVo.MapID);

                db.ExecuteNonQuery(createMFOrderTrackingCmd);
                bResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return bResult;
        }

        public bool UpdateWerpName(WERPlookupCodeValueManagementVo werplookupCodeValueManagementVo, int userID)
        {
            bool bResult = false;
            Database db;
            DbCommand createMFOrderTrackingCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createMFOrderTrackingCmd = db.GetStoredProcCommand("SPROC_UpdateInternalValues");
                db.AddInParameter(createMFOrderTrackingCmd, "@lookupID", DbType.Int32, werplookupCodeValueManagementVo.LookupID);
                db.AddInParameter(createMFOrderTrackingCmd, "@internalName", DbType.String, werplookupCodeValueManagementVo.WerpName);
                db.AddInParameter(createMFOrderTrackingCmd, "@userID", DbType.Int32, userID);

                db.ExecuteNonQuery(createMFOrderTrackingCmd);
                bResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return bResult;
        }

        public bool DeleteWerpName(WERPlookupCodeValueManagementVo werplookupCodeValueManagementVo)
        {
            bool bResult = false;
            int affectedRecords=0;
            Database db;
            DbCommand createCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createCmd = db.GetStoredProcCommand("SPROC_DeleteInternalValues");
                db.AddInParameter(createCmd, "@lookupID", DbType.Int32, werplookupCodeValueManagementVo.LookupID);

                db.AddOutParameter(createCmd, "@IsDeleted", DbType.Int32, 0);
                if (db.ExecuteNonQuery(createCmd) != 0)
                    affectedRecords = int.Parse(db.GetParameterValue(createCmd, "@IsDeleted").ToString());
                if (affectedRecords == 1)
                    bResult = true;
                else
                    bResult = false;                
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return bResult;
        }


        public bool UpdateSchemeSetUpDetail(MFProductAMCSchemePlanDetailsVo mfProductAMCSchemePlanDetailsVo, int SchemePlanCode)
        {
            bool blResult = false;
            Database db;
            DbCommand updateSchemeSetUpDetailsCmd;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                updateSchemeSetUpDetailsCmd = db.GetStoredProcCommand("SPROC_Onl_UpdateSchemeSetUpDetail");
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASP_SchemePlanCode", DbType.Int32, mfProductAMCSchemePlanDetailsVo.SchemePlanCode); //1
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_FaceValue", DbType.Double, mfProductAMCSchemePlanDetailsVo.FaceValue); //2
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PSLV_LookupValueCodeForSchemeType", DbType.String, mfProductAMCSchemePlanDetailsVo.SchemeType); //3
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PSLV_LookupValueCodeForSchemeOption", DbType.String, mfProductAMCSchemePlanDetailsVo.SchemeOption);//4
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@XF_DividendFrequency", DbType.String, mfProductAMCSchemePlanDetailsVo.DividendFrequency);//5
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_BankName", DbType.String, mfProductAMCSchemePlanDetailsVo.BankName);//6
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_AccountNumber", DbType.String, mfProductAMCSchemePlanDetailsVo.AccountNumber); //7
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_Branch", DbType.String, mfProductAMCSchemePlanDetailsVo.Branch);//8
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_IsNFO", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsNFO);//9

                if (mfProductAMCSchemePlanDetailsVo.NFOStartDate != DateTime.MinValue) //10
                {
                    db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_NFOStartDate", DbType.DateTime, mfProductAMCSchemePlanDetailsVo.NFOStartDate);
                }
                else
                {
                    db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_NFOStartDate", DbType.DateTime, DBNull.Value);
                }
                if (mfProductAMCSchemePlanDetailsVo.NFOEndDate != DateTime.MinValue)//11
                {
                    db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_NFOEndDate", DbType.DateTime, mfProductAMCSchemePlanDetailsVo.NFOEndDate);
                }
                else
                {
                    db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_NFOEndDate", DbType.DateTime, DBNull.Value);
                }
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_LockInPeriod", DbType.Int32, mfProductAMCSchemePlanDetailsVo.LockInPeriod); //12
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_CutOffTime", DbType.String, mfProductAMCSchemePlanDetailsVo.CutOffTime.ToString()); //13
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_EntryLoadPercentage", DbType.Double, mfProductAMCSchemePlanDetailsVo.EntryLoadPercentag);//14
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_EntryLoadRemark", DbType.String, mfProductAMCSchemePlanDetailsVo.EntryLoadRemark);//15
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_ExitLoadPercentage", DbType.Double, mfProductAMCSchemePlanDetailsVo.ExitLoadPercentage);//16
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_ExitLoadRemark", DbType.String, mfProductAMCSchemePlanDetailsVo.ExitLoadRemark);//17
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_IsPurchaseAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsPurchaseAvailable);//18
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_IsRedeemAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsRedeemAvailable);//19
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_IsSIPAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsSIPAvailable);//20
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_IsSWPAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsSWPAvailable);//21
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_IsSwitchAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsSwitchAvailable);//22
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_IsSTPAvailable", DbType.Int32, mfProductAMCSchemePlanDetailsVo.IsSTPAvailable);//23
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_InitialPurchaseAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.InitialPurchaseAmount);//24
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_InitialMultipleAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.InitialMultipleAmount);//25
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_AdditionalPruchaseAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.AdditionalPruchaseAmount);//26
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_AdditionalMultipleAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.AdditionalMultipleAmount);//27
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_MinRedemptionAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.MinRedemptionAmount);//28
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_RedemptionMultipleAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.RedemptionMultipleAmount);//29
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_MinRedemptionUnits", DbType.Int32, mfProductAMCSchemePlanDetailsVo.MinRedemptionUnits);//30
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_RedemptionMultiplesUnits", DbType.Int32, mfProductAMCSchemePlanDetailsVo.RedemptionMultiplesUnits);//31
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_MinSwitchAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.MinSwitchAmount);//32
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_SwitchMultipleAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.SwitchMultipleAmount);//33
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_MinSwitchUnits", DbType.Int32, mfProductAMCSchemePlanDetailsVo.MinSwitchUnits);//34
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_SwitchMultiplesUnits", DbType.Int32, mfProductAMCSchemePlanDetailsVo.SwitchMultiplesUnits);//35
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@XF_FileGenerationFrequency", DbType.String, mfProductAMCSchemePlanDetailsVo.GenerationFrequency);//36
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@XES_SourceCode", DbType.String, DBNull.Value);//37
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@XCST_CustomerSubTypeCode", DbType.String, mfProductAMCSchemePlanDetailsVo.CustomerSubTypeCode);//38
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_SecurityCode", DbType.String, mfProductAMCSchemePlanDetailsVo.SecurityCode);//39
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_MaxInvestment", DbType.Double, mfProductAMCSchemePlanDetailsVo.PASPD_MaxInvestment);//40
                db.AddInParameter(updateSchemeSetUpDetailsCmd, "@WERPBM_BankCode", DbType.String, mfProductAMCSchemePlanDetailsVo.WERPBM_BankCode);//41
                // db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PA_AMCCode", DbType.Int32, mfProductAMCSchemePlanDetailsVo.AMCCode);
                //db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@PASP_SchemePlanName", DbType.String, mfProductAMCSchemePlanDetailsVo.SchemePlanName);
                //db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASP_SchemePlanName", DbType.String, mfProductAMCSchemePlanDetailsVo.SchemePlanName);
                // db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PAISSC_AssetInstrumentSubSubCategoryCode", DbType.String,mfProductAMCSchemePlanDetailsVo.AssetSubSubCategory);
                //db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PAISC_AssetInstrumentSubCategoryCode", DbType.String, mfProductAMCSchemePlanDetailsVo.AssetSubCategoryCode);
                // db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PAIC_AssetInstrumentCategoryCode", DbType.String, mfProductAMCSchemePlanDetailsVo.AssetCategoryCode);
                // db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PAG_AssetGroupCode",DbType.String, mfProductAMCSchemePlanDetailsVo.Product);
                // db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASP_Status", DbType.String,mfProductAMCSchemePlanDetailsVo.Status);
                // db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASP_IsOnline", DbType.Int32,mfProductAMCSchemePlanDetailsVo.IsOnline);
                // db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASP_IsDirect", DbType.Int32,mfProductAMCSchemePlanDetailsVo.IsDirect);
                //db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@XES_SourceCode", DbType.String, mfProductAMCSchemePlanDetailsVo.SourceCode);
                //db.AddInParameter(updateSchemeSetUpDetailsCmd, "@ExternalCode", DbType.String,mfProductAMCSchemePlanDetailsVo.ExternalCode);
                //db.AddInParameter(updateSchemeSetUpDetailsCmd, "@ExternalType", DbType.String,mfProductAMCSchemePlanDetailsVo.ExternalType);
                // db.AddInParameter(updateSchemeSetUpDetailsCmd, "@PASPD_ModifiedBy", DbType.Int32, UserId);
                // db.AddOutParameter(createMFOnlineSchemeSetUpCmd, "@PASP_SchemePlanCode",DbType.Int32, 10000);
                //db.AddInParameter(createMFOnlineSchemeSetUpCmd, "@XF_DividendFrequency",DbType.String, mfProductAMCSchemePlanDetailsVo.DividendFrequency);
                db.ExecuteNonQuery(updateSchemeSetUpDetailsCmd);

                if (db.ExecuteNonQuery(updateSchemeSetUpDetailsCmd) != 0)
                    blResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:UpdateSchemeSetUpDetail()");
                object[] objects = new object[3];
                objects[0] = mfProductAMCSchemePlanDetailsVo;
                objects[1] = SchemePlanCode;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return blResult;
        }
           public DataTable OnlinebindRandT(int SchemPlaneCode)
        {
            DataSet dsOnlinebindRandT;
            DataTable dt;
            Database db;
            DbCommand OnlinebindRandTCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                OnlinebindRandTCmd = db.GetStoredProcCommand("SPROC_Onl_BindRandT");
                db.AddInParameter(OnlinebindRandTCmd, "@PASP_SchemPlaneCode", DbType.Int32, SchemPlaneCode);
                dsOnlinebindRandT=db.ExecuteDataSet(OnlinebindRandTCmd);
                dt = dsOnlinebindRandT.Tables[0];
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:OnlinebindRandT()");
                object[] objects = new object[1];
                objects[0]=SchemPlaneCode;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dt;
        }
        public DataSet GetSystematicDetails(int schemeplancode)
        {
            Database db;
            DataSet dsSystematicDetails;
            DbCommand SystematicDetailscmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                SystematicDetailscmd = db.GetStoredProcCommand("SPROC_ONL_GetsystematicDetails");
                db.AddInParameter(SystematicDetailscmd, "@PASP_SchemePlanCode", DbType.Int32, schemeplancode);
                dsSystematicDetails = db.ExecuteDataSet(SystematicDetailscmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:GetSystematicDetails()");
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsSystematicDetails;
        }

        public bool CreateSystematicDetails(MFProductAMCSchemePlanDetailsVo mfProductAMCSchemePlanDetailsVo, int schemeplancode)
        {
            bool bResult = false;
            Database db;
            DbCommand CreateSystematicDetailsCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                CreateSystematicDetailsCmd = db.GetStoredProcCommand("SPROC_ONL_CreatesystematicDetails");
                db.AddInParameter(CreateSystematicDetailsCmd, "@PASP_SchemePlanCode", DbType.Int32,schemeplancode);
                db.AddInParameter(CreateSystematicDetailsCmd, "@XSTT_SystematicTypeCode", DbType.String, mfProductAMCSchemePlanDetailsVo.SystematicCode);
                db.AddInParameter(CreateSystematicDetailsCmd, "@XF_SystematicFrequencyCode", DbType.String, mfProductAMCSchemePlanDetailsVo.Frequency);
                db.AddInParameter(CreateSystematicDetailsCmd, "@PASPSD_StatingDates", DbType.String, mfProductAMCSchemePlanDetailsVo.StartDate);
                db.AddInParameter(CreateSystematicDetailsCmd, "@PASPSD_MinDues", DbType.Int32, mfProductAMCSchemePlanDetailsVo.MinDues);
                db.AddInParameter(CreateSystematicDetailsCmd, "@PASPSD_MaxDues", DbType.Int32, mfProductAMCSchemePlanDetailsVo.MaxDues);
                db.AddInParameter(CreateSystematicDetailsCmd, "@PASPSD_MinAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.MinAmount);
                db.AddInParameter(CreateSystematicDetailsCmd, "@PASPSD_MultipleAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.MultipleAmount);
                if (db.ExecuteNonQuery(CreateSystematicDetailsCmd) != 0)
                    bResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:CreateSystematicDetails()");

                object[] objects = new object[2];
                objects[0] = mfProductAMCSchemePlanDetailsVo;
                objects[1] = schemeplancode;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }
        public bool EditSystematicDetails(MFProductAMCSchemePlanDetailsVo mfProductAMCSchemePlanDetailsVo, int schemeplancode, int systematicdetailsid)
        {
            bool blResult = false;
            Database db;
            DbCommand EditSystematicDetailscmd;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                EditSystematicDetailscmd = db.GetStoredProcCommand("SPROC_Onl_EditSystematicDetails");
                db.AddInParameter(EditSystematicDetailscmd, "@PASP_SchemePlanCode", DbType.Int32, schemeplancode);
                db.AddInParameter(EditSystematicDetailscmd,"@PASPSD_SystematicDetailsId",DbType.Int32,systematicdetailsid);
                db.AddInParameter(EditSystematicDetailscmd, "@XF_SystematicFrequencyCode", DbType.String, mfProductAMCSchemePlanDetailsVo.Frequency);
                db.AddInParameter(EditSystematicDetailscmd, "@PASPSD_StatingDates", DbType.String, mfProductAMCSchemePlanDetailsVo.StartDate);
                db.AddInParameter(EditSystematicDetailscmd, "@PASPSD_MinDues", DbType.Int32, mfProductAMCSchemePlanDetailsVo.MinDues);
                db.AddInParameter(EditSystematicDetailscmd, "@PASPSD_MaxDues", DbType.Int32, mfProductAMCSchemePlanDetailsVo.MaxDues);
                db.AddInParameter(EditSystematicDetailscmd, "@PASPSD_MinAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.MinAmount);
                db.AddInParameter(EditSystematicDetailscmd, "@PASPSD_MultipleAmount", DbType.Double, mfProductAMCSchemePlanDetailsVo.MultipleAmount);
                db.ExecuteNonQuery(EditSystematicDetailscmd);
                if (db.ExecuteNonQuery(EditSystematicDetailscmd) != 0)
                    blResult = true;
                  
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:EditSystematicDetails()");
                object[] objects = new object[2];
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return blResult;
        }


        public DataSet GetTradeBusinessDates()
        {
            DataSet dsGetTradeBusinessDate;
            Database db;
            DbCommand cmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_GetTradeBusinessDates");

                dsGetTradeBusinessDate = db.ExecuteDataSet(cmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeBO.cs:GetTradeBusinessDates()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }

            return dsGetTradeBusinessDate;

        }
        public bool CreateTradeBusinessDate(TradeBusinessDateVo tradeBusinessDateVo)
        {
            int affectedRecords = 0;
            bool bResult = false;
            Database db;
            DbCommand createtradeBusinessDateCmd;            

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createtradeBusinessDateCmd = db.GetStoredProcCommand("SPROC_CreateTradeBusinessDate");
                db.AddInParameter(createtradeBusinessDateCmd, "@WTBD_TradeId", DbType.Int32, tradeBusinessDateVo.TradeBusinessId);
                db.AddInParameter(createtradeBusinessDateCmd, "@WTBD_Date", DbType.DateTime, tradeBusinessDateVo.TradeBusinessDate);
                db.AddInParameter(createtradeBusinessDateCmd, "@WTBD_ExecutionDate", DbType.DateTime, tradeBusinessDateVo.TradeBusinessExecutionDate);
                db.AddInParameter(createtradeBusinessDateCmd, "@WTBD_isholiday", DbType.Int32, tradeBusinessDateVo.IsTradeBusinessDateHoliday);
                db.AddInParameter(createtradeBusinessDateCmd, "@WTBD_isweekend", DbType.Int32, tradeBusinessDateVo.IsTradeBusinessDateWeekend);
                db.AddOutParameter(createtradeBusinessDateCmd, "@IsSuccess", DbType.Int16, 0);

                if (db.ExecuteNonQuery(createtradeBusinessDateCmd) != 0)
                    affectedRecords = int.Parse(db.GetParameterValue(createtradeBusinessDateCmd, "@IsSuccess").ToString());
                if (affectedRecords == 1)
                    bResult = true;
                else
                    bResult = false;
            }

            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineOrderBackOfficeDao.cs:CreateTradeBusinessDate()");
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return bResult;
        }

        public DataSet GetAdviserClientKYCStatusList(int adviserId)
        {

            Database db;
            DataSet dsAdviserClientKYCStatusList;
            DbCommand AdviserClientKYCStatusListcmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                AdviserClientKYCStatusListcmd = db.GetStoredProcCommand("SPROC_GetAdviserAllClientKYCStatus");
                db.AddInParameter(AdviserClientKYCStatusListcmd, "@AdviserId", DbType.Int32, adviserId);
                dsAdviserClientKYCStatusList = db.ExecuteDataSet(AdviserClientKYCStatusListcmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "GetAdviserClientKYCStatusList(int adviserId)");
                object[] objects = new object[1];
                objects[0] = adviserId;
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsAdviserClientKYCStatusList;


        }
    }
}
