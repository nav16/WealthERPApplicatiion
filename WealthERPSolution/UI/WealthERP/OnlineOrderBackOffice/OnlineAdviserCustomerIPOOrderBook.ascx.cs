﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using VoUser;
using BoOnlineOrderManagement;
using WealthERP.Base;

namespace WealthERP.OnlineOrderBackOffice
{
    public partial class OnlineAdviserCustomerIPOOrderBook : System.Web.UI.UserControl
    {

        UserVo userVo;
        OnlineMFOrderBo OnlineMFOrderBo = new OnlineMFOrderBo();
        AdvisorVo advisorVo;
        DateTime fromDate;
        DateTime toDate;
        int AIMissueId = 0;
        int orderId = 0;
        int debitstatus = 0;
        BoOnlineOrderManagement.OnlineBondOrderBo BoOnlineBondOrder = new BoOnlineOrderManagement.OnlineBondOrderBo();
        OnlineNCDBackOfficeBo onlineNCDBackOfficeBo = new OnlineNCDBackOfficeBo();
        OnlineIPOBackOfficeBo OnlineIPOBackOfficeBo = new OnlineIPOBackOfficeBo();
        protected void Page_Load(object sender, EventArgs e)
        {

            userVo = (UserVo)Session[SessionContents.UserVo];
            advisorVo = (AdvisorVo)Session["advisorVo"];
            if (Request.QueryString["orderId"] == null)
            {
                fromDate = DateTime.Now.AddMonths(-1);
                txtOrderFrom.SelectedDate = fromDate.Date;
                txtOrderTo.SelectedDate = DateTime.Now;
            }
            BindOrderStatus();
            BindIssueName();
            if (!IsPostBack)
            {
                if (Request.QueryString["AIMissueId"] != null && Request.QueryString["orderId"] != null && Request.QueryString["fromDate"] != null && Request.QueryString["toDate"] != null)
                {
                    AIMissueId = int.Parse(Request.QueryString["AIMissueId"].ToString());
                    orderId = int.Parse(Request.QueryString["orderId"].ToString());
                    fromDate = Convert.ToDateTime(Request.QueryString["fromDate"].ToString());
                    toDate = Convert.ToDateTime(Request.QueryString["toDate"].ToString());
                    txtOrderFrom.SelectedDate = fromDate;
                    txtOrderTo.SelectedDate = toDate;
                    ddlOrderStatus.SelectedValue = "PR";
                    ddlIssueName.SelectedValue = AIMissueId.ToString();
                    //hdnOrderStatus.Value = "PR";
                    BindAdviserNCCOrderBook();
                }
                if (Request.QueryString["orderId"] != null)
                {
                    ViewState["OrderId"] = int.Parse(Request.QueryString["orderId"].ToString());
                    BindAdviserNCCOrderBook();
                    divConditional.Visible = false;
                }
            }
        }
        protected void BindIssueName()
        {
            DataTable dtGetIssueName = new DataTable();

            dtGetIssueName = onlineNCDBackOfficeBo.GetIssueName(advisorVo.advisorId, "IP");
            ddlIssueName.DataSource = dtGetIssueName;
            ddlIssueName.DataValueField = dtGetIssueName.Columns["AIM_IssueId"].ToString();
            ddlIssueName.DataTextField = dtGetIssueName.Columns["AIM_IssueName"].ToString();
            ddlIssueName.DataBind();
            ddlIssueName.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
        private void SetParameter()
        {
            if (ddlOrderStatus.SelectedIndex != 0)
            {
                hdnOrderStatus.Value = ddlOrderStatus.SelectedValue;
                ViewState["OrderstatusDropDown"] = hdnOrderStatus.Value;
            }
            else
            {
                hdnOrderStatus.Value = "0";
            }
        }
        /// <summary>
        /// Get Bind Orderstatus
        /// </summary>
        private void BindOrderStatus()
        {
            ddlOrderStatus.Items.Clear();
            DataSet dsOrderStatus;
            DataTable dtOrderStatus;
            dsOrderStatus = OnlineMFOrderBo.GetOrderStatus();
            dtOrderStatus = dsOrderStatus.Tables[0];
            if (dtOrderStatus.Rows.Count > 0)
            {
                ddlOrderStatus.DataSource = dtOrderStatus;
                ddlOrderStatus.DataTextField = dtOrderStatus.Columns["WOS_OrderStep"].ToString();
                ddlOrderStatus.DataValueField = dtOrderStatus.Columns["WOS_OrderStepCode"].ToString();
                ddlOrderStatus.DataBind();
            }
            ddlOrderStatus.Items.Insert(0, new ListItem("All", "0"));
        }
        protected void btnViewOrder_Click(object sender, EventArgs e)
        {
            SetParameter();
            BindAdviserNCCOrderBook();
        }
        protected void BindAdviserNCCOrderBook()
        {
            DataTable dtIPOOrder;
            if (Request.QueryString["orderId"] != null)
            {
                            
                dtIPOOrder = OnlineIPOBackOfficeBo.GetAdviserIPOOrderBook(advisorVo.advisorId,0, "0", fromDate, toDate, int.Parse(  ViewState["OrderId"].ToString()),ddlBidType.SelectedValue);

            }
            else
            {
                if (txtOrderFrom.SelectedDate != null)
                    fromDate = DateTime.Parse(txtOrderFrom.SelectedDate.ToString());
                if (txtOrderTo.SelectedDate != null)
                    toDate = DateTime.Parse(txtOrderTo.SelectedDate.ToString());

                dtIPOOrder = OnlineIPOBackOfficeBo.GetAdviserIPOOrderBook(advisorVo.advisorId, Convert.ToInt32(ddlIssueName.SelectedValue.ToString()), ddlOrderStatus.SelectedValue, fromDate, toDate, orderId, ddlBidType.SelectedValue);
            }
                if (dtIPOOrder.Rows.Count >= 0)
            {
                if (Cache["IPOBookList" + userVo.UserId.ToString()] == null)
                {
                    Cache.Insert("IPOBookList" + userVo.UserId.ToString(), dtIPOOrder);
                }
                else
                {
                    Cache.Remove("IPOBookList" + userVo.UserId.ToString());
                    Cache.Insert("IPOBookList" + userVo.UserId.ToString(), dtIPOOrder);
                }
                gvIPOOrderBook.DataSource = dtIPOOrder;
                gvIPOOrderBook.DataBind();
                ibtExportSummary.Visible = true;
                pnlGrid.Visible = true;
            }
            else
            {
                ibtExportSummary.Visible = false;
                gvIPOOrderBook.DataSource = dtIPOOrder;
                gvIPOOrderBook.DataBind();
                pnlGrid.Visible = true;
            }
        }
        protected void gvIPOOrderBook_UpdateCommand(object source, GridCommandEventArgs e)
        {
            bool lbResult = false;
            string strRemark = string.Empty;
            if (e.CommandName == RadGrid.UpdateCommandName)
            {
                GridEditableItem editItem = e.Item as GridEditableItem;
                TextBox txtRemark = (TextBox)e.Item.FindControl("txtRemark");
                strRemark = txtRemark.Text;
                LinkButton buttonEdit = editItem["MarkAsReject"].Controls[0] as LinkButton;
                //   Label extractStepCode = editItem["WES_Code"].Controls[1] as Label;
                Int32 orderId = Convert.ToInt32(gvIPOOrderBook.MasterTableView.DataKeyValues[e.Item.ItemIndex]["CO_OrderId"].ToString());
                string extractionStepCode = gvIPOOrderBook.MasterTableView.DataKeyValues[e.Item.ItemIndex]["WES_Code"].ToString();
                if (extractionStepCode == string.Empty)
                {
                    string AcntId = gvIPOOrderBook.MasterTableView.DataKeyValues[e.Item.ItemIndex]["C_CustCode"].ToString();
                    double AmountPayable = Convert.ToDouble(gvIPOOrderBook.MasterTableView.DataKeyValues[e.Item.ItemIndex]["Amount"].ToString());
                    lbResult = BoOnlineBondOrder.cancelBondsBookOrder(orderId, 2, txtRemark.Text);

                    BoOnlineBondOrder.DebitRMSUserAccountBalance(AcntId, AmountPayable, 0,out debitstatus);
                   
                    if (lbResult == true)
                    {
                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Pageloadscript", "alert('Order Cancelled Successfully');", true);
                    }
                    BindAdviserNCCOrderBook();

                }
                else
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Pageloadscript", "alert('Order Cant be Cancelled as it is Extracted.');", true);

                }
            }
        }
        
        protected void gvIPOOrderBook_ItemDataBound(object sender, GridItemEventArgs e)
        {

            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                LinkButton lbtnMarkAsReject = dataItem["MarkAsReject"].Controls[0] as LinkButton;
                string OrderStepCode = Convert.ToString(gvIPOOrderBook.MasterTableView.DataKeyValues[e.Item.ItemIndex]["WOS_OrderStep"]);
                Boolean isCancel = Convert.ToBoolean(gvIPOOrderBook.MasterTableView.DataKeyValues[e.Item.ItemIndex]["AIM_IsCancelAllowed"].ToString());
                if (OrderStepCode == "INPROCESS" && isCancel != false)
                {
                    lbtnMarkAsReject.Visible = true;
                }
                else
                {
                    lbtnMarkAsReject.Visible = false;
                }
            }
        }

    
        protected void btnExpandAll_Click(object sender, EventArgs e)
        {
            int strIssuerId = 0;
            LinkButton buttonlink = (LinkButton)sender;
            GridDataItem gdi;
            gdi = (GridDataItem)buttonlink.NamingContainer;
            strIssuerId = int.Parse(gvIPOOrderBook.MasterTableView.DataKeyValues[gdi.ItemIndex]["AIM_IssueId"].ToString());
            int orderId = int.Parse(gvIPOOrderBook.MasterTableView.DataKeyValues[gdi.ItemIndex]["CO_OrderId"].ToString());
            RadGrid gvIPODetails = (RadGrid)gdi.FindControl("gvIPODetails");
            Panel PnlChild = (Panel)gdi.FindControl("pnlchild");
            if (PnlChild.Visible == false)
            {
                PnlChild.Visible = true;
                buttonlink.Text = "-";
            }
            else if (PnlChild.Visible == true)
            {
                PnlChild.Visible = false;
                buttonlink.Text = "+";
            }
            DataTable dtIPOOrderBook = OnlineIPOBackOfficeBo.GetAdviserIPOOrderSubBook(advisorVo.advisorId, strIssuerId, orderId);
            gvIPODetails.DataSource = dtIPOOrderBook;
            gvIPODetails.DataBind();
        }
        protected void gvIPOOrderBook_OnNeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            DataTable dtIPOOrderBook;
            dtIPOOrderBook = (DataTable)Cache["IPOBookList" + userVo.UserId.ToString()];
            if (dtIPOOrderBook != null)
            {
                gvIPOOrderBook.DataSource = dtIPOOrderBook;
            }

        }
        public void ibtExport_OnClick(object sender, ImageClickEventArgs e)
        {
            //  gvIPOOrderBook.MasterTableView.DetailTables[0].HierarchyDefaultExpanded = true;
            gvIPOOrderBook.MasterTableView.HierarchyLoadMode = GridChildLoadMode.ServerBind;
            gvIPOOrderBook.ExportSettings.OpenInNewWindow = true;
            gvIPOOrderBook.ExportSettings.IgnorePaging = true;
            gvIPOOrderBook.ExportSettings.HideStructureColumns = true;
            gvIPOOrderBook.ExportSettings.ExportOnlyData = true;
            gvIPOOrderBook.ExportSettings.FileName = "IPO Order Book";
            gvIPOOrderBook.ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML;
            gvIPOOrderBook.MasterTableView.ExportToExcel();

        }
        protected void btnExpand_Click(object sender, EventArgs e)
        {
            LinkButton button1 = (LinkButton)sender;
            if (button1.Text == "+")
            {
                foreach (GridDataItem gvr in this.gvIPOOrderBook.Items)
                {

                    DataTable dtIssueDetail;
                    int strIssuerId = 0;
                    LinkButton button = (LinkButton)gvr.FindControl("lbDetails");
                    RadGrid gvIPODetails = (RadGrid)gvr.FindControl("gvIPODetails");
                    Panel PnlChild = (Panel)gvr.FindControl("pnlchild");
                    strIssuerId = int.Parse(gvIPOOrderBook.MasterTableView.DataKeyValues[gvr.ItemIndex]["AIM_IssueId"].ToString());
                    int orderId = int.Parse(gvIPOOrderBook.MasterTableView.DataKeyValues[gvr.ItemIndex]["CO_OrderId"].ToString());
                    DataTable dtIPOOrderBook = OnlineIPOBackOfficeBo.GetAdviserIPOOrderSubBook(advisorVo.advisorId, strIssuerId, orderId);
                    dtIssueDetail = dtIPOOrderBook;
                    gvIPODetails.DataSource = dtIssueDetail;
                    gvIPODetails.DataBind();
                    if (PnlChild.Visible == false)
                    {
                        PnlChild.Visible = true;
                        button.Text = "-";
                    }

                }
                button1.Text = "-";
            }
            else
            {
                foreach (GridDataItem gvr in this.gvIPOOrderBook.Items)
                {
                    LinkButton button = (LinkButton)gvr.FindControl("lbDetails");
                    Panel PnlChild = (Panel)gvr.FindControl("pnlchild");
                    if (PnlChild.Visible == true)
                        PnlChild.Visible = false;
                    button.Text = "+";
                }
                button1.Text = "+";
            }

        }
    }
}
