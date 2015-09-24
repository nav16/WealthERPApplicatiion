﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BoWerpAdmin;
using BoProductMaster;
using System.Data;
using VoOnlineOrderManagemnet;
using BoOnlineOrderManagement;
using BoCommon;
using VoUser;
using VoCustomerPortfolio;
using System.Web.Services;
using System.Web.Script.Services;
using System.Net;
using System.IO;
using System.Configuration;
using System.Text;
using InfoSoftGlobal;
namespace WealthERP.OnlineOrderManagement
{
    public partial class MFSchemeDetails : System.Web.UI.UserControl
    {
        OnlineMFSchemeDetailsBo onlineMFSchemeDetailsBo = new OnlineMFSchemeDetailsBo();
        CustomerVo customerVo = new CustomerVo();
        List<int> schemeCompareList=new List<int>();
        OnlineMFSchemeDetailsVo onlineMFSchemeDetailsVo;
        CommonLookupBo commonLookupBo = new CommonLookupBo();
        protected void Page_Load(object sender, EventArgs e)
        {
            OnlineUserSessionBo.CheckSession();
            customerVo = (CustomerVo)Session["CustomerVo"];
            if (!IsPostBack)
            {
                BindAMC();
                if (Session["MFSchemePlan"] != null || Request.QueryString["schemeCode"]!=null)
                {
                    if(Request.QueryString["schemeCode"]!=null)
                    Session["MFSchemePlan"] = Request.QueryString["schemeCode"];
                    int amcCode = 0;
                    string category = string.Empty;
                    BindCategory();
                    commonLookupBo.GetSchemeAMCCategory(int.Parse(Session["MFSchemePlan"].ToString()), out amcCode, out category);
                    int schemecode = int.Parse(Session["MFSchemePlan"].ToString());
                    ddlAMC.SelectedValue = amcCode.ToString();
                    ddlCategory.SelectedValue = category;
                    BindScheme();
                    ddlScheme.SelectedValue = schemecode.ToString();
                    GetAmcSchemeDetails();
                    hidCurrentScheme.Value = ddlScheme.SelectedValue;
                    BindfundManagerDetails();
                }
            }
        }
        protected void ddlAMC_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlAMC.SelectedIndex != 0)
            {
                BindCategory();
                BindfundManagerDetails();
            }
        }
        protected void ddlCategory_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            BindScheme();
        }
        private void BindAMC()
        {

            DataTable dtGetAMCList = new DataTable();
            CommonLookupBo commonLookupBo = new CommonLookupBo();
            dtGetAMCList = commonLookupBo.GetProdAmc(0, true);
            ddlAMC.DataSource = dtGetAMCList;
            ddlAMC.DataTextField = dtGetAMCList.Columns["PA_AMCName"].ToString();
            ddlAMC.DataValueField = dtGetAMCList.Columns["PA_AMCCode"].ToString();
            ddlAMC.DataBind();
            ddlAMC.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select", "0"));
        }
        protected void BindScheme()
        {
            DataTable dt;
            OnlineMFSchemeDetailsBo OnlineMFSchemeDetailsBo = new OnlineMFSchemeDetailsBo();
            dt = OnlineMFSchemeDetailsBo.GetAMCandCategoryWiseScheme(int.Parse(ddlAMC.SelectedValue), ddlCategory.SelectedValue);
            if (dt.Rows.Count > 0)
            {
                ddlScheme.DataSource = dt;
                ddlScheme.DataValueField = "PASP_SchemePlanCode";
                ddlScheme.DataTextField = "PASP_SchemePlanName";
                ddlScheme.DataBind();
                ddlScheme.Items.Insert(0, new System.Web.UI.WebControls.ListItem("select", "0"));
            }
        }
        private void BindCategory()
        {
            DataSet dsProductAssetCategory;
            ProductMFBo productMFBo = new ProductMFBo();
            dsProductAssetCategory = productMFBo.GetProductAssetCategory();
            DataTable dtCategory = dsProductAssetCategory.Tables[0];
            ddlCategory.DataSource = dtCategory;
            ddlCategory.DataValueField = dtCategory.Columns["PAIC_AssetInstrumentCategoryCode"].ToString();
            ddlCategory.DataTextField = dtCategory.Columns["PAIC_AssetInstrumentCategoryName"].ToString();
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("select", "0"));
        }
        protected void Go_OnClick(object sender, EventArgs e)
        {
            GetAmcSchemeDetails();
            hidCurrentScheme.Value = ddlScheme.SelectedValue;
        }
        public void GetAmcSchemeDetails()
        {
            DataTable dtNavDetails;
           onlineMFSchemeDetailsVo= onlineMFSchemeDetailsBo.GetSchemeDetails(int.Parse(ddlAMC.SelectedValue), int.Parse(ddlScheme.SelectedValue), ddlCategory.SelectedValue,out  dtNavDetails);

           StringBuilder strXML = new StringBuilder();
           strXML.Append(@"<chart caption='Scheme performance' xAxisName='Date'  yAxisName='NAV' anchorBgColor='FF3300' bgColor='FFFFFF' showBorder='0'  canvasBgColor='FFFFFF' lineColor='2480C7' >");
           strXML.Append(@" <categories>");
           foreach (DataRow dr in dtNavDetails.Rows)
           {
               strXML.AppendFormat("<category label ='{0}' />", dr["PSP_Date"]);
           }
           strXML.AppendFormat(@" </categories> <dataset seriesName='{0}'>", onlineMFSchemeDetailsVo.schemeName);
           foreach (DataRow dr in dtNavDetails.Rows)
           {
               strXML.AppendFormat("<set value ='{0}' />", dr["PSP_NetAssetValue"].ToString());
           }
           strXML.Append("</dataset>");

           strXML.Append(@"<vTrendlines>  <line startValue='895' color='FF0000' toolText='NAV' displayValue='Average' showOnTop='1' /></vTrendlines> </chart>");
           
           Literal1.Text = FusionCharts.RenderChartHTML("../FusionCharts/ZoomLine.swf", "", strXML.ToString(), "FactorySum", "100%", "400", false, true, false);


            lblSchemeName.Text = onlineMFSchemeDetailsVo.schemeName;
            lblAMC.Text = onlineMFSchemeDetailsVo.amcName;
            lblNAV.Text = onlineMFSchemeDetailsVo.NAV.ToString();
            lblNAVDate.Text = onlineMFSchemeDetailsVo.navDate.ToString();
            lblCategory.Text = onlineMFSchemeDetailsVo.category;
            lblBanchMark.Text = onlineMFSchemeDetailsVo.schemeBanchMark;
            lblFundManager.Text = onlineMFSchemeDetailsVo.fundManager;
            lblFundReturn1styear.Text = onlineMFSchemeDetailsVo.fundReturn3rdYear.ToString();
            lblFundReturn3rdyear.Text = onlineMFSchemeDetailsVo.fundReturn5thtYear.ToString();
            lblFundReturn5thyear.Text = onlineMFSchemeDetailsVo.fundReturn10thYear.ToString();
            lblBenchmarkReturn.Text = onlineMFSchemeDetailsVo.benchmarkReturn1stYear;
            lblBenchMarkReturn3rd.Text = onlineMFSchemeDetailsVo.benchmark3rhYear;
            lblBenchMarkReturn5th.Text = onlineMFSchemeDetailsVo.benchmark5thdYear;
            lblMinSIP.Text = onlineMFSchemeDetailsVo.minSIPInvestment.ToString();
            lblSIPMultipleOf.Text = onlineMFSchemeDetailsVo.SIPmultipleOf.ToString();
            lblExitLoad.Text = onlineMFSchemeDetailsVo.exitLoad.ToString();
            lblMinInvestment.Text = onlineMFSchemeDetailsVo.minmumInvestmentAmount.ToString();
            lblMinMultipleOf.Text = onlineMFSchemeDetailsVo.multipleOf.ToString();
            if (onlineMFSchemeDetailsVo.mornigStar > 0)
            {
                imgSchemeRating.ImageUrl = @"../Images/MorningStarRating/RatingSmallIcon/" + onlineMFSchemeDetailsVo.mornigStar + ".png";
                imgStyleBox.ImageUrl = @"../Images/MorningStarRating/StarStyleBox/" + onlineMFSchemeDetailsVo.schemeBox + ".png";
            }
            else
            {
                imgSchemeRating.ImageUrl = @"../Images/MorningStarRating/RatingSmallIcon/0.png";
                imgStyleBox.ImageUrl = @"../Images/MorningStarRating/StarStyleBox/0.png";

            }
        }
        protected void lbBuy_OnClick(object sender, EventArgs e)
        {
            if (ddlScheme.SelectedValue != "")
            {
                if (Session["PageDefaultSetting"] != null)
                {
                    Session["MFSchemePlan"] = ddlScheme.SelectedValue;
                    LoadMFTransactionPage("MFOrderPurchaseTransType", 2);

                }
                else
                {
                    Response.Redirect("ControlHost.aspx?pageid=MFOrderPurchaseTransType&Amc=" + ddlAMC.SelectedValue + "&SchemeCode=" + ddlScheme.SelectedValue + "&category=" + ddlCategory.SelectedValue + "", false);

                }
            }
        }
        protected void lbAddPurchase_OnClick(object sender, EventArgs e)
        {
            if (ddlScheme.SelectedValue != "")
            {
                if (Session["PageDefaultSetting"] != null)
                {
                    Session["MFSchemePlan"] = ddlScheme.SelectedValue;
                    LoadMFTransactionPage("MFOrderAdditionalPurchase",2);

                }
                else
                {
                    Response.Redirect("ControlHost.aspx?pageid=MFOrderAdditionalPurchase&Amc=" + ddlAMC.SelectedValue + "&SchemeCode=" + ddlScheme.SelectedValue + "&category=" + ddlCategory.SelectedValue + "", false);

                }
            }
        }
        protected void lbSIP_OnClick(object sender, EventArgs e)
        {
            if (ddlScheme.SelectedValue != "")
            {
                if (Session["PageDefaultSetting"] != null)
                {
                    Session["MFSchemePlan"] = ddlScheme.SelectedValue;
                    LoadMFTransactionPage("MFOrderSIPTransType",2);

                }
                else
                {
                    Response.Redirect("ControlHost.aspx?pageid=MFOrderSIPTransType&Amc=" + ddlAMC.SelectedValue + "&SchemeCode=" + ddlScheme.SelectedValue + "&category=" + ddlCategory.SelectedValue + "", false);

                }
            }
        }
        protected void lbRedem_OnClick(object sender, EventArgs e)
        {
            if (ddlScheme.SelectedValue != "")
            {
                if (Session["PageDefaultSetting"] != null)
                {
                    Session["MFSchemePlan"] = ddlScheme.SelectedValue;
                    LoadMFTransactionPage("MFOrderRdemptionTransType",2);

                }
                else
                {
                    Response.Redirect("ControlHost.aspx?pageid=MFOrderRdemptionTransType&Amc=" + ddlAMC.SelectedValue + "&SchemeCode=" + ddlScheme.SelectedValue + "&category=" + ddlCategory.SelectedValue + "", false);

                }
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        //public object GetData()
        //{
        protected void BindfundManagerDetails()
        {
            //string cmotcode = onlineMFSchemeDetailsBo.GetCmotCode((!string.IsNullOrEmpty(Session["MFSchemePlan"].ToString())) ? int.Parse(Session["MFSchemePlan"].ToString()) : int.Parse(ddlScheme.SelectedValue));
            //string result;
            //if (cmotcode != "")
            //{
            //    string FundManagerDetais = ConfigurationSettings.AppSettings["FUND_MANAGER_DETAILS"] + cmotcode + "/Pre";
            //    WebResponse response;
            //    WebRequest request = HttpWebRequest.Create(FundManagerDetais);
            //    response = request.GetResponse();
            //    using (StreamReader reader = new StreamReader(response.GetResponseStream()))
            //    {
            //        result = reader.ReadToEnd();
            //        reader.Close();
            //    }
            //    StringReader theReader = new StringReader(result);
            //    DataSet theDataSet = new DataSet();
            //    theDataSet.ReadXml(theReader);
            //    foreach (DataRow dr in theDataSet.Tables[1].Rows)
            //    {
            //        lblFundMAnagername.Text = dr["FundManager"].ToString();
            //        lblQualification.Text = dr["Qualification"].ToString();
            //        lblDesignation.Text = dr["Designation"].ToString();
            //        lblExperience.Text = dr["experience"].ToString();
            //    }
            //}
        }
        
        protected void lnkAddToCompare_OnClick(object sender, EventArgs e)
        {
            if (ddlScheme.SelectedValue != "")
            {
                if (Session["SchemeCompareList"] != null)
                {
                    schemeCompareList = (List<int>)Session["SchemeCompareList"];
                    if (schemeCompareList[0] != Convert.ToInt32(hidCurrentScheme.Value))
                    {
                        schemeCompareList.Add(Convert.ToInt32(hidCurrentScheme.Value));
                        Session["SchemeCompareList"] = schemeCompareList;

                        if (schemeCompareList.Count > 1)
                        {
                            //ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscriptvvvv", "LoadBottomPanelControl('OnlineMFSchemeCompare');", true);
                            LoadMFTransactionPage("OnlineMFSchemeCompare",1);

                        }
                    }
                    else
                    {
                        ShowMessage("Scheme already added for compare!!", 'I');
                    }

                }
                else
                {
                    schemeCompareList.Add(Convert.ToInt32(hidCurrentScheme.Value));
                    Session["SchemeCompareList"] = schemeCompareList;
                }
            }
        }
        private void ShowMessage(string msg, char type)
        {
            //--S(success)
            //--F(failure)
            //--W(warning)
            //--I(information)
            trMessage.Visible = true;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "wsedrftgyhjukloghjnnnghj", " showMsg('" + msg + "','" + type.ToString() + "');", true);
        }
        protected void LoadMFTransactionPage(string pageId, int investerpage)
        {
            Dictionary<string, string> defaultProductPageSetting = new Dictionary<string, string>();

            defaultProductPageSetting.Clear();
            if (investerpage == 1)
            {
                defaultProductPageSetting.Add("ProductType", "MF");
                defaultProductPageSetting.Add("ProductMenu", "trMFOrderMenuMarketTab");
                defaultProductPageSetting.Add("ProductMenuItem", "RTSMFOrderMenuHomeMarket");
                defaultProductPageSetting.Add("ProductMenuItemPage", pageId);
            }
            else
            {
                defaultProductPageSetting.Add("ProductType", "MF");
                defaultProductPageSetting.Add("ProductMenu", "trMFOrderMenuTransactTab");
                defaultProductPageSetting.Add("ProductMenuItem", "RTSMFOrderMenuTransact");
                defaultProductPageSetting.Add("ProductMenuItemPage", pageId);
            }
            Session["PageDefaultSetting"] = defaultProductPageSetting;
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscriptvvvv", "LoadTopPanelControl('OnlineOrderTopMenu','login');", true);
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "pageloadscriptabcd", "LoadTopPanelDefault('OnlineOrderTopMenu');", true);

        }
    }
}
