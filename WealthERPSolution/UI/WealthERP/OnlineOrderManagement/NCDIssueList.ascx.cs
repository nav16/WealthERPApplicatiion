﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BoUser;
using VoUser;
using WealthERP.Base;
using BoCommon;
using BoOnlineOrderManagement;
using VoOnlineOrderManagemnet;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;
using Telerik.Web.UI;
using System.Text;
using System.Data;


namespace WealthERP.OnlineOrderManagement
{
    public partial class NCDIssueList : System.Web.UI.UserControl
    {
        OnlineBondOrderBo OnlineBondBo = new OnlineBondOrderBo();
        OnlineNCDBackOfficeBo onlineNCDBackOfficeBo = new OnlineNCDBackOfficeBo();
        AdvisorVo advisorVo = new AdvisorVo();
        CustomerVo customerVo = new CustomerVo();
        UserVo userVo;
        int adviserId;
        int customerId;
        string IssuerId = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionBo.CheckSession();
            userVo = (UserVo)Session[SessionContents.UserVo];
            advisorVo = (AdvisorVo)Session["advisorVo"];
            customerVo = (CustomerVo)Session["customerVo"];
            adviserId = advisorVo.advisorId;
            customerId = customerVo.CustomerId;
            if (!IsPostBack)
            {
                //Session["CustId"] = "123456";
                ddlType.SelectedValue = "Curent";
                BindStructureRuleGrid(GetType(ddlType.SelectedValue));
                BindDropDownListIssuer();
            }
        }
        protected void btnGo_Click(object sender, EventArgs e)
        {
            int type = GetType(ddlType.SelectedValue);
            BindStructureRuleGrid(type);

        }
        private int GetType(string ddlSelection)
        {
            int type = 0;
            if (ddlSelection == "Curent")
            {
                type = 1;
            }
            else if (ddlSelection == "Closed")
            {
                type = 2;
            }
            else
            {
                type = 3;
            }
            return type;
        }
        protected void BindStructureRuleGrid(int type)
        {
            DataSet dsStructureRules = OnlineBondBo.GetAdviserIssuerList(adviserId, 0, type);
            DataTable dtIssue = dsStructureRules.Tables[0];
            if (dtIssue.Rows.Count > 0)
            {
                if (Cache["NCDIssueList" + userVo.UserId.ToString()] == null)
                {
                    Cache.Insert("NCDIssueList" + userVo.UserId.ToString(), dtIssue);
                }
                else
                {
                    Cache.Remove("NCDIssueList" + userVo.UserId.ToString());
                    Cache.Insert("NCDIssueList" + userVo.UserId.ToString(), dtIssue);
                }
                //ibtExportSummary.Visible = false;
                gvCommMgmt.DataSource = dtIssue;
                gvCommMgmt.DataBind();
            }
            else
            {
                //ibtExportSummary.Visible = false;
                gvCommMgmt.DataSource = dtIssue;
                gvCommMgmt.DataBind();

            }

            //FILING THE DATA FOR THE CHILD GRID
            // gvCommMgmt.MasterTableView.DetailTables[0].DataSource = dsStructureRules.Tables[1];



        }
        protected void gvCommMgmt_PreRender(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //gvCommMgmt.MasterTableView.Items[0].Expanded = true;
                //gvCommMgmt.MasterTableView.Items[0].ChildItem.NestedTableViews[0].Items[0].Expanded = false;
            }

        }
        protected void BindDropDownListIssuer()
        {
            //int IssuerId = Convert.ToInt32(ddIssuerList.SelectedValue.ToString());
            //DataSet dsStructureRules = OnlineBondBo.GetBindIssuerList();
            //ddlListOfBonds.DataTextField = dsStructureRules.Tables[0].Columns["PFIIM_IssuerName"].ToString();
            //ddlListOfBonds.DataValueField = dsStructureRules.Tables[0].Columns["PFIIM_IssuerId"].ToString();
            //ddlListOfBonds.DataSource = dsStructureRules.Tables[0];
            //ddlListOfBonds.DataBind(); 
        }
        protected void llPurchase_Click(object sender, EventArgs e)
        {
            int rowindex1 = ((GridDataItem)((LinkButton)sender).NamingContainer).RowIndex;
            int rowindex = (rowindex1 / 2) - 1;
            LinkButton lbButton = (LinkButton)sender;
            GridDataItem item = (GridDataItem)lbButton.NamingContainer;
            int IssuerId = int.Parse(gvCommMgmt.MasterTableView.DataKeyValues[rowindex]["AIM_IssueId"].ToString());
            int minQty = int.Parse(gvCommMgmt.MasterTableView.DataKeyValues[rowindex]["AIM_MInQty"].ToString());
            int maxQty = int.Parse(gvCommMgmt.MasterTableView.DataKeyValues[rowindex]["AIM_MaxQty"].ToString());
            string Issuename = gvCommMgmt.MasterTableView.DataKeyValues[rowindex]["AIM_SchemeName"].ToString();
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "TransactionPage", "loadcontrol('NCDIssueTransact','&IssuerId=" + IssuerId + "&Issuename=" + Issuename + "&minQty=" + minQty + "&maxQty=" + maxQty + "');", true);

        }
        protected void btnEquityBond_Click(object sender, EventArgs e)
        {
            //string CustId = Session["CustId"].ToString();

            //string IssuerId = ddlListOfBonds.SelectedValue.ToString();
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "TransactionPage", "loadcontrol('NCDIssueTransact','&customerId=" + customerVo.CustomerId + "&IssuerId=" + IssuerId + " ');", true);


        }
        protected void gvCommMgmt_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "download_file" & e.Item is GridDataItem && e.Item.ItemIndex != -1)
            {
                string filename = gvCommMgmt.MasterTableView.DataKeyValues[e.Item.ItemIndex]["AR_Filename"].ToString();
                if (filename == string.Empty)
                    return;
                string path = MapPath("~/Repository") + "\\advisor_" + advisorVo.advisorId + "\\" + filename;
                byte[] bts = System.IO.File.ReadAllBytes(path);
                Response.Clear();
                Response.ClearHeaders();
                Response.AddHeader("Content-Type", "Application/octet-stream");
                Response.AddHeader("Content-Length", bts.Length.ToString());
                Response.AddHeader("Content-Disposition", "attachment; filename=" + filename);
                Response.BinaryWrite(bts);
                Response.Flush();
                Response.End();
            }
        }

        protected void gvCommMgmt_ItemDataBound(object sender, GridItemEventArgs e)
        {
            int isPurchaseAvailblity = 0;
            if (e.Item is GridDataItem && e.Item.ItemIndex != -1)
            {
                
                LinkButton editButton = (LinkButton)e.Item.FindControl("llPurchase");
                
                if (ddlType.SelectedValue == "Curent")
                {
                    editButton.Visible = true;
                    int IssueId = int.Parse(gvCommMgmt.MasterTableView.DataKeyValues[e.Item.ItemIndex]["AIM_IssueId"].ToString());

                    onlineNCDBackOfficeBo.GetOrdersEligblity(IssueId, ref isPurchaseAvailblity);
                    if (isPurchaseAvailblity == 1)
                    {
                        editButton.Enabled = true;
                    }
                    else
                    {
                        editButton.Enabled = false;
                    }
                }
                else
                {
                    editButton.Visible = false;
                }
            }


        }

        protected void btnExpandAll_Click(object sender, EventArgs e)
        {
            DataTable dtIssueDetail;
            int strIssuerId = 0;
            LinkButton buttonlink = (LinkButton)sender;
            GridDataItem gdi;
            gdi = (GridDataItem)buttonlink.NamingContainer;
          
            strIssuerId = int.Parse(gvCommMgmt.MasterTableView.DataKeyValues[gdi.ItemIndex]["AIM_IssueId"].ToString());
            RadGrid gvchildIssue = (RadGrid)gdi.FindControl("gvChildDetails");
            Panel pnlchild = (Panel)gdi.FindControl("pnlchild");
            
            if (pnlchild.Visible == false)
            {
                pnlchild.Visible = true;
                buttonlink.Text = "-";
            }
            else if (pnlchild.Visible == true)
            {
                pnlchild.Visible = false;
                buttonlink.Text = "+";
            }
            DataSet ds = OnlineBondBo.GetIssueDetail(strIssuerId);
            dtIssueDetail = ds.Tables[0];
            gvchildIssue.DataSource = dtIssueDetail;
            gvchildIssue.DataBind();
        }
        protected void gvChildDetails_ItemDataBound(object sender, GridItemEventArgs e)
        {



        }
        protected void gvCommMgmt_OnNeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            DataTable dtIssueDetail;
            dtIssueDetail = (DataTable)Cache["NCDIssueList" + userVo.UserId.ToString()];
            if (dtIssueDetail != null)
            {
                gvCommMgmt.DataSource = dtIssueDetail;
            }

        }
        protected void gvChildDetails_OnNeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGrid gvchildIssue = (RadGrid)sender; // Get reference to grid 
            GridDataItem nesteditem = (GridDataItem)gvchildIssue.NamingContainer;
            int strIssuerId = int.Parse(gvCommMgmt.MasterTableView.DataKeyValues[nesteditem.ItemIndex]["AIM_IssueId"].ToString()); // Get the value 
            DataSet ds = OnlineBondBo.GetIssueDetail(strIssuerId);
            gvchildIssue.DataSource = ds.Tables[0];
        }
        public void ibtExportSummary_OnClick(object sender, ImageClickEventArgs e)
        {
            gvCommMgmt.ExportSettings.OpenInNewWindow = true;
            gvCommMgmt.ExportSettings.IgnorePaging = true;
            gvCommMgmt.ExportSettings.HideStructureColumns = true;
            gvCommMgmt.ExportSettings.ExportOnlyData = true;
            gvCommMgmt.ExportSettings.FileName = "NCD Issue List";
            gvCommMgmt.ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML;
            gvCommMgmt.MasterTableView.ExportToExcel();
        }
    }
}