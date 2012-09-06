﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VoUser;
using BoUser;
using BoAdvisorProfiling;
using BoCustomerProfiling;
using System.Data;
using WealthERP.Customer;
using System.Collections.Specialized;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using WealthERP.Base;
using System.IO;
using System.Web.UI.HtmlControls;
using iTextSharp.text;
using iTextSharp.text.html;
using iTextSharp.text.pdf;
using System.Xml;
using System.Text;
using iTextSharp.text.html.simpleparser;
using VoCustomerPortfolio;
using BoCustomerPortfolio;
using BoCommon;
using System.Configuration;
using Telerik.Web.UI;
using VoUser;

namespace WealthERP.Advisor
{
    public partial class AdvisorMISCommission : System.Web.UI.UserControl
    {
        AdvisorMISBo advisorMISBo=new AdvisorMISBo();
        string path = string.Empty;
        DataSet dsMISCommission=new DataSet();
        UserVo userVo = new UserVo();
        DateBo dtBo = new DateBo();
        DateTime dtTo = new DateTime();
        DateTime dtFrom = new DateTime();
        AdvisorVo advisorVo = new AdvisorVo();

        protected void Page_Load(object sender, EventArgs e)
        {
            advisorVo = (AdvisorVo)Session["advisorVo"];
            trCommissionMIS.Visible = false;
            gvCommissionMIS.Visible = false;
            if (!Page.IsPostBack)
            {
                BindPeriodDropDown();
                RadioButtonClick(sender, e);
                ddlMISType.SelectedIndex = 0;
            }
        }
        /// <summary>
        /// Binding Period Dropdown From Xml File
        /// </summary>        
        private void BindPeriodDropDown()
        {            
            path = Server.MapPath(ConfigurationManager.AppSettings["xmllookuppath"].ToString());
            DataTable dtPeriod;
            dtPeriod = XMLBo.GetDatePeriod(path);
            ddlPeriod.DataSource = dtPeriod;
            ddlPeriod.DataTextField = "PeriodType";
            ddlPeriod.DataValueField = "PeriodCode";
            ddlPeriod.DataBind();
            ddlPeriod.Items.Insert(0, new RadComboBoxItem("Select a Period","0"));
            ddlPeriod.Items.Remove(15);
        }
        public void BindCommissionMISGrid()
        {
            DataTable dtMIS;
            //string misType = null;
            //ddlMISType.SelectedValue = misType;
            userVo=(UserVo)Session["userVo"];
            double sumTotal;
            if (hdnCurrentPage.Value.ToString() != "")
            {
            }
            dsMISCommission = advisorMISBo.GetMFMISCommission(advisorVo.advisorId, hdnMISType.Value.ToString(), DateTime.Parse(hdnFromDate.Value.ToString()), DateTime.Parse(hdnToDate.Value.ToString()), out sumTotal);            
            if (dsMISCommission.Tables[0].Rows.Count > 0)
            {
                trCommissionMIS.Visible = true;
                dtMIS = dsMISCommission.Tables[0];
                string misType = hdnMISType.Value.ToString();                
                tblMessage.Visible = false;
                ErrorMessage.Visible = false;
                Label lblHeaderText = new Label();
                GridBoundColumn ghItem = gvCommissionMIS.MasterTableView.Columns.FindByUniqueName("MISType") as GridBoundColumn;
                GridBoundColumn ghItem1 = gvCommissionMIS.MasterTableView.Columns.FindByUniqueName("CustomerName") as GridBoundColumn;
                GridBoundColumn ghItem2 = gvCommissionMIS.MasterTableView.Columns.FindByUniqueName("RM_Name") as GridBoundColumn;
                GridBoundColumn ghItem3 = gvCommissionMIS.MasterTableView.Columns.FindByUniqueName("AB_BranchName") as GridBoundColumn; 
                switch (misType)
                {
                    case "Folio Wise":
                        ghItem.HeaderText = "Folio Number";
                        ghItem.DataField = "folio";
                        ghItem1.Visible = true;
                        ghItem2.Visible = true;
                        ghItem3.Visible = true;
                        break;
                    case "AMC Wise":
                        ghItem.HeaderText = "AMC Name";
                        ghItem.DataField = "AMCCODE";
                        ghItem1.Visible = true;
                        ghItem2.Visible = true;
                        ghItem3.Visible = true;
                        break;
                    case "Transaction_Wise":
                        ghItem.HeaderText = "Transaction Classification Name";
                        ghItem.DataField = "TransactionType";
                        ghItem1.Visible = true;
                        ghItem2.Visible = true;
                        ghItem3.Visible = true;
                        break;
                    case "Category Wise":
                        ghItem.HeaderText = "Category";
                        ghItem.DataField = "categoryName";
                        ghItem1.Visible = false;
                        ghItem2.Visible = false;
                        ghItem3.Visible = false;
                        break;
                    default:
                        ghItem.HeaderText = "Folio Number";
                        ghItem.DataField = "";
                        ghItem1.Visible = true;
                        ghItem2.Visible = true;
                        ghItem3.Visible = true;
                        break;
                }

              

                gvCommissionMIS.DataSource = dtMIS;
                gvCommissionMIS.CurrentPageIndex = 0;                
                gvCommissionMIS.DataBind();
                gvCommissionMIS.Visible = true;

                if (Cache["MIS"+ advisorVo.advisorId] == null)
                {
                    Cache.Insert("MIS" + advisorVo.advisorId, dtMIS);
                }
                else
                {
                    Cache.Remove("MIS" + advisorVo.advisorId);
                    Cache.Insert("MIS" + advisorVo.advisorId, dtMIS);
                }


            }
            else
            {
                gvCommissionMIS.Visible = false;                
                tblMessage.Visible = true;
                ErrorMessage.Visible = true;
                ErrorMessage.InnerText = "No Records Found...!";
            }           
        }
        protected void btnView_Click(object sender, EventArgs e)
        {
            hdnMISType.Value = ddlMISType.SelectedValue.ToString();
            CalculateDateRange(out dtFrom, out dtTo);
            hdnFromDate.Value = dtFrom.ToString();
            hdnToDate.Value = dtTo.ToString();
            hdnRecordCount.Value = "1";

            GridColumn column = gvCommissionMIS.MasterTableView.GetColumnSafe("MISType");
            column.CurrentFilterFunction = GridKnownFunction.Contains;
            column.CurrentFilterValue = null;
            gvCommissionMIS.MasterTableView.Rebind();

            gvCommissionMIS.MasterTableView.FilterExpression = null;
            gvCommissionMIS.MasterTableView.SortExpressions.Clear();
            gvCommissionMIS.MasterTableView.Rebind();
            gvCommissionMIS.MasterTableView.ClearEditItems();
            gvCommissionMIS.MasterTableView.IsItemInserted = false;
            gvCommissionMIS.Rebind();
            BindCommissionMISGrid();
        }
        /// <summary>
        /// Get the From and To Date of reports
        /// </summary>
        private void CalculateDateRange(out DateTime fromDate, out DateTime toDate)
        {
            if (rbtnPickDate.Checked)
            {
                fromDate = DateTime.Parse((txtFromDate.SelectedDate.Value).ToString());
                toDate = DateTime.Parse((txtToDate.SelectedDate.Value).ToString());
            }
            else if (rbtnPickPeriod.Checked)
            {
                dtBo.CalculateFromToDatesUsingPeriod(ddlPeriod.SelectedValue.ToString(), out dtFrom, out dtTo);
                fromDate = dtFrom;
                toDate = dtTo;
            }
            else
            {
                fromDate = DateTime.MinValue;
                toDate = DateTime.MinValue;
            }
        }
        
        public void RadioButtonClick(object sender, EventArgs e)
        {
            if (rbtnPickPeriod.Checked)
            {
                lblPeriod.Visible = true;
                ddlPeriod.Visible = true;
                lblFromDate.Visible = false;
                txtFromDate.Visible = false;
                lblToDate.Visible = false;
                txtToDate.Visible = false;
                PickADateValidation.Visible = false;
                PickAPeriodValidation.Visible = true;
            }
            else if (rbtnPickDate.Checked)
            {             
                lblPeriod.Visible = false;
                ddlPeriod.Visible = false;
                lblFromDate.Visible = true;
                txtFromDate.Visible = true;
                lblToDate.Visible = true;
                txtToDate.Visible = true;
                PickAPeriodValidation.Visible = false;
                PickADateValidation.Visible = true;
            }
        }
        protected void btnCommissionMIS_OnClick(object sender, ImageClickEventArgs e)
        {
            gvCommissionMIS.ExportSettings.OpenInNewWindow = true;
            gvCommissionMIS.ExportSettings.IgnorePaging = true;
            foreach (GridFilteringItem filter in gvCommissionMIS.MasterTableView.GetItems(GridItemType.FilteringItem))
            {
                filter.Visible = false;
            }
            gvCommissionMIS.MasterTableView.ExportToExcel();
        }
        public void gvCommissionMIS_OnNeedDataSource(object sender, EventArgs e)
        {
            gvCommissionMIS.Visible = true;
            trCommissionMIS.Visible = true;
            DataTable dtMIS = new DataTable();
            dtMIS = (DataTable)Cache["MIS" + advisorVo.advisorId];
            gvCommissionMIS.DataSource = dtMIS;
        }
    }
}