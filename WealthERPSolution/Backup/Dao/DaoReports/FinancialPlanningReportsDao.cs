﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System.Data.Common;
using System.Data;

using System.Collections.Specialized;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using VoReports;
using BoCommon;


namespace DaoReports
{
    public class FinancialPlanningReportsDao
    {

        /// <summary>
        /// 
        /// </summary>
        /// <param name="report"></param>
        /// <returns></returns>
        public DataSet GetFinancialPlanningReport(FinancialPlanningVo report)
        {
            Database db;
            DbCommand cmd;
            DataSet ds = null;
            DataTable dtCustomerDetails = new DataTable();
            DataTable dtSpouseDetails = new DataTable();
            DataTable dtChildrenDetails = new DataTable();
            DataTable dtTempChildrenDetails = new DataTable();
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SP_RPT_GetFinancialPlanningReport");
                db.AddInParameter(cmd, "@CustomerId", DbType.String, report.CustomerId);
                cmd.CommandTimeout = 60 * 60;
                ds = db.ExecuteDataSet(cmd);
                dtCustomerDetails.Columns.Add("Name", typeof(string));
                dtCustomerDetails.Columns.Add("Dob", typeof(string));

                dtSpouseDetails.Columns.Add("Name", typeof(string));
                dtSpouseDetails.Columns.Add("Dob", typeof(string));

                dtTempChildrenDetails.Columns.Add("Name", typeof(string));
                dtTempChildrenDetails.Columns.Add("Dob", typeof(string));
                dtTempChildrenDetails.Columns.Add("YearEducation", typeof(string));
                dtTempChildrenDetails.Columns.Add("YearMarriage", typeof(string));

                dtChildrenDetails.Columns.Add("Name", typeof(string));
                dtChildrenDetails.Columns.Add("Dob", typeof(string));
                dtChildrenDetails.Columns.Add("YearEducation", typeof(string));
                dtChildrenDetails.Columns.Add("YearMarriage", typeof(string));

                if (ds.Tables[2].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[2].Rows)
                    {
                        if (dr["RelationShipCode"].ToString() == "SELF")
                        {
                            DataRow drCustomer = dtCustomerDetails.NewRow();

                            drCustomer["Name"] = dr["Name"].ToString();
                            if (!string.IsNullOrEmpty(dr["DOB"].ToString().Trim()))
                                drCustomer["Dob"] = String.Format("{0:dd MMM yyyy}", DateTime.Parse(dr["DOB"].ToString().Trim()));
                            else
                                drCustomer["Dob"] = "-";
                            dtCustomerDetails.Rows.Add(drCustomer);

                        }
                        else if (dr["RelationShipCode"].ToString() == "SP")
                        {
                            DataRow drSpouse = dtSpouseDetails.NewRow();
                            if (!string.IsNullOrEmpty(dr["Name"].ToString()))
                                drSpouse["Name"] = dr["Name"].ToString();
                            else
                                drSpouse["Name"] = "-";
                            if (!string.IsNullOrEmpty(dr["DOB"].ToString().Trim()))
                                drSpouse["Dob"] = String.Format("{0:dd MMM yyyy}", DateTime.Parse(dr["DOB"].ToString().Trim()));
                            else
                                drSpouse["Dob"] = "-";
                            dtSpouseDetails.Rows.Add(drSpouse);

                        }
                        else if (dr["RelationShipCode"].ToString() == "CH" && (dr["IsGoalActive"].ToString() == "1" || string.IsNullOrEmpty(dr["IsGoalActive"].ToString())))
                        {
                            DataRow drChild = dtTempChildrenDetails.NewRow();
                            if (!string.IsNullOrEmpty(dr["Name"].ToString()))
                                drChild["Name"] = dr["Name"].ToString();
                            else
                                drChild["Name"] = "-";
                            if (!string.IsNullOrEmpty(dr["DOB"].ToString().Trim()))
                                drChild["Dob"] = String.Format("{0:dd MMM yyyy}", DateTime.Parse(dr["DOB"].ToString().Trim()));
                            else
                                drChild["Dob"] = "-";
                            if (!string.IsNullOrEmpty(dr["YearOfEducation"].ToString()))
                                drChild["YearEducation"] = dr["YearOfEducation"].ToString();
                            else
                                drChild["YearEducation"] = "-";
                            if (!string.IsNullOrEmpty(dr["YearOfMarriage"].ToString()))
                                drChild["YearMarriage"] = dr["YearOfMarriage"].ToString();
                            else
                                drChild["YearMarriage"] = "-";
                            dtTempChildrenDetails.Rows.Add(drChild);

                        }


                    }

                }
                if (dtTempChildrenDetails.Rows.Count > 0)
                {
                    for (int rowNo = 0; rowNo < dtTempChildrenDetails.Rows.Count; rowNo++)
                    {
                        DataRow drChild = dtChildrenDetails.NewRow();
                        if (rowNo != dtTempChildrenDetails.Rows.Count)
                        {
                            if (rowNo == dtTempChildrenDetails.Rows.Count - 1)
                            {
                                drChild["Name"] = dtTempChildrenDetails.Rows[rowNo]["Name"].ToString();
                                drChild["Dob"] = dtTempChildrenDetails.Rows[rowNo]["Dob"].ToString();
                                drChild["YearEducation"] = dtTempChildrenDetails.Rows[rowNo]["YearEducation"].ToString();
                                drChild["YearMarriage"] = dtTempChildrenDetails.Rows[rowNo]["YearMarriage"].ToString();
                                dtChildrenDetails.Rows.Add(drChild);

                            }
                            else
                            {
                                if (dtTempChildrenDetails.Rows[rowNo]["Name"].ToString().Trim() == dtTempChildrenDetails.Rows[rowNo + 1]["Name"].ToString().Trim())
                                {
                                    drChild["Name"] = dtTempChildrenDetails.Rows[rowNo]["Name"].ToString();
                                    drChild["Dob"] = dtTempChildrenDetails.Rows[rowNo]["Dob"].ToString();
                                    if (dtTempChildrenDetails.Rows[rowNo]["YearEducation"].ToString()!="-")
                                        drChild["YearEducation"] = dtTempChildrenDetails.Rows[rowNo]["YearEducation"].ToString();
                                    else
                                        drChild["YearEducation"] = dtTempChildrenDetails.Rows[rowNo + 1]["YearEducation"].ToString();
                                    if (dtTempChildrenDetails.Rows[rowNo]["YearMarriage"].ToString()!="-")
                                        drChild["YearMarriage"] = dtTempChildrenDetails.Rows[rowNo]["YearMarriage"].ToString();
                                    else
                                        drChild["YearMarriage"] = dtTempChildrenDetails.Rows[rowNo + 1]["YearMarriage"].ToString();

                                    dtChildrenDetails.Rows.Add(drChild);
                                    rowNo++;
                                }
                                else
                                {
                                    drChild["Name"] = dtTempChildrenDetails.Rows[rowNo]["Name"].ToString();
                                    drChild["Dob"] = dtTempChildrenDetails.Rows[rowNo]["Dob"].ToString();
                                    drChild["YearEducation"] = dtTempChildrenDetails.Rows[rowNo]["YearEducation"].ToString();
                                    drChild["YearMarriage"] = dtTempChildrenDetails.Rows[rowNo]["YearMarriage"].ToString();
                                    dtChildrenDetails.Rows.Add(drChild);


                                }
                            }
                        }


                    }

                    //int rowCount = 0;
                    //foreach (DataRow dr in dtTempChildrenDetails.Rows)
                    //{
                    //    if (rowCount == 0)
                    //    {

                    //    }
                    //    DataRow drChild = dtChildrenDetails.NewRow();


                    //}
                }

                ds.Tables.Add(dtCustomerDetails);
                ds.Tables.Add(dtSpouseDetails);
                ds.Tables.Add(dtChildrenDetails);



                //if (ds.Tables[0].Rows.Count < 1)
                //{
                //    DataTable dtGoal = new DataTable();
                //    dtGoal.Columns.Add("GoalId");
                //    dtGoal.Columns.Add("GoalName");
                //    dtGoal.Columns.Add("ChildName");
                //    dtGoal.Columns.Add("CostToday", System.Type.GetType("System.Double"));
                //    dtGoal.Columns.Add("MonthlySavingsRequired", System.Type.GetType("System.Double"));
                //    dtGoal.Columns.Add("CalculatedOn", System.Type.GetType("System.DateTime"));
                //    dtGoal.Columns.Add("Year");

                //    DataRow drGoal = ds.Tables[0].NewRow();
                //    drGoal["GoalId"] = -1;
                //    drGoal["GoalName"] = "Test";
                //    drGoal["ChildName"] = "Test";
                //    drGoal["CostToday"] = 0.00;
                //    drGoal["MonthlySavingsRequired"] = 0;
                //    drGoal["CalculatedOn"] = DateTime.MinValue;
                //    //drGoal["Year"] =0;
                //    //dtGoal.Rows.Add(drGoal);
                //    ds.Tables[0].Rows.Add(drGoal);

                //}

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "Reports.cs:GetFinancialPlanningReport()");

                object[] objects = new object[1];
                objects[0] = report;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return ds;
        }

        /// <summary>
        /// Get the Asset and Liability details for a customer.
        /// </summary>
        /// <param name="report"></param>
        /// <remarks>Get All the details of Financial Planning of customers</remarks>
        /// <returns></returns>
        public DataSet GetCustomerFPDetails(FinancialPlanningVo report, out double assetTotal, out double liabilitiesTotal, out double netWorthTotal, out string riskClass, out double sumAssuredLI, out int dynamicAdvisorRiskClass,out int financialAssetTotal)
        {
            Database db;
            DbCommand cmdCustomerFPReportDetails;
            DataSet dsCustomerFPReportDetails = null;
            DataTable dtAsset = new DataTable();
            DataTable dtLiabilities = new DataTable();
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmdCustomerFPReportDetails = db.GetStoredProcCommand("SP_RPT_GetFPReportDetails");
                db.AddInParameter(cmdCustomerFPReportDetails, "@AdvisorId", DbType.Int32, report.advisorId);
                db.AddInParameter(cmdCustomerFPReportDetails, "@CustomerId", DbType.Int32, report.CustomerId);
                db.AddOutParameter(cmdCustomerFPReportDetails, "@RiskClass", DbType.String, 50);
                db.AddOutParameter(cmdCustomerFPReportDetails, "@InsuranceSUMAssured", DbType.Decimal, 20);
                db.AddOutParameter(cmdCustomerFPReportDetails, "@AssetTotal", DbType.Decimal, 20);
                db.AddOutParameter(cmdCustomerFPReportDetails, "@FinancialAssetToal", DbType.Int32, 20);
                db.AddOutParameter(cmdCustomerFPReportDetails, "@DynamicRiskClsaaAdvisor", DbType.Int16, 2);

                dsCustomerFPReportDetails = db.ExecuteDataSet(cmdCustomerFPReportDetails);

                Object riskClassObj = db.GetParameterValue(cmdCustomerFPReportDetails, "@RiskClass");
                if (riskClassObj != DBNull.Value)
                    riskClass = db.GetParameterValue(cmdCustomerFPReportDetails, "@RiskClass").ToString();
                else
                    riskClass = string.Empty;

                Object objSumAssuredLI = db.GetParameterValue(cmdCustomerFPReportDetails, "@InsuranceSUMAssured");
                if (objSumAssuredLI != DBNull.Value)
                    sumAssuredLI = double.Parse(db.GetParameterValue(cmdCustomerFPReportDetails, "@InsuranceSUMAssured").ToString());
                else
                    sumAssuredLI = 0;

                Object objAssetTotal = db.GetParameterValue(cmdCustomerFPReportDetails, "@AssetTotal");
                if (objAssetTotal != DBNull.Value)
                    assetTotal = double.Parse(db.GetParameterValue(cmdCustomerFPReportDetails, "@AssetTotal").ToString());
                else
                    assetTotal = 0;

                Object objFPAssetTotal = db.GetParameterValue(cmdCustomerFPReportDetails, "@FinancialAssetToal");
                if (objFPAssetTotal != DBNull.Value)
                    financialAssetTotal = int.Parse(db.GetParameterValue(cmdCustomerFPReportDetails, "@FinancialAssetToal").ToString());
                else
                    financialAssetTotal = 0;

                Object objDynamicRiskClass = db.GetParameterValue(cmdCustomerFPReportDetails, "@DynamicRiskClsaaAdvisor");
                if (objAssetTotal != DBNull.Value)
                    dynamicAdvisorRiskClass = int.Parse(db.GetParameterValue(cmdCustomerFPReportDetails, "@DynamicRiskClsaaAdvisor").ToString());
                else
                    dynamicAdvisorRiskClass = 0;

                dtAsset = dsCustomerFPReportDetails.Tables[2];
                dtLiabilities = dsCustomerFPReportDetails.Tables[3];
                if (dtLiabilities.Rows.Count > 0)
                    liabilitiesTotal = double.Parse(dtLiabilities.Rows[0][0].ToString());
                else
                    liabilitiesTotal = 0;
                netWorthTotal = assetTotal - liabilitiesTotal;

                dsCustomerFPReportDetails.Tables[0].TableName = "ReportSection";
                dsCustomerFPReportDetails.Tables[1].TableName = "CustomerFamilyDetails";
                dsCustomerFPReportDetails.Tables[2].TableName = "AssetToal";
                dsCustomerFPReportDetails.Tables[3].TableName = "LiabilitiesTotal";
                dsCustomerFPReportDetails.Tables[4].TableName = "KeyAssumption";
                dsCustomerFPReportDetails.Tables[5].TableName = "OtherGoal";
                dsCustomerFPReportDetails.Tables[6].TableName = "MonthlyGoalTotal";
                dsCustomerFPReportDetails.Tables[7].TableName = "RTGoal";
                dsCustomerFPReportDetails.Tables[8].TableName = "Income";
                dsCustomerFPReportDetails.Tables[9].TableName = "Expense";
                dsCustomerFPReportDetails.Tables[10].TableName = "CashFlow";
                dsCustomerFPReportDetails.Tables[11].TableName = "AssetDetails";
                dsCustomerFPReportDetails.Tables[12].TableName = "LiabilitiesDetail";
                dsCustomerFPReportDetails.Tables[13].TableName = "RiskProfile";
                dsCustomerFPReportDetails.Tables[14].TableName = "LifeInsurance";
                dsCustomerFPReportDetails.Tables[15].TableName = "GeneralInsurance";
                dsCustomerFPReportDetails.Tables[16].TableName = "HLV";
                dsCustomerFPReportDetails.Tables[17].TableName = "AdvisorRiskClass";
                dsCustomerFPReportDetails.Tables[18].TableName = "AdvisorPortfolioAllocation";
                dsCustomerFPReportDetails.Tables[19].TableName = "FPRatio";
                dsCustomerFPReportDetails.Tables[20].TableName = "FPRatioDetails";
                dsCustomerFPReportDetails.Tables[21].TableName = "LoanEMI";
                dsCustomerFPReportDetails.Tables[22].TableName = "HLVAssumption";
                dsCustomerFPReportDetails.Tables[23].TableName = "RMRecommendation";

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "Reports.cs:GetCustomerAssetAllocationDetails()");

                object[] objects = new object[2];
                objects[0] = report.CustomerId;
                objects[0] = report.CustomerId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsCustomerFPReportDetails;
        }
        public DataSet GetFPQuestionnaire(FPOfflineFormVo reports, int adviserId)
        {

            Microsoft.Practices.EnterpriseLibrary.Data.Database db;
            DbCommand getfpOfflineFormCmd;
            DataSet dsfpOfflineForm;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getfpOfflineFormCmd = db.GetStoredProcCommand("SP_GetFPQuestionnaire");
                db.AddInParameter(getfpOfflineFormCmd, "@AdviserId", DbType.Int32, adviserId);
                dsfpOfflineForm = db.ExecuteDataSet(getfpOfflineFormCmd);
                return dsfpOfflineForm;


            }
            catch (Exception ex)
            {
                throw (ex);
            }


        }

        public DataSet GetWelComeNoteDetails(long associateId)
        {
            Microsoft.Practices.EnterpriseLibrary.Data.Database db;
            DbCommand WelComeNoteDetailsFormCmd;
            DataSet dsWelComeNoteDetails;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                WelComeNoteDetailsFormCmd = db.GetStoredProcCommand("SP_GetWelcomeNoteDetails");
                db.AddInParameter(WelComeNoteDetailsFormCmd, "@AssociateId", DbType.Int64, associateId);
                dsWelComeNoteDetails = db.ExecuteDataSet(WelComeNoteDetailsFormCmd);
                dsWelComeNoteDetails.Tables[0].TableName = "AssociateDetails";
                dsWelComeNoteDetails.Tables[1].TableName = "ReportSection";
                dsWelComeNoteDetails.Tables[2].TableName = "FieldCode";
                


            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return dsWelComeNoteDetails;
        }
     

    }
}
