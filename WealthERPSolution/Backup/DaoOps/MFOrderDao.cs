﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;
using VoOps;
using VoCustomerPortfolio;


namespace DaoOps
{
    public class MFOrderDao : OrderDao
    {
        FIOrderDao mfOrderDao = new FIOrderDao();
        public int GetOrderNumber(int orderId)
        {
            DataSet dsOrderNumber;
            DataTable dtOrderNumber;
            int orderNumber = 0;
            Database db;
            DbCommand getOrdernocmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getOrdernocmd = db.GetStoredProcCommand("SP_GetOrderNumber");
                db.AddInParameter(getOrdernocmd, "@CO_OrderId", DbType.Int32, orderId);
                dsOrderNumber = db.ExecuteDataSet(getOrdernocmd);
                dtOrderNumber = dsOrderNumber.Tables[0];
                if (dtOrderNumber.Rows.Count > 0)
                    orderNumber = int.Parse(dtOrderNumber.Rows[0]["CMFOD_OrderNumber"].ToString());
                //else
                //    orderNumber = 999;
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OperationDao.cs:GetOrderNumber()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return orderNumber;
        }


        public DataTable AplicationNODuplicates(string prefixText)
        {
            DataTable DupAppNos = new DataTable();
            Database db;
            DbCommand DupAppNosCmd;
            DataSet dsApplicationNo;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                DupAppNosCmd = db.GetStoredProcCommand("Sp_CheckAplicationNo");
                db.AddInParameter(DupAppNosCmd, "@CO_ApplicationNumber", DbType.String, prefixText);
                dsApplicationNo = db.ExecuteDataSet(DupAppNosCmd);
                DupAppNos = dsApplicationNo.Tables[0];

            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "MFOrderDao.cs:AplicationNODuplicates()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return DupAppNos;


        }

        public List<int> CreateOffLineMFSwitchOrderDetails(DataTable dtSwitchOrder, int userId, int customerId, DateTime appliRecDate, DateTime orderDate, string applicationNo, int agentid, string subbrokerCode, int systematicId)
        {
            List<int> orderIds = new List<int>();
            int sICO_OrderId, sOCO_OrderId;
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            dt = dtSwitchOrder.Copy();
            ds.Tables.Add(dt);
            String sb;
            sb = ds.GetXml().ToString();
            Database db;
            DbCommand CreateOnlineMFSwitchOrderDetailsCmd;
            try
            {


                db = DatabaseFactory.CreateDatabase("wealtherp");
                CreateOnlineMFSwitchOrderDetailsCmd = db.GetStoredProcCommand("SPROC_OffLine_CreateCustomerOnlineMFOrderSwitchDetails");
                db.AddInParameter(CreateOnlineMFSwitchOrderDetailsCmd, "@xmlOrderDetails", DbType.Xml, sb);
                db.AddInParameter(CreateOnlineMFSwitchOrderDetailsCmd, "@userId", DbType.Int32, userId);
                db.AddInParameter(CreateOnlineMFSwitchOrderDetailsCmd, "@customerId", DbType.Int32, customerId);
                db.AddOutParameter(CreateOnlineMFSwitchOrderDetailsCmd, "@SICO_OrderId", DbType.Int32, 10);
                db.AddOutParameter(CreateOnlineMFSwitchOrderDetailsCmd, "@SOCO_OrderId", DbType.Int32, 10);
                db.AddInParameter(CreateOnlineMFSwitchOrderDetailsCmd, "@appliRecDate", DbType.DateTime, appliRecDate);
                db.AddInParameter(CreateOnlineMFSwitchOrderDetailsCmd, "@orderDate", DbType.DateTime, orderDate);
                db.AddInParameter(CreateOnlineMFSwitchOrderDetailsCmd, "@applicationNo", DbType.String, applicationNo);
                db.AddInParameter(CreateOnlineMFSwitchOrderDetailsCmd, "@agentid", DbType.Int32, agentid);
                db.AddInParameter(CreateOnlineMFSwitchOrderDetailsCmd, "@subbrokerCode", DbType.String, subbrokerCode);
                db.AddInParameter(CreateOnlineMFSwitchOrderDetailsCmd, "@systematicId", DbType.Int32, systematicId);


                if (db.ExecuteNonQuery(CreateOnlineMFSwitchOrderDetailsCmd) != 0)
                {
                    sICO_OrderId = Convert.ToInt32(db.GetParameterValue(CreateOnlineMFSwitchOrderDetailsCmd, "SICO_OrderId").ToString());
                    sOCO_OrderId = Convert.ToInt32(db.GetParameterValue(CreateOnlineMFSwitchOrderDetailsCmd, "SOCO_OrderId").ToString());
                    orderIds.Add(sICO_OrderId);
                    orderIds.Add(sOCO_OrderId);
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
                FunctionInfo.Add("Method", "OperationDao.cs:GetFolioAccount()");
                object[] objects = new object[10];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return orderIds;

        }


        public DataSet GetSipDetails(int schemeId, string frequency)
        {
            DataSet dsSipDetails;
            Database db;
            DbCommand cmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_Onl_SipDetails");
                db.AddInParameter(cmd, "@PASP_SchemePlanCode", DbType.Int32, schemeId);
                if (frequency != null) db.AddInParameter(cmd, "@XF_SystematicFrequencyCode", DbType.String, frequency);
                dsSipDetails = db.ExecuteDataSet(cmd);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OperationDao.cs:GetFolioAccount()");
                object[] objects = new object[10];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsSipDetails;
        }

        public List<int> CreateOrderMFDetails(OrderVo orderVo, MFOrderVo mforderVo, int userId, SystematicSetupVo systematicSetupVo, out int setupId)
        {
            List<int> orderIds = new List<int>();
            int OrderId;
            Database db;
            DbCommand createMFOrderTrackingCmd;
            setupId = 0;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createMFOrderTrackingCmd = db.GetStoredProcCommand("SP_CreateCustomerMFOrderDetails");
                db.AddInParameter(createMFOrderTrackingCmd, "@customerId", DbType.Int32, orderVo.CustomerId);
                db.AddInParameter(createMFOrderTrackingCmd, "@PASP_SchemePlanCode", DbType.Int32, mforderVo.SchemePlanCode);
                db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_OrderNumber", DbType.Int32, mforderVo.OrderNumber);
                db.AddInParameter(createMFOrderTrackingCmd, "@AssetGroupCode", DbType.String, orderVo.AssetGroup);
                db.AddInParameter(createMFOrderTrackingCmd, "@CustBankAccId", DbType.Int32, orderVo.CustBankAccId);
                db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_Amount ", DbType.Double, mforderVo.Amount);
                //db.AddInParameter(createMFOrderTrackingCmd, "@statusCode", DbType.String, orderVo.OrderStatusCode);
                //db.AddInParameter(createMFOrderTrackingCmd, "@StatusReasonCode", DbType.String, orderVo.ReasonCode);
                if (mforderVo.accountid != 0)
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFA_accountid", DbType.Int32, mforderVo.accountid);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFA_accountid", DbType.Int32, 0);
                db.AddInParameter(createMFOrderTrackingCmd, "@WMTT_TransactionClassificationCode", DbType.String, mforderVo.TransactionCode);
                db.AddInParameter(createMFOrderTrackingCmd, "@CO_OrderDate", DbType.DateTime, orderVo.OrderDate);
                db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_IsImmediate", DbType.Int16, mforderVo.IsImmediate);
                //db.AddInParameter(createMFOrderTrackingCmd, "@SourceCode", DbType.String, operationVo.SourceCode);
                if (!string.IsNullOrEmpty(mforderVo.FutureTriggerCondition.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_FutureTriggerCondition", DbType.String, mforderVo.FutureTriggerCondition);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_FutureTriggerCondition", DbType.String, DBNull.Value);
                db.AddInParameter(createMFOrderTrackingCmd, "@ApplicationNumber", DbType.String, orderVo.ApplicationNumber);
                //db.AddInParameter(createMFOrderTrackingCmd, "@ApplicationReceivedDate", DbType.DateTime, orderVo.ApplicationReceivedDate);
                if (orderVo.ApplicationReceivedDate != DateTime.MinValue)
                    db.AddInParameter(createMFOrderTrackingCmd, "@ApplicationReceivedDate", DbType.DateTime, orderVo.ApplicationReceivedDate);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@ApplicationReceivedDate", DbType.DateTime, DBNull.Value);

                db.AddInParameter(createMFOrderTrackingCmd, "@CP_portfolioId", DbType.Int32, mforderVo.portfolioId);
                db.AddInParameter(createMFOrderTrackingCmd, "@PaymentMode", DbType.String, orderVo.PaymentMode);
                if (!string.IsNullOrEmpty(orderVo.ChequeNumber.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@ChequeNumber", DbType.String, orderVo.ChequeNumber);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@ChequeNumber", DbType.String, DBNull.Value);
                if (orderVo.PaymentDate != DateTime.MinValue)
                    db.AddInParameter(createMFOrderTrackingCmd, "@PaymentDate", DbType.DateTime, orderVo.PaymentDate);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@PaymentDate", DbType.DateTime, DBNull.Value);
                if (mforderVo.FutureExecutionDate != DateTime.MinValue)
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_FutureExecutionDate", DbType.DateTime, mforderVo.FutureExecutionDate);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_FutureExecutionDate", DbType.DateTime, DBNull.Value);
                if (mforderVo.SchemePlanSwitch != 0)
                    db.AddInParameter(createMFOrderTrackingCmd, "@PASP_SchemePlanSwitch", DbType.Int32, mforderVo.SchemePlanSwitch);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@PASP_SchemePlanSwitch", DbType.Int32, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.BankName.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@MFOD_BankName", DbType.String, mforderVo.BankName);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@MFOD_BankName", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.BranchName.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_BranchName", DbType.String, mforderVo.BranchName);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_BranchName", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.AddrLine1.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_AddrLine1", DbType.String, mforderVo.AddrLine1);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_AddrLine1", DbType.String, DBNull.Value);
                if (mforderVo.AddrLine2 != null)
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_AddrLine2", DbType.String, mforderVo.AddrLine2);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_AddrLine2", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.AddrLine3.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_AddrLine3", DbType.String, mforderVo.AddrLine3);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_AddrLine3", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.City.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_City", DbType.String, mforderVo.City);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_City", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.State.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_State", DbType.String, mforderVo.State);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_State", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.Country.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_Country", DbType.String, mforderVo.Country);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_Country", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.Pincode.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_PinCode", DbType.String, mforderVo.Pincode);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_PinCode", DbType.String, DBNull.Value);
                if (mforderVo.LivingSince != DateTime.MinValue)
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_LivingScince", DbType.DateTime, mforderVo.LivingSince);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_LivingScince", DbType.DateTime, DBNull.Value);
                db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_IsExecuted ", DbType.Int16, mforderVo.IsExecuted);
                if (mforderVo.FrequencyCode != null && mforderVo.FrequencyCode != "")
                    db.AddInParameter(createMFOrderTrackingCmd, "@XF_FrequencyCode", DbType.String, mforderVo.FrequencyCode);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@XF_FrequencyCode", DbType.String, DBNull.Value);
                if (mforderVo.StartDate != DateTime.MinValue)
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_StartDate", DbType.DateTime, mforderVo.StartDate);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_StartDate", DbType.DateTime, DBNull.Value);
                if (mforderVo.EndDate != DateTime.MinValue)
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_EndDate", DbType.DateTime, mforderVo.EndDate);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_EndDate", DbType.DateTime, DBNull.Value);
                if (mforderVo.Units != 0)
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_Units", DbType.Double, mforderVo.Units);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_Units", DbType.Double, DBNull.Value);

                if (!string.IsNullOrEmpty(mforderVo.ARNNo.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_ARNNo", DbType.String, mforderVo.ARNNo);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFOD_ARNNo", DbType.String, DBNull.Value);
                if (mforderVo.EUIN != null)
                {
                    //if (!string.IsNullOrEmpty(mforderVo.EUIN.ToString().Trim()))
                        db.AddInParameter(createMFOrderTrackingCmd, "@CO_EUIN", DbType.String, mforderVo.EUIN);
                }
                    else
                {
                        db.AddInParameter(createMFOrderTrackingCmd, "@CO_EUIN", DbType.String, DBNull.Value);
                }
              


                db.AddOutParameter(createMFOrderTrackingCmd, "@CO_OrderId", DbType.Int32, 10);

                if (mforderVo.AgentId != 0)
                    db.AddInParameter(createMFOrderTrackingCmd, "@AgentId", DbType.Int32, mforderVo.AgentId);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@AgentId", DbType.Int32, DBNull.Value);
                if (mforderVo.EmpId != 0)
                    db.AddInParameter(createMFOrderTrackingCmd, "@EmpId", DbType.Int32, mforderVo.EmpId);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@EmpId", DbType.Int32, DBNull.Value);

                db.AddInParameter(createMFOrderTrackingCmd, "@UserId", DbType.Int32, userId);


                db.AddInParameter(createMFOrderTrackingCmd, "@CMFSS_SystematicDate", DbType.Int32, systematicSetupVo.SystematicDate);

                db.AddInParameter(createMFOrderTrackingCmd, "@CMFSS_Tenure", DbType.Int32, systematicSetupVo.Period);

                db.AddInParameter(createMFOrderTrackingCmd, "@TenureCycle", DbType.String, systematicSetupVo.PeriodSelection);

                if (systematicSetupVo.RegistrationDate != DateTime.MinValue)
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFSS_RegistrationDate", DbType.DateTime, systematicSetupVo.RegistrationDate);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CMFSS_RegistrationDate", DbType.DateTime, DBNull.Value);

                if (systematicSetupVo.CeaseDate != DateTime.MinValue)
                    db.AddInParameter(createMFOrderTrackingCmd, "@CeaseDate", DbType.DateTime, systematicSetupVo.CeaseDate);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CeaseDate", DbType.DateTime, DBNull.Value);
                if (mforderVo.BankBranchId != 0)
                    db.AddInParameter(createMFOrderTrackingCmd, "@BranchLookUpId", DbType.Int32, mforderVo.BankBranchId);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@BranchLookUpId", DbType.Int32, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.DivOption))
                    db.AddInParameter(createMFOrderTrackingCmd, "@DivOption", DbType.String, mforderVo.DivOption);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@DivOption", DbType.String, mforderVo.DivOption);
                if (!string.IsNullOrEmpty(mforderVo.Remarks.ToString().Trim()))
                    db.AddInParameter(createMFOrderTrackingCmd, "@CO_Remarks", DbType.String, mforderVo.Remarks);
                else
                    db.AddInParameter(createMFOrderTrackingCmd, "@CO_Remarks", DbType.String, DBNull.Value);
                db.AddOutParameter(createMFOrderTrackingCmd, "@SetupId", DbType.Int32, 10);
                db.AddInParameter(createMFOrderTrackingCmd, "@PASP_SchemePlanCodeSwitch", DbType.Int32, mforderVo.SchemePlanSwitch);
                db.AddInParameter(createMFOrderTrackingCmd, "@CMFA_AccountIdSwitch", DbType.Int32, mforderVo.AccountIdSwitch);
                db.AddInParameter(createMFOrderTrackingCmd, "@CMFSS_MandateId", DbType.String, systematicSetupVo.MandateId);
                if (db.ExecuteNonQuery(createMFOrderTrackingCmd) != 0)
                {
                    OrderId = Convert.ToInt32(db.GetParameterValue(createMFOrderTrackingCmd, "CO_OrderId").ToString());
                    setupId = Convert.ToInt32(db.GetParameterValue(createMFOrderTrackingCmd, "SetupId").ToString());


                    orderIds.Add(OrderId);
                }
                else
                {
                    orderIds = null;
                }

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return orderIds;
        }

        public DataSet GetCustomerMFOrderMIS(int AdviserId, DateTime dtFrom, DateTime dtTo, string branchId, string rmId, string transactionType, string status, string orderType, string amcCode, string customerId, int isOnline, string type)
        {
            DataSet dsGetCustomerMFOrderMIS = null;
            Database db;
            DbCommand GetCustomerMFOrderMIScmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                GetCustomerMFOrderMIScmd = db.GetStoredProcCommand("SP_GetCustomerMFOrderMIS");
                db.AddInParameter(GetCustomerMFOrderMIScmd, "@adviserId", DbType.Int64, AdviserId);
                db.AddInParameter(GetCustomerMFOrderMIScmd, "@fromdate", DbType.DateTime, dtFrom);
                db.AddInParameter(GetCustomerMFOrderMIScmd, "@todate", DbType.DateTime, dtTo);
                db.AddInParameter(GetCustomerMFOrderMIScmd, "@branchId", DbType.String, branchId);
                db.AddInParameter(GetCustomerMFOrderMIScmd, "@rmId", DbType.String, rmId);
                if (!string.IsNullOrEmpty(transactionType.ToString().Trim()))
                    db.AddInParameter(GetCustomerMFOrderMIScmd, "@trxType", DbType.String, transactionType);
                else
                    db.AddInParameter(GetCustomerMFOrderMIScmd, "@trxType", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(status.ToString().Trim()))
                    db.AddInParameter(GetCustomerMFOrderMIScmd, "@orderStatus", DbType.String, status);
                else
                    db.AddInParameter(GetCustomerMFOrderMIScmd, "@orderStatus", DbType.String, DBNull.Value);
                db.AddInParameter(GetCustomerMFOrderMIScmd, "@ordertype", DbType.String, orderType);
                if (!string.IsNullOrEmpty(amcCode.ToString().Trim()))
                    db.AddInParameter(GetCustomerMFOrderMIScmd, "@amcCode", DbType.String, amcCode);
                else
                    db.AddInParameter(GetCustomerMFOrderMIScmd, "@amcCode", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(customerId.ToString().Trim()))
                    db.AddInParameter(GetCustomerMFOrderMIScmd, "@customerId", DbType.String, customerId);
                else
                    db.AddInParameter(GetCustomerMFOrderMIScmd, "@customerId", DbType.String, DBNull.Value);

                db.AddInParameter(GetCustomerMFOrderMIScmd, "@isOnline", DbType.Int64, isOnline);
                db.AddInParameter(GetCustomerMFOrderMIScmd, "@type", DbType.Int64, type);
                GetCustomerMFOrderMIScmd.CommandTimeout = 60 * 60;

                dsGetCustomerMFOrderMIS = db.ExecuteDataSet(GetCustomerMFOrderMIScmd);
            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            return dsGetCustomerMFOrderMIS;
        }

        public void UpdateCustomerMFOrderDetails(OrderVo orderVo, MFOrderVo mforderVo, int userId, SystematicSetupVo systematicSetupVo)
        {
            Database db;
            DbCommand UpdateMFOrderTrackingCmd;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                UpdateMFOrderTrackingCmd = db.GetStoredProcCommand("SP_UpdateCustomerMFOrderDetails");
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@CO_OrderId", DbType.Int32, orderVo.OrderId);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@C_CustomerId", DbType.Int32, orderVo.CustomerId);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@PASP_SchemePlanCode", DbType.Int32, mforderVo.SchemePlanCode);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_OrderNumber", DbType.Int32, mforderVo.OrderNumber);
                if (orderVo.CustBankAccId != 0)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CustBankAccId", DbType.Int32, orderVo.CustBankAccId);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CustBankAccId", DbType.Int32, 0);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@AssetGroupCode", DbType.String, orderVo.AssetGroup);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_Amount ", DbType.Decimal, mforderVo.Amount);

                if (mforderVo.accountid != 0)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFA_accountid", DbType.Int32, mforderVo.accountid);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFA_accountid", DbType.Int32, 0);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@WMTT_TransactionClassificationCode", DbType.String, mforderVo.TransactionCode);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@CO_OrderDate", DbType.DateTime, orderVo.OrderDate);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_IsImmediate", DbType.Int16, mforderVo.IsImmediate);
                //db.AddInParameter(UpdateMFOrderTrackingCmd, "@SourceCode", DbType.String, operationVo.SourceCode);
                if (!string.IsNullOrEmpty(mforderVo.FutureTriggerCondition.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_FutureTriggerCondition", DbType.String, mforderVo.FutureTriggerCondition);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_FutureTriggerCondition", DbType.String, DBNull.Value);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@ApplicationNumber", DbType.String, orderVo.ApplicationNumber);
                if (orderVo.ApplicationReceivedDate != DateTime.MinValue)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@ApplicationReceivedDate", DbType.DateTime, orderVo.ApplicationReceivedDate);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@ApplicationReceivedDate", DbType.DateTime, DBNull.Value);
                //db.AddInParameter(UpdateMFOrderTrackingCmd, "@ApplicationReceivedDate", DbType.DateTime, orderVo.ApplicationReceivedDate);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@CP_portfolioId", DbType.Int32, mforderVo.portfolioId);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@PaymentMode", DbType.String, orderVo.PaymentMode);
                if (!string.IsNullOrEmpty(orderVo.ChequeNumber.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@ChequeNumber", DbType.String, orderVo.ChequeNumber);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@ChequeNumber", DbType.String, DBNull.Value);
                if (orderVo.PaymentDate != DateTime.MinValue)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@PaymentDate", DbType.DateTime, orderVo.PaymentDate);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@PaymentDate", DbType.DateTime, DBNull.Value);
                if (mforderVo.FutureExecutionDate != DateTime.MinValue)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_FutureExecutionDate", DbType.DateTime, mforderVo.FutureExecutionDate);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_FutureExecutionDate", DbType.DateTime, DBNull.Value);
                if (mforderVo.SchemePlanSwitch != 0)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@PASP_SchemePlanSwitch", DbType.Int32, mforderVo.SchemePlanSwitch);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@PASP_SchemePlanSwitch", DbType.Int32, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.BankName.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@MFOD_BankName", DbType.String, mforderVo.BankName);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@MFOD_BankName", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.BranchName.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_BranchName", DbType.String, mforderVo.BranchName);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_BranchName", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.AddrLine1.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_AddrLine1", DbType.String, mforderVo.AddrLine1);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_AddrLine1", DbType.String, DBNull.Value);
                if (mforderVo.AddrLine2 != null)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_AddrLine2", DbType.String, mforderVo.AddrLine2);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_AddrLine2", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.AddrLine3.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_AddrLine3", DbType.String, mforderVo.AddrLine3);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_AddrLine3", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.City.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_City", DbType.String, mforderVo.City);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_City", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.State.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_State", DbType.String, mforderVo.State);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_State", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.Country.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_Country", DbType.String, mforderVo.Country);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_Country", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.Pincode.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_PinCode", DbType.String, mforderVo.Pincode);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_PinCode", DbType.String, DBNull.Value);
                if (mforderVo.LivingSince != DateTime.MinValue)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_LivingScince", DbType.DateTime, mforderVo.LivingSince);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_LivingScince", DbType.DateTime, DBNull.Value);
                db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_IsExecuted ", DbType.Int16, mforderVo.IsExecuted);
                if (mforderVo.FrequencyCode != null && mforderVo.FrequencyCode != "")
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@XF_FrequencyCode", DbType.String, mforderVo.FrequencyCode);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@XF_FrequencyCode", DbType.String, DBNull.Value);
                if (mforderVo.StartDate != DateTime.MinValue)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_StartDate", DbType.DateTime, mforderVo.StartDate);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_StartDate", DbType.DateTime, DBNull.Value);
                if (mforderVo.EndDate != DateTime.MinValue)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_EndDate", DbType.DateTime, mforderVo.EndDate);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_EndDate", DbType.DateTime, DBNull.Value);
                if (mforderVo.Units != 0)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_Units", DbType.Double, mforderVo.Units);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_Units", DbType.Double, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.ARNNo.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_ARNNo", DbType.String, mforderVo.ARNNo);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFOD_ARNNo", DbType.String, DBNull.Value);
                if (!string.IsNullOrEmpty(mforderVo.EUIN.ToString().Trim()))
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CO_EUIN", DbType.String, mforderVo.EUIN);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CO_EUIN", DbType.String, DBNull.Value);
                if (orderVo.AgentId != 0)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@AgentId", DbType.Int32, orderVo.AgentId);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@AgentId", DbType.Int32, DBNull.Value);
                if (mforderVo.EmpId != 0)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@EmpId", DbType.Int32, mforderVo.EmpId);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@EmpId", DbType.Int32, DBNull.Value);

                db.AddInParameter(UpdateMFOrderTrackingCmd, "@UserId", DbType.Int32, userId);

                db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFSS_SystematicDate", DbType.Int32, systematicSetupVo.SystematicDate);

                db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFSS_Tenure", DbType.Int32, systematicSetupVo.Period);

                db.AddInParameter(UpdateMFOrderTrackingCmd, "@TenureCycle", DbType.String, systematicSetupVo.PeriodSelection);

                if (systematicSetupVo.RegistrationDate != DateTime.MinValue)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFSS_RegistrationDate", DbType.DateTime, systematicSetupVo.RegistrationDate);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CMFSS_RegistrationDate", DbType.DateTime, DBNull.Value);

                if (systematicSetupVo.CeaseDate != DateTime.MinValue)
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CeaseDate", DbType.DateTime, systematicSetupVo.CeaseDate);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CeaseDate", DbType.DateTime, DBNull.Value);
                if (mforderVo.Remarks != null && mforderVo.Remarks != "")
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CO_Remarks", DbType.String, mforderVo.Remarks);
                else
                    db.AddInParameter(UpdateMFOrderTrackingCmd, "@CO_Remarks", DbType.String, DBNull.Value);

                db.ExecuteNonQuery(UpdateMFOrderTrackingCmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }


        }

        public DataSet GetSipControlDetails(int Scheme, string frequency)
        {
            DataSet dsGetControlDetails;
            Database db;
            DbCommand GetGetControlDetailsCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                GetGetControlDetailsCmd = db.GetStoredProcCommand("SPROC_Offline_SipDetails");
                db.AddInParameter(GetGetControlDetailsCmd, "@PASP_SchemePlanCode", DbType.Int32, Scheme);

                db.AddInParameter(GetGetControlDetailsCmd, "@XF_SystematicFrequencyCode", DbType.String, frequency);



                dsGetControlDetails = db.ExecuteDataSet(GetGetControlDetailsCmd);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OperationDao.cs:GetFolioAccount()");
                object[] objects = new object[10];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsGetControlDetails;
        }


        public DataSet GetControlDetails(int Scheme, string folio)
        {
            DataSet dsGetControlDetails;
            Database db;
            DbCommand GetGetControlDetailsCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                GetGetControlDetailsCmd = db.GetStoredProcCommand("SPROC_OffLine_GetSchemeDetails");
                db.AddInParameter(GetGetControlDetailsCmd, "@schemecode", DbType.Int32, Scheme);
                if (!string.IsNullOrEmpty(folio))
                    db.AddInParameter(GetGetControlDetailsCmd, "@accountid", DbType.Int32, int.Parse(folio));
                else
                    db.AddInParameter(GetGetControlDetailsCmd, "@accountid", DbType.Int32, 0);

                dsGetControlDetails = db.ExecuteDataSet(GetGetControlDetailsCmd);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OperationDao.cs:GetFolioAccount()");
                object[] objects = new object[10];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsGetControlDetails;
        }

        public DataSet GetCustomerMFOrderDetails(int orderId)
        {
            DataSet dsGetCustomerMFOrderDetails;
            Database db;
            DbCommand getCustomerMFOrderDetailscmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getCustomerMFOrderDetailscmd = db.GetStoredProcCommand("SP_GetCustomerMFOrderDetails");
                db.AddInParameter(getCustomerMFOrderDetailscmd, "@orderId", DbType.Int32, orderId);
                dsGetCustomerMFOrderDetails = db.ExecuteDataSet(getCustomerMFOrderDetailscmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OperationDao.cs:GetOrderNumber()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsGetCustomerMFOrderDetails;
        }

        public void GetSchemeNameByCode(int SchemePlanCode, out string SchemePlanName)
        {

            Database db;
            DbCommand getCustomerMFOrderDetailscmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getCustomerMFOrderDetailscmd = db.GetStoredProcCommand("SP_GetSchemeNameByCode");
                db.AddInParameter(getCustomerMFOrderDetailscmd, "@SchemePlanCode", DbType.Int32, SchemePlanCode);
                db.AddOutParameter(getCustomerMFOrderDetailscmd, "@SchemePlanName", DbType.String, 1000);

                db.ExecuteDataSet(getCustomerMFOrderDetailscmd);
                SchemePlanName = db.GetParameterValue(getCustomerMFOrderDetailscmd, "@SchemePlanName").ToString();

            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }

        }
        public void GetFolio(int customerId, int schemePlanCode, out string folio, out int accountId)
        {
            Database db;
            DbCommand createMFOrderTrackingCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createMFOrderTrackingCmd = db.GetStoredProcCommand("SPROC_GetFolio");
                db.AddInParameter(createMFOrderTrackingCmd, "@CustomerId", DbType.Int32, customerId);
                db.AddInParameter(createMFOrderTrackingCmd, "@AMcCode", DbType.Int32, schemePlanCode);
                db.AddOutParameter(createMFOrderTrackingCmd, "@FolioNo", DbType.String, schemePlanCode);
                db.AddOutParameter(createMFOrderTrackingCmd, "@accountId", DbType.Int32, schemePlanCode);

                db.ExecuteDataSet(createMFOrderTrackingCmd);
                folio = db.GetParameterValue(createMFOrderTrackingCmd, "@FolioNo").ToString();
                if (!string.IsNullOrEmpty(db.GetParameterValue(createMFOrderTrackingCmd, "@accountId").ToString()))
                    accountId = int.Parse(db.GetParameterValue(createMFOrderTrackingCmd, "@accountId").ToString());
                else
                    accountId = 0;


            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }


        }


        public int MarkAsReject(int OrderID, string Remarks)
        {
            int IsMarked = 0;

            Database db;
            DbCommand createMFOrderTrackingCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createMFOrderTrackingCmd = db.GetStoredProcCommand("SPROC_MarkAsReject");
                db.AddInParameter(createMFOrderTrackingCmd, "@OrderId", DbType.Int32, OrderID);
                db.AddInParameter(createMFOrderTrackingCmd, "@Remarks", DbType.String, Remarks);
                IsMarked = Convert.ToInt32(db.ExecuteScalar(createMFOrderTrackingCmd));
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }

            return IsMarked;
        }
        public int RevertToExecute(int orderId, int userId)
        {
            int IsMarked = 0;

            Database db;
            DbCommand revertToExecuteCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                revertToExecuteCmd = db.GetStoredProcCommand("SPROC_RevertTransactionToExecuted");
                db.AddInParameter(revertToExecuteCmd, "@orderId", DbType.Int32, orderId);
                db.AddInParameter(revertToExecuteCmd, "@userId", DbType.Int32, userId);
                IsMarked = Convert.ToInt32(db.ExecuteScalar(revertToExecuteCmd));
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }

            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "MFOrderDao.cs:RevertToExecute()");

                object[] objects = new object[2];
                objects[0] = orderId;
                objects[1] = userId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return IsMarked;
        }

        public string GetDividendOptions(int schemePlanCode)
        {
            string schemeOption = "";

            Database db;
            DbCommand createMFOrderTrackingCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createMFOrderTrackingCmd = db.GetStoredProcCommand("SPROC_GetDividendOptions");
                db.AddInParameter(createMFOrderTrackingCmd, "@schemePlanCode", DbType.Int32, schemePlanCode);
                object result = db.ExecuteScalar(createMFOrderTrackingCmd);
                if (result != null)
                {
                    schemeOption = result.ToString();
                }

            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }

            return schemeOption;
        }

        public DataSet GetCustomerBank(int customerId)
        {
            DataSet dsGetCustomerBank;
            Database db;
            DbCommand getCustomerBankcmd;
            try
            {
                //  Shantanu Dated :- 18thSept2012
                //Don't Change this scripts As I am using same while MF Folio Add. If you want to change ,
                //then test the folio Add Screen also..

                db = DatabaseFactory.CreateDatabase("wealtherp");
                getCustomerBankcmd = db.GetStoredProcCommand("SP_GetBankAccountDetails");
                db.AddInParameter(getCustomerBankcmd, "@C_CustomerId", DbType.Int32, customerId);
                dsGetCustomerBank = db.ExecuteDataSet(getCustomerBankcmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dsGetCustomerBank;
        }

        public DataSet GetCustomerBanks(int customerId)
        {
            DataSet dsGetCustomerBank;
            Database db;
            DbCommand getCustomerBankcmd;
            try
            {
                //  Shantanu Dated :- 18thSept2012
                //Don't Change this scripts As I am using same while MF Folio Add. If you want to change ,
                //then test the folio Add Screen also..

                db = DatabaseFactory.CreateDatabase("wealtherp");
                getCustomerBankcmd = db.GetStoredProcCommand("SP_GetBankDetails");
                db.AddInParameter(getCustomerBankcmd, "@C_CustomerId", DbType.Int32, customerId);
                dsGetCustomerBank = db.ExecuteDataSet(getCustomerBankcmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dsGetCustomerBank;
        }
        public DataSet GetSipDetails(int orderID)
        {
            DataSet dsGetCustomerBank;
            Database db;
            DbCommand getSipcmd;
            try
            {
                //  Shantanu Dated :- 18thSept2012
                //Don't Change this scripts As I am using same while MF Folio Add. If you want to change ,
                //then test the folio Add Screen also..

                db = DatabaseFactory.CreateDatabase("wealtherp");
                getSipcmd = db.GetStoredProcCommand("Sp_GetSipDetails");
                db.AddInParameter(getSipcmd, "@Orderid", DbType.Int32, orderID);
                dsGetCustomerBank = db.ExecuteDataSet(getSipcmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dsGetCustomerBank;
        }


        public DataTable GetBankBranchLookups(int lookUpId)
        {
            DataSet dsGetBankBranch;
            DataTable dtGetBankBranch;
            Database db;
            DbCommand getBankBranchcmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getBankBranchcmd = db.GetStoredProcCommand("SP_GetBankBranchLookUPs");
                db.AddInParameter(getBankBranchcmd, "@LookupId", DbType.Int32, lookUpId);
                dsGetBankBranch = db.ExecuteDataSet(getBankBranchcmd);
                dtGetBankBranch = dsGetBankBranch.Tables[0];
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dtGetBankBranch;
        }
        public DataTable GetBankBranch(int BankId)
        {
            DataSet dsGetBankBranch;
            DataTable dtGetBankBranch;
            Database db;
            DbCommand getBankBranchcmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getBankBranchcmd = db.GetStoredProcCommand("SP_GetBankBranchLookUPs");
                db.AddInParameter(getBankBranchcmd, "@LookupId", DbType.Int32, BankId);
                dsGetBankBranch = db.ExecuteDataSet(getBankBranchcmd);
                dtGetBankBranch = dsGetBankBranch.Tables[0];
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dtGetBankBranch;
        }

        public bool DeleteMFOrder(int orderId)
        {
            bool bResult = false;
            Database db;
            DbCommand DeleteMFOrderCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                DeleteMFOrderCmd = db.GetStoredProcCommand("SP_DeleteCustomerMFOrder");
                db.AddInParameter(DeleteMFOrderCmd, "@OrderId", DbType.Int32, orderId);
                db.ExecuteNonQuery(DeleteMFOrderCmd);
                bResult = true;

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return bResult;
        }

        //      public bool ChkOnlineOrder(int OrderId)
        //{
        //    Database db;
        //    DbCommand MFOrderAutoMatchCmd;
        //    int status;
        //    try
        //    {
        //        db = DatabaseFactory.CreateDatabase("wealtherp");
        //        MFOrderAutoMatchCmd = db.GetStoredProcCommand("SPROC_IsOnlineFolioNo");
        //        db.AddInParameter(MFOrderAutoMatchCmd, "@orderId", DbType.Int32, OrderId);
        //        db.AddOutParameter(MFOrderAutoMatchCmd, "@IsOnline", DbType.Int16, 0);
        //        db.ExecuteDataSet(MFOrderAutoMatchCmd);
        //        status = int.Parse(db.GetParameterValue(MFOrderAutoMatchCmd, "@IsOnline").ToString());
        //        if (status == 1)
        //            return true;
        //        else
        //            return false;

        //    }

        //    catch (BaseApplicationException Ex)
        //    {
        //        throw Ex;
        //    }
        //}


        public bool ChkOnlineOrder(int OrderId)
        {
            Database db;
            DbCommand MFOrderAutoMatchCmd;
            int status;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                MFOrderAutoMatchCmd = db.GetStoredProcCommand("SP_ChkOnlineOrder");
                db.AddInParameter(MFOrderAutoMatchCmd, "@orderId", DbType.Int32, OrderId);
                db.AddOutParameter(MFOrderAutoMatchCmd, "@IsOnline", DbType.Int16, 0);
                db.ExecuteDataSet(MFOrderAutoMatchCmd);
                status = int.Parse(db.GetParameterValue(MFOrderAutoMatchCmd, "@IsOnline").ToString());
                if (status == 1)
                    return true;
                else
                    return false;

            }

            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
        }


        public bool ChkOfflineValidFolio(string folioNo)
        {
            Database db;
            DbCommand MFOrderAutoMatchCmd;
            int status;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                MFOrderAutoMatchCmd = db.GetStoredProcCommand("SPROC_CheckOfflineValidFolio");
                db.AddInParameter(MFOrderAutoMatchCmd, "@folioNo", DbType.String, folioNo);
                db.AddOutParameter(MFOrderAutoMatchCmd, "@count", DbType.Int16, 0);
                db.ExecuteDataSet(MFOrderAutoMatchCmd);
                status = int.Parse(db.GetParameterValue(MFOrderAutoMatchCmd, "@count").ToString());
                if (status >= 1)
                    return true;
                else
                    return false;

            }

            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
        }

        public bool MFOrderAutoMatch(int OrderId, int SchemeCode, int AccountId, string TransType, int CustomerId, double Amount, DateTime OrderDate, out bool status)
        {
            Database db;
            DbCommand MFOrderAutoMatchCmd;
            int affectedRecords = 0;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                MFOrderAutoMatchCmd = db.GetStoredProcCommand("SP_OrderAutoMatchForOrderSteps");
                db.AddInParameter(MFOrderAutoMatchCmd, "@orderId", DbType.Int32, OrderId);
                db.AddInParameter(MFOrderAutoMatchCmd, "@schemeCode", DbType.Int32, SchemeCode);
                db.AddInParameter(MFOrderAutoMatchCmd, "@accountId", DbType.Int32, AccountId);
                db.AddInParameter(MFOrderAutoMatchCmd, "@trxType", DbType.String, TransType);
                db.AddInParameter(MFOrderAutoMatchCmd, "@customerId", DbType.Int32, CustomerId);
                db.AddInParameter(MFOrderAutoMatchCmd, "@amount", DbType.Double, Amount);
                if (OrderDate != DateTime.MinValue)
                    db.AddInParameter(MFOrderAutoMatchCmd, "@orderDate", DbType.DateTime, OrderDate);

                db.AddOutParameter(MFOrderAutoMatchCmd, "@IsSuccess", DbType.Int16, 0);
                //sai   //if (db.ExecuteNonQuery(MFOrderAutoMatchCmd) != 0)
                //    affectedRecords = int.Parse(db.GetParameterValue(MFOrderAutoMatchCmd, "@IsSuccess").ToString());
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            if (affectedRecords > 0)
                return status = true;
            else
                return status = false;
        }
        public DataSet GetEQCustomerBank(int customerId)
        {
            DataSet dsGetCustomerBank;
            Database db;
            DbCommand getCustomerBankcmd;
            try
            {
                //  Shantanu Dated :- 18thSept2012
                //Don't Change this scripts As I am using same while MF Folio Add. If you want to change ,
                //then test the folio Add Screen also..

                db = DatabaseFactory.CreateDatabase("wealtherp");
                getCustomerBankcmd = db.GetStoredProcCommand("SP_GetBankAccountEQDetails");
                db.AddInParameter(getCustomerBankcmd, "@C_CustomerId", DbType.Int32, customerId);
                // db.AddInParameter(getCustomerBankcmd, "@CB_CustBankAccId", DbType.Int32, CB_CustBankAccId);
                dsGetCustomerBank = db.ExecuteDataSet(getCustomerBankcmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dsGetCustomerBank;
        }
        public DataSet GetARNNo(int adviserId)
        {
            DataSet dsARNNo;
            Database db;
            DbCommand getArnNocmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getArnNocmd = db.GetStoredProcCommand("SPROC_GetARNNo");
                db.AddInParameter(getArnNocmd, "@AdviserId", DbType.Int32, adviserId);
                dsARNNo = db.ExecuteDataSet(getArnNocmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dsARNNo;
        }
        public DataSet GetEUIN(int adviserId)
        {
            DataSet dsEUIN;
            Database db;
            DbCommand getEUINcmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getEUINcmd = db.GetStoredProcCommand("SPROC_GetEUIN");
                db.AddInParameter(getEUINcmd, "@AdviserId", DbType.Int32, adviserId);
                dsEUIN = db.ExecuteDataSet(getEUINcmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dsEUIN;
        }

        public void GetPanDetails(string Pannum, string Subbrokercode, int AdviserId, out int customerId, out string CustomerName, out int AgentId)
        {
            Database db;
            DbCommand MFOrderAutoMatchCmd;

            customerId = 0;
            AgentId = 0;
            CustomerName = string.Empty;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                MFOrderAutoMatchCmd = db.GetStoredProcCommand("SP_GetPanDetails");
                db.AddInParameter(MFOrderAutoMatchCmd, "@Pannum", DbType.String, Pannum);
                db.AddInParameter(MFOrderAutoMatchCmd, "@Subbrokercode", DbType.String, Subbrokercode);
                db.AddInParameter(MFOrderAutoMatchCmd, "@AdviserId", DbType.Int32, AdviserId);
                db.AddOutParameter(MFOrderAutoMatchCmd, "@customerId", DbType.Int32, customerId);
                db.AddOutParameter(MFOrderAutoMatchCmd, "@CustomerName", DbType.String, 100);

                db.AddOutParameter(MFOrderAutoMatchCmd, "@AgentId", DbType.Int32, 100);



                if (db.ExecuteNonQuery(MFOrderAutoMatchCmd) != 0)
                {

                    customerId = int.Parse(db.GetParameterValue(MFOrderAutoMatchCmd, "@customerId").ToString());

                    CustomerName = db.GetParameterValue(MFOrderAutoMatchCmd, "@CustomerName").ToString();

                    AgentId = int.Parse(db.GetParameterValue(MFOrderAutoMatchCmd, "@AgentId").ToString());

                }
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
        }

    }
}
