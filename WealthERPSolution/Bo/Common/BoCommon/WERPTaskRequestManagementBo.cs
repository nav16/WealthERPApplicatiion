﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DaoCommon;
using System.Data;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;
using VoCommon;
using VoReports;


namespace BoCommon
{
    public class WERPTaskRequestManagementBo
    {
        /// <summary>
        /// Create Task Request returns RequestId
        /// </summary>
        /// <param name="portfolioIDs"></param>
        /// <param name="subreportype"></param>
        /// <param name="fromDate"></param>
        /// <returns></returns>
        /// 
        public void CreateTaskRequest(int taskId, int userId, out int taskRequestId, string filePath, int adviserId, int rmId)
        {
             WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();
            try
            {
                requestManagementDao.CreateTaskRequest(taskId, userId, out taskRequestId, filePath, adviserId, rmId);
            }
             catch (BaseApplicationException ex)
            {
                throw (ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "WERPTaskRequestManagementBo.cs:CreateTaskRequest()");
                object[] objects = new object[2];
                objects[0] = taskId;
                objects[1] = userId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }
        public void CreateTaskRequest(int taskId, int userId, out int taskRequestId, string filePath, int adviserId, int rmId, int branchId, string uploadType, int xmlFileTypeId,int isOnline)
        {
            WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();

            try
            {
                requestManagementDao.CreateTaskRequest(taskId, userId, out taskRequestId, filePath, adviserId, rmId, branchId, uploadType, xmlFileTypeId, isOnline);

            }
            catch (BaseApplicationException ex)
            {
                throw (ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "WERPTaskRequestManagementBo.cs:CreateTaskRequest()");
                object[] objects = new object[2];
                objects[0] = taskId;
                objects[1] = userId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }

        }
        public void CreateTaskRequestForRecon(int taskId, int userId, out int taskRequestId, string filePath, int adviserId, string uploadType, string remarks)
        {
            WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();

            try
            {
                requestManagementDao.CreateTaskRequestForRecon(taskId, userId, out taskRequestId, filePath, adviserId, uploadType, remarks);

            }
            catch (BaseApplicationException ex)
            {
                throw (ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "WERPTaskRequestManagementBo.cs:CreateTaskRequestForRecon()");
                object[] objects = new object[2];
                objects[0] = taskId;
                objects[1] = userId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }

        }

        public DataSet GetAdviserWiseRM(int adviserId)
        {
            DataSet dsRm = new DataSet();
            WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();
            try
            {
                dsRm = requestManagementDao.GetAdviserWiseRM(adviserId);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return dsRm;
        }

        public DataSet GetAdviserWiseBranch(int adviserId)
        {
            DataSet dsBranch = new DataSet();
            WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();
            try
            {
                dsBranch = requestManagementDao.GetAdviserWiseBranch(adviserId);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return dsBranch;
        }
        /// <summary>
        /// Create Bulk Report request to Queue
        /// </summary>
        /// <param name="portfolioIDs"></param>
        /// <param name="subreportype"></param>
        /// <param name="fromDate"></param>
        /// <returns></returns>
        public void CreateBulkReportRequest(List<MFReportVo> mfReportVoList,MFReportEmailVo mfReportEmailVo, int parentRequestId, int taskId, int userId)
        {
            WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();
            try
            {
                requestManagementDao.CreateBulkReportRequest(mfReportVoList,mfReportEmailVo, parentRequestId, taskId, userId);

            }
            catch (BaseApplicationException ex)
            {
                throw (ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "WERPTaskRequestManagementBo.cs:CreateBulkReportRequest()");
                object[] objects = new object[3];
                objects[0] = taskId;
                objects[1] = userId;
                objects[2] = parentRequestId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }


        public DataSet GetRequestStatusList(int adviserId, DateTime requestDate)
        {
            DataSet dsRequestList = null;
            WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();
            try
            {
                dsRequestList = requestManagementDao.GetRequestStatusList(adviserId, requestDate);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "WERPTaskRequestManagementBo.cs:GetRequestStatusList(int userId,DateTime requestDate)");
                object[] objects = new object[1];
                objects[0] = adviserId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsRequestList;


        }

        /// <summary>
        /// Create Task Request returns RequestId
        /// </summary>
        /// <param name="portfolioIDs"></param>
        /// <param name="subreportype"></param>
        /// <param name="fromDate"></param>
        /// <returns></returns>
        public void CreateBulkMailRequestRecord(Dictionary<string, object> bulkMailRequest)
        {
            WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();

            try
            {
               requestManagementDao.CreateBulkMailRequestRecord(bulkMailRequest);

            }
            catch (BaseApplicationException ex)
            {
                throw (ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "WERPTaskRequestManagementBo.cs:CreateTaskRequest()");
                object[] objects = new object[2];
                objects[0] = bulkMailRequest["ADVISER_ID"];
                objects[1] = bulkMailRequest["USER_ID"];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }

        }

        public void CreateTaskRequestForBulk(int taskId, int UserId, out int ReqId, int advisorId, string OrderBookType, string IssueNO)
        {
            WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();

            try
            {
                requestManagementDao.CreateTaskRequestForBulk(taskId, UserId, out ReqId, advisorId, OrderBookType, IssueNO);

            }
            catch (BaseApplicationException ex)
            {
                throw (ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "WERPTaskRequestManagementBo.cs:CreateTaskRequestForBulk()");
                object[] objects = new object[2];
                objects[0] = taskId;
                objects[1] = UserId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }
        public DataSet GetBulkOrderStatus(int reqId,string OrderBookType,DateTime Fromdate,DateTime Todate)
        {
            WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();
            try
            {
                return requestManagementDao.GetBulkOrderStatus(reqId,OrderBookType, Fromdate, Todate);

            }
            catch (BaseApplicationException ex)
            {
                throw (ex);
            }
        }
        public DataTable GetBrokerageCalculationDetails(int reqId, out string productType, out String productCategory, out string commissionType)
        { 
         WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();
         productType = string.Empty;
         productCategory = string.Empty;
         commissionType = string.Empty;
         try
         {
             
             return requestManagementDao.GetBrokerageCalculationDetails(reqId, out productType, out productCategory, out commissionType);
         }
         catch (BaseApplicationException ex)
         {
             throw (ex);
         }
         catch (Exception Ex)
         {
             BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
             NameValueCollection FunctionInfo = new NameValueCollection();
             FunctionInfo.Add("Method", "WERPTaskRequestManagementBo:GetBrokerageCalculationDetails(int reqId, out string productType, out String productCategory, out string commissionType)");
             object[] objects = new object[12];
             objects[0] = reqId;
             objects[1] = productType;
             objects[2] = productCategory;
             FunctionInfo = exBase.AddObject(FunctionInfo, objects);
             exBase.AdditionalInformation = FunctionInfo;
             ExceptionManager.Publish(exBase);
             throw exBase;
         }
        }
        public DataTable GetBrokerageCalculationStatus(int reqId, DateTime FromDate, DateTime ToDate)
        {
            WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();
            try
            {
                return requestManagementDao.GetBrokerageCalculationStatus(reqId, FromDate, ToDate);

            }
            catch (BaseApplicationException ex)
            {
                throw (ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "WERPTaskRequestManagementBo:GetBrokerageCalculationStatus(int reqId,DateTime FromDate,DateTime ToDate)");
                object[] objects = new object[12];
                objects[0] = reqId;
                objects[1] = FromDate;
                objects[2] = ToDate;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }


        }
        public void CreateTaskRequestForBrokerageCalculation(int taskId, int UserId, out int reqId, string product, int typeOfTransaction, int AdviserId, int schemeid, int month, int year, string category, string recontype, string commtype, int issuer, int issueId, int commissionLookUpId, string orderStatus, string agentCode, string productCategory, int isAuthenticated)
        {
            reqId = 0;
            WERPTaskRequestManagementDao requestManagementDao = new WERPTaskRequestManagementDao();
            try
            {
                requestManagementDao.CreateTaskRequestForBrokerageCalculation(taskId, UserId, out  reqId, product, typeOfTransaction, AdviserId, schemeid, month, year, category, recontype, commtype, issuer, issueId, commissionLookUpId, orderStatus, agentCode, productCategory, isAuthenticated);
            }
            catch (BaseApplicationException ex)
            {
                throw (ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CreateTaskRequestForBrokerageCalculation(int taskId, int UserId, out int reqId, string product, int typeOfTransaction, int AdviserId, int schemeid, int month, int year, string category, string recontype, string commtype, int issuer, int issueId, int commissionLookUpId, string orderStatus, string agentCode, string productCategory, int isAuthenticated)");
                object[] objects = new object[12];
                objects[0] = AdviserId;
                objects[1] = schemeid;
                objects[2] = month;
                objects[3] = year;
                objects[4] = category;
                objects[5] = recontype;
                objects[6] = commtype;
                objects[7] = issuer;
                objects[8] = product;
                objects[9] = typeOfTransaction;
                objects[10] = issueId;
                objects[11] = commissionLookUpId;
                objects[12] = orderStatus;
                objects[13] = agentCode;
                objects[14] = productCategory;
                objects[15] = isAuthenticated;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
           
        }
    }
}
