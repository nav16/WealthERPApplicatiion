﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BoCommon;
using VoUser;
using System.Configuration;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;
using BoCustomerPortfolio;
using System.Globalization;
using BoCustomerProfiling;
using WealthERP.Base;
using VoCustomerPortfolio;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;
using VoAdvisorProfiling;
using System.Collections;
using Telerik.Web.UI.GridExcelBuilder;

namespace WealthERP.CustomerPortfolio
{
    public partial class RMMultipleTransactionView : System.Web.UI.UserControl
    {

        AdvisorVo advisorVo = new AdvisorVo();
        RMVo rmVo = new RMVo();
        string userType;
        string path = string.Empty;
        CustomerTransactionBo customerTransactionBo = new CustomerTransactionBo();
        CustomerBo customerBo = new CustomerBo();
        CustomerVo customerVo = new CustomerVo();
        UserVo userVo = new UserVo();
        int GroupHead = 0;
        int customerId=0;
        List<MFTransactionVo> mfTransactionList = null;
        MFTransactionVo mfTransactionVo = new MFTransactionVo();
        List<MFTransactionVo> mfBalanceList = null;
        MFTransactionVo mfBalanceVo = new MFTransactionVo();
        DateTime dtTo = new DateTime();
        DateBo dtBo = new DateBo();
        DateTime dtFrom = new DateTime();
        static DateTime convertedFromDate = new DateTime();
        static DateTime convertedToDate = new DateTime();
        static double totalAmount = 0;
        static double totalUnits = 0;
        int PasssedFolioValue = 0;
        bool GridViewCultureFlag = true;
        String DisplayType;
        Hashtable ht = new Hashtable();
        int schemePlanCode=0;
        AdvisorPreferenceVo advisorPrefrenceVo = new AdvisorPreferenceVo();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                SessionBo.CheckSession();
                this.Page.Culture = "en-GB";
                userVo = (UserVo)Session["userVo"];
                advisorPrefrenceVo = (AdvisorPreferenceVo)Session["AdvisorPreferenceVo"];
                advisorVo = (AdvisorVo)Session[SessionContents.AdvisorVo];
                rmVo = (RMVo)Session[SessionContents.RmVo];

                path = Server.MapPath(ConfigurationManager.AppSettings["xmllookuppath"].ToString());

                if (Session[SessionContents.CurrentUserRole].ToString().ToLower() == "admin")
                    userType = "advisor";

                else if (Session[SessionContents.CurrentUserRole].ToString().ToLower() == "rm")
                    userType = "rm";
                else if (Session["IsCustomerDrillDown"] != null)
                {
                    userType = "Customer";
                    
                }
                //else if (Session[SessionContents.CurrentUserRole].ToString().ToLower() == "Customer")
                //    userType = "Customer";
                else
                    userType = Session[SessionContents.CurrentUserRole].ToString().ToLower();

                customerVo = (CustomerVo)Session["CustomerVo"];
                if (Session["CustomerVo"] != null)
                {
                    customerId = customerVo.CustomerId;
                    trRangeNcustomer.Visible = false;
                    //trRange.Visible = false;
                   
                }

                if (!IsPostBack)
                {

                    if (Session["CustomerVo"] != null)
                    {
                        ddlDisplayType.Items.RemoveAt(2);
                    }

                    Cache.Remove("ViewTrailCommissionDetails" + advisorVo.advisorId);
                    trGroupHead.Visible = false;
                    hdnProcessIdSearch.Value = "0";
                    //Panel2.Visible = false;
                   // Panel1.Visible = false;
                    gvMFTransactions.Visible = false;
                    gvBalanceView.Visible = false;
                    gvTrail.Visible = false;
                    //divTrail.Visible = false;
                   
                    hdnSchemeSearch.Value = string.Empty;
                    hdnTranType.Value = string.Empty;
                    hdnCustomerNameSearch.Value = string.Empty;
                    hdnFolioNumber.Value = string.Empty;
                    hdnCategory.Value = string.Empty;
                    hdnAMC.Value = "0";
                    rbtnPickDate.Checked = true;
                    rbtnPickPeriod.Checked = false;
                    trRange.Visible = true;
                    trPeriod.Visible = false;
                    //tdGroupHead.Visible = false;
                    //lblGroupHead.Visible = false;
                    //txtParentCustomer.Visible = false;
                    


                    if (Session[SessionContents.CurrentUserRole].ToString() == "RM")
                    {
                        txtParentCustomer_autoCompleteExtender.ContextKey = rmVo.RMId.ToString();
                        txtParentCustomer_autoCompleteExtender.ServiceMethod = "GetParentCustomerName";
                    }
                    else if (Session[SessionContents.CurrentUserRole].ToString() == "Admin" || Session[SessionContents.CurrentUserRole].ToString().ToLower() == "ops")
                    {
                        txtParentCustomer_autoCompleteExtender.ContextKey = advisorVo.advisorId.ToString();
                        txtParentCustomer_autoCompleteExtender.ServiceMethod = "GetAdviserGroupCustomerName";

                    }
                    else if (Session[SessionContents.CurrentUserRole].ToString() == "BM")
                    {
                        txtParentCustomer_autoCompleteExtender.ContextKey = rmVo.RMId.ToString();
                        txtParentCustomer_autoCompleteExtender.ServiceMethod = "GetBMParentCustomerNames";

                    }

                    if (Request.QueryString["folionum"] != null)
                    {
                        int accountId = int.Parse(Request.QueryString["folionum"].ToString());
                        PasssedFolioValue = accountId;


                        BindLastTradeDate();
                        string fromdate = "01-01-1990";
                        txtFromDate.SelectedDate = DateTime.Parse(fromdate);
                    }
                    else
                    {
                        BindLastTradeDate();
                    }
                    if (Session["tranDates"] != null)
                    {
                        ht = (Hashtable)Session["tranDates"];
                        txtFromDate.SelectedDate = DateTime.Parse(ht["From"].ToString());
                        txtToDate.SelectedDate = DateTime.Parse(ht["To"].ToString());
                        schemePlanCode = Convert.ToInt32(ht["SchemePlanCode"].ToString());
                        PasssedFolioValue = Convert.ToInt32(ht["Account"].ToString());
                        BindGrid(DateTime.Parse((txtFromDate.SelectedDate).ToString()), DateTime.Parse((txtToDate.SelectedDate).ToString()));
                        Session.Remove("tranDates");
                        hdnExportType.Value = "TV";
                    }

                    //if (Session["tranDates"] != null)
                    //{
                    //    ht = (Hashtable)Session["tranDates"];
                    //    txtFromDate.SelectedDate = DateTime.Parse(ht["From"].ToString());
                    //    txtToDate.SelectedDate = DateTime.Parse(ht["To"].ToString());
                    //    BindGrid(DateTime.Parse((txtFromDate.SelectedDate).ToString()), DateTime.Parse((txtToDate.SelectedDate).ToString()));
                    //    Session.Remove("tranDates");
                    //}
                    //else
                    //{
                    //    txtFromDate.SelectedDate = DateTime.Now;
                    //    txtToDate.SelectedDate = DateTime.Now;
                    //    BindGrid(DateTime.Parse((txtFromDate.SelectedDate).ToString()), DateTime.Parse((txtToDate.SelectedDate).ToString()));
                    //}
                   
                    ErrorMessage.Visible = false;
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

                FunctionInfo.Add("Method", "RMMultipleTransactionView.ascx:PageLoad()");

                object[] objects = new object[2];
                objects[0] = advisorVo;
                objects[1] = path;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
        }

        private void BindLastTradeDate()
        {
            DataSet ds = customerTransactionBo.GetLastTradeDate();
            txtFromDate.SelectedDate = DateTime.Parse(ds.Tables[0].Rows[0][0].ToString());
            txtToDate.SelectedDate = DateTime.Parse(ds.Tables[0].Rows[0][0].ToString());

        }

        protected void rbtnDate_CheckedChanged(object sender, EventArgs e)
        {
            if (rbtnPickDate.Checked == true)
            {
                trRange.Visible = true;
                trPeriod.Visible = false;
            }
            else if (rbtnPickPeriod.Checked == true)
            {
                trRange.Visible = false;
                trPeriod.Visible = true;
                BindPeriodDropDown();
            }
        }

        private void BindPeriodDropDown()
        {
            DataTable dtPeriod;
            dtPeriod = XMLBo.GetDatePeriod(path);

            ddlPeriod.DataSource = dtPeriod;
            ddlPeriod.DataTextField = "PeriodType";
            ddlPeriod.DataValueField = "PeriodCode";
            ddlPeriod.DataBind();
            ddlPeriod.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select a Period", "Select a Period"));
            ddlPeriod.Items.RemoveAt(15);
        }



        protected void rbtnAll_CheckedChanged(object sender, EventArgs e)
        {
            if (rbtnAll.Checked == true)
            {
                //lblGroupHead.Visible = false;
                //txtParentCustomer.Visible = false;
                //tdGroupHead.Visible = false;
                trGroupHead.Visible = false;

            }
            else if (rbtnGroup.Checked == true)
            {
                //lblGroupHead.Visible = true;
                //txtParentCustomer.Visible = true;
                //tdGroupHead.Visible = true;
                trGroupHead.Visible = true;
                BindGroupHead();

            }
        }

        private void BindGroupHead()
        {

        }
        protected void btnGo_Click(object sender, EventArgs e)
        {
            DisplayType = ddlDisplayType.SelectedValue;
            hdnSchemeSearch.Value = string.Empty;
            hdnTranType.Value = string.Empty;
            hdnCustomerNameSearch.Value = string.Empty;
            hdnFolioNumber.Value = string.Empty;
            hdnProcessIdSearch.Value = "0";
            if (rbtnPickDate.Checked)
            {
                convertedFromDate = Convert.ToDateTime(txtFromDate.SelectedDate);
                convertedToDate = Convert.ToDateTime(txtToDate.SelectedDate);
            }
            else
            {
                if (ddlPeriod.SelectedIndex != 0)
                {
                    dtBo.CalculateFromToDatesUsingPeriod(ddlPeriod.SelectedValue, out dtFrom, out dtTo);
                    convertedFromDate = dtFrom;
                    convertedToDate = dtTo;
                }
            }
            if (Session["CustomerVo"] != null)
            {
                //trRange.Visible = true;
            }

            if (DisplayType =="TV")
            {
                ViewState.Remove("TransactionStatus");
                BindGrid(convertedFromDate, convertedToDate);
                hdnExportType.Value = "TV";
                gvBalanceView.Visible = false;
               // Panel1.Visible = false;
                gvTrail.Visible = false;
                //divTrail.Visible = false;
                           
            }
            if(DisplayType=="RHV")
            {
                BindGridBalance(convertedFromDate, convertedToDate);
                hdnExportType.Value = "RHV";
                gvMFTransactions.Visible = false;
               // Panel2.Visible = false;
                gvTrail.Visible = false;
                //divTrail.Visible = false;
               
            }

            if (DisplayType == "TCV")
            {
                BindGridTrailCommission(convertedFromDate, convertedToDate);
                hdnExportType.Value = "TCV";
                gvMFTransactions.Visible = false;
                //Panel2.Visible = false;
                gvBalanceView.Visible = false;
                //Panel1.Visible = false;   

            }
           
            
        }
        protected void TabClick(object sender, RadTabStripEventArgs e)
        {
          
        }

        protected void gvMFTransactions_PreRender(object sender, EventArgs e)
        {
            if (gvMFTransactions.MasterTableView.FilterExpression != string.Empty)
            {
                RefreshCombos();
            }
        }

        protected void RefreshCombos()
        {
            DataTable dtMFTransaction = new DataTable();
            dtMFTransaction = (DataTable)Cache["ViewTransaction" + userVo.UserId + userType];
            DataView view = new DataView(dtMFTransaction);
            DataTable distinctValues = view.ToTable();
            DataRow[] rows = distinctValues.Select(gvMFTransactions.MasterTableView.FilterExpression.ToString());
            gvMFTransactions.MasterTableView.Rebind();
        
        }
        protected void gvMFTransactions_ItemDataBound(object sender, GridItemEventArgs e)
        {          

        }
        protected void gvBalanceView_ItemDataBound(object sender, GridItemEventArgs e)
        {

        }
       
        private void BindGrid(DateTime convertedFromDate, DateTime convertedToDate)
            {
            //Dictionary<string, string> genDictTranType = new Dictionary<string, string>();
            //Dictionary<string, string> genDictCategory = new Dictionary<string, string>();
            //Dictionary<string, int> genDictAMC = new Dictionary<string, int>();
            DataSet ds = new DataSet();
            //int Count = 0;
            //totalAmount = 0;
            //totalUnits = 0;
            int rmID = 0;
            int AdviserId = 0;

            if (userType == "advisor" || userType == "ops")
                AdviserId = advisorVo.advisorId;
            else if(userType=="rm")
                rmID = rmVo.RMId;

            if(!string.IsNullOrEmpty(txtParentCustomerId.Value.ToString().Trim()))
                customerId = int.Parse(txtParentCustomerId.Value);
            try
            {//pramod
                   if (rbtnGroup.Checked)
                    {
                        mfTransactionList = customerTransactionBo.GetRMCustomerMFTransactions(rmID, AdviserId, customerId, convertedFromDate, convertedToDate, int.Parse(ddlPortfolioGroup.SelectedItem.Value.ToString()),PasssedFolioValue,false,schemePlanCode);
                    }
                   else if (Convert.ToString(Session["IsCustomerDrillDown"]) == "Yes")
                    {
                       customerId = customerVo.CustomerId;
                       mfTransactionList = customerTransactionBo.GetRMCustomerMFTransactions(rmID, AdviserId, customerId, convertedFromDate, convertedToDate, int.Parse(ddlPortfolioGroup.SelectedItem.Value.ToString()), PasssedFolioValue, true, schemePlanCode);
                    }
                    else
                    {
                        mfTransactionList = customerTransactionBo.GetRMCustomerMFTransactions(rmID, AdviserId, 0, convertedFromDate, convertedToDate, int.Parse(ddlPortfolioGroup.SelectedItem.Value.ToString()), PasssedFolioValue, false, schemePlanCode);
                    }
                
                if (mfTransactionList.Count != 0)
                {
                    ErrorMessage.Visible = false;
                   // Panel2.Visible = true;
                    DataTable dtMFTransactions = new DataTable();

                    dtMFTransactions.Columns.Add("TransactionId");
                    dtMFTransactions.Columns.Add("Customer Name");
                    dtMFTransactions.Columns.Add("Folio Number");                    
                    dtMFTransactions.Columns.Add("Scheme Name");
                    dtMFTransactions.Columns.Add("Transaction Type");
                    dtMFTransactions.Columns.Add("Transaction Date", typeof(DateTime));
                    dtMFTransactions.Columns.Add("Price", typeof(double));
                    dtMFTransactions.Columns.Add("Units", typeof(double));
                    dtMFTransactions.Columns.Add("Amount", typeof(double));
                    dtMFTransactions.Columns.Add("STT", typeof(double));
                    dtMFTransactions.Columns.Add("Portfolio Name");
                    dtMFTransactions.Columns.Add("TransactionStatus");
                    dtMFTransactions.Columns.Add("Category");
                    dtMFTransactions.Columns.Add("AMC");
                    dtMFTransactions.Columns.Add("ADUL_ProcessId");
                    dtMFTransactions.Columns.Add("CMFT_SubBrokerCode");
                    dtMFTransactions.Columns.Add("PAISC_AssetInstrumentSubCategoryName");
                    dtMFTransactions.Columns.Add("CreatedOn");
                    dtMFTransactions.Columns.Add("CMFT_ExternalBrokerageAmount", typeof(double));
                  
                    DataRow drMFTransaction;

                    for (int i = 0; i < mfTransactionList.Count; i++)
                    {
                        drMFTransaction = dtMFTransactions.NewRow();
                        mfTransactionVo = new MFTransactionVo();
                        mfTransactionVo = mfTransactionList[i];
                        
                        drMFTransaction[0] = mfTransactionVo.TransactionId.ToString();
                        drMFTransaction[1] = mfTransactionVo.CustomerName.ToString();
                        drMFTransaction[2] = mfTransactionVo.Folio.ToString();
                        drMFTransaction[3] = mfTransactionVo.SchemePlan.ToString();
                        drMFTransaction[4] = mfTransactionVo.TransactionType.ToString();
                        drMFTransaction[5] = mfTransactionVo.TransactionDate.ToShortDateString().ToString();
                        if (GridViewCultureFlag==true)
                        drMFTransaction[6] = decimal.Parse(mfTransactionVo.Price.ToString()).ToString("n4", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"));
                        else
                        {
                            drMFTransaction[6] = decimal.Parse(mfTransactionVo.Price.ToString()); 
                        }
                        //drMFTransaction[7] = mfTransactionVo.Units.ToString("f4");
                        //drMFTransaction[8] = decimal.Parse(mfTransactionVo.Amount.ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"));
                        drMFTransaction[7] = mfTransactionVo.Units.ToString("f4");
                        totalUnits = totalUnits + mfTransactionVo.Units;
                        if (GridViewCultureFlag == true)
                        drMFTransaction[8] = decimal.Parse(mfTransactionVo.Amount.ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"));
                        else
                        {
                            drMFTransaction[8] = decimal.Parse(mfTransactionVo.Amount.ToString());
                        }
                        totalAmount = totalAmount + mfTransactionVo.Amount;
                        if (GridViewCultureFlag == true)
                        drMFTransaction[9] = decimal.Parse(mfTransactionVo.STT.ToString()).ToString("n4", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"));
                        else
                        {
                            drMFTransaction[9] = decimal.Parse(mfTransactionVo.STT.ToString());
                        }
                        drMFTransaction[10] = mfTransactionVo.PortfolioName.ToString();
                        drMFTransaction[11] = mfTransactionVo.TransactionStatus.ToString();
                        drMFTransaction[12] = mfTransactionVo.Category;
                        drMFTransaction[13] = mfTransactionVo.AMCName;
                        
                        if (mfTransactionVo.ProcessId == 0)
                            drMFTransaction[14] = "N/A";
                        else
                        drMFTransaction[14] = int.Parse(mfTransactionVo.ProcessId.ToString());
                        drMFTransaction[15] = mfTransactionVo.SubBrokerCode;
                        drMFTransaction[16] = mfTransactionVo.SubCategoryName;
                        drMFTransaction[17] = mfTransactionVo.CreatedOn;
                        drMFTransaction[18] = decimal.Parse(mfTransactionVo.BrokerageAmount.ToString());                      

                        dtMFTransactions.Rows.Add(drMFTransaction);
                    }

                    GridBoundColumn gbcCustomer = gvMFTransactions.MasterTableView.Columns.FindByUniqueName("Customer Name") as GridBoundColumn;
                    GridBoundColumn gbcPortfolio = gvMFTransactions.MasterTableView.Columns.FindByUniqueName("Portfolio Name") as GridBoundColumn;
                    GridBoundColumn gbCMFT_ExternalBrokerageAmount = gvMFTransactions.MasterTableView.Columns.FindByUniqueName("CMFT_ExternalBrokerageAmount") as GridBoundColumn;
                    if (Convert.ToString(Session["IsCustomerDrillDown"]) == "Yes")
                    {
                        gbcCustomer.Visible = false;
                        gbcPortfolio.Visible = false;
                        gbCMFT_ExternalBrokerageAmount.Visible = false;
                    }
                    else
                    gbcCustomer.Visible = true;
                                                     
                    if (Cache["ViewTransaction" + userVo.UserId + userType] == null)
                    {
                        Cache.Insert("ViewTransaction" + userVo.UserId + userType, dtMFTransactions);
                    }
                    else
                    {
                        Cache.Remove("ViewTransaction" + userVo.UserId + userType);
                        Cache.Insert("ViewTransaction" + userVo.UserId + userType, dtMFTransactions);
                    }
                    gvMFTransactions.CurrentPageIndex = 0;
                    gvMFTransactions.DataSource = dtMFTransactions;
                    gvMFTransactions.PageSize = advisorPrefrenceVo.GridPageSize;
                    gvMFTransactions.DataBind();
                    //Panel2.Visible = true;
                    ErrorMessage.Visible = false;
                    gvMFTransactions.Visible = true;
                    btnTrnxExport.Visible = true;
                   
                }
                else
                {
                    gvMFTransactions.Visible = false;
                    hdnRecordCount.Value = "0";
                    ErrorMessage.Visible = true;
                   // Panel2.Visible = false;
                    btnTrnxExport.Visible = false;
                  
                }
                gvTrail.Visible = false;
            }
            catch (Exception e)
            {
            }
           
        }

        private void BindGridBalance(DateTime convertedFromDate, DateTime convertedToDate)
        {
            //Dictionary<string, string> genDictTranType = new Dictionary<string, string>();
            //Dictionary<string, string> genDictCategory = new Dictionary<string, string>();
            //Dictionary<string, int> genDictAMC = new Dictionary<string, int>();
            DataSet ds = new DataSet();
            //int Count = 0;
            //totalAmount = 0;
            //totalUnits = 0;
            int rmID = 0;
            int AdviserId = 0;

            if (userType == "advisor" || userType == "ops")
                AdviserId = advisorVo.advisorId;
            else if (userType == "rm")
                rmID = rmVo.RMId;

            if (!string.IsNullOrEmpty(txtParentCustomerId.Value.ToString().Trim()))
                customerId = int.Parse(txtParentCustomerId.Value);
            try
            {//pramod
                if (rbtnGroup.Checked)
                {
                    mfBalanceList = customerTransactionBo.GetRMCustomerMFBalance(rmID, AdviserId, customerId, convertedFromDate, convertedToDate, int.Parse(ddlPortfolioGroup.SelectedItem.Value.ToString()), PasssedFolioValue);
                }
                else if (Session["IsCustomerDrillDown"] == "Yes")
                {
                    customerId = customerVo.CustomerId;
                    mfBalanceList = customerTransactionBo.GetRMCustomerMFBalance(rmID, AdviserId, customerId, convertedFromDate, convertedToDate, int.Parse(ddlPortfolioGroup.SelectedItem.Value.ToString()), PasssedFolioValue);
                }
                else
                {
                    mfBalanceList = customerTransactionBo.GetRMCustomerMFBalance(rmID, AdviserId, 0, convertedFromDate, convertedToDate, int.Parse(ddlPortfolioGroup.SelectedItem.Value.ToString()), PasssedFolioValue);
                }
               if (mfBalanceList.Count != 0)
                {
                    ErrorMessage.Visible = false;
                   // Panel1.Visible = true;
                    DataTable dtMFBalance = new DataTable();

                    dtMFBalance.Columns.Add("TransactionId");
                    dtMFBalance.Columns.Add("Customer Name");
                    dtMFBalance.Columns.Add("Folio Number");
                    dtMFBalance.Columns.Add("Scheme Name");
                    dtMFBalance.Columns.Add("CurrentValue");
                    dtMFBalance.Columns.Add("Transaction Type");
                    dtMFBalance.Columns.Add("Transaction Date",typeof(DateTime));
                    dtMFBalance.Columns.Add("Category");
                    dtMFBalance.Columns.Add("PAISC_AssetInstrumentSubCategoryName");
                    dtMFBalance.Columns.Add("Price", typeof(double));
                    dtMFBalance.Columns.Add("Units", typeof(double));
                    dtMFBalance.Columns.Add("Amount", typeof(double));
                    dtMFBalance.Columns.Add("NAV",typeof(double));
                    dtMFBalance.Columns.Add("Age");
                    dtMFBalance.Columns.Add("Balance", typeof(double));                   
                  
                    DataRow drMFBalance;

                    for (int i = 0; i < mfBalanceList.Count; i++)
                    {
                        drMFBalance = dtMFBalance.NewRow();
                        mfBalanceVo = new MFTransactionVo();
                        mfBalanceVo = mfBalanceList[i];

                        drMFBalance["TransactionId"] = mfBalanceVo.TransactionId.ToString();
                        drMFBalance["Customer Name"] = mfBalanceVo.CustomerName.ToString();
                        drMFBalance["Folio Number"] = mfBalanceVo.Folio.ToString();
                        drMFBalance["Scheme Name"] = mfBalanceVo.SchemePlan.ToString();
                        drMFBalance["CurrentValue"] = mfBalanceVo.CurrentValue.ToString();
                        drMFBalance["Transaction Type"] = mfBalanceVo.TransactionType.ToString(); ;
                        drMFBalance["Transaction Date"] = mfBalanceVo.TransactionDate.ToShortDateString().ToString();
                        drMFBalance["Category"] = mfBalanceVo.Category.ToString();
                        drMFBalance["PAISC_AssetInstrumentSubCategoryName"] = mfBalanceVo.SubCategoryName.ToString();
                        if (GridViewCultureFlag == true)
                            drMFBalance["Price"] = decimal.Parse(mfBalanceVo.Price.ToString()).ToString("n4", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"));
                        else
                        {
                            drMFBalance["Price"] = decimal.Parse(mfBalanceVo.Price.ToString());
                        }
                        //drMFTransaction[7] = mfTransactionVo.Units.ToString("f4");
                        //drMFTransaction[8] = decimal.Parse(mfTransactionVo.Amount.ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"));
                        drMFBalance["Units"] = mfBalanceVo.Units.ToString("f4");
                        totalUnits = totalUnits + mfBalanceVo.Units;
                        if (GridViewCultureFlag == true)
                            drMFBalance["Amount"] = decimal.Parse(mfBalanceVo.Amount.ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"));
                        else
                        {
                            drMFBalance["Amount"] = decimal.Parse(mfBalanceVo.Amount.ToString());
                        }
                         totalAmount = totalAmount + mfBalanceVo.Amount;
                         drMFBalance["NAV"] = mfBalanceVo.NAV.ToString();
                         drMFBalance["Age"] = mfBalanceVo.Age;
                         drMFBalance["Balance"] = mfBalanceVo.Balance.ToString();
                         dtMFBalance.Rows.Add(drMFBalance);
                    }

                    GridBoundColumn gbcCustomer = gvBalanceView.MasterTableView.Columns.FindByUniqueName("Customer Name") as GridBoundColumn;
                    //GridBoundColumn gbcPortfolio = gvBalanceView.MasterTableView.Columns.FindByUniqueName("Portfolio Name") as GridBoundColumn;
                    if (Session["CustomerVo"] != null)
                    {
                        gbcCustomer.Visible = false;
                    //    gbcPortfolio.Visible = false;
                    }
                    else
                        gbcCustomer.Visible = true;
                                                                  
                    if (Cache["ViewBalance" + userVo.UserId + userType] == null)
                    {
                        Cache.Insert("ViewBalance" + userVo.UserId + userType, dtMFBalance);
                    }
                    else
                    {
                        Cache.Remove("ViewBalance" + userVo.UserId + userType);
                        Cache.Insert("ViewBalance" + userVo.UserId + userType, dtMFBalance);
                    }
                    gvBalanceView.DataSource = dtMFBalance;
                    gvBalanceView.PageSize =advisorPrefrenceVo.GridPageSize;
                    gvBalanceView.DataBind();
                   // Panel1.Visible = true;
                    ErrorMessage.Visible = false;
                    gvBalanceView.Visible = true;
                    btnTrnxExport.Visible = true;
                  }
                              
                else
                {
                    gvBalanceView.Visible = false;
                    ErrorMessage.Visible = true;
                   // Panel1.Visible = false;
                    hdnRecordCount.Value = "0";
                    btnTrnxExport.Visible = false;
                }
               gvTrail.Visible = false;
            }
            catch (Exception e)
            {
            }
            }

        protected void CallAllGridBindingFunctions()
        {
        }
        protected void ExportGrid(string hdnExportType)
        {
            if (hdnExportType == "TV")
            {
                gvMFTransactions.ExportSettings.OpenInNewWindow = true;
                gvMFTransactions.ExportSettings.IgnorePaging = true;
                gvMFTransactions.ExportSettings.HideStructureColumns = true;
                gvMFTransactions.ExportSettings.ExportOnlyData = true;
                gvMFTransactions.ExportSettings.FileName = "View Transactions Details";
                gvMFTransactions.ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML;
                gvMFTransactions.MasterTableView.ExportToExcel();
            }
            if (hdnExportType == "RHV")
            {
                gvBalanceView.ExportSettings.OpenInNewWindow = true;
                gvBalanceView.ExportSettings.IgnorePaging = true;
                gvBalanceView.ExportSettings.HideStructureColumns = true;
                gvBalanceView.ExportSettings.ExportOnlyData = true;
                gvBalanceView.ExportSettings.FileName = "View ReturnHolding Details";
                gvBalanceView.ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML;
                gvBalanceView.MasterTableView.ExportToExcel();
            
            }

            if (hdnExportType == "TCV")
            {
                DataSet dtFolioDetails = new DataSet();

                dtFolioDetails = (DataSet)Cache["ViewTrailCommissionDetails" + advisorVo.advisorId.ToString()];
                gvTrail.DataSource = dtFolioDetails;

                gvTrail.DataSource = dtFolioDetails;
                gvTrail.ExportSettings.OpenInNewWindow = true;
                gvTrail.ExportSettings.IgnorePaging = true;
                gvTrail.ExportSettings.HideStructureColumns = true;
                gvTrail.ExportSettings.ExportOnlyData = true;
                gvTrail.ExportSettings.FileName = "Trail Details";
                gvTrail.ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML;
                gvTrail.MasterTableView.ExportToExcel();

            }
        
        }

        protected void gvMFTransactions_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void lnkView_Click(object sender, EventArgs e)
        {
            LinkButton lnkView = (LinkButton)sender;
            GridDataItem gdi;
            gdi = (GridDataItem)lnkView.NamingContainer;
            int selectedRow = gdi.ItemIndex + 1;
            int transactionId = int.Parse((gvMFTransactions.MasterTableView.DataKeyValues[selectedRow - 1]["TransactionId"].ToString()));
            mfTransactionVo = customerTransactionBo.GetMFTransaction(transactionId);
            Session["MFTransactionVo"] = mfTransactionVo;
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "RMCustomerIndividualDashboard", "loadcontrol('ViewMFTransaction','login');", true);
          //  Response.Write("<script type='text/javascript'>detailedresults=window.open('CustomerPortfolio/ViewMFTransaction.aspx','mywindow', 'width=1000,height=450,scrollbars=yes,location=center');</script>");
            //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('ViewMFTransaction','none');", true);
        }
        protected void gvMFTransactions_OnItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "Scheme")
            {
                LinkButton lnkScheme = (LinkButton)e.Item.FindControl("lnkprAmc");
                GridDataItem gdi;
                gdi = (GridDataItem)lnkScheme.NamingContainer;
                int selectedRow = gdi.ItemIndex + 1;
                int transactionId = int.Parse((gvMFTransactions.MasterTableView.DataKeyValues[selectedRow - 1]["TransactionId"].ToString()));
                mfTransactionVo = customerTransactionBo.GetMFTransaction(transactionId);
                int month = 0;
                int amcCode = mfTransactionVo.AMCCode;
                int schemeCode = mfTransactionVo.MFCode;
                int year = 0;

                if (DateTime.Now.Month != 1)
                {
                    month = DateTime.Now.Month - 1;
                    year = DateTime.Now.Year;
                }
                else
                {
                    month = 12;
                    year = DateTime.Now.Year - 1;
                }
                string schemeName = mfTransactionVo.SchemePlan;
                Response.Redirect("ControlHost.aspx?pageid=AdminPriceList&SchemeCode=" + schemeCode + "&Year=" + year + "&Month=" + month + "&SchemeName=" + schemeName + "&AMCCode=" + amcCode + "", false);
            }
        }


        #region added for Trail transaction

        private void BindGridTrailCommission(DateTime convertedFromDate, DateTime convertedToDate)
        {
            DataSet dsTrailCommissionDetails = new DataSet();
            DataSet ds = new DataSet();
            int rmID = 0;
            int AdviserId = 0;

            if (userType == "advisor" || userType == "ops")
                AdviserId = advisorVo.advisorId;
            else if (userType == "rm")
                rmID = rmVo.RMId;

            if (!string.IsNullOrEmpty(txtParentCustomerId.Value.ToString().Trim()))
                customerId = int.Parse(txtParentCustomerId.Value);
            try
            {
                if (rbtnGroup.Checked)
                {
                    dsTrailCommissionDetails = customerTransactionBo.GetRMCustomerTrailCommission(rmID, AdviserId, customerId, convertedFromDate, convertedToDate, int.Parse(ddlPortfolioGroup.SelectedItem.Value.ToString()), PasssedFolioValue);
                }
                else if (Session["IsCustomerDrillDown"] == "Yes")
                {
                    customerId = customerVo.CustomerId;
                    dsTrailCommissionDetails = customerTransactionBo.GetRMCustomerTrailCommission(rmID, AdviserId, customerId, convertedFromDate, convertedToDate, int.Parse(ddlPortfolioGroup.SelectedItem.Value.ToString()), PasssedFolioValue);
                }
                else
                {
                    dsTrailCommissionDetails = customerTransactionBo.GetRMCustomerTrailCommission(rmID, AdviserId, 0, convertedFromDate, convertedToDate, int.Parse(ddlPortfolioGroup.SelectedItem.Value.ToString()), PasssedFolioValue);
                }
                if (dsTrailCommissionDetails.Tables[0].Rows.Count != 0)
                {
                    btnTrnxExport.Visible = true;
                    ErrorMessage.Visible = false;
                  //  Panel1.Visible = false;
                
                    GridBoundColumn gbcCustomer = gvBalanceView.MasterTableView.Columns.FindByUniqueName("Customer Name") as GridBoundColumn;
                  
                    gvTrail.DataSource = dsTrailCommissionDetails;
                    gvTrail.PageSize = advisorPrefrenceVo.GridPageSize;
                    gvTrail.DataBind();
                    //divTrail.Visible = true;
                    Div3.Visible = true;
                    gvTrail.Visible = true;
                    //imgBtnTrail.Visible = true;
                    ErrorMessage.Visible = false;        
                }

                else
                {
                    gvTrail.Visible = false;
                    Div3.Visible = false;
                   // divTrail.Visible = false;
                    ErrorMessage.Visible = true;
                    hdnRecordCount.Value = "0";
                    btnTrnxExport.Visible = false;
                    //imgBtnTrail.Visible = false;
                }

                
                if (Cache["ViewTrailCommissionDetails" + userVo.UserId + userType] == null)
                {
                    Cache.Insert("ViewTrailCommissionDetails" + advisorVo.advisorId, dsTrailCommissionDetails);
                }
                else
                {
                    Cache.Remove("ViewTrailCommissionDetails" + advisorVo.advisorId);
                    Cache.Insert("ViewTrailCommissionDetails" + advisorVo.advisorId, dsTrailCommissionDetails);
                }
                Panel2.Visible = false;
                Panel1.Visible = false;
                //Div1.Visible = false;
                //tbl.Visible = false;

            }
            catch (Exception e)
            {
            }
        }

        protected void gvTrail_OnNeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            DataSet dtTrailstransactionDetails = new DataSet();
            dtTrailstransactionDetails = (DataSet)Cache["ViewTrailCommissionDetails" + advisorVo.advisorId.ToString()];
            gvTrail.DataSource = dtTrailstransactionDetails;
            gvTrail.Visible = true;            
        }

        protected void btnTrailExport_Click(object sender, ImageClickEventArgs e)
        {
            DataSet dtFolioDetails = new DataSet();

            dtFolioDetails = (DataSet)Cache["ViewTrailCommissionDetails" + advisorVo.advisorId.ToString()];
            gvTrail.DataSource = dtFolioDetails;
            gvTrail.Visible = true;

            gvTrail.DataSource = dtFolioDetails;
            gvTrail.ExportSettings.OpenInNewWindow = true;
            gvTrail.ExportSettings.IgnorePaging = true;
            gvTrail.ExportSettings.HideStructureColumns = true;
            gvTrail.ExportSettings.ExportOnlyData = true;
            gvTrail.ExportSettings.FileName = "Trail Details";
            gvTrail.ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML;
            gvTrail.MasterTableView.ExportToExcel();
        }

        #endregion

        protected void gvMFTransactions_OnNeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            string rcbType = string.Empty;
            DataTable dtMFTransaction = new DataTable();
            dtMFTransaction = (DataTable)Cache["ViewTransaction" + userVo.UserId + userType];
            if (dtMFTransaction != null)
            {
                if (ViewState["TransactionStatus"] != null)
                    rcbType = ViewState["TransactionStatus"].ToString();
                if (!string.IsNullOrEmpty(rcbType))
                {
                    DataView dvStaffList = new DataView(dtMFTransaction, "TransactionStatus = '" + rcbType + "'", "Customer Name,Folio Number,Category,AMC,Scheme Name,Transaction Type,Transaction Date,ADUL_ProcessId", DataViewRowState.CurrentRows);
                    gvMFTransactions.DataSource = dvStaffList.ToTable();

                }
                else
                {
                    gvMFTransactions.DataSource = dtMFTransaction;

                }
            }
            //if (Session["IsCustomerDrillDown"] != null)
            //{
            //    trRange.Visible = true;
            //}
            //gvMFTransactions.Visible = true;
            //DataTable dtMFTransactions = new DataTable();
            //dtMFTransactions = (DataTable)Cache["ViewTransaction" + userVo.UserId ];
            //gvMFTransactions.DataSource = dtMFTransactions;
            
        }

        protected void gvBalanceView_OnNeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

            gvBalanceView.Visible = true;
            DataTable dtMFBalance = new DataTable();
            dtMFBalance = (DataTable)Cache["ViewBalance" + userVo.UserId + userType];
            gvBalanceView.DataSource = dtMFBalance;
            if (Session["IsCustomerDrillDown"] != null)
            {
                //trRange.Visible = true;
            }
           
        }
        protected void lbBack_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('ViewMutualFundPortfolio','none');", true);

        }
        protected void btnTrnxExport_Click(object sender, ImageClickEventArgs e)
        {   
            ExportGrid(hdnExportType.Value);        
        }
        protected void btnbalncExport_Click(object sender, ImageClickEventArgs e)
        {            
        }
        protected void Transaction_PreRender(object sender, EventArgs e)
        {
            RadComboBox Combo = sender as RadComboBox;
            ////persist the combo selected value  
            if (ViewState["TransactionStatus"] != null)
            {
                Combo.SelectedValue = ViewState["TransactionStatus"].ToString();
            }
               
        }
        protected void RadComboBoxTS_SelectedIndexChanged(object o, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox dropdown = o as RadComboBox;
            ViewState["TransactionStatus"] = dropdown.SelectedValue.ToString();
            if (ViewState["TransactionStatus"] !="")
            {
                GridColumn column = gvMFTransactions.MasterTableView.GetColumnSafe("TransactionStatus");
                column.CurrentFilterFunction = GridKnownFunction.EqualTo;
                gvMFTransactions.CurrentPageIndex = 0;
                gvMFTransactions.MasterTableView.Rebind();

            }
            else 
            {
                GridColumn column = gvMFTransactions.MasterTableView.GetColumnSafe("TransactionStatus");
                column.CurrentFilterFunction = GridKnownFunction.EqualTo;
                gvMFTransactions.CurrentPageIndex = 0;
                gvMFTransactions.MasterTableView.Rebind();


            }
        
           }

        protected void gvMFTransactions_OnExcelMLExportStylesCreated(object source, Telerik.Web.UI.GridExcelBuilder.GridExportExcelMLStyleCreatedArgs e)
        {
            BorderStylesCollection borders = new BorderStylesCollection();
            BorderStyles borderStyle = null;
            for (int i = 1; i <= 3; i++)
            {
                borderStyle = new BorderStyles();
                borderStyle.PositionType = (PositionType)i;
                borderStyle.Color = System.Drawing.Color.Black;
                borderStyle.LineStyle = LineStyle.Continuous;
                borderStyle.Weight = 1.0;
                borders.Add(borderStyle);
            }


            foreach (Telerik.Web.UI.GridExcelBuilder.StyleElement style in e.Styles)
            {
                foreach (BorderStyles border in borders)
                {
                    style.Borders.Add(border);
                }
                if (style.Id == "headerStyle")
                {
                    style.FontStyle.Bold = true;
                    style.FontStyle.Color = System.Drawing.Color.White;
                    style.InteriorStyle.Color = System.Drawing.Color.Black;
                    style.InteriorStyle.Pattern = Telerik.Web.UI.GridExcelBuilder.InteriorPatternType.Solid;
                }
                else if (style.Id == "itemStyle")
                {
                    style.InteriorStyle.Color = System.Drawing.Color.WhiteSmoke;
                    style.InteriorStyle.Pattern = Telerik.Web.UI.GridExcelBuilder.InteriorPatternType.Solid;
                }
                else if (style.Id == "alternatingItemStyle")
                {
                    style.InteriorStyle.Color = System.Drawing.Color.LightGray;
                    style.InteriorStyle.Pattern = Telerik.Web.UI.GridExcelBuilder.InteriorPatternType.Solid;
                }
                else if (style.Id == "dateItemStyle")
                {
                    style.InteriorStyle.Color = System.Drawing.Color.WhiteSmoke;
                    style.InteriorStyle.Pattern = Telerik.Web.UI.GridExcelBuilder.InteriorPatternType.Solid;
                }
                else if (style.Id == "alternatingDateItemStyle")
                {
                    style.InteriorStyle.Color = System.Drawing.Color.LightGray;
                    style.InteriorStyle.Pattern = Telerik.Web.UI.GridExcelBuilder.InteriorPatternType.Solid;
                }
            }

            Telerik.Web.UI.GridExcelBuilder.StyleElement myStyle = new Telerik.Web.UI.GridExcelBuilder.StyleElement("MyCustomStyle");
            myStyle.FontStyle.Bold = true;
            myStyle.FontStyle.Italic = true;
            myStyle.InteriorStyle.Color = System.Drawing.Color.Gray;
            myStyle.InteriorStyle.Pattern = Telerik.Web.UI.GridExcelBuilder.InteriorPatternType.Solid;
            e.Styles.Add(myStyle);
        }
        protected void gvMFTransactions_OnExcelMLExportRowCreated(object source, GridExportExcelMLRowCreatedArgs e)
        {

            if (e.RowType == GridExportExcelMLRowType.HeaderRow)
            {
                int rowIndex = 0;
                RowElement row = new RowElement();
                CellElement cell = new CellElement();
                cell.MergeAcross = e.Row.Cells.Count - 1;
                cell.Data.DataItem = "Adviser" + ": " + advisorVo.OrganizationName;
                row.Cells.Add(cell);
                e.Worksheet.Table.Rows.Insert(rowIndex, row);
                rowIndex++;
                if (Session["IsCustomerDrillDown"] == "Yes")
                {
                    RowElement row1 = new RowElement();
                    CellElement cell1 = new CellElement();
                    cell1.MergeAcross = e.Row.Cells.Count - 1;
                    cell1.Data.DataItem = "Customer" + ": " + customerVo.FirstName + "  " + customerVo.MiddleName + "  " + customerVo.LastName;
                    row1.Cells.Add(cell1);

                    e.Worksheet.Table.Rows.Insert(rowIndex, row1);
                    rowIndex++;
                }


                RowElement DateRow = new RowElement();
                CellElement Datecell = new CellElement();
                Datecell.MergeAcross = e.Row.Cells.Count - 1;
                Datecell.Data.DataItem = "From" + ": " + Convert.ToDateTime(txtFromDate.SelectedDate).ToLongDateString() + "  " + "To" + ": " + Convert.ToDateTime(txtToDate.SelectedDate).ToLongDateString();
                DateRow.Cells.Add(Datecell);
                e.Worksheet.Table.Rows.Insert(rowIndex, DateRow);
                rowIndex++;


                RowElement BlankRow = new RowElement();
                CellElement Blankcell = new CellElement();
                Blankcell.MergeAcross = e.Row.Cells.Count - 1;
                Blankcell.Data.DataItem = "";
                BlankRow.Cells.Add(Blankcell);
                e.Worksheet.Table.Rows.Insert(rowIndex, BlankRow);



                //e.Worksheet.AutoFilter.Range = e.Worksheet.AutoFilter.Range.Replace("R1", "R2");
            }
        }

         }
      }


