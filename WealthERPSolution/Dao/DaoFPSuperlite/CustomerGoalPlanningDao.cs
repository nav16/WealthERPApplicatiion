﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.Specialized;

using System.Data;
using System.Data.Sql;
using System.Data.Common;

using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using VoFPSuperlite;

namespace DaoFPSuperlite
{
    public class CustomerGoalPlanningDao
    {
        public DataSet GetGoalObjectiveTypes()
        {
            Database db;
            DbCommand getGoalObjTypeCmd;
            DataSet getGoalObjTypeDs;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getGoalObjTypeCmd = db.GetStoredProcCommand("SP_GetGoalName");
                getGoalObjTypeDs = db.ExecuteDataSet(getGoalObjTypeCmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalPlanningDao:GetGoalObjectiveTypes()");


                object[] objects = new object[1];
                objects[0] = "SP_GetGoalName";

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return getGoalObjTypeDs;
        }

        public DataSet GetAllGoalDropDownDetails(int CustomerID)
        {
            Database db;
            DbCommand allGoalDropDownDetailsCmd;
            DataSet allGoalDropDownDetailsDs;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                allGoalDropDownDetailsCmd = db.GetStoredProcCommand("SP_GetAllGoalDropDownDetails");
                db.AddInParameter(allGoalDropDownDetailsCmd, "@Customer_ID", DbType.Int32, CustomerID);
                allGoalDropDownDetailsDs = db.ExecuteDataSet(allGoalDropDownDetailsCmd);
                allGoalDropDownDetailsDs.Tables[0].TableName = "GoalObjective";
                allGoalDropDownDetailsDs.Tables[1].TableName = "ChildDetails";
                allGoalDropDownDetailsDs.Tables[2].TableName = "GoalFrequency";
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalSetupDao:GetCustomerAssociationDetails()");


                object[] objects = new object[1];
                objects[0] = CustomerID;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return allGoalDropDownDetailsDs;
        }


        public void CreateCustomerGoalPlanning(CustomerGoalPlanningVo GoalPlanningVo, int UserId)
        {
            Database db;
            DbCommand createCustomerGoalProfileCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createCustomerGoalProfileCmd = db.GetStoredProcCommand("SP_CreateCustomerGoalPlanning");
                db.AddInParameter(createCustomerGoalProfileCmd, "@CustomerId", DbType.Int32, GoalPlanningVo.CustomerId);
                db.AddInParameter(createCustomerGoalProfileCmd, "@GoalCode", DbType.String, GoalPlanningVo.Goalcode);
                db.AddInParameter(createCustomerGoalProfileCmd, "@CostToday", DbType.Double, GoalPlanningVo.CostOfGoalToday);
                db.AddInParameter(createCustomerGoalProfileCmd, "@GoalYear", DbType.Int32, GoalPlanningVo.GoalYear);
                db.AddInParameter(createCustomerGoalProfileCmd, "@GoalProfileDate", DbType.DateTime, GoalPlanningVo.GoalDate);
                db.AddInParameter(createCustomerGoalProfileCmd, "@FutureValueOfCostToday", DbType.Double, GoalPlanningVo.FutureValueOfCostToday);
                db.AddInParameter(createCustomerGoalProfileCmd, "@MonthlySavingsRequired", DbType.Double, GoalPlanningVo.MonthlySavingsReq);
                if (GoalPlanningVo.AssociateId != 0)
                {
                    db.AddInParameter(createCustomerGoalProfileCmd, "@AssociateId", DbType.Int32, GoalPlanningVo.AssociateId);
                }
                db.AddInParameter(createCustomerGoalProfileCmd, "@ROIEarned", DbType.Double, GoalPlanningVo.ROIEarned);
                db.AddInParameter(createCustomerGoalProfileCmd, "@CurrentInvestment", DbType.Double, GoalPlanningVo.CurrInvestementForGoal);
                db.AddInParameter(createCustomerGoalProfileCmd, "@ExpectedROI", DbType.Double, GoalPlanningVo.ExpectedROI);
                db.AddInParameter(createCustomerGoalProfileCmd, "@IsActive", DbType.Int16, GoalPlanningVo.IsActice);
                db.AddInParameter(createCustomerGoalProfileCmd, "@InflationPer", DbType.Double, GoalPlanningVo.InflationPercent);
                if (GoalPlanningVo.CustomerApprovedOn != DateTime.Parse("01/01/0001 00:00:00"))
                {
                    db.AddInParameter(createCustomerGoalProfileCmd, "@CustomerApprovedOn", DbType.DateTime, GoalPlanningVo.CustomerApprovedOn);
                }
                db.AddInParameter(createCustomerGoalProfileCmd, "@Comments", DbType.String, GoalPlanningVo.Comments);
                db.AddInParameter(createCustomerGoalProfileCmd, "@GoalDescription", DbType.String, GoalPlanningVo.GoalDescription);
                db.AddInParameter(createCustomerGoalProfileCmd, "@ROIOnFuture", DbType.Double, GoalPlanningVo.RateofInterestOnFture);
                db.AddInParameter(createCustomerGoalProfileCmd, "@CreatedBy", DbType.Int32, GoalPlanningVo.CreatedBy);
                db.AddInParameter(createCustomerGoalProfileCmd, "@LumpsumInvestmentRequired", DbType.Double, GoalPlanningVo.LumpsumInvestRequired);
                db.AddInParameter(createCustomerGoalProfileCmd, "@FutureValueOnCurrentInvest", DbType.Double, GoalPlanningVo.FutureValueOnCurrentInvest);
              

                db.AddInParameter(createCustomerGoalProfileCmd, "@GoalPriority", DbType.String, GoalPlanningVo.Priority);
                if (GoalPlanningVo.IsOnetimeOccurence==true)
                db.AddInParameter(createCustomerGoalProfileCmd, "@IsOneTimeOccurrence", DbType.Int16, 1);
                else
                db.AddInParameter(createCustomerGoalProfileCmd, "@IsOneTimeOccurrence", DbType.Int16, 0);
                if (!string.IsNullOrEmpty(GoalPlanningVo.Frequency))
                db.AddInParameter(createCustomerGoalProfileCmd, "@GoalFrequency", DbType.String, GoalPlanningVo.Frequency);
                
                
                
                db.ExecuteNonQuery(createCustomerGoalProfileCmd);


            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalPlanningDao.cs:CreateCustomerGoalProfile()");


                object[] objects = new object[1];
                objects[0] = GoalPlanningVo;


                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }


        }

        public CustomerAssumptionVo GetAllCustomerAssumption(int CustomerID,int goalYear)
        {
            Database db;
            DbCommand allCustomerAssumptionCmd;
            DataSet allCustomerAssumptionDs;
            CustomerAssumptionVo customerAssumptionVo = new CustomerAssumptionVo(); 
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                allCustomerAssumptionCmd = db.GetStoredProcCommand("SP_GetCustomerAssumptionForGoalSetup");
                db.AddInParameter(allCustomerAssumptionCmd, "@CustomerId", DbType.Int32, CustomerID);
                db.AddInParameter(allCustomerAssumptionCmd, "@Year", DbType.Int32, goalYear);
                allCustomerAssumptionDs = db.ExecuteDataSet(allCustomerAssumptionCmd);
                DataTable dtCustomerStaticAssumption = allCustomerAssumptionDs.Tables[0];
                DataTable dtCustomerProjectedAssumption = allCustomerAssumptionDs.Tables[1];
                foreach (DataRow dr in dtCustomerStaticAssumption.Rows)
                {
                    if(Convert.ToString(dr["WA_AssumptionId"])=="LE")
                    {
                        customerAssumptionVo.CustomerEOL = int.Parse(Math.Round(double.Parse(dr["CSA_Value"].ToString()), 0).ToString());

                    }
                    else if (Convert.ToString(dr["WA_AssumptionId"]) == "RA")
                    {
                        customerAssumptionVo.RetirementAge = int.Parse(Math.Round(double.Parse(dr["CSA_Value"].ToString()), 0).ToString());

                    }
 
                }
                foreach (DataRow dr in dtCustomerProjectedAssumption.Rows)
                {
                    switch(Convert.ToString(dr["WA_AssumptionId"]))
                    {
                        case "IR":
                            {
                               customerAssumptionVo.InflationPercent=double.Parse(Convert.ToString(dr["CPA_Value"]));
                               break;
                            }                        
                        case "PRT":
                            {
                                customerAssumptionVo.PostRetirementReturn = double.Parse(Convert.ToString(dr["CPA_Value"]));
                                break;
                            }
                        case "RNI":
                            {
                                customerAssumptionVo.ReturnOnNewInvestment = double.Parse(Convert.ToString(dr["CPA_Value"]));
                                break;
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

                FunctionInfo.Add("Method", "CustomerGoalSetupDao:GetAllCustomerAssumption()");


                object[] objects = new object[1];
                objects[0] = CustomerID;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            return customerAssumptionVo;
            
        }

        public DataSet GetCustomerGoalDetails(int CustomerID)
        {
            Database db;
            DbCommand customerGoalDetailsCmd;
            DataSet customerGoalDetailsDS;
          
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                customerGoalDetailsCmd = db.GetStoredProcCommand("SP_GetCustomersAllGoalDetails");
                db.AddInParameter(customerGoalDetailsCmd, "@CustomerId", DbType.Int32, CustomerID);
                customerGoalDetailsDS = db.ExecuteDataSet(customerGoalDetailsCmd);                

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalPlanningDao:GetCustomerGoalDetails()");


                object[] objects = new object[1];
                objects[0] = CustomerID;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            return customerGoalDetailsDS;

        }

        public DataSet GetCustomerGoalList(int CustomerID)
        {
            Database db;
            DbCommand customerGoalListCmd;
            DataSet customerGoalListDS;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                customerGoalListCmd = db.GetStoredProcCommand("SP_GetCustomerGoalList");
                db.AddInParameter(customerGoalListCmd, "@CustomerId", DbType.Int32, CustomerID);
                customerGoalListDS = db.ExecuteDataSet(customerGoalListCmd);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalPlanningDao:GetCustomerGoalList()");


                object[] objects = new object[1];
                objects[0] = CustomerID;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            return customerGoalListDS;

        }
        public void CreateCustomerGoalFunding(int goalId, decimal equityAllocatedAmount, decimal debtAllocatedAmount, decimal cashAllocatedAmount, decimal alternateAllocatedAmount, int isloanFunded, decimal loanAmount, DateTime loanStartDate)
        {
            Database db;
            DbCommand CreateCustomerGoalFundingCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                CreateCustomerGoalFundingCmd = db.GetStoredProcCommand("SP_GetCustomerGoalFunding");
                db.AddInParameter(CreateCustomerGoalFundingCmd, "@goalId", DbType.Int32, goalId);
                db.AddInParameter(CreateCustomerGoalFundingCmd, "@equityAllocatedAmount", DbType.Decimal, equityAllocatedAmount);
                db.AddInParameter(CreateCustomerGoalFundingCmd, "@debtAllocatedAmount", DbType.Decimal, debtAllocatedAmount);
                db.AddInParameter(CreateCustomerGoalFundingCmd, "@cashAllocatedAmount", DbType.Decimal, cashAllocatedAmount);
                db.AddInParameter(CreateCustomerGoalFundingCmd, "@alternateAllocatedAmount", DbType.Decimal, alternateAllocatedAmount);
                db.AddInParameter(CreateCustomerGoalFundingCmd, "@isloanFunded", DbType.Int16, isloanFunded);
                db.AddInParameter(CreateCustomerGoalFundingCmd, "@loanAmount", DbType.Decimal, loanAmount);
                if (loanStartDate != DateTime.MinValue)
                    db.AddInParameter(CreateCustomerGoalFundingCmd, "@loanStartDate", DbType.DateTime, loanStartDate);
                else
                    db.AddInParameter(CreateCustomerGoalFundingCmd, "@loanStartDate", DbType.DateTime, DBNull.Value);
                db.ExecuteNonQuery(CreateCustomerGoalFundingCmd);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
        }
     }
}
