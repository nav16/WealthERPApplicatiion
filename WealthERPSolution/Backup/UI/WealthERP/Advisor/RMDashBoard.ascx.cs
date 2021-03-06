﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VoUser;
using BoAdvisorProfiling;
using BoCustomerProfiling;
using BoCustomerPortfolio;
using BoAlerts;
using System.Data;
using WealthERP.Customer;
using System.Collections.Specialized;
using WealthERP.Base;
using VOAssociates;
using BOAssociates;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using BoCommon;

namespace WealthERP.Advisor
{
    public partial class RMDashBoard : System.Web.UI.UserControl
    {
        RMVo rmVo = new RMVo();
        UserVo userVo = new UserVo();
        CustomerVo customerVo = new CustomerVo();
        CustomerBo customerBo = new CustomerBo();
        AlertsBo alertsBo = new AlertsBo();
        AssetBo assetBo = new AssetBo();
        DataSet dsCustomerAlerts = new DataSet();
        DataRow drCustomerAlerts;
        DataTable dtLoanProposal = new DataTable();
        LiabilitiesBo liabilitiesBo = new LiabilitiesBo();
        AssociatesVO associatesVo = new AssociatesVO();
        MessageBo msgBo;
        string userType;
        int agentId;

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionBo.CheckSession();
            userVo = (UserVo)Session["userVo"];
            associatesVo = (AssociatesVO)Session["associatesVo"];
            rmVo = (RMVo)Session[SessionContents.RmVo];
            int rmId = 0;
            double total = 0;
            DataSet dsCurrentValues = null;
            DataTable dt;

           if (Session[SessionContents.CurrentUserRole].ToString().ToLower() == "rm")
            {
                userType = "rm";
                rmId = rmVo.RMId;
                trAUM.Visible = true;
                trcustomer.Visible = true;
                tdloan.Visible = true;
               
             
            }
            else if (Session[SessionContents.CurrentUserRole].ToString().ToLower() == "associates")
            {
                userType = "associates";
                agentId = associatesVo.AAC_AdviserAgentId;
                trAUM.Visible = false;
                trcustomer.Visible = true;
                tdloan.Visible = false;
             
            }
            try
            {
               





                if (Session["BMDashBoardRMId"] != null)
                {
                    rmId = int.Parse(Session["BMDashBoardRMId"].ToString());
                }
                else
                rmId = rmVo.RMId;

                dsCurrentValues = getCurrentValuesforRM(rmId);
                getCustomerListforRM(rmId,agentId,userType);
                dt = dsCurrentValues.Tables[0];
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["AssetType"].ToString() == "Equity")
                    {
                        if (dr["AggrGSCurrentValue"].ToString() == "")
                        {
                            lblEquityValue.Text = "0";
                        }
                        else
                        {
                            lblEquityValue.Text = String.Format("{0:N}", decimal.Parse(dr["AggrGSCurrentValue"].ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                            total += double.Parse(dr["AggrGSCurrentValue"].ToString());
                        }
                    }
                    if (dr["AssetType"].ToString() == "IN")
                    {
                        if (dr["AggrGSCurrentValue"].ToString() == "")
                        {
                            lblInsuranceValue.Text = "0";
                        }
                        else
                        {
                            lblInsuranceValue.Text = String.Format("{0:N}", decimal.Parse(dr["AggrGSCurrentValue"].ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                            total += double.Parse(dr["AggrGSCurrentValue"].ToString());
                        }
                    }
                    if (dr["AssetType"].ToString() == "MF-DT")
                    {
                        if (dr["AggrGSCurrentValue"].ToString() == "")
                        {
                            lblMFDebtValue.Text = "0";
                        }
                        else
                        {
                            lblMFDebtValue.Text = String.Format("{0:N}", decimal.Parse(dr["AggrGSCurrentValue"].ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                            total += double.Parse(dr["AggrGSCurrentValue"].ToString());
                        }

                    }
                    if (dr["AssetType"].ToString() == "MF-HY")
                    {
                        if (dr["AggrGSCurrentValue"].ToString() == "")
                        {
                            lblMFHybridValue.Text = "0";

                        }
                        else
                        {
                            lblMFHybridValue.Text = String.Format("{0:N}", decimal.Parse(dr["AggrGSCurrentValue"].ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                            total += double.Parse(dr["AggrGSCurrentValue"].ToString());
                        }
                    }
                    if (dr["AssetType"].ToString() == "MF-OT")
                    {
                        if (dr["AggrGSCurrentValue"].ToString() == "")
                        {
                            lblMFOthersValue.Text = "0";

                        }
                        else
                        {
                            lblMFOthersValue.Text = String.Format("{0:N}", decimal.Parse(dr["AggrGSCurrentValue"].ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                            total += double.Parse(dr["AggrGSCurrentValue"].ToString());
                        }
                    }
                    if (dr["AssetType"].ToString() == "MF-EQ")
                    {
                        if (dr["AggrGSCurrentValue"].ToString() == "")
                        {
                            lblEquityMFValue.Text = "0";

                        }
                        else
                        {
                            lblEquityMFValue.Text = String.Format("{0:N}", decimal.Parse(dr["AggrGSCurrentValue"].ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));

                            total += double.Parse(dr["AggrGSCurrentValue"].ToString());
                        }
                    }
                    if (dr["AssetType"].ToString() == "MF-CO")
                    {
                        if (dr["AggrGSCurrentValue"].ToString() == "")
                        {
                            lblMFCommodityValue.Text = "0";

                        }
                        else
                        {
                            lblMFCommodityValue.Text = String.Format("{0:N}", decimal.Parse(dr["AggrGSCurrentValue"].ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));

                            total += double.Parse(dr["AggrGSCurrentValue"].ToString());
                        }
                    }

                }
                BindCustomerAlerts();
                dtLoanProposal=liabilitiesBo.GetRMLoanProposalPendingCount(rmVo.RMId);

                if (dtLoanProposal != null)
                {
                    tblLoanCount.Visible = true;
                    lblPendingBank.Text = dtLoanProposal.Rows[0]["N_Count"].ToString();
                    lblPendingUs.Text = dtLoanProposal.Rows[1]["N_Count"].ToString();
                }
                else
                {
                    tblLoanCount.Visible = false;
                }
                lblTotalValue.Text = String.Format("{0:N}", decimal.Parse(total.ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN"))); 
                //total.ToString("n2");
                ShowUnreadMessageAlert();
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "RMDashBoard.ascx.cs:Page_Load()");

                object[] objects = new object[3];
                objects[0] = rmId;
                objects[1] = total;
                objects[2] = dsCurrentValues;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
           

        }

        private void ShowUnreadMessageAlert()
        {
            msgBo = new MessageBo();

            // Get unread messages from the DB
            int intCount = 0,flavourId = 0;
            intCount = msgBo.GetUnreadMessageCount(userVo.UserId,out flavourId);

            // Store the messages in a label control            
            if (intCount > 0)
            {
                if (Session[SessionContents.UserTopRole] == "RM" && flavourId == 10)
                {
                    lnkBtnNewMessages.Visible = true;
                    lnkBtnNewMessages.Text = "<u>You have " + intCount + " unread messages</u>";
                }
                else
                    lnkBtnNewMessages.Visible = false;
            }
        }

        protected void lnkBtnNewMessages_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loadcontrol('MessageInbox','login');", true);
        }

        public DataSet getCurrentValuesforRM(int RMId)
        {
            DataSet dsCurrentValues = null;
            try
            {
                dsCurrentValues = assetBo.GetRMAssetAggregateCurrentValues(RMId);
             

               
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RMDashboard.ascx.cs:getCurrentValuesforRM()");
                object[] objects = new object[1];
                objects[0] = dsCurrentValues;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            return dsCurrentValues;
        }

        /// <summary>
        /// Modified the function to add total field to the Client List Grid
        /// </summary>
        /// <param name="RMId"></param>
        public void getCustomerListforRM(int RMId,int agentID,string usertype)
        {
            DataSet dsCurrentValues=null;
            double total = 0.00;

            try
            {
                dsCurrentValues = assetBo.GetRMCustomersAssetAggregateCurrentValues(RMId, agentID,usertype);

                if (dsCurrentValues != null)
                {
                    DataTable dtCurrentValusForRM = new DataTable();
                    dtCurrentValusForRM.Columns.Add("CustomerId");
                    dtCurrentValusForRM.Columns.Add("Customer_Name");
                    //if (userType != "associates")
                    //{
                        dtCurrentValusForRM.Columns.Add("EQCurrentVal");
                    //}
                    dtCurrentValusForRM.Columns.Add("MFCurrentVal");
                    dtCurrentValusForRM.Columns.Add("Total");
                    DataRow drCurrentValuesForRM;

                    for (int i = 0; i < dsCurrentValues.Tables[0].Rows.Count; i++)
                    {
                        drCurrentValuesForRM = dtCurrentValusForRM.NewRow();
                        drCurrentValuesForRM[0] = dsCurrentValues.Tables[0].Rows[i]["CustomerId"].ToString();
                        drCurrentValuesForRM[1] = dsCurrentValues.Tables[0].Rows[i]["Customer_Name"].ToString();
                       
                        drCurrentValuesForRM[2] = String.Format("{0:n2}", decimal.Parse(dsCurrentValues.Tables[0].Rows[i]["EQCurrentVal"].ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                        drCurrentValuesForRM[3] = String.Format("{0:n2}", decimal.Parse(dsCurrentValues.Tables[0].Rows[i]["MFCurrentVal"].ToString()).ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                        if (userType != "associates")
                        {
                            total = double.Parse(dsCurrentValues.Tables[0].Rows[i]["EQCurrentVal"].ToString()) + double.Parse(dsCurrentValues.Tables[0].Rows[i]["MFCurrentVal"].ToString());
                            drCurrentValuesForRM[4] = String.Format("{0:n2}", total.ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                        }
                        else
                        {
                            total = double.Parse(dsCurrentValues.Tables[0].Rows[i]["MFCurrentVal"].ToString());
                            drCurrentValuesForRM[4] = String.Format("{0:n2}", total.ToString("n2", System.Globalization.CultureInfo.CreateSpecificCulture("hi-IN")));
                        }
                       

                        dtCurrentValusForRM.Rows.Add(drCurrentValuesForRM);
                    }
                    gvrRMClinetList.DataSource = dtCurrentValusForRM;
                    gvrRMClinetList.DataBind();
                    if (userType == "associates")
                    {
                        gvrRMClinetList.Columns[1].Visible = false;
                       // lnkCustomerName.Visible= false;
                    }
                }

                /* If AUM is zero, donot show customers */
                //gvrRMClinetList.DataSource = dsCurrentValues;
                //gvrRMClinetList.DataBind();
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RMDashboard.ascx:getCustomerListforRM()");
                object[] objects = new object[1];
                objects[0] = dsCurrentValues;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
           
        }

        public void BindCustomerAlerts()
        {
            try
            {
                rmVo = (RMVo)Session[SessionContents.RmVo];
                userVo = (UserVo)Session[SessionContents.UserVo];

                dsCustomerAlerts = alertsBo.GetRMCustomerDashboardAlerts(rmVo.RMId);
                if (dsCustomerAlerts.Tables[0].Rows.Count == 0)
                {
                    lblAlertsMessage.Visible = true;
                }
                else
                {
                    lblAlertsMessage.Visible = false;
                    DataTable dtCustomerAlerts = new DataTable();

                    dtCustomerAlerts.Columns.Add("Customer");
                    dtCustomerAlerts.Columns.Add("Details");
                    dtCustomerAlerts.Columns.Add("EventMessage");


                    foreach (DataRow dr in dsCustomerAlerts.Tables[0].Rows)
                    {
                        drCustomerAlerts = dtCustomerAlerts.NewRow();

                        drCustomerAlerts[0] = dr["CustomerName"].ToString();
                        drCustomerAlerts[1] = dr["EventCode"].ToString() + " : " + dr["Name"].ToString();
                        drCustomerAlerts[2] = dr["EventMessage"].ToString();

                        dtCustomerAlerts.Rows.Add(drCustomerAlerts);

                    }
                    gvCustomerAlerts.DataSource = dtCustomerAlerts;
                    gvCustomerAlerts.DataBind();
                    gvCustomerAlerts.Visible = true;
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

                FunctionInfo.Add("Method", "RMDashBoarad.ascx:BindCustomerAlerts()");


                object[] objects = new object[3];
                objects[0] = rmVo;
                objects[1] = userVo;
                objects[2] = dsCustomerAlerts;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
        }
        //protected void ddlAction_OnSelectedIndexChange(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        DropDownList ddlAction = (DropDownList)sender;
        //        GridViewRow gvr = (GridViewRow)ddlAction.NamingContainer;
        //        int selectedRow = gvr.RowIndex;
        //        customerId = int.Parse(gvCustomers.DataKeys[selectedRow].Value.ToString());
        //        customerVo = customerBo.GetCustomer(customerId);
        //        Session["CustomerVo"] = customerVo;

        //        if (ddlAction.SelectedItem.Value.ToString() == "Profile")
        //        {
        //            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('RMCustomerIndividualDashboard','none');", true);
        //        }
        //        if (ddlAction.SelectedItem.Value.ToString() == "Portfolio")
        //        {
        //            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('PortfolioDashboard','none');", true);
        //        }
        //        if (ddlAction.SelectedItem.Value.ToString() == "Alerts")
        //        {
        //            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('RMAlertDashBoard','none');", true);
        //        }
        //    }
        //    catch (Exception Ex)
        //    {
        //        BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
        //        NameValueCollection FunctionInfo = new NameValueCollection();

        //        FunctionInfo.Add("Method", "RMDashBoard.ascx:ddlAction_OnSelectedIndexChange()");

        //        object[] objects = new object[2];
        //        objects[0] = customerId;
        //        objects[1] = customerVo;

        //        FunctionInfo = exBase.AddObject(FunctionInfo, objects);
        //        exBase.AdditionalInformation = FunctionInfo;
        //        ExceptionManager.Publish(exBase);
        //        throw exBase;

        //    }
        //}

        /// <summary>
        /// Goes to the Customer Dashboard when we click on the Member name on the Client List Grid
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkCustomerNameClientListGrid_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = ((GridViewRow)(((LinkButton)sender).Parent.Parent));
            int rowIndex = gvRow.RowIndex;
            DataKey dk = gvrRMClinetList.DataKeys[rowIndex];
            int customerId = Convert.ToInt32(dk.Value);
            if (customerId != 0)
            {
                Session[SessionContents.FPS_ProspectList_CustomerId] = customerId;
            }
            customerVo = customerBo.GetCustomer(customerId);
            Session["CustomerVo"] = customerVo;
            Session["IsDashboard"] = "CustDashboard";
            if (userType != "associates")
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('AdvisorRMCustIndiDashboard','none');", true);
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "RMCustomerIndividualLeftPane", "loadlinks('RMCustomerIndividualLeftPane','login');", true);
            }
            else
            {
               // lnkCustomerName.Visible = false;
            }
        }

        /// <summary>
        /// Goes to Alert Notifications on the click of the Link below the Alerst grid
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkAlertNotifications_Click(object sender, EventArgs e)
        {
            Session["UserType"] = "rm";
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('AdviserCustomerSMSAlerts','none');", true);
        }
        
    }
}
