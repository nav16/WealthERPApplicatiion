﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VoUser;
using WealthERP.Base;

using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;
using BoCommon;
using BoCustomerProfiling;

namespace WealthERP.Customer
{
    public partial class CustomerLeftPane : System.Web.UI.UserControl
    {
        CustomerVo customerVo = new CustomerVo();
        CustomerBo customerBo = new CustomerBo();
        bool isGrpHead = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    customerVo = (CustomerVo)Session[SessionContents.CustomerVo];
            //    string First = customerVo.FirstName.ToString();
            //    string Middle = customerVo.MiddleName.ToString();
            //    string Last = customerVo.LastName.ToString();

            //    if (Middle != "")
            //    {
            //        lblNameValue.Text = customerVo.FirstName.ToString() + " " + customerVo.MiddleName.ToString() + " " + customerVo.LastName.ToString();
            //    }
            //    else
            //    {
            //        lblNameValue.Text = customerVo.FirstName.ToString() + " " + customerVo.LastName.ToString();
            //    }

            //    lblEmailIdValue.Text = customerVo.Email.ToString();
            //}
            SessionBo.CheckSession();
            customerVo = (CustomerVo)Session[SessionContents.CustomerVo];
            if (customerVo != null)
            {
                Session[SessionContents.FPS_ProspectList_CustomerId] = customerVo.CustomerId;
            }
            if (!IsPostBack)
            {
                isGrpHead = customerBo.CheckCustomerGroupHead(customerVo.CustomerId);
                if (isGrpHead == true)
                {
                    TreeView1.Nodes.AddAt(0, new TreeNode("Group Home"));
                    Session["IsDashboard"] = "true";
                }
                else
                    Session["IsDashboard"] = "CustDashboard";

                string IsDashboard = string.Empty;

                if (Session["IsDashboard"] != null)
                    IsDashboard = Session["IsDashboard"].ToString();
                if (IsDashboard == "true")
                {
                    TreeView1.CollapseAll();

                    if (customerVo.RelationShip == "SELF")
                    {
                        TreeView1.FindNode("Group Home").Selected = true;
                    }
                    else
                    {
                        TreeView1.FindNode("Customer Dashboard").Selected = true;
                    }
                    Session["IsDashboard"] = "false";
                }
                else if (IsDashboard == "CustDashboard")
                {
                    TreeView1.CollapseAll();
                    TreeView1.FindNode("Customer Dashboard").Selected = true;
                }
                else
                {
                    TreeView1.CollapseAll();
                    TreeView1.FindNode("Profile Dashboard").Expand();
                    TreeView1.FindNode("Profile Dashboard").Selected = true;
                }
                
            }
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "leftpane", "loadtopmenu('CustomerIndividualLeftPane');", true);
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (Page.Request.Params.Get("__EVENTTARGET") != null && (Page.Request.Params.Get("__EVENTTARGET")).Contains("TreeView1"))
            {
                SetNode();
            }
        }
        public void SetNode()
        {
            string strNodeValue = null;
            try
            {
                if (TreeView1.SelectedNode.Value == "Group Home")
                {
                    if (customerVo.RelationShip != "SELF")
                    {
                        customerVo = customerBo.GetCustomer(int.Parse(customerVo.ParentCustomer));
                        Session["CustomerVo"] = customerVo;
                    }

                    Session["IsDashboard"] = "true";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('AdvisorRMCustGroupDashboard','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Customer Dashboard")
                {
                    Session["IsDashboard"] = "CustDashboard";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('AdvisorRMCustIndiDashboard','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Portfolio Dashboard")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('PortfolioDashboard','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Equity")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('ViewEquityPortfolios', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "View Equity Transaction")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('EquityTransactionsView','none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Equity Transaction")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('EquityManualSingleTransaction','none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Equity Account")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerEQAccountAdd', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "MF")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('ViewMutualFundPortfolio', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "View MF Transaction")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('TransactionsView', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add MF Transaction")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('MFManualSingleTran', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add MF Folio")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerMFAccountAdd', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "View MF Folio")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrol('CustomerMFFolioView', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "MFReports")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrol('MFReports', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Insurance")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('ViewInsuranceDetails', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Insurance")
                {
                    Session.Remove("table");
                    Session.Remove("insuranceVo");
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerAccountAdd', 'action=IN')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Fixed Income")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('PortfolioFixedIncomeView', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Fixed Income")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerAccountAdd', 'action=FI')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Govt Savings")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('ViewGovtSavings', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Govt Savings")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerAccountAdd', 'action=GS')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Property")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('PortfolioProperty', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Property")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerAccountAdd', 'action=PR')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Pension And Gratuities")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('PensionPortfolio', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Pension and Gratuities")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerAccountAdd', 'action=PG')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Personal Assets")
                {

                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('PortfolioPersonal', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Personal Assets")
                {
                    Session.Remove("personalVo");
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('PortfolioPersonalEntry', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Gold Assets")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('ViewGoldPortfolio', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Gold Assets")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('PortfolioGoldEntry', 'action=GoldEntry')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Collectibles")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('ViewCollectiblesPortfolio', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Collectibles")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('PortfolioCollectiblesEntry', 'action=Col')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Cash And Savings")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('PortfolioCashSavingsView', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Cash and Savings")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerAccountAdd', 'action=CS')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Register Systematic Schemes")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('PortfolioSystematicEntry', 'action=entry')", true);
                }
                else if (TreeView1.SelectedNode.Value == "View Systematic Schemes")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('PortfolioSystematicView', 'none')", true);
                }
                else if (TreeView1.SelectedNode.Value == "Profile Dashboard")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('RMCustomerIndividualDashboard','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Alerts")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('RMAlertNotifications','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "View Notifications")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('RMAlertNotifications','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "MF Alerts")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerMFAlert','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "FI Alerts")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerFIAlerts','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Insurance Alerts")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerInsuranceAlerts','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Equity Alerts")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerEQAlerts','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "View Profile")
                {
                    if (customerVo.Type.ToUpper().ToString() == "IND" || customerVo.Type == null)
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('ViewCustomerIndividualProfile','none');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('ViewNonIndividualProfile','none');", true);
                    }
                }
                else if (TreeView1.SelectedNode.Value == "Edit Profile")
                {
                    if (customerVo.Type.ToUpper().ToString() == "IND" || customerVo.Type == null)
                    {

                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('EditCustomerIndividualProfile','none');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('EditCustomerNonIndividualProfile','none');", true);
                    }
                }
                else if (TreeView1.SelectedNode.Value == "Proof")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('ViewCustomerProofs','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Proof")
                {
                    Session.Remove("SessionSpecificProof");
                    Session["FlagProof"] = 1;
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerProofsAdd','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Bank Details")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('ViewBankDetails','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Bank Details")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('AddBankDetails','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Group Member")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('FamilyDetails','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Associate Member")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerAssociatesAdd','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Liability")
                {
                    Session["menu"] = null;
                    Session.Remove("personalVo");
                    Session.Remove("propertyVo");
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('LiabilitiesMaintenanceForm','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Liabilities Dashboard")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('LiabilityView','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Income Details")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerIncome','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Expense Details")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrolCustomer('CustomerExpense','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "General Insurance")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrol('ViewGeneralInsuranceDetails','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add General Insurance")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrol('PortfolioGeneralInsuranceAccountAdd','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Add Life Insurance")
                {
                    Session.Remove("table");
                    Session.Remove("insuranceVo");
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrol('CustomerAccountAdd', 'action=IN')", true);
                    //ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrol('PortfolioInsuranceEntry','none');", true);
                }
                else if (TreeView1.SelectedNode.Value == "Reports")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrol('FinancialPlanningReports','login')", true);

                }
                else if (TreeView1.SelectedNode.Value == "Life Insurance")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "LeftPaneKey", "loadcontrol('ViewInsuranceDetails','none');", true);
                }

                // Code to Expand/Collapse the Tree View Nodes based on selections
                if (TreeView1.SelectedNode.Parent == null)
                {
                    foreach (TreeNode node in TreeView1.Nodes)
                    {
                        if (node.Value != TreeView1.SelectedNode.Value)
                            node.Collapse();
                        else
                            node.Expand();
                    }
                }
                else
                {
                    if (TreeView1.SelectedNode.Parent.Parent != null)
                    {
                        string parentNode = TreeView1.SelectedNode.Parent.Parent.Value;
                        foreach (TreeNode node in TreeView1.Nodes)
                        {
                            if (node.Value != parentNode)
                                node.Collapse();
                        }
                    }
                    else
                    {
                        if (TreeView1.SelectedNode.Parent == null)
                        {
                            foreach (TreeNode node in TreeView1.Nodes)
                            {
                                if (node.Value != TreeView1.SelectedNode.Value)
                                    node.Collapse();
                                else
                                    node.Expand();
                            }
                        }
                        else
                        {
                            strNodeValue = TreeView1.SelectedNode.Parent.Value;
                            foreach (TreeNode node in TreeView1.Nodes)
                            {
                                if (node.Value != strNodeValue)
                                    node.Collapse();
                            }
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

                FunctionInfo.Add("Method", "RMCustomerIndividualLeftPane.ascx.cs:TreeView1_SelectedNodeChanged()");

                object[] objects = new object[1];

                objects[0] = strNodeValue;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }

        }
        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {
        }
    }
}
