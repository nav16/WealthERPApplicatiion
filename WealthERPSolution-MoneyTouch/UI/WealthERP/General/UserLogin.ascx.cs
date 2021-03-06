﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using BoUser;
using BoAdvisorProfiling;
using BoCustomerProfiling;
using VoAdvisorProfiling;
using VoUser;
using BoCustomerPortfolio;
using WealthERP.Advisor;
using WealthERP.Customer;
using System.Collections;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;
using WealthERP.Base;
using BoCommon;

namespace WealthERP.General
{
    public partial class UserLogin : System.Web.UI.UserControl
    {
        Dictionary<string, DateTime> genDict = new Dictionary<string, DateTime>();
        protected void Page_Load(object sender, EventArgs e)
        {
            int userId = 0;
            if (!IsPostBack)
            {
                if (Request.QueryString["UserId"] != null)
                {
                    userId = int.Parse(Encryption.Decrypt(Request.QueryString["UserId"].ToString()));
                    SetUser(userId);
                }
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            UserVo userVo = new UserVo();
            UserBo userBo = new UserBo();
            AdvisorStaffBo advisorStaffBo = new AdvisorStaffBo();
            AdvisorBranchBo advisorBranchBo = new AdvisorBranchBo();
            AdvisorBranchVo advisorBranchVo = new AdvisorBranchVo();
            RMVo rmVo = new RMVo();
            AdvisorBo advisorBo = new AdvisorBo();
            AdvisorVo advisorVo = new AdvisorVo();
            CustomerBo customerBo = new CustomerBo();
            CustomerVo customerVo = new CustomerVo();
            List<string> roleList = new List<string>();
            string sourcePath = "";
            string branchLogoSourcePath = "";
            int count;
            bool isGrpHead = false;
            if (!CheckSuperAdmin())
            {
                if (txtLoginId.Text == "" || txtPassword.Text == "")
                {
                    lblIllegal.Visible = true;
                    lblIllegal.Text = "Username and Password does not match";

                }
                else
                {

                    if (userBo.ValidateUser(txtLoginId.Text, txtPassword.Text))  // Validating the User Using the Username and Password
                    {

                        Session["id"] = "";
                        lblIllegal.Visible = true;


                        userVo = userBo.GetUser(txtLoginId.Text);
                        Session["UserVo"] = userVo;
                        AddLoginTrack(txtLoginId.Text, txtPassword.Text, true, userVo.UserId);

                        if (userVo.theme != null)
                        {
                            Session["Theme"] = userVo.theme.ToString();
                            Session["refreshTheme"] = true;
                        }
                        else
                        {
                            Session["Theme"] = "Purple";
                            Session["refreshTheme"] = true;
                        }

                        if (userVo.IsTempPassword == 0)
                        {
                            string UserName = userVo.FirstName + " " + userVo.LastName;


                            if (userVo.UserType == "Advisor")
                            {
                                Session[SessionContents.CurrentUserRole] = "Admin";
                                Session["advisorVo"] = advisorBo.GetAdvisorUser(userVo.UserId);
                                Session["rmVo"] = advisorStaffBo.GetAdvisorStaff(userVo.UserId);
                                advisorVo = (AdvisorVo)Session["advisorVo"];
                                rmVo = (RMVo)Session["rmVo"];
                                Session["adviserId"] = advisorBo.GetRMAdviserId(rmVo.RMId);
                                if (advisorVo.LogoPath == null || advisorVo.LogoPath == "")
                                {
                                    advisorVo.LogoPath = "spacer.png";
                                }
                                else
                                {
                                    sourcePath = "Images/" + advisorVo.LogoPath.ToString();
                                    if (!System.IO.File.Exists(Server.MapPath(sourcePath)))
                                        sourcePath = "";
                                }

                                Session[SessionContents.LogoPath] = sourcePath;

                                roleList = userBo.GetUserRoles(userVo.UserId);
                                count = roleList.Count;

                                if (count == 3)
                                {
                                    advisorBranchVo = advisorBranchBo.GetBranch(advisorBranchBo.GetBranchId(rmVo.RMId));
                                    Session["advisorBranchVo"] = advisorBranchVo;
                                    branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                                    Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdvisorRMBMDashBoard','login','" + UserName + "','" + sourcePath + "');", true);
                                    //login user role Type
                                    Session["S_CurrentUserRole"] = "Admin";
                                }
                                if (count == 2)
                                {
                                    if (roleList.Contains("RM") && roleList.Contains("BM"))
                                    {
                                        advisorBranchVo = advisorBranchBo.GetBranch(advisorBranchBo.GetBranchId(rmVo.RMId));
                                        Session["advisorBranchVo"] = advisorBranchVo;
                                        //login user role Type
                                        Session["S_CurrentUserRole"] = "RM";
                                        branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                                        Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('BMRMDashBoard','login','" + UserName + "','" + sourcePath + "','" + branchLogoSourcePath + "');", true);
                                    }
                                    else if (roleList.Contains("RM") && roleList.Contains("Admin"))
                                    {
                                        advisorBranchVo = advisorBranchBo.GetBranch(advisorBranchBo.GetBranchId(rmVo.RMId));
                                        Session["advisorBranchVo"] = advisorBranchVo;
                                        //login user role Type
                                        Session["S_CurrentUserRole"] = "Admin";
                                        branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                                        Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdvisorRMDashBoard','login','" + UserName + "','" + sourcePath + "');", true);
                                    }
                                    else if (roleList.Contains("BM") && roleList.Contains("Admin"))
                                    {
                                        advisorBranchVo = advisorBranchBo.GetBranch(advisorBranchBo.GetBranchId(rmVo.RMId));
                                        Session["advisorBranchVo"] = advisorBranchVo;
                                        branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                                        Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                                        //login user role Type
                                        Session["S_CurrentUserRole"] = "Admin";
                                    }
                                }


                                if (count == 1)
                                {
                                    if (roleList.Contains("RM"))
                                    {
                                        Session["adviserId"] = advisorBo.GetRMAdviserId(rmVo.RMId);
                                        //Session["advisorVo"]=advisorBo.GetAdvisor(
                                        branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                                        sourcePath = "Images/" + userBo.GetRMLogo(rmVo.RMId);
                                        Session[SessionContents.LogoPath] = sourcePath;
                                        Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                                        //login user role Type Issue Reported by Ajay on July 1 2010
                                        Session["S_CurrentUserRole"] = "RM";
                                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('RMDashBoard','login','" + UserName + "','" + sourcePath + "','" + branchLogoSourcePath + "');", true);

                                    }
                                    else if (roleList.Contains("BM"))
                                    {
                                        advisorBranchVo = advisorBranchBo.GetBranch(advisorBranchBo.GetBranchId(rmVo.RMId));
                                        Session["advisorBranchVo"] = advisorBranchVo;
                                        branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                                        Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                                        //login user role Type Issue Reported by Ajay on July 1 2010
                                        Session["S_CurrentUserRole"] = "BM";
                                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('BMDashBoard','login','" + UserName + "','" + sourcePath + "','" + branchLogoSourcePath + "');", true);

                                    }
                                    else
                                    {

                                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdvisorDashBoard','login','" + UserName + "','" + sourcePath + "');", true);
                                    }
                                }
                                GetLatestValuationDate();
                            }

                            else if (userVo.UserType == "Customer")
                            {
                                customerVo = customerBo.GetCustomerInfo(userVo.UserId);
                                //Session["advisorVo"] = advisorBo.GetAdvisorUser(userVo.UserId);
                                Session["CustomerVo"] = customerVo;
                                customerVo = (CustomerVo)Session["CustomerVo"];

                                advisorVo = advisorBo.GetAdvisor(advisorBranchBo.GetBranch(customerVo.BranchId).AdviserId);
                                rmVo = advisorStaffBo.GetAdvisorStaffDetails(customerVo.RmId);
                                Session["rmVo"] = rmVo;
                                Session["advisorVo"] = advisorVo;

                                //if(customerVo!=null){

                                sourcePath = "Images/" + userBo.GetCustomerLogo(customerVo.CustomerId);
                                Session[SessionContents.LogoPath] = sourcePath;
                                Session["S_CurrentUserRole"] = "Customer";
                                GetLatestValuationDate();

                                Session["IsDashboard"] = "true";
                                isGrpHead = customerBo.CheckCustomerGroupHead(customerVo.CustomerId);
                                if (isGrpHead == true)
                                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdvisorRMCustGroupDashboard','login','" + UserName + "','" + sourcePath + "');", true);
                                else
                                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdvisorRMCustIndiDashboard','login','" + UserName + "','" + sourcePath + "');", true);

                            }

                            else if (userVo.UserType == "Admin")
                            {
                                Session["refreshTheme"] = false;
                                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdminUpload','login','" + UserName + "','');", true);


                            }
                        }
                        else
                        {
                            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loadcontrol('ChangeTempPassword','none');", true);
                        }
                    }

                    else
                    {
                        lblIllegal.Visible = true;
                        lblIllegal.Text = "Username and Password does not match";
                        AddLoginTrack(txtLoginId.Text, txtPassword.Text, false, 0);
                    }

                }
            }

        }
        public void SetUser(int userId)
        {
            UserVo userVo = new UserVo();
            UserBo userBo = new UserBo();
            AdvisorStaffBo advisorStaffBo = new AdvisorStaffBo();
            AdvisorBranchBo advisorBranchBo = new AdvisorBranchBo();
            AdvisorBranchVo advisorBranchVo = new AdvisorBranchVo();
            RMVo rmVo = new RMVo();
            AdvisorBo advisorBo = new AdvisorBo();
            AdvisorVo advisorVo = new AdvisorVo();
            CustomerBo customerBo = new CustomerBo();
            CustomerVo customerVo = new CustomerVo();
            List<string> roleList = new List<string>();
            string sourcePath = "";
            string branchLogoSourcePath = "";
            int count;
            bool isGrpHead = false;
            userVo = userBo.GetUserDetails(userId);
            Session["UserVo"] = userVo;
            AddLoginTrack(txtLoginId.Text, txtPassword.Text, true, userVo.UserId);

            if (userVo.theme != null)
            {
                Session["Theme"] = userVo.theme.ToString();
                Session["refreshTheme"] = true;
            }
            else
            {
                Session["Theme"] = "Purple";
                Session["refreshTheme"] = true;
            }

            if (userVo.IsTempPassword == 0)
            {
                string UserName = userVo.FirstName + " " + userVo.LastName;


                if (userVo.UserType == "Advisor")
                {
                    Session[SessionContents.CurrentUserRole] = "Admin";
                    Session["advisorVo"] = advisorBo.GetAdvisorUser(userVo.UserId);
                    Session["rmVo"] = advisorStaffBo.GetAdvisorStaff(userVo.UserId);
                    advisorVo = (AdvisorVo)Session["advisorVo"];
                    rmVo = (RMVo)Session["rmVo"];
                    Session["adviserId"] = advisorBo.GetRMAdviserId(rmVo.RMId);
                    if (advisorVo.LogoPath == null || advisorVo.LogoPath == "")
                    {
                        advisorVo.LogoPath = "spacer.png";
                    }
                    else
                    {
                        sourcePath = "Images/" + advisorVo.LogoPath.ToString();
                        if (!System.IO.File.Exists(Server.MapPath(sourcePath)))
                            sourcePath = "";
                    }

                    Session[SessionContents.LogoPath] = sourcePath;

                    roleList = userBo.GetUserRoles(userVo.UserId);
                    count = roleList.Count;

                    if (count == 3)
                    {
                        advisorBranchVo = advisorBranchBo.GetBranch(advisorBranchBo.GetBranchId(rmVo.RMId));
                        Session["advisorBranchVo"] = advisorBranchVo;
                        branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                        Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdvisorRMBMDashBoard','login','" + UserName + "','" + sourcePath + "');", true);
                        //login user role Type
                        Session["S_CurrentUserRole"] = "Admin";
                    }
                    if (count == 2)
                    {
                        if (roleList.Contains("RM") && roleList.Contains("BM"))
                        {
                            advisorBranchVo = advisorBranchBo.GetBranch(advisorBranchBo.GetBranchId(rmVo.RMId));
                            Session["advisorBranchVo"] = advisorBranchVo;
                            //login user role Type
                            Session["S_CurrentUserRole"] = "RM";
                            branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                            Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('BMRMDashBoard','login','" + UserName + "','" + sourcePath + "','" + branchLogoSourcePath + "');", true);
                        }
                        else if (roleList.Contains("RM") && roleList.Contains("Admin"))
                        {
                            advisorBranchVo = advisorBranchBo.GetBranch(advisorBranchBo.GetBranchId(rmVo.RMId));
                            Session["advisorBranchVo"] = advisorBranchVo;
                            //login user role Type
                            Session["S_CurrentUserRole"] = "Admin";
                            branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                            Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdvisorRMDashBoard','login','" + UserName + "','" + sourcePath + "');", true);
                        }
                        else if (roleList.Contains("BM") && roleList.Contains("Admin"))
                        {
                            advisorBranchVo = advisorBranchBo.GetBranch(advisorBranchBo.GetBranchId(rmVo.RMId));
                            Session["advisorBranchVo"] = advisorBranchVo;
                            branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                            Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                            //login user role Type
                            Session["S_CurrentUserRole"] = "Admin";
                        }
                    }


                    if (count == 1)
                    {
                        if (roleList.Contains("RM"))
                        {
                            Session["adviserId"] = advisorBo.GetRMAdviserId(rmVo.RMId);
                            //Session["advisorVo"]=advisorBo.GetAdvisor(
                            branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                            sourcePath = "Images/" + userBo.GetRMLogo(rmVo.RMId);
                            Session[SessionContents.LogoPath] = sourcePath;
                            Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                            //login user role Type Issue Reported by Ajay on July 1 2010
                            Session["S_CurrentUserRole"] = "RM";
                            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('RMDashBoard','login','" + UserName + "','" + sourcePath + "','" + branchLogoSourcePath + "');", true);

                        }
                        else if (roleList.Contains("BM"))
                        {
                            advisorBranchVo = advisorBranchBo.GetBranch(advisorBranchBo.GetBranchId(rmVo.RMId));
                            Session["advisorBranchVo"] = advisorBranchVo;
                            branchLogoSourcePath = "Images/" + userBo.GetRMBranchLogo(rmVo.RMId);
                            Session[SessionContents.BranchLogoPath] = branchLogoSourcePath;
                            //login user role Type Issue Reported by Ajay on July 1 2010
                            Session["S_CurrentUserRole"] = "BM";
                            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('BMDashBoard','login','" + UserName + "','" + sourcePath + "','" + branchLogoSourcePath + "');", true);

                        }
                        else
                        {

                            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdvisorDashBoard','login','" + UserName + "','" + sourcePath + "');", true);
                        }
                    }
                    GetLatestValuationDate();
                }

                else if (userVo.UserType == "Customer")
                {
                    customerVo = customerBo.GetCustomerInfo(userVo.UserId);
                    //Session["advisorVo"] = advisorBo.GetAdvisorUser(userVo.UserId);
                    Session["CustomerVo"] = customerVo;
                    customerVo = (CustomerVo)Session["CustomerVo"];

                    advisorVo = advisorBo.GetAdvisor(advisorBranchBo.GetBranch(customerVo.BranchId).AdviserId);
                    rmVo = advisorStaffBo.GetAdvisorStaffDetails(customerVo.RmId);
                    Session["rmVo"] = rmVo;
                    Session["advisorVo"] = advisorVo;

                    //if(customerVo!=null){

                    sourcePath = "Images/" + userBo.GetCustomerLogo(customerVo.CustomerId);
                    Session[SessionContents.LogoPath] = sourcePath;
                    Session["S_CurrentUserRole"] = "Customer";
                    GetLatestValuationDate();

                    Session["IsDashboard"] = "true";
                    isGrpHead = customerBo.CheckCustomerGroupHead(customerVo.CustomerId);
                    if (isGrpHead == true)
                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdvisorRMCustGroupDashboard','login','" + UserName + "','" + sourcePath + "');", true);
                    else
                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdvisorRMCustIndiDashboard','login','" + UserName + "','" + sourcePath + "');", true);

                }

                else if (userVo.UserType == "Admin")
                {
                    Session["refreshTheme"] = false;
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('AdminUpload','login','" + UserName + "','');", true);


                }
            }
            else
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loadcontrol('ChangeTempPassword','none');", true);
            }
        }
        private bool CheckSuperAdmin()
        {
            string UserName = "";
            UserVo userVo = new UserVo();
            UserBo userBo = new UserBo();

            if (userBo.ValidateUser(txtLoginId.Text, txtPassword.Text))
            {
                userVo = userBo.GetUser(txtLoginId.Text);
                AddLoginTrack(txtLoginId.Text, txtPassword.Text, true, userVo.UserId);
                Session[SessionContents.LogoPath] = "";
                Session[SessionContents.BranchLogoPath] = "";


                if (userVo != null && userVo.UserType == "SuperAdmin")
                {
                    Session["role"] = "SUPER_ADMIN";
                    Session["UserVo"] = userVo;
                    Session["SuperAdminRetain"] = userVo;
                    UserName = userVo.FirstName + " " + userVo.LastName;
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loginloadcontrol('IFF','login','" + UserName + "','');", true);
                    if (userVo.theme != null)
                    {
                        Session["Theme"] = "Purple";
                        Session["refreshTheme"] = true;
                    }
                    else
                    {
                        Session["Theme"] = "Purple";
                        Session["refreshTheme"] = true;
                    }
                    return true;
                }
                else
                    return false;
            }
            else
            {
                lblIllegal.Visible = true;
                lblIllegal.Text = "Username and Password does not match";
                AddLoginTrack(txtLoginId.Text, txtPassword.Text, false, 0);
                return false;
            }

        }
        private void GetLatestValuationDate()
        {
            DateTime EQValuationDate = new DateTime();
            DateTime MFValuationDate = new DateTime();
            PortfolioBo portfolioBo = null;
            genDict = new Dictionary<string, DateTime>();
            AdvisorVo advisorVo = new AdvisorVo();
            int adviserId = 0;
            try
            {
                portfolioBo = new PortfolioBo();
                advisorVo = (AdvisorVo)Session["advisorVo"];
                adviserId = advisorVo.advisorId;


                if (portfolioBo.GetLatestValuationDate(adviserId, "EQ") != null)
                {
                    EQValuationDate = DateTime.Parse(portfolioBo.GetLatestValuationDate(adviserId, "EQ").ToString());
                }
                if (portfolioBo.GetLatestValuationDate(adviserId, "MF") != null)
                {
                    MFValuationDate = DateTime.Parse(portfolioBo.GetLatestValuationDate(adviserId, "MF").ToString());
                }
                genDict.Add("EQDate", EQValuationDate);
                genDict.Add("MFDate", MFValuationDate);
                Session["ValuationDate"] = genDict;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "PortfolioDashboard.ascx.cs:GetLatestValuationDate()");
                object[] objects = new object[3];
                objects[0] = EQValuationDate;
                objects[1] = adviserId;
                objects[2] = MFValuationDate;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }

        }
        protected void setControl()
        {
            AdvisorHomeLinks HomeLinks = (AdvisorHomeLinks)this.Page.LoadControl("Advisor//AdvisorHomeLinks.ascx");
            //HomeLinks = (AdvisorHomeLinks)this.Page.LoadControl("Advisor//AdvisorHomeLinks.ascx");
            Panel pleft = new Panel();
            pleft = (Panel)this.Parent.FindControl("LeftPanel");
            pleft.Controls.Clear();
            pleft.Controls.Add(HomeLinks);
        }

        protected void NewUser_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loadcontrol('RegistrationType','none','none');", true);
        }

        protected void ForgotPassword_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "pageloadscript", "loadcontrol('ForgotPassword','none','none');", true);
        }
        /// <summary>
        /// Save the Login Track information.
        /// </summary>
        private void AddLoginTrack(string loginId, string password, bool isSuccess, int createdBy)
        {
            string IPAddress = string.Empty;
            string browser = string.Empty;

            if (HttpContext.Current.Request.UserAgent != null)
                browser = HttpContext.Current.Request.UserAgent;

            IPAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

            UserBo.AddLoginTrack(txtLoginId.Text, txtPassword.Text, isSuccess, IPAddress, browser, createdBy);

        }

    }
}
