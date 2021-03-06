﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using Microsoft.ApplicationBlocks.ExceptionManagement;

using DaoFPSuperlite;
using VoFPSuperlite;
using Microsoft.VisualBasic;


namespace BoFPSuperlite
{
    public class CustomerGoalPlanningBo
    {

        public CustomerAssumptionVo GetCustomerAssumptions(int CustomerID, int adviserId, out bool isHavingAssumption)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            CustomerAssumptionVo customerAssumptionVo = new CustomerAssumptionVo();

            customerAssumptionVo = customerGoalPlanningDao.GetCustomerAssumptions(CustomerID, adviserId, out isHavingAssumption);

            return customerAssumptionVo;

        }
        public DataSet GetGoalObjectiveTypes()
        {
            DataSet dsGoalObjectiveTypes;
            CustomerGoalPlanningDao daoGoalPlanning = new CustomerGoalPlanningDao();

            try
            {
                dsGoalObjectiveTypes = daoGoalPlanning.GetGoalObjectiveTypes();
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerGoalSetupBo.cs:GetCustomerGoalProfiling()");

                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return dsGoalObjectiveTypes;

        }

        public DataSet GetAllGoalDropDownDetails(int CustomerID)
        {
            DataSet dsGetCustomerAssociationDetails = new DataSet();
            CustomerGoalPlanningDao AssociationDetails = new CustomerGoalPlanningDao();

            try
            {
                dsGetCustomerAssociationDetails = AssociationDetails.GetAllGoalDropDownDetails(CustomerID);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalSetupBo.cs:GetCustomerGoalProfiling()");

                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return dsGetCustomerAssociationDetails;


        }


        public CustomerGoalPlanningVo CreateCustomerGoalPlanning(CustomerGoalPlanningVo goalPlanningVo, CustomerAssumptionVo customerAssumptionVo, int UserId, bool updateGoal,DataTable dtRecurring, out int goalId)
        {

            try
            {
                CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
                //customerAssumptionVo = customerGoalPlanningDao.GetAllCustomerAssumption(UserId, goalPlanningVo.GoalYear, out isHavingAssumption);
                goalId = 0;

                if (goalPlanningVo.Goalcode != "RT")
                {
                    goalPlanningVo = CalculateGoalProfile(goalPlanningVo, customerAssumptionVo);
                }
                else if (goalPlanningVo.Goalcode == "RT")
                    goalPlanningVo = CalculateGoalProfileRT(goalPlanningVo, customerAssumptionVo);

                if (updateGoal)
                {
                    customerGoalPlanningDao.UpdateCustomerGoalProfile(goalPlanningVo, dtRecurring);
                    goalId = goalPlanningVo.GoalId;
                }
                else
                    customerGoalPlanningDao.CreateCustomerGoalPlanning(goalPlanningVo,dtRecurring, out goalId);

                return goalPlanningVo;


            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerGoalPlanningBo.cs:CreateCustomerGoalPlanning()");
                object[] objects = new object[2];
                objects[0] = goalPlanningVo;
                objects[1] = UserId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }


        }


        public CustomerGoalPlanningVo CalculateGoalProfile(CustomerGoalPlanningVo goalPlanningVo, CustomerAssumptionVo customerAssumptionVo)
        {
            double lumpsumInvestment = 0;
            double futureInvValue = 0;
            double futureCost = 0;
            double requiredSavings = 0;
            double costToday = 0;
            double requiredAfter = 0;
            double currentValue = 0;
            double rateEarned = 0;
            double rateOfReturn = 0;
            double inflationValues = 0;
            string goal = string.Empty;
            //double InflationPercent = 8;

            try
            {
                if (goalPlanningVo.GoalType != "RG")
                costToday = goalPlanningVo.CostOfGoalToday;
                else
                    costToday = goalPlanningVo.RCgoalCoast;
                // requiredAfter = GoalProfileVo.GoalYear;
                requiredAfter = goalPlanningVo.GoalYear - DateTime.Today.Year;
                currentValue = goalPlanningVo.CurrInvestementForGoal;
                rateEarned = goalPlanningVo.ROIEarned / 100;
                rateOfReturn = goalPlanningVo.ExpectedROI / 100;
                inflationValues = (Double)goalPlanningVo.InflationPercent / 100;

                if (goalPlanningVo.GoalType != "RG")
                    futureCost = Math.Abs(FutureValue(inflationValues, requiredAfter, 0, costToday, 1));
                else
                    futureCost = costToday;
                if (currentValue == 0 && rateEarned == 0)
                {
                    futureInvValue = 0;

                }
                else
                    futureInvValue = Math.Abs(FutureValue(rateEarned, requiredAfter, 0, currentValue, 1));

                lumpsumInvestment = PV(goalPlanningVo.ExpectedROI / 100, requiredAfter, 0, -futureCost, 1);

                requiredSavings = Math.Abs(PMT((rateOfReturn / 12), (requiredAfter * 12), 0, (futureCost - futureInvValue), 1));
                goalPlanningVo.MonthlySavingsReq = Math.Round(requiredSavings, 2);
                goalPlanningVo.FutureValueOfCostToday = Math.Round((Double)futureCost, 2);
                goalPlanningVo.LumpsumInvestRequired = Math.Round(lumpsumInvestment, 2);
                goalPlanningVo.FutureValueOnCurrentInvest = Math.Round(futureInvValue, 0);
                return goalPlanningVo;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerGoalPlanningBo.cs:CalculateGoalProfile()");
                object[] objects = new object[1];
                objects[0] = goalPlanningVo;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

        }


        public CustomerGoalPlanningVo CalculateGoalProfileRT(CustomerGoalPlanningVo goalPlanningVo, CustomerAssumptionVo customerAssumptionVo)
        {

            double yearsLeftForRetirement = customerAssumptionVo.RetirementAge - customerAssumptionVo.CustomerAge;
            double amountAfterFirstMonthRetirement;
            double spouseLifeAfterCustomerRet;
            double adjustedInfluation;
            double corpusReqAtTimeOfRetirement;
            double amountToBeSavedPerMonth;
            double futureValueOfCurrentInvestment;

            try
            {
                if (goalPlanningVo.CurrInvestementForGoal == 0 && goalPlanningVo.ROIEarned == 0)
                {
                    futureValueOfCurrentInvestment = 0;

                }
                else
                    futureValueOfCurrentInvestment = Math.Abs(FutureValue(goalPlanningVo.ROIEarned / 100, yearsLeftForRetirement, 0, goalPlanningVo.CurrInvestementForGoal, 1));

                amountAfterFirstMonthRetirement = FutureValue(customerAssumptionVo.InflationPercent / 100, yearsLeftForRetirement, 0, -(goalPlanningVo.CostOfGoalToday * 12), 1);
                if (customerAssumptionVo.SpouseAge != 0 && customerAssumptionVo.SpouseEOL != 0)
                    spouseLifeAfterCustomerRet = customerAssumptionVo.SpouseEOL - customerAssumptionVo.RetirementAge + (customerAssumptionVo.CustomerAge - customerAssumptionVo.SpouseAge);
                else
                    spouseLifeAfterCustomerRet = customerAssumptionVo.CustomerEOL - customerAssumptionVo.RetirementAge;

                adjustedInfluation = ((1 + customerAssumptionVo.PostRetirementReturn / 100) / (1 + customerAssumptionVo.PostRetirementInflation / 100) - 1) * 100;

                if (goalPlanningVo.CorpusLeftBehind == 0)
                {
                    if (spouseLifeAfterCustomerRet > 0)
                        corpusReqAtTimeOfRetirement = PV(adjustedInfluation / 100, spouseLifeAfterCustomerRet, -amountAfterFirstMonthRetirement, 0, 1);
                    else
                        corpusReqAtTimeOfRetirement = PV(adjustedInfluation / 100, -spouseLifeAfterCustomerRet, -amountAfterFirstMonthRetirement, 0, 1);
                }
                else
                {
                    double corpsTobeLeftBehindRetirement = 0;
                    corpsTobeLeftBehindRetirement = PV((customerAssumptionVo.PostRetirementReturn / 100), (customerAssumptionVo.CustomerEOL - customerAssumptionVo.RetirementAge), 0, -goalPlanningVo.CorpusLeftBehind, 1);
                    if (spouseLifeAfterCustomerRet > 0)
                        corpusReqAtTimeOfRetirement = PV(adjustedInfluation / 1200, spouseLifeAfterCustomerRet * 12, -amountAfterFirstMonthRetirement,0, 1);
                    else
                        corpusReqAtTimeOfRetirement = PV(adjustedInfluation / 1200, -(spouseLifeAfterCustomerRet * 12), -amountAfterFirstMonthRetirement, -goalPlanningVo.CorpusLeftBehind, 1);

                    corpusReqAtTimeOfRetirement = corpusReqAtTimeOfRetirement + corpsTobeLeftBehindRetirement;

                }
                double lumpsumInvestment = 0;
                amountToBeSavedPerMonth = PMT(customerAssumptionVo.ReturnOnNewInvestment / 1200, yearsLeftForRetirement * 12, 0, -(corpusReqAtTimeOfRetirement - futureValueOfCurrentInvestment), 1);
                lumpsumInvestment = PV(goalPlanningVo.ExpectedROI / 100, goalPlanningVo.GoalYear - DateTime.Now.Year, 0, -corpusReqAtTimeOfRetirement, 1);

                goalPlanningVo.LumpsumInvestRequired = lumpsumInvestment;
                goalPlanningVo.FutureValueOfCostToday = Math.Round(corpusReqAtTimeOfRetirement);
                goalPlanningVo.MonthlySavingsReq = Math.Round(amountToBeSavedPerMonth, 2);
                //goalPlanningVo.CorpusLeftBehind = customerAssumptionVo.CorpusToBeLeftBehind;
                goalPlanningVo.GoalYear = goalPlanningVo.GoalYear;
                goalPlanningVo.InflationPercent = customerAssumptionVo.InflationPercent;
                goalPlanningVo.FutureValueOnCurrentInvest = Math.Round(futureValueOfCurrentInvestment, 0);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalPlanningBo.cs:CalculateGoalProfileRT()");


                object[] objects = new object[2];
                objects[0] = goalPlanningVo;
                objects[1] = customerAssumptionVo;



                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return goalPlanningVo;

        }


        /// <summary>/// Calculates the present value of a loan based upon constant payments and a constant interest rate.
        /// </summary>
        /// <param name="rate">The interest rate.</param>
        /// <param name="nper">Total number of payments.</param>
        /// <param name="pmt">payment made each period</param>
        /// <param name="fv">Future value.</param>
        /// <param name="type">Indicates when payments are due. 0 = end of period, 1 = beginning of period.</param>
        /// <returns>The Present Value</returns>
        public double PV(double rate, double nper, double pmt, double fv, double type)
        {
            if (rate == 0.0)
                return (-fv - (pmt * nper));
            else
                return (pmt * (1.0 + rate * type) * (1.0 - Math.Pow((1.0 + rate), nper)) / rate - fv) / Math.Pow((1.0 + rate), nper);
        }

        public double FutureValue(double rate, double nper, double pmt, double pv, int type)
        {
            double result = 0;
            result = Financial.FV(rate, nper, pmt, pv, DueDate.BegOfPeriod);
            return result;
        }
        public double NPER(double rate, double pmt, double pv, double fv, int type)
        {
            double result = 0;
            result = Financial.NPer(rate, pmt, pv, fv, DueDate.BegOfPeriod);
            return result;
        }


        public double PMT(double rate, double nper, double pv, double fv, double type)
        {
            double result = 0;
            Math.Round(fv, 2);
            //result = Financial.Pmt(rate, nper, pv, Math.Round(fv, 2), 1);
          result=  Financial.Pmt(rate, nper, pv, -Math.Round(fv, 2), 0);
            return result;
        }


        public DataSet GetCustomerGoalDetails(int CustomerID)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet customerGoalDetailsDS;

            try
            {
                customerGoalDetailsDS = customerGoalPlanningDao.GetCustomerGoalDetails(CustomerID);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalPlanningBo:GetCustomerGoalDetails()");

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
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet customerGoalListDS;

            try
            {
                customerGoalListDS = customerGoalPlanningDao.GetCustomerGoalList(CustomerID);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalPlanningBo:GetCustomerGoalList()");

                object[] objects = new object[1];
                objects[0] = CustomerID;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            return customerGoalListDS;

        }


        public CustomerGoalPlanningVo GetGoalDetails(int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            CustomerGoalPlanningVo goalPlanningVo = new CustomerGoalPlanningVo();

            try
            {
                goalPlanningVo = customerGoalPlanningDao.GetGoalDetails(goalId);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalPlanningBo:GetCustomerGoalList()");

                object[] objects = new object[1];
                objects[0] = goalId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }

            return goalPlanningVo;

        }

        public DataTable GetCustomerFPCalculationBasis(int customerId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataTable dtFPCalculationBasis;

            try
            {
                dtFPCalculationBasis = customerGoalPlanningDao.GetCustomerFPCalculationBasis(customerId);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalPlanningBo:GetCustomerFPCalculationBasis()");


                object[] objects = new object[1];
                objects[0] = customerId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return dtFPCalculationBasis;

        }

        public void CreateCustomerGoalFunding(int goalId, decimal equityAllocatedAmount, decimal debtAllocatedAmount, decimal cashAllocatedAmount, decimal alternateAllocatedAmount, int isloanFunded, decimal loanAmount, DateTime loanStartDate)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();

            try
            {
                customerGoalPlanningDao.CreateCustomerGoalFunding(goalId, equityAllocatedAmount, debtAllocatedAmount, cashAllocatedAmount, alternateAllocatedAmount, isloanFunded, loanAmount, loanStartDate);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerGoalPlanningBo:CreateCustomerGoalFunding()");


                object[] objects = new object[8];
                objects[0] = goalId;
                objects[1] = equityAllocatedAmount;
                objects[2] = debtAllocatedAmount;
                objects[3] = cashAllocatedAmount;
                objects[4] = alternateAllocatedAmount;
                objects[5] = isloanFunded;
                objects[6] = loanAmount;
                objects[7] = loanStartDate;


                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
        }

        public void DeleteCustomerGoalFunding(int goalId, int customerId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            try
            {
                customerGoalPlanningDao.DeleteCustomerGoalFunding(goalId, customerId);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
        }

        public DataSet GetExistingInvestmentDetails(int customerId, int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet dsExistingInvestment = new DataSet();
            try
            {
                dsExistingInvestment = customerGoalPlanningDao.GetExistingInvestmentDetails(customerId, goalId);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return dsExistingInvestment;
        }

        public DataSet GetSIPInvestmentDetails(int customerId, int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet dsSIPInvestment = new DataSet();
            try
            {
                dsSIPInvestment = customerGoalPlanningDao.GetSIPInvestmentDetails(customerId, goalId);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return dsSIPInvestment;
        }


        public void UpdateGoalAllocationPercentage(decimal allocationPercentage, int schemeId, int goalId, decimal investedAmount)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();

            try
            {
                customerGoalPlanningDao.UpdateGoalAllocationPercentage(allocationPercentage, schemeId, goalId, investedAmount);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }

        }


        public void UpdateSIPGoalAllocationAmount(decimal allocationAmount, int sipId, int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();

            try
            {
                customerGoalPlanningDao.UpdateSIPGoalAllocationAmount(allocationAmount, sipId, goalId);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }

        }
        public DataSet BindDDLSchemeAllocated(int customerId, int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet dsBindDDLSchemeAllocated = new DataSet();
            try
            {
                dsBindDDLSchemeAllocated = customerGoalPlanningDao.BindDDLSchemeAllocated(customerId, goalId);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return dsBindDDLSchemeAllocated;
        }

        public DataSet BindDDLSIPSchemeAllocated(int customerId, int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet dsBindDDLSIPSchemeAllocated = new DataSet();
            try
            {
                dsBindDDLSIPSchemeAllocated = customerGoalPlanningDao.BindDDLSIPSchemeAllocated(customerId, goalId);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return dsBindDDLSIPSchemeAllocated;
        }

        //public void CreateCustomerGoalPlanning(global::VoCustomerGoalProfiling.GoalProfileSetupVo goalProfileSetupVo, CustomerAssumptionVo customerAssumptionVo, int ParentCustomerId, bool p)
        //{
        //    throw new NotImplementedException();
        //}

        public void DeleteFundedScheme(int schemeCode, int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet dsBindDDLSIPSchemeAllocated = new DataSet();
            try
            {
                customerGoalPlanningDao.DeleteFundedScheme(schemeCode, goalId);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
        }

        public void DeleteSIPFundedScheme(int sipId, int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();

            try
            {
                customerGoalPlanningDao.DeleteSIPFundedScheme(sipId, goalId);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
        }

        public CustomerGoalFundingProgressVo GetGoalFundingProgressDetails(int goalId, int customerId, int advisorId, out DataSet dsGoalFundingDetails, out DataSet dsExistingInvestment, out DataSet dsSIPInvestment, out CustomerGoalPlanningVo goalPlanningVo, out DataSet dsEquityExistingInvestment)
        {

            CustomerGoalFundingProgressVo customerGoalFundingProgressVo = new CustomerGoalFundingProgressVo();
            //CustomerGoalPlanningVo goalPlanningVo = new CustomerGoalPlanningVo();
            CustomerAssumptionVo customerAssumptionVo = new CustomerAssumptionVo();
            DataTable dtMFFundingDetails = new DataTable();
            DataTable dtSIPFundingDetails = new DataTable();
            double totalInvestedSIPamount = 0;
            DataTable dtExistingInvestment = new DataTable();
            DataTable dtEQFundingDetails = new DataTable();

            //DataSet dsExistingInvestment = new DataSet();
            //DataSet dsSIPInvestment = new DataSet();

            double totalMFFundingInvestedAmount = 0;
            double totalMFSIPFunding = 0;
            double totalMFCurrentValue = 0;
            double totalMFProjectedAmount = 0;
            double totalMFSIPProjectedAmount = 0;
            double totalXIRR = 0;
            double totalequityFunding = 0;

            dtMFFundingDetails = GetGoalMFFundingDetails(goalId, customerId, advisorId, out dtExistingInvestment, out dsExistingInvestment, out customerAssumptionVo, out goalPlanningVo);
            dtSIPFundingDetails = GetGoalSIPFunding(goalId, customerId, out totalInvestedSIPamount, out dsSIPInvestment, ref customerAssumptionVo);
            dtEQFundingDetails = GetGoalEquityFunding(goalId, customerId, out dsEquityExistingInvestment, ref customerAssumptionVo, goalPlanningVo.GoalYear);
            customerGoalFundingProgressVo.WeightedReturn = (double)CalculateweightedReturn(dtMFFundingDetails, dtExistingInvestment, customerAssumptionVo);


            foreach (DataRow dr in dtEQFundingDetails.Rows)
            {
                if (dr["EquityProjectedAmount"].ToString() != "")
                    totalequityFunding = totalequityFunding + double.Parse(dr["EquityProjectedAmount"].ToString());
            }

            foreach (DataRow dr in dtMFFundingDetails.Rows)
            {
                if (dr["AllocatedReturnsXIRR"].ToString() != "")
                {
                    totalXIRR = totalXIRR + double.Parse(dr["AllocatedReturnsXIRR"].ToString());
                }
                if (dr["InvestedAmount"].ToString() != "")
                    totalMFFundingInvestedAmount = totalMFFundingInvestedAmount + double.Parse(dr["InvestedAmount"].ToString());


                if (dr["CurrentValue"].ToString() != "")
                {
                    totalMFCurrentValue = totalMFCurrentValue + double.Parse(dr["CurrentValue"].ToString());
                }

                if (dr["ProjectedAmount"].ToString() != "")
                {
                    totalMFProjectedAmount = totalMFProjectedAmount + double.Parse(dr["ProjectedAmount"].ToString());
                }
                else
                {
                    totalMFProjectedAmount = totalMFProjectedAmount + 0;
                }
            }
            foreach (DataRow dr in dtSIPFundingDetails.Rows)
            {
                totalMFSIPFunding = totalMFSIPFunding + double.Parse(dr["SIPInvestedAmount"].ToString());
                if (dr["SIPProjectedAmount"].ToString() != "")
                    totalMFSIPProjectedAmount = totalMFSIPProjectedAmount + double.Parse(dr["SIPProjectedAmount"].ToString());
            }
            totalMFProjectedAmount = totalMFSIPProjectedAmount + totalMFProjectedAmount + totalequityFunding;

            customerGoalFundingProgressVo.GoalCurrentValue = totalMFCurrentValue;
            customerGoalFundingProgressVo.MonthlyContribution = totalMFSIPFunding;
            customerGoalFundingProgressVo.ProjectedValue = totalMFProjectedAmount;
            customerGoalFundingProgressVo.AmountInvestedTillDate = totalMFFundingInvestedAmount;
            //if (dtMFFundingDetails.Rows.Count > 0)
            //{
            //if (totalMFCurrentValue != 0)
            //{
            double returns = 0;
            double remainingTime = 0;
            if (customerGoalFundingProgressVo.WeightedReturn != 0)
                returns = double.Parse((customerGoalFundingProgressVo.WeightedReturn / 100).ToString());
            if (totalMFProjectedAmount != 0 && goalPlanningVo.ExpectedROI != 0)
                remainingTime = NPER(goalPlanningVo.ExpectedROI / 100, 0, -double.Parse(totalMFProjectedAmount.ToString()), goalPlanningVo.FutureValueOfCostToday, 1);

            int year = 0;
            double month = 0;
            year = (int)remainingTime;
            month = remainingTime - year;
            month = Math.Round((month * 12), 0);
            customerGoalFundingProgressVo.GEstimatedTimeToAchiveGoal = year + " " + "Years" + " " + "/" + " " + month + " " + "Months";
            if ((goalPlanningVo.GoalYear - DateTime.Now.Year) != 0 && goalPlanningVo.ExpectedROI != 0)
            {
                double addInvestmentReq = PMT(goalPlanningVo.ExpectedROI / 100, (goalPlanningVo.GoalYear - DateTime.Now.Year), 0, (totalMFProjectedAmount - goalPlanningVo.FutureValueOfCostToday), 1);
                double addMonthlyInvestmentReq = PMT(goalPlanningVo.ExpectedROI / (12 * 100), (goalPlanningVo.GoalYear - DateTime.Now.Year) * 12, 0, (totalMFProjectedAmount - goalPlanningVo.FutureValueOfCostToday), 1);
                customerGoalFundingProgressVo.AdditionalYearlyRequirement = addInvestmentReq;
                customerGoalFundingProgressVo.AdditionalMonthlyRequirement = addMonthlyInvestmentReq;
            }
            customerGoalFundingProgressVo.ProjectedGapValue = totalMFProjectedAmount - goalPlanningVo.FutureValueOfCostToday;
            customerGoalFundingProgressVo.ReturnsXIRR = Convert.ToDecimal(totalXIRR);
            customerGoalFundingProgressVo.ProjectedEndYear = Math.Round(remainingTime + goalPlanningVo.GoalYear);

            //}
            //}

            dsGoalFundingDetails = new DataSet();
            dsGoalFundingDetails.Tables.Add(dtMFFundingDetails);
            dsGoalFundingDetails.Tables.Add(dtSIPFundingDetails);
            dsGoalFundingDetails.Tables.Add(dtEQFundingDetails);
            return customerGoalFundingProgressVo;

        }

        public DataTable GetGoalMFFundingDetails(int goalId, int customerId, int advisorId, out DataTable dtExistingInvestment, out DataSet dsExistingInvestment, out CustomerAssumptionVo customerAssumptionVo, out CustomerGoalPlanningVo goalPlanningVo)
        {

            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            //CustomerGoalPlanningVo goalPlanningVo = new CustomerGoalPlanningVo();
            //DataSet dsExistingInvestment = new DataSet();

            goalPlanningVo = customerGoalPlanningDao.GetGoalDetails(goalId);
            bool isHavingAssumption;
            customerAssumptionVo = customerGoalPlanningDao.GetCustomerAssumptions(customerId, advisorId, out isHavingAssumption);
            DataTable dtCustomerGoalFundingDetails = new DataTable();
            dtCustomerGoalFundingDetails.Columns.Add("GoalId");
            dtCustomerGoalFundingDetails.Columns.Add("SchemeCode");
            dtCustomerGoalFundingDetails.Columns.Add("SchemeName");
            dtCustomerGoalFundingDetails.Columns.Add("MemberName");
            dtCustomerGoalFundingDetails.Columns.Add("Category");
            dtCustomerGoalFundingDetails.Columns.Add("InvestedAmount");
            dtCustomerGoalFundingDetails.Columns.Add("Units");
            dtCustomerGoalFundingDetails.Columns.Add("CurrentValue");
            dtCustomerGoalFundingDetails.Columns.Add("AllocationEntry");
            dtCustomerGoalFundingDetails.Columns.Add("CurrentGoalAllocation");
            dtCustomerGoalFundingDetails.Columns.Add("OtherGoalAllocation");
            dtCustomerGoalFundingDetails.Columns.Add("ProjectedAmount");
            DataRow drCustomerGoalFundingDetails;
            dtCustomerGoalFundingDetails.Columns.Add("AvailableAllocation");
            dtCustomerGoalFundingDetails.Columns.Add("AvailableAmount");
            dtCustomerGoalFundingDetails.Columns.Add("AllocatedReturnsXIRR");
            dtCustomerGoalFundingDetails.Columns.Add("ReturnsXIRR");


            dsExistingInvestment = customerGoalPlanningDao.GetExistingInvestmentDetails(customerId, goalId);
            //********************************8
            dtExistingInvestment = dsExistingInvestment.Tables[5];

            DataRow[] drExistingInvestmentGoalId = new DataRow[10];
            DataRow[] drExistingInvestmentSchemePlanId;
            DataRow[] drExistingInvestmentCurrentAllocation;
            //DataRow[] drExistingInvestmentAssumptionValue;
            DataRow[] drExistingInvestmentReturnHybridCommodity;
            int schemePlanCode = 0;
            //string assumptionId = "";
            double assumptionValue = 0;
            double futureCost = 0;
            double requiredAfter = 0;
            requiredAfter = goalPlanningVo.GoalYear - DateTime.Now.Year;
            double currentValue = 0;
            decimal currentAllocation = 0;
            double equityAllocation = 0;
            double debtAllocation = 0;
            decimal investedAmount = 0;
            decimal totalInvestedAmount = 0;
            decimal XIRR = 0;

            //foreach(DataRow drGoalId in dsExistingInvestment.Tables[1].Rows)
            //{
            //drExistingInvestmentGoalId = dsExistingInvestment.Tables[1].Select("CG_GoalId=" + goalId.ToString());

            foreach (DataRow drGoalExistingInvestments in dsExistingInvestment.Tables[0].Rows)
            {
                schemePlanCode = int.Parse(drGoalExistingInvestments["PASP_SchemePlanCode"].ToString());
                drExistingInvestmentCurrentAllocation = dsExistingInvestment.Tables[3].Select("PASP_SchemePlanCode=" + schemePlanCode.ToString());

                if (drExistingInvestmentCurrentAllocation.Count() > 0)
                {
                    foreach (DataRow dr in drExistingInvestmentCurrentAllocation)
                    {
                        currentAllocation = decimal.Parse(dr["allocatedPercentage"].ToString());
                    }
                }

                else
                    currentAllocation = 0;
                if (int.Parse(drGoalExistingInvestments["PASP_SchemePlanCode"].ToString()) == schemePlanCode)
                    totalInvestedAmount = totalInvestedAmount + (decimal.Parse(drGoalExistingInvestments["CMFNP_AcqCostExclDivReinvst"].ToString()) * currentAllocation) / 100;
            }

            foreach (DataRow drGoalExistingInvestments in dsExistingInvestment.Tables[0].Rows)
            {
                schemePlanCode = int.Parse(drGoalExistingInvestments["PASP_SchemePlanCode"].ToString());
                drCustomerGoalFundingDetails = dtCustomerGoalFundingDetails.NewRow();
                drExistingInvestmentSchemePlanId = dsExistingInvestment.Tables[2].Select("PASP_SchemePlanCode=" + schemePlanCode.ToString());

                drExistingInvestmentCurrentAllocation = dsExistingInvestment.Tables[3].Select("PASP_SchemePlanCode=" + schemePlanCode.ToString());
                if (drGoalExistingInvestments["PAIC_AssetInstrumentCategoryCode"].ToString() == "Debt")
                {
                    assumptionValue = customerAssumptionVo.ReturnOnDebt / 100;

                }
                else if (drGoalExistingInvestments["PAIC_AssetInstrumentCategoryCode"].ToString() == "Equity")
                {
                    assumptionValue = customerAssumptionVo.ReturnOnEquity / 100;
                }
                else
                {
                    drExistingInvestmentReturnHybridCommodity = dsExistingInvestment.Tables[5].Select("PASP_SchemePlanCode=" + schemePlanCode.ToString());
                    if (drExistingInvestmentReturnHybridCommodity.Count() > 0)
                    {
                        foreach (DataRow dr in drExistingInvestmentReturnHybridCommodity)
                        {
                            if (dr["WAC_AssetClassificationCode"].ToString() == "Equity")
                            {
                                equityAllocation = double.Parse(dr["WACPISSCA_PercentageAllocation"].ToString());
                            }
                            if (dr["WAC_AssetClassificationCode"].ToString() == "Debt")
                            {
                                debtAllocation = double.Parse(dr["WACPISSCA_PercentageAllocation"].ToString());
                            }

                        }
                    }
                    if (debtAllocation != 0 && equityAllocation != 0)
                    {
                        assumptionValue = ((equityAllocation / debtAllocation) * customerAssumptionVo.ReturnOnEquity + (1 - (equityAllocation / debtAllocation)) * customerAssumptionVo.ReturnOnDebt) / 100;
                    }
                    else if (debtAllocation == 0)
                    {
                        assumptionValue = customerAssumptionVo.ReturnOnEquity / 100;
                    }
                    else if (equityAllocation == 0)
                    {
                        assumptionValue = customerAssumptionVo.ReturnOnDebt / 100;
                    }

                }

                //if(assumptionId!="")
                //   drExistingInvestmentAssumptionValue=dsExistingInvestment.Tables[4].Select("WA_AssumptionId='"+assumptionId+"'");


                if (drExistingInvestmentCurrentAllocation.Count() > 0)
                {
                    foreach (DataRow dr in drExistingInvestmentCurrentAllocation)
                    {
                        currentAllocation = decimal.Parse(dr["allocatedPercentage"].ToString());
                    }
                }

                else
                    currentAllocation = 0;
                if (drExistingInvestmentSchemePlanId.Count() > 0)
                {
                    foreach (DataRow drSchemeId in drExistingInvestmentSchemePlanId)
                    {
                        if (decimal.Parse(drSchemeId["allocatedPercentage"].ToString()) <= 100)
                        {
                            drCustomerGoalFundingDetails["GoalId"] = goalId.ToString();
                            drCustomerGoalFundingDetails["MemberName"] = drGoalExistingInvestments["MemberName"].ToString();
                            drCustomerGoalFundingDetails["SchemeName"] = drGoalExistingInvestments["PASP_SchemePlanName"].ToString();
                            drCustomerGoalFundingDetails["SchemeCode"] = drGoalExistingInvestments["PASP_SchemePlanCode"].ToString();

                            currentValue = (double.Parse((decimal.Parse(drGoalExistingInvestments["CMFNP_CurrentValue"].ToString()) * currentAllocation).ToString())) / 100;
                            investedAmount = (decimal.Parse(drGoalExistingInvestments["CMFNP_AcqCostExclDivReinvst"].ToString()) * currentAllocation) / 100;
                            if (totalInvestedAmount != 0)
                            {
                                XIRR = investedAmount / totalInvestedAmount;
                            }
                            else
                            {
                                XIRR = 0;
                            }
                            drCustomerGoalFundingDetails["InvestedAmount"] = String.Format("{0:n2}", Math.Round(((Decimal.Parse(drGoalExistingInvestments["CMFNP_AcqCostExclDivReinvst"].ToString()) * currentAllocation) / 100), 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                            //drGoalExistingInvestments["CMFNP_AcqCostExclDivReinvst"].ToString();
                            drCustomerGoalFundingDetails["Units"] = String.Format("{0:n2}", Math.Round(Decimal.Parse(drGoalExistingInvestments["CMFNP_NetHoldings"].ToString()), 2).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                            drCustomerGoalFundingDetails["CurrentValue"] = String.Format("{0:n2}", Math.Round(((Decimal.Parse(drGoalExistingInvestments["CMFNP_CurrentValue"].ToString()) * currentAllocation) / 100), 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                            drCustomerGoalFundingDetails["AllocationEntry"] = drSchemeId["allocatedPercentage"].ToString();
                            drCustomerGoalFundingDetails["AvailableAllocation"] = 100 - decimal.Parse(drSchemeId["allocatedPercentage"].ToString());
                            drCustomerGoalFundingDetails["CurrentGoalAllocation"] = currentAllocation.ToString();
                            drCustomerGoalFundingDetails["ReturnsXIRR"] = Decimal.Parse(drGoalExistingInvestments["CMFNP_XIRR"].ToString()) != 0 ? Math.Round(double.Parse(String.Format("{0:n2}", Decimal.Parse(drGoalExistingInvestments["CMFNP_XIRR"].ToString()))), 2).ToString() : "0";
                            if (drGoalExistingInvestments["CMFNP_XIRR"].ToString() != "" && drGoalExistingInvestments["CMFNP_XIRR"].ToString() != null)
                            {
                                drCustomerGoalFundingDetails["AllocatedReturnsXIRR"] = (Decimal.Parse(drGoalExistingInvestments["CMFNP_XIRR"].ToString()) * XIRR).ToString();
                            }
                            else
                            {
                                drCustomerGoalFundingDetails["AllocatedReturnsXIRR"] = "0";
                            }
                            if (currentValue != 0)
                            {
                                futureCost = Math.Abs(FutureValue(assumptionValue, requiredAfter, 0, currentValue, 1));
                            }
                            else
                            {
                                futureCost = 0;
                            }
                            drCustomerGoalFundingDetails["OtherGoalAllocation"] = (decimal.Parse(drSchemeId["allocatedPercentage"].ToString()) - currentAllocation).ToString();
                            drCustomerGoalFundingDetails["AvailableAmount"] = String.Format("{0:n2}", Math.Round(((decimal.Parse(drCustomerGoalFundingDetails["AvailableAllocation"].ToString()) / 100) * decimal.Parse(drGoalExistingInvestments["CMFNP_AcqCostExclDivReinvst"].ToString())), 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                            drCustomerGoalFundingDetails["ProjectedAmount"] = String.Format("{0:n2}", Math.Round(futureCost, 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                            drCustomerGoalFundingDetails["Category"] = drGoalExistingInvestments["PAIC_AssetInstrumentCategoryCode"].ToString();
                            dtCustomerGoalFundingDetails.Rows.Add(drCustomerGoalFundingDetails);
                        }

                    }
                }
                else
                {
                    drCustomerGoalFundingDetails["GoalId"] = goalId.ToString();
                    drCustomerGoalFundingDetails["SchemeName"] = drGoalExistingInvestments["PASP_SchemePlanName"].ToString();
                    drCustomerGoalFundingDetails["MemberName"] = drGoalExistingInvestments["MemberName"].ToString();
                    drCustomerGoalFundingDetails["SchemeCode"] = drGoalExistingInvestments["PASP_SchemePlanCode"].ToString();
                    currentValue = (double.Parse((decimal.Parse(drGoalExistingInvestments["CMFNP_CurrentValue"].ToString()) * currentAllocation).ToString())) / 100;
                    drCustomerGoalFundingDetails["InvestedAmount"] = String.Format("{0:n2}", Math.Round(((Decimal.Parse(drGoalExistingInvestments["CMFNP_AcqCostExclDivReinvst"].ToString()) * currentAllocation) / 100), 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                    //drGoalExistingInvestments["CMFNP_AcqCostExclDivReinvst"].ToString();
                    drCustomerGoalFundingDetails["Units"] = String.Format("{0:n2}", Math.Round(Decimal.Parse(drGoalExistingInvestments["CMFNP_NetHoldings"].ToString()), 2).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                    drCustomerGoalFundingDetails["CurrentValue"] = String.Format("{0:n2}", Math.Round(((Decimal.Parse(drGoalExistingInvestments["CMFNP_CurrentValue"].ToString()) * currentAllocation) / 100), 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                    investedAmount = (decimal.Parse(drGoalExistingInvestments["CMFNP_AcqCostExclDivReinvst"].ToString()) * currentAllocation) / 100;

                    if (totalInvestedAmount != 0)
                    {
                        XIRR = investedAmount / totalInvestedAmount;
                    }
                    else
                    {
                        XIRR = 0;
                    }
                    drCustomerGoalFundingDetails["AllocationEntry"] = "0";
                    drCustomerGoalFundingDetails["AvailableAllocation"] = "100";
                    drCustomerGoalFundingDetails["CurrentGoalAllocation"] = currentAllocation.ToString();
                    drCustomerGoalFundingDetails["OtherGoalAllocation"] = "0";
                    drCustomerGoalFundingDetails["ReturnsXIRR"] = Decimal.Parse(drGoalExistingInvestments["CMFNP_XIRR"].ToString()) != 0 ? Math.Round(double.Parse(String.Format("{0:n2}", Decimal.Parse(drGoalExistingInvestments["CMFNP_XIRR"].ToString()))), 2).ToString() : "0";
                    if (drGoalExistingInvestments["CMFNP_XIRR"].ToString() != "" && drGoalExistingInvestments["CMFNP_XIRR"].ToString() != null)
                    {
                        drCustomerGoalFundingDetails["AllocatedReturnsXIRR"] = (Decimal.Parse(drGoalExistingInvestments["CMFNP_XIRR"].ToString()) * XIRR).ToString();
                    }
                    else
                    {
                        drCustomerGoalFundingDetails["AllocatedReturnsXIRR"] = "0";
                    }
                    if (currentValue != 0)
                    {
                        futureCost = Math.Abs(FutureValue(assumptionValue, requiredAfter, 0, currentValue, 1));
                    }
                    else
                    {
                        futureCost = 0;
                    }
                    drCustomerGoalFundingDetails["AvailableAmount"] = String.Format("{0:n2}", Math.Round(((decimal.Parse(drCustomerGoalFundingDetails["AvailableAllocation"].ToString()) / 100) * decimal.Parse(drGoalExistingInvestments["CMFNP_AcqCostExclDivReinvst"].ToString())), 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                    drCustomerGoalFundingDetails["ProjectedAmount"] = String.Format("{0:n2}", Math.Round(futureCost, 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                    drCustomerGoalFundingDetails["Category"] = drGoalExistingInvestments["PAIC_AssetInstrumentCategoryCode"].ToString();
                    dtCustomerGoalFundingDetails.Rows.Add(drCustomerGoalFundingDetails);

                }

            }

            return dtCustomerGoalFundingDetails;

        }


        public DataTable GetGoalSIPFunding(int goalId, int customerId, out double totalInvestedSIPamount, out DataSet dsSIPInvestment, ref CustomerAssumptionVo customerAssumptionVo)
        {

            totalInvestedSIPamount = 0;
            //DataSet dsSIPInvestment=new DataSet();
            DataTable dtCustomerGoalFundingSIPDetails = new DataTable();
            dtCustomerGoalFundingSIPDetails.Columns.Add("GoalId");
            dtCustomerGoalFundingSIPDetails.Columns.Add("SIPId");
            dtCustomerGoalFundingSIPDetails.Columns.Add("SchemeCode");
            dtCustomerGoalFundingSIPDetails.Columns.Add("SchemeName");
            dtCustomerGoalFundingSIPDetails.Columns.Add("MemberName");
            dtCustomerGoalFundingSIPDetails.Columns.Add("SIPInvestedAmount");
            dtCustomerGoalFundingSIPDetails.Columns.Add("TotalSIPamount");
            dtCustomerGoalFundingSIPDetails.Columns.Add("OtherGoalAllocation");
            dtCustomerGoalFundingSIPDetails.Columns.Add("AvailableAllocation");
            dtCustomerGoalFundingSIPDetails.Columns.Add("SIPProjectedAmount");
            dtCustomerGoalFundingSIPDetails.Columns.Add("SIPFrequecny");
            dtCustomerGoalFundingSIPDetails.Columns.Add("SIPStartDate");
            dtCustomerGoalFundingSIPDetails.Columns.Add("SIPEndDate");
            DataRow drCustomerSIPGoalFundingDetails;
            DataRow[] drtotalSIPamount;
            DataRow[] drreturnHybridCommodity;

            decimal currentAllocation = 0;
            double equityAllocation = 0;
            double debtAllocation = 0;
            double assumptionValue = 0;
            int schemePlanCode = 0;

            dsSIPInvestment = GetSIPInvestmentDetails(customerId, goalId);



            foreach (DataRow dr in dsSIPInvestment.Tables[0].Rows)
            {
                if (dr["PASP_SchemePlanCode"].ToString() != "")
                {
                    schemePlanCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                }
                if (dr["PAIC_AssetInstrumentCategoryCode"].ToString() == "Debt")
                {
                    assumptionValue = customerAssumptionVo.ReturnOnDebt / 100;

                }
                else if (dr["PAIC_AssetInstrumentCategoryCode"].ToString() == "Equity")
                {
                    assumptionValue = customerAssumptionVo.ReturnOnEquity / 100;
                }
                else
                {
                    drreturnHybridCommodity = dsSIPInvestment.Tables[3].Select("PASP_SchemePlanCode=" + schemePlanCode.ToString());
                    if (drreturnHybridCommodity.Count() > 0)
                    {
                        foreach (DataRow drhyCo in drreturnHybridCommodity)
                        {
                            if (drhyCo["WAC_AssetClassificationCode"].ToString() == "Equity")
                            {
                                equityAllocation = double.Parse(drhyCo["WACPISSCA_PercentageAllocation"].ToString());
                            }
                            if (drhyCo["WAC_AssetClassificationCode"].ToString() == "Debt")
                            {
                                debtAllocation = double.Parse(drhyCo["WACPISSCA_PercentageAllocation"].ToString());
                            }

                        }
                    }
                    assumptionValue = ((equityAllocation / 100) * customerAssumptionVo.ReturnOnEquity + (debtAllocation / 100) * customerAssumptionVo.ReturnOnDebt) / 100;

                }

                int sipId = int.Parse(dr["CMFSS_SystematicSetupId"].ToString());
                foreach (DataRow drTotalSIPInvestment in dsSIPInvestment.Tables[1].Rows)
                {
                    drtotalSIPamount = dsSIPInvestment.Tables[1].Select("CMFSS_SystematicSetupId=" + sipId.ToString());
                    if (drtotalSIPamount.Count() > 0)
                    {
                        foreach (DataRow drtotalSIPAmount in drtotalSIPamount)
                        {
                            totalInvestedSIPamount = double.Parse(drtotalSIPAmount["TotalInvestedAmount"].ToString());
                        }
                    }

                    else
                        totalInvestedSIPamount = 0;
                }

                DateTime sipEndDate = DateTime.Parse(dr["CMFSS_EndDate"].ToString());
                DateTime sipStartDate = DateTime.Parse(dr["CMFSS_StartDate"].ToString());
                int goalYear = int.Parse(dr["CG_GoalYear"].ToString());
                DateTime now = DateTime.Now;
                int remainingYear = 0;
                double noOfPayments = 0;
                double interestrate = 0;
                double valueTillDate = 0;
                double projectedAmount = 0;
                string frequencyCode = dr["XF_FrequencyCode"].ToString();
                interestrate = CalculateValuebasedOnFrequency(frequencyCode, assumptionValue);
                if (sipEndDate.Year < goalYear)
                {
                    if (sipStartDate.Year < now.Year)
                    {
                        remainingYear = sipEndDate.Year - now.Year;
                    }
                    else
                    {
                        remainingYear = sipEndDate.Year - sipStartDate.Year;
                    }
                    noOfPayments = CalculateYearValuebasedOnFrequency(frequencyCode, remainingYear);
                    if (totalInvestedSIPamount != 0)
                        valueTillDate = FutureValue(interestrate, noOfPayments, -totalInvestedSIPamount, 0, 0);
                    else
                        valueTillDate = 0;
                    remainingYear = goalYear - sipEndDate.Year;
                    if (valueTillDate != 0)
                        projectedAmount = valueTillDate + FutureValue(assumptionValue, remainingYear, 0, -valueTillDate, 0);
                    else
                        projectedAmount = 0;

                }
                if (sipEndDate.Year > goalYear)
                {
                    if (sipStartDate.Year < now.Year)
                    {
                        remainingYear = goalYear - now.Year;
                    }
                    else
                    {
                        remainingYear = goalYear - sipStartDate.Year;
                    }
                    noOfPayments = CalculateYearValuebasedOnFrequency(frequencyCode, remainingYear);
                    projectedAmount = valueTillDate + FutureValue(interestrate, noOfPayments, -totalInvestedSIPamount, 0, 0);
                }


                drCustomerSIPGoalFundingDetails = dtCustomerGoalFundingSIPDetails.NewRow();
                drCustomerSIPGoalFundingDetails["GoalId"] = dr["CG_GoalId"].ToString();
                drCustomerSIPGoalFundingDetails["MemberName"] = dr["MemberName"].ToString();
                drCustomerSIPGoalFundingDetails["SIPId"] = dr["CMFSS_SystematicSetupId"].ToString();
                drCustomerSIPGoalFundingDetails["SchemeCode"] = dr["PASP_SchemePlanCode"].ToString();
                drCustomerSIPGoalFundingDetails["SchemeName"] = dr["PASP_SchemePlanName"].ToString();
                drCustomerSIPGoalFundingDetails["SIPFrequecny"] = dr["XF_Frequency"].ToString();
                drCustomerSIPGoalFundingDetails["SIPStartDate"] = DateTime.Parse(dr["CMFSS_StartDate"].ToString()).ToShortDateString();
                drCustomerSIPGoalFundingDetails["SIPEndDate"] = DateTime.Parse(dr["CMFSS_EndDate"].ToString()).ToShortDateString();
                drCustomerSIPGoalFundingDetails["SIPInvestedAmount"] = double.Parse(dr["InvestedAmount"].ToString()) != 0 ? String.Format("{0:n2}", Math.Round(double.Parse(dr["InvestedAmount"].ToString()), 0).ToString()) : "0";
                drCustomerSIPGoalFundingDetails["OtherGoalAllocation"] = totalInvestedSIPamount - double.Parse(dr["InvestedAmount"].ToString()) != 0 ? String.Format("{0:n2}", Math.Round((totalInvestedSIPamount - double.Parse(dr["InvestedAmount"].ToString())), 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"))) : "0"; ; ;
                drCustomerSIPGoalFundingDetails["AvailableAllocation"] = double.Parse(dr["CMFSS_Amount"].ToString()) - totalInvestedSIPamount != 0 ? String.Format("{0:n2}", Math.Round((double.Parse(dr["CMFSS_Amount"].ToString()) - totalInvestedSIPamount), 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"))) : "0"; ;
                drCustomerSIPGoalFundingDetails["TotalSIPamount"] = double.Parse(dr["CMFSS_Amount"].ToString()) != 0 ? String.Format("{0:n2}", Math.Round(double.Parse(dr["CMFSS_Amount"].ToString()), 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"))) : "0";
                drCustomerSIPGoalFundingDetails["SIPProjectedAmount"] = projectedAmount != 0 ? String.Format("{0:n2}", Math.Round(projectedAmount, 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"))) : "0";

                dtCustomerGoalFundingSIPDetails.Rows.Add(drCustomerSIPGoalFundingDetails);
            }

            return dtCustomerGoalFundingSIPDetails;


        }

        public double CalculateValuebasedOnFrequency(string frequencyCode, double assumptionValue)
        {
            switch (frequencyCode)
            {
                case "AM":
                    break;
                case "DA":
                    assumptionValue = assumptionValue / 365;
                    break;
                case "FN":
                    assumptionValue = assumptionValue / 26;
                    break;
                case "HY":
                    assumptionValue = assumptionValue / 2;
                    break;
                case "MN":
                    assumptionValue = assumptionValue / 12;
                    break;
                case "NA":
                    break;
                case "QT":
                    assumptionValue = assumptionValue / 4;
                    break;
                case "WK":
                    assumptionValue = assumptionValue / 52;
                    break;
                case "YR":
                    break;
            }

            return assumptionValue;

        }

        protected decimal CalculateweightedReturn(DataTable dtCustomerGoalFunding, DataTable dtExistingInvestment, CustomerAssumptionVo customerAssumptionVo)
        {
            decimal equityAmount = 0;
            decimal debtAmount = 0;
            decimal hybridCommodityAmount = 0;
            decimal totalInvestedAmount = 0;
            decimal investedAmount = 0;
            double equityAllocation = 0;
            double debtAllocation = 0;
            int schemePlanCode = 0;
            decimal weightedReturn = 0;
            //double hybridCommodityAllocation;
            DataRow[] drExistingInvestmentReturnHybridCommodity;
            if (dtCustomerGoalFunding.Rows.Count > 0)
            {
                foreach (DataRow dr in dtCustomerGoalFunding.Rows)
                {
                    if (dr["InvestedAmount"].ToString() == "")
                    {
                        investedAmount = 0;
                    }
                    else
                    {
                        investedAmount = decimal.Parse(dr["InvestedAmount"].ToString());
                    }
                    schemePlanCode = int.Parse(dr["SchemeCode"].ToString());
                    if (dr["Category"].ToString() == "Equity")
                    {
                        equityAmount = equityAmount + investedAmount;
                    }
                    else if (dr["Category"].ToString() == "Debt")
                    {
                        debtAmount = debtAmount + investedAmount;
                    }
                    else
                    {
                        hybridCommodityAmount = hybridCommodityAmount + investedAmount;
                        drExistingInvestmentReturnHybridCommodity = dtExistingInvestment.Select("PASP_SchemePlanCode=" + schemePlanCode.ToString());
                        if (drExistingInvestmentReturnHybridCommodity.Count() > 0)
                        {
                            foreach (DataRow drReturnHybridCommodity in drExistingInvestmentReturnHybridCommodity)
                            {
                                if (drReturnHybridCommodity["WAC_AssetClassificationCode"].ToString() == "Equity")
                                {
                                    equityAllocation = double.Parse(drReturnHybridCommodity["WACPISSCA_PercentageAllocation"].ToString());
                                    equityAmount = equityAmount + (investedAmount * decimal.Parse(equityAllocation.ToString())) / 100;
                                    debtAmount = debtAmount + (investedAmount * (100 - decimal.Parse(equityAllocation.ToString()))) / 100;
                                }
                                if (drReturnHybridCommodity["WAC_AssetClassificationCode"].ToString() == "Debt")
                                {
                                    debtAllocation = double.Parse(drReturnHybridCommodity["WACPISSCA_PercentageAllocation"].ToString());
                                    debtAmount = debtAmount + (investedAmount * decimal.Parse(debtAllocation.ToString())) / 100;
                                    equityAmount = equityAmount + (investedAmount * (100 - decimal.Parse(debtAllocation.ToString()))) / 100;

                                }

                            }
                        }
                    }
                    totalInvestedAmount = equityAmount + debtAmount + hybridCommodityAmount;
                }
                if (totalInvestedAmount != 0)
                {
                    weightedReturn = (equityAmount / totalInvestedAmount) * decimal.Parse(customerAssumptionVo.ReturnOnEquity.ToString()) + (debtAmount / totalInvestedAmount) * decimal.Parse(customerAssumptionVo.ReturnOnDebt.ToString());
                }
            }

            return weightedReturn;
        }


        public double CalculateYearValuebasedOnFrequency(string frequencyCode, double year)
        {
            switch (frequencyCode)
            {
                case "AM":
                    break;
                case "DA":
                    year = year * 365;
                    break;
                case "FN":
                    year = year * 26;
                    break;
                case "HY":
                    year = year * 2;
                    break;
                case "MN":
                    year = year * 12;

                    break;
                case "NA":

                    break;
                case "QT":
                    year = year * 4;
                    break;
                case "WK":
                    year = year * 52;
                    break;
                case "YR":
                    break;
            }

            return year;

        }

        public double GetLoanOutstandingForLiabilities(string frequencyCode, double loanAmount, DateTime startDate, DateTime endDate, int paymentOption, double installmentAmount, double noOfInstallments, double rate)
        {
            double outstandingLoanAmount = 0;
            DateTime currentDate = DateTime.Today;
            double effectiveRate;
            TimeSpan tsDateDiff = new TimeSpan();
            //int noOfRemainingInstallments = 0;
            double months = 0;
            int frequencyCount = 0;

            if (paymentOption == 1)
            {
                outstandingLoanAmount = loanAmount;
            }
            else
            {
                if (startDate <= currentDate && currentDate <= endDate)
                {
                    tsDateDiff = currentDate.Subtract(startDate);
                    months = tsDateDiff.Days / 30.4375;

                    switch (frequencyCode)
                    {
                        case "MN":
                            //noOfRemainingInstallments = noOfInstallments - months;
                            frequencyCount = 12;
                            break;
                        case "QT":
                            //noOfRemainingInstallments = noOfInstallments - (months / 3);
                            frequencyCount = 4;
                            months = months / 3;
                            break;

                        case "HY":
                            //noOfRemainingInstallments = noOfInstallments - (months / 6);
                            frequencyCount = 2;
                            months = months / 6;
                            break;

                        case "YR":
                            //noOfRemainingInstallments = noOfInstallments - (months / 12);
                            frequencyCount = 1;
                            months = months / 12;
                            break;
                    }

                    double noOfIns = 0;
                    noOfIns = frequencyCount;
                    if (rate != 0)
                    {
                        effectiveRate = (Math.Pow((1 + (rate / 100) / noOfIns), noOfIns)) - 1;
                    }
                    else
                    {
                        effectiveRate = (Math.Pow((1), noOfIns)) - 1;
                    }
                    double effectiveRatePerPeriod = Math.Pow(1 + effectiveRate, 1 / noOfIns) - 1;

                    //outstandingLoanAmount = Financial.IPmt(
                    if (rate != 0)
                    {
                        outstandingLoanAmount = Financial.IPmt(effectiveRatePerPeriod, Math.Round(months, 0) + 2, noOfInstallments, -loanAmount, 0, DueDate.EndOfPeriod) / effectiveRatePerPeriod;
                    }
                    else
                    {
                        outstandingLoanAmount =0;
                    }
                }
            }
            return outstandingLoanAmount;
        }
        public DataSet BindDDLFamilyMembers(int CustomerID)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet dsFamilyMembers = new DataSet();
            dsFamilyMembers = customerGoalPlanningDao.BindDDLFamilyMembers(CustomerID);

            return dsFamilyMembers;

        }

        public DataSet BindDDLScripsAllocated(int CustomerID, int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet dsFamilyMembers = new DataSet();
            dsFamilyMembers = customerGoalPlanningDao.BindDDLScripsAllocated(CustomerID, goalId);

            return dsFamilyMembers;
        }

        public void UpdateEquityGoalAllocation(decimal allocationAmount, int eqId, int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();

            try
            {
                customerGoalPlanningDao.UpdateEquityGoalAllocation(allocationAmount, eqId, goalId);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }

        }

        //--------------*******************************Equity DataSet Creation***********************-------------------\\

        public DataTable GetGoalEquityFunding(int goalId, int customerId, out DataSet dsEquityInvestment, ref CustomerAssumptionVo customerAssumptionVo, int goalYear)
        {
            //DataSet dsSIPInvestment=new DataSet();
            DataTable dtCustomerGoalFundingSIPDetails = new DataTable();
            dtCustomerGoalFundingSIPDetails.Columns.Add("GoalId"); //Done
            dtCustomerGoalFundingSIPDetails.Columns.Add("CENPS_Id");//Done
            dtCustomerGoalFundingSIPDetails.Columns.Add("PEM_ScripCode");//Done
            dtCustomerGoalFundingSIPDetails.Columns.Add("MemberName");
            dtCustomerGoalFundingSIPDetails.Columns.Add("PEM_CompanyName");//Done
            dtCustomerGoalFundingSIPDetails.Columns.Add("AvailableShares");
            dtCustomerGoalFundingSIPDetails.Columns.Add("CurrentValue");
            dtCustomerGoalFundingSIPDetails.Columns.Add("AllocatedShares");
            dtCustomerGoalFundingSIPDetails.Columns.Add("TotalHoldingEquityShares");
            dtCustomerGoalFundingSIPDetails.Columns.Add("OtherEquityGoalAllocation");
            dtCustomerGoalFundingSIPDetails.Columns.Add("EquityProjectedAmount");
            dtCustomerGoalFundingSIPDetails.Columns.Add("EquityNetCost");
            dtCustomerGoalFundingSIPDetails.Columns.Add("TotalSharesAllocation");
            dtCustomerGoalFundingSIPDetails.Columns.Add("AvailableSharesforCurrentGoal");            

            DataRow drCustomerEquityGoalFundingDetails;
            DataRow[] drtotalEquityShares;
            DataRow[] drreturnHybridCommodity;

            double totalOtherAllocation = 0;
            double currentAllocation = 0;
            double totalEquityAmount = 0;
            double totalAllocation = 0;

            double TotalHoldingEquityShares = 0;
            double currentEQValue = 0;
            dsEquityInvestment = GetEquityFundedDetails(customerId, goalId);

            DataRow[] drOtherInvestmentEquity;
            DataRow[] drEquityCurrentInvestment;
            DataRow[] drTotalEquityamount;

            foreach (DataRow dr in dsEquityInvestment.Tables[0].Rows)
            {
                int remainingYear = 0;
                int eqId = int.Parse(dr["CENPS_Id"].ToString());
                if (DateTime.Now.Year < goalYear)
                {
                    remainingYear = goalYear - DateTime.Now.Year;
                }
                else
                    remainingYear = 0;


                drtotalEquityShares = dsEquityInvestment.Tables[3].Select("CENPS_Id=" + eqId.ToString());
                if (drtotalEquityShares.Count() > 0)
                {
                    foreach (DataRow drtotalEQShares in drtotalEquityShares)
                    {
                        TotalHoldingEquityShares = double.Parse(drtotalEQShares["CENP_NetHoldings"].ToString());
                        currentEQValue = double.Parse(drtotalEQShares["CENP_CurrentValue"].ToString());
                    }
                }


                drOtherInvestmentEquity = dsEquityInvestment.Tables[1].Select("CENPS_Id=" + eqId.ToString());
                drEquityCurrentInvestment = dsEquityInvestment.Tables[2].Select("CENPS_Id=" + eqId.ToString());

                if (drOtherInvestmentEquity.Count() > 0)
                {
                    foreach (DataRow dreq in drOtherInvestmentEquity)
                    {
                        totalAllocation = double.Parse(dreq["CEESTGA_AllocatedShares"].ToString());
                    }
                }

                if (drEquityCurrentInvestment.Count() > 0)
                {
                    foreach (DataRow dreq in drEquityCurrentInvestment)
                    {
                        currentAllocation = double.Parse(dreq["CEESTGA_AllocatedShares"].ToString());
                    }
                }

                double projectedAmount = 0;

                projectedAmount = Math.Abs(FutureValue(customerAssumptionVo.ReturnOnEquity, remainingYear, 0, currentAllocation, 1));
                drCustomerEquityGoalFundingDetails = dtCustomerGoalFundingSIPDetails.NewRow();
                drCustomerEquityGoalFundingDetails["GoalId"] = goalId;
                drCustomerEquityGoalFundingDetails["CENPS_Id"] = dr["CENPS_Id"].ToString();
                drCustomerEquityGoalFundingDetails["MemberName"] = dr["MemberName"].ToString();
                drCustomerEquityGoalFundingDetails["PEM_ScripCode"] = dr["PEM_ScripCode"].ToString();
                drCustomerEquityGoalFundingDetails["CurrentValue"] = Math.Round(currentEQValue,0).ToString();
                drCustomerEquityGoalFundingDetails["TotalSharesAllocation"] =Math.Round(totalAllocation,0).ToString();
                drCustomerEquityGoalFundingDetails["PEM_CompanyName"] = dr["PEM_CompanyName"].ToString();
                drCustomerEquityGoalFundingDetails["AvailableShares"] = double.Parse(dr["CENP_NetHoldings"].ToString()) - totalAllocation != 0 ? String.Format("{0:n2}", Math.Round(double.Parse(dr["CENP_NetHoldings"].ToString()) - totalAllocation, 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"))) : "0";
                drCustomerEquityGoalFundingDetails["OtherEquityGoalAllocation"] = (totalAllocation - currentAllocation) != 0 ? String.Format("{0:n2}", Math.Round((totalAllocation - currentAllocation), 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"))) : "0"; ; ;
                drCustomerEquityGoalFundingDetails["AllocatedShares"] = Math.Round(currentAllocation, 0).ToString();
                drCustomerEquityGoalFundingDetails["TotalHoldingEquityShares"] = double.Parse(dr["CENP_NetHoldings"].ToString()) != 0 ? String.Format("{0:n2}", Math.Round(double.Parse(dr["CENP_NetHoldings"].ToString()), 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"))) : "0";
                drCustomerEquityGoalFundingDetails["EquityProjectedAmount"] = projectedAmount != 0 ? String.Format("{0:n2}", Math.Round(projectedAmount, 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"))) : "0";
                drCustomerEquityGoalFundingDetails["EquityNetCost"] = currentAllocation != 0 ? String.Format("{0:n2}", Math.Round(currentAllocation, 0).ToString("#,#", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"))) : "0"; ;
                drCustomerEquityGoalFundingDetails["AvailableSharesforCurrentGoal"] = Math.Round((TotalHoldingEquityShares - (totalAllocation - currentAllocation)),0).ToString();
                
                dtCustomerGoalFundingSIPDetails.Rows.Add(drCustomerEquityGoalFundingDetails);
            }

            return dtCustomerGoalFundingSIPDetails;
        }
        public DataSet GetEquityFundedDetails(int CustomerID, int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet dsEqFundedDetails = new DataSet();
            dsEqFundedDetails = customerGoalPlanningDao.GetEquityFundedDetails(CustomerID, goalId);

            return dsEqFundedDetails;

        }
        public void DeleteEqFundedScheme(int eqId, int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();

            try
            {
                customerGoalPlanningDao.DeleteEqFundedScheme(eqId, goalId);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
        }

        public DataSet BindGoalDetails(int goalId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet ds = new DataSet();
            ds = customerGoalPlanningDao.BindGoalDetails(goalId);
            return ds;
        }
        public DataSet BindBondAllotedIssue(int customerId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet ds = new DataSet();
            ds = customerGoalPlanningDao.BindBondAllotedIssue(customerId);
            return ds;
        }
        public DataSet BindBondAllotedCategoryForCustomer(int customerId, int issueId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet ds = new DataSet();
            ds = customerGoalPlanningDao.BindBondAllotedCategoryForCustomer(customerId,issueId);
            return ds;
        }
        public DataSet BindBondSeriesAllotmentDetails(int customerId, int issueId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet ds = new DataSet();
            ds = customerGoalPlanningDao.BindBondSeriesAllotmentDetails(customerId, issueId);
            return ds;
        }
        public DataSet BindBondAllotedOrderQuentity(int customerId, int issueId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet ds = new DataSet();
            ds = customerGoalPlanningDao.BindBondAllotedOrderQuentity(customerId, issueId);
            return ds;
        }
        public bool BondOrderAssociateToGoal(int goalId, int AllotedQuentity, int IssueDetailId, int AIDCSR_Id, int InvestorCatgeoryId, int IssueId)
        {
            bool result = false;
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            result = customerGoalPlanningDao.BondOrderAssociateToGoal(goalId, AllotedQuentity, IssueDetailId, AIDCSR_Id, InvestorCatgeoryId, IssueId);
            return result;
        }
        public string GetAdviserIssueCategory(int IssueId)
        {
            string ProductType = string.Empty;
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            ProductType = customerGoalPlanningDao.GetAdviserIssueCategory(IssueId);
            return ProductType;
        }
        public DataSet BindBondGoalAssociateQuentity(int goalId, int issueId, int seriesId)
        {
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            DataSet ds = new DataSet();
            ds = customerGoalPlanningDao.BindBondGoalAssociateQuentity(goalId, issueId, seriesId);
            return ds;
        }
        public bool BondOrderAssociateToGoalUpdate(int goalId, int AllotedQuentity, int IssueDetailId, int AIDCSR_Id, int InvestorCatgeoryId, int IssueId)
        {
            bool result = false;
            CustomerGoalPlanningDao customerGoalPlanningDao = new CustomerGoalPlanningDao();
            result = customerGoalPlanningDao.BondOrderAssociateToGoalUpdate(goalId, AllotedQuentity, IssueDetailId, AIDCSR_Id, InvestorCatgeoryId, IssueId);
            return result;
        }
    }
}
