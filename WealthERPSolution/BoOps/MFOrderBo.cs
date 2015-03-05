﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;
using DaoOps;
using VoOps;
using VoCustomerPortfolio;

namespace BoOps
{
    public class MFOrderBo : OrderBo
    {
        MFOrderDao mfOrderDao = new MFOrderDao();
        public int GetOrderNumber(int orderId)
        {
            int orderNumber = 0;
            try
            {
                orderNumber = mfOrderDao.GetOrderNumber(orderId);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OperationBo.cs:GetOrderNumber()");
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
            DataTable AplicationNODuplicates = new DataTable();
            try
            {
                AplicationNODuplicates = mfOrderDao.AplicationNODuplicates(prefixText);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return AplicationNODuplicates;
        }
        public List<int> CreateCustomerMFOrderDetails(OrderVo orderVo, MFOrderVo mforderVo, int userId, SystematicSetupVo SystematicSetupVo,out int setupId)
        {
            List<int> orderIds = new List<int>();
            try
            {
                orderIds = mfOrderDao.CreateOrderMFDetails(orderVo, mforderVo, userId, SystematicSetupVo, out setupId);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return orderIds;
        }

        public List<int> CreateOffLineMFSwitchOrderDetails(List<MFOrderVo> lsonlinemforder, int userId, int customerId)
        {

            DataTable dtSwitchOrder = new DataTable();
            List<int> OrderIds = new List<int>();

            try
            {
                dtSwitchOrder = creataTableForSwitch(lsonlinemforder);
                OrderIds = mfOrderDao.CreateOffLineMFSwitchOrderDetails(dtSwitchOrder, userId, customerId);

            }

            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineMFOrderBo.cs:GetCustomerSchemeFolioHoldings(int customerId, int schemeId)");

                object[] objects = new object[1];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return OrderIds;


        }

        public DataTable creataTableForSwitch(List<MFOrderVo> lsonlinemforder)
        {
            MFOrderVo offlineMFOrderVo = new MFOrderVo();
            DataTable dtSwitchOrder = new DataTable();
            dtSwitchOrder.Columns.Add("CMFSO_AccountId");
            dtSwitchOrder.Columns.Add("CMFSO_SchemePlanCode");
            dtSwitchOrder.Columns.Add("CMFSO_Amount");
            dtSwitchOrder.Columns.Add("CMFSO_TransactionType");
            dtSwitchOrder.Columns.Add("CMFSO_DivOption");
            dtSwitchOrder.Columns.Add("CO_OrderId");

            DataRow drOrderDetails;
            for (int i = 0; i < lsonlinemforder.Count; i++)
            {
                offlineMFOrderVo = lsonlinemforder[i];
                drOrderDetails = dtSwitchOrder.NewRow();
                drOrderDetails["CMFSO_AccountId"] = offlineMFOrderVo.accountid.ToString();
                drOrderDetails["CMFSO_SchemePlanCode"] = offlineMFOrderVo.SchemePlanCode.ToString();
                drOrderDetails["CMFSO_Amount"] = offlineMFOrderVo.Amount.ToString();
                drOrderDetails["CMFSO_TransactionType"] = offlineMFOrderVo.TransactionCode.ToString();
                if (offlineMFOrderVo.DivOption == string.Empty)
                    drOrderDetails["CMFSO_DivOption"] = offlineMFOrderVo.DivOption.ToString();
                else
                    drOrderDetails["CMFSO_DivOption"] = null;
                dtSwitchOrder.Rows.Add(drOrderDetails);
            }
            return dtSwitchOrder;

        }

        public DataSet GetCustomerMFOrderMIS(int AdviserId, DateTime FromDate, DateTime ToDate, string branchId, string rmId, string transactionType, string status, string orderType, string amcCode, string customerId, int isOnline)
        {
            DataSet dsGetMFOrderMIS;
            try
            {
                dsGetMFOrderMIS = mfOrderDao.GetCustomerMFOrderMIS(AdviserId, FromDate, ToDate, branchId, rmId, transactionType, status, orderType, amcCode, customerId, isOnline);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dsGetMFOrderMIS;
        }

        public void UpdateCustomerMFOrderDetails(OrderVo orderVo, MFOrderVo mforderVo, int userId, SystematicSetupVo systematicSetupVo)
        {
            try
            {
                mfOrderDao.UpdateCustomerMFOrderDetails(orderVo, mforderVo, userId, systematicSetupVo);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
        }
        public int MarkAsReject(int orderId, string Remarks)
        {
            int IsMarked = 0;
            try
            {
                IsMarked = mfOrderDao.MarkAsReject(orderId, Remarks);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return IsMarked;
        }
        public bool ChkOnlineOrder(int OrderId)
        {
            try
            {
                return mfOrderDao.ChkOnlineOrder(OrderId);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
        }

        public bool ChkOfflineValidFolio(string folioNo)
        {
            try
            {
                return mfOrderDao.ChkOfflineValidFolio(folioNo);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
        }

        public void GetFolio(int customerId, int schemePlanCode, out string folio, out int accountId)
       
        {
            try
            {
                  mfOrderDao.GetFolio(customerId, schemePlanCode, out folio, out accountId);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
        }
 

        public DataSet GetCustomerMFOrderDetails(int orderId)
        {
            DataSet dsGetCustomerMFOrderDetails;
            try
            {
                dsGetCustomerMFOrderDetails = mfOrderDao.GetCustomerMFOrderDetails(orderId);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return dsGetCustomerMFOrderDetails;
        }


        public DataSet GetSipControlDetails(int scheme, string frequency)
        {
            DataSet ds = null;

            try
            {
                ds = mfOrderDao.GetSipControlDetails(scheme, frequency);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OrderBo.cs:GetOrderStepsDetails()");

                object[] objects = new object[1];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return ds;
        }

        public DataSet GetControlDetails(int scheme, string folio)
        {
            DataSet ds = null;

            try
            {
                ds = mfOrderDao.GetControlDetails(scheme, folio);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OrderBo.cs:GetOrderStepsDetails()");

                object[] objects = new object[1];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return ds;
        }

        public DataSet GetCustomerBank(int customerId)
        {
            DataSet dsGetCustomerBank;
            try
            {
                dsGetCustomerBank = mfOrderDao.GetCustomerBank(customerId);
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
            try
            {
                dsGetCustomerBank = mfOrderDao.GetCustomerBanks(customerId);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dsGetCustomerBank;
        }


        public DataSet GetSipDetails(int orderID)
        {
            DataSet dsGetSip;
            try
            {
                dsGetSip = mfOrderDao.GetSipDetails(orderID);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dsGetSip;
        }
        public DataTable GetBankBranch(int BankId)
        {
            DataTable dtGetBankBranch;
            try
            {
                dtGetBankBranch = mfOrderDao.GetBankBranch(BankId);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dtGetBankBranch;
        }

        //public DataTable GetBankBranchLookups(int lookUpId)
        //{
        //    DataTable dtGetBankBranch;
        //    try
        //    {
        //        dtGetBankBranch = mfOrderDao.GetBankBranchLookups(lookUpId);
        //    }
        //    catch (BaseApplicationException Ex)
        //    {
        //        throw (Ex);
        //    }
        //    return dtGetBankBranch;
        //}

        public bool DeleteMFOrder(int orderId)
        {
            bool bResult = false;
            try
            {
                bResult = mfOrderDao.DeleteMFOrder(orderId);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return bResult;
        }


        public bool MFOrderAutoMatch(int OrderId, int SchemeCode, int AccountId, string TransType, int CustomerId, double Amount, DateTime OrderDate)
        {
            bool result = false;
            try
            {
                result = mfOrderDao.MFOrderAutoMatch(OrderId, SchemeCode, AccountId, TransType, CustomerId, Amount, OrderDate, out result);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return result;
        }
        public DataSet GetEQCustomerBank(int customerId)
        {
            DataSet dsGetCustomerBank;
            try
            {
                dsGetCustomerBank = mfOrderDao.GetEQCustomerBank(customerId);
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
            try
            {
                dsARNNo = mfOrderDao.GetARNNo(adviserId);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dsARNNo;
        }

    }
}
