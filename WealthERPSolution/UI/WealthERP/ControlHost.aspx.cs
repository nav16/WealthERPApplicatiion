﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Resources;
using System.Text;
using BoUser;
using VoUser;
using DaoCustomerPortfolio;
using System.Web.Services;
using DaoUser;
using VoHostConfig;
using WealthERP.Base;

namespace WealthERP
{
    public partial class ControlHost : System.Web.UI.Page
    {
        string path = string.Empty;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            GeneralConfigurationVo generalconfigurationvo = new GeneralConfigurationVo();

            if (Session[SessionContents.SAC_HostGeneralDetails] != null)
            {
                generalconfigurationvo = (GeneralConfigurationVo)Session[SessionContents.SAC_HostGeneralDetails];

                if (!string.IsNullOrEmpty(generalconfigurationvo.DefaultTheme))
                {
                    if (Session["Theme"] == null || Session["Theme"].ToString() == string.Empty)
                    {
                        Session["Theme"] = generalconfigurationvo.DefaultTheme;
                    }
                    Page.Theme = Session["Theme"].ToString();

                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
           // Response.Cache.SetCacheability(HttpCacheability.NoCache);
           // Response.Cache.SetExpires(new DateTime(1990, 1, 1));

            if (Session["refreshTheme"] != null && Convert.ToBoolean(Session["refreshTheme"]) == true)
            {
                Session["refreshTheme"] = null;
                ScriptManager.RegisterClientScriptBlock(this.Page,this.GetType(), "pageloadscript","window.parent.location.href = window.parent.location.href;", true);
            }

            //if (Request.QueryString["FromTopMenuFP"] != null)
            //{
            //    Session.Remove("FP_UserName");
            //    Session.Remove("FP_UserID");
            //}
      

            if (Request.QueryString["Branch"] != null)
            {
                Session["Branch"] = Request.QueryString["Branch"].ToString();

            }
            if (Request.QueryString["RM"] != null)
            {
                Session["RM"] = Request.QueryString["RM"].ToString();
            }
            if (Request.QueryString["Customer"] != null)
            {
                Session["Customer"] = Request.QueryString["Customer"].ToString();
            }
            if (Request.QueryString["action"] != null)
            {
                Session["action"] = Request.QueryString["action"].ToString();
            }
            if (Request.QueryString["pageid"] != null)
            {
                Session["Current_PageID"] = Request.QueryString["pageid"].ToString();
            }
            else
            {
                string key = string.Empty;
                string value = string.Empty;

                if (HttpContext.Current.Session["Sessionkey"] != null)
                    key = HttpContext.Current.Session["Sessionkey"].ToString();
                if (HttpContext.Current.Session["Sessionkey"] != null)
                    value = HttpContext.Current.Session["Sessionvalue"].ToString();
                Session[key] = value;
            }

            loadcontrol();
        }

        [WebMethod]
        public static bool CheckTradeNoAvailability(string TradeAccNo, string BrokerCode, int PortfolioId)
        {
            CustomerAccountDao checkAccDao = new CustomerAccountDao();
            return checkAccDao.CheckTradeNoAvailability(TradeAccNo, BrokerCode, PortfolioId);
        }

        [WebMethod]
        public static bool CheckPANNoAvailability(string PanNumber, string BranchId, int adviserId)
        {
            CustomerAccountDao checkAccDao = new CustomerAccountDao();
            return checkAccDao.CheckPANNoAvailability(PanNumber, BranchId, adviserId);
        }
        [WebMethod]
        public static bool CheckPANNoAvailabilityForAssociates(string PanNumber, int adviserId)
        {
            CustomerAccountDao checkAccDao = new CustomerAccountDao();
            return checkAccDao.CheckPANNoAvailability(PanNumber, adviserId);
        }

        [WebMethod]
        public static bool CheckTradeNoAvailabilityForUpdate(string TradeAccNo, string BrokerCode, int PortfolioId)
        {
            CustomerAccountDao checkAccDao = new CustomerAccountDao();
            return checkAccDao.CheckTradeNoAvailabilityForUpdate(TradeAccNo, BrokerCode, PortfolioId);
        }

        [WebMethod]
        
        public static bool CheckTradeNoAvailabilityAccount(string TradeAccNo, string BrokerCode, int PortfolioId)
        {
            CustomerAccountDao checkAccDao = new CustomerAccountDao();
            return checkAccDao.CheckTradeNoAvailabilityAccount(TradeAccNo, BrokerCode, PortfolioId);
        }
        [WebMethod]

        public static bool CheckAgentCodeAvailability(int adviserId, string agentCode)
        {
            CustomerAccountDao checkAccDao = new CustomerAccountDao();
            return checkAccDao.CheckAgentCodeAvailability(adviserId, agentCode);
        }

        [WebMethod]
        public static bool CheckTradeNoMFAvailability(string TradeAccNo, string BrokerCode, int PortfolioId)
        {

            CustomerAccountDao checkAccDao = new CustomerAccountDao();
            return checkAccDao.CheckTradeNoMFAvailability(TradeAccNo, BrokerCode, PortfolioId);
        }

        [WebMethod]
        public static bool CheckTransactionExistanceOnHoldingAdd(int CBBankAccountNum)
        {

            CustomerAccountDao checkAccDao = new CustomerAccountDao();
            return checkAccDao.CheckTransactionExistanceOnHoldingAdd(CBBankAccountNum);
        }



        [WebMethod]
        public static bool CheckInsuranceNoAvailabilityOnAdd(string InsuranceNo, int AdviserId)
        {

            CustomerAccountDao checkAccDao = new CustomerAccountDao();
            return checkAccDao.CheckInsuranceNoAvailabilityOnAdd(InsuranceNo,AdviserId);
        }

        [WebMethod]
        public static bool CheckGenInsuranceNoAvailabilityOnAdd(string InsuranceNo, int AdviserId)
        {

            CustomerAccountDao checkAccDao = new CustomerAccountDao();
            return checkAccDao.CheckGenInsuranceNoAvailabilityOnAdd(InsuranceNo, AdviserId);
        }

        [WebMethod]
        public static bool CheckFolioDuplicate(int customerId,string folioNumber)
        {

            CustomerAccountDao checkAccDao = new CustomerAccountDao();
            return checkAccDao.CheckFolioDuplicate(customerId, folioNumber);
        }


        private void AddSessionTrack()
        {
            UserVo userVo = null;
            string loginId = string.Empty;
            string referrer = string.Empty;
            string url = string.Empty;
            string IPAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            string browser = string.Empty;

            if (Session["userVo"] != null)
            {
                userVo = (UserVo)Session["userVo"];
                if(userVo.LoginId != null)
                loginId = userVo.LoginId;
            }

            if (HttpContext.Current.Request.UrlReferrer != null)
                referrer = HttpContext.Current.Request.UrlReferrer.AbsoluteUri;
            string sessionID = HttpContext.Current.Session.SessionID;

            url = path;//HttpContext.Current.Request.Url.AbsolutePath;
            if (HttpContext.Current.Request.UserAgent != null)
                browser = HttpContext.Current.Request.UserAgent;
            try
            {
                UserBo.AddSessionTrack(loginId, referrer, sessionID, url, browser, IPAddress);
            }
            catch (Exception ex)
            {

            }
        }


        protected void loadcontrol()
        {

            string pageID = "";

            if (Session["Sessionkey"] != null)
            {
                if (Session[Session["Sessionkey"].ToString()] == null || Session[Session["Sessionkey"].ToString()].ToString() == "")
                {
                    return;
                }
                else
                {
                    pageID = Session[Session["Sessionkey"].ToString()].ToString();
                }
            }
            else if (Request.QueryString["pageid"] != null)
            {   // If Session is null, get the pageid from the querystring
                pageID = Request.QueryString["pageid"].ToString();
            }
            else
            {
                return;
            }

            //BreadCrumbs Loading Scripts
            string bcID = "";
            if (Request.QueryString["action"] != null)
            {
                bcID = pageID + "_" + Request.QueryString["action"].ToString();
            }
            else
            {
                bcID = pageID;
            }

           

            // Control Loading Script
            path = Getpagepath(pageID);
            UserControl uc1 = new UserControl();

            uc1 = (UserControl)this.Page.LoadControl(path);
            uc1.ID = "ctrl_" + pageID;

           

            PlaceHolder1.Controls.Clear();
            PlaceHolder1.Controls.Add(uc1);
            AddSessionTrack();
        }

        private string GetBreadCrumbScript(string b)
        {
            ResourceManager resourceMessages = new ResourceManager("WealthERP.BreadCrumbScripts", typeof(ControlHost).Assembly);
            return resourceMessages.GetString(b);
        }

        // Put your logic here to get the Product list    8: }

        protected string Getpagepath(string pageID)
        {
            ResourceManager resourceMessages = new ResourceManager("WealthERP.ControlMapping", typeof(ControlHost).Assembly);
            return resourceMessages.GetString(pageID);
        }

        protected string GetBreadCrumbLinkNames(string pageID)
        {
            ResourceManager resourceMessages = new ResourceManager("WealthERP.BreadcrumbLinks", typeof(ControlHost).Assembly);
            return resourceMessages.GetString(pageID);
        }

        [WebMethod]
        public static bool CheckLoginIdAvailability(string loginId)
        {
            UserDao userDao = new UserDao();
            return userDao.ChkAvailability(loginId);
        }
    }
}
