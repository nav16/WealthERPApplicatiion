﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VoUser;
using BoResearch;
using System.Data;
using Telerik.Web.UI;
using BoCustomerRiskProfiling;
using VoCustomerRiskProfiling;
using System.Web.UI.HtmlControls;

namespace WealthERP.Research
{
    public partial class RiskScore : System.Web.UI.UserControl
    {
        DataSet dsGlobal = new DataSet();
        AdvisorVo adviserVo = new AdvisorVo();
        AdviserFPConfigurationBo adviserFPConfigurationBo = new AdviserFPConfigurationBo();
        AdviserDynamicRiskQuestionsVo adviserDRQVo = new AdviserDynamicRiskQuestionsVo();
        RiskProfileBo riskprofilebo = new RiskProfileBo();
        ModelPortfolioBo modelPortfolioBo = new ModelPortfolioBo();
        int expiryAge = 0;
        String[] stquestionOptions = new string[7];
        int[] stquestionOptionsWeightage = new int[7];
        DataSet dsGetAdviserQuestions = new DataSet();
        DataSet dsGetAdviserQuestionOptions = new DataSet();
        DataTable dtBindAdviserQuestions = new DataTable();
        DataTable dtBindAdviserQuestionsOptions = new DataTable();
        DataSet dsBindBothQuestionOptions = new DataSet();
        int QuestionId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            adviserVo = (AdvisorVo)Session["AdvisorVo"];
           
            if (!IsPostBack)
            {
                pnlAdviserQuestionsDisplay.Visible = true;
                pnlAdviserQuestionsMaintanance.Visible = false;
                pnlMaintanceFormTitle.Visible = false;
                GetAndBindAdviserQuestionsAndAnswers(0, string.Empty);
                BindAdviserAssumptions();
            }
            Page.RegisterStartupScript("load", "<script> DisableAllValidations();</script>");
            BindAdviserRiskScoreGrid();
        }

        private void GetAndBindAdviserQuestionsAndAnswers(int QuestionId, string FromWhere)
        {
            dtBindAdviserQuestionsOptions.Columns.Add("QM_QuestionID");
            dtBindAdviserQuestionsOptions.Columns.Add("QM_Question");

            dtBindAdviserQuestionsOptions.Columns.Add("QOM_OptionId");
            dtBindAdviserQuestionsOptions.Columns.Add("QM_QuestionOption1");
            dtBindAdviserQuestionsOptions.Columns.Add("QM_QuestionOption2");
            dtBindAdviserQuestionsOptions.Columns.Add("QM_QuestionOption3");
            dtBindAdviserQuestionsOptions.Columns.Add("QM_QuestionOption4");
            dtBindAdviserQuestionsOptions.Columns.Add("QM_QuestionOption5");
            dtBindAdviserQuestionsOptions.Columns.Add("QM_QuestionOption6");
            dtBindAdviserQuestionsOptions.Columns.Add("QOM_Weightage1");
            dtBindAdviserQuestionsOptions.Columns.Add("QOM_Weightage2");
            dtBindAdviserQuestionsOptions.Columns.Add("QOM_Weightage3");
            dtBindAdviserQuestionsOptions.Columns.Add("QOM_Weightage4");
            dtBindAdviserQuestionsOptions.Columns.Add("QOM_Weightage5");
            dtBindAdviserQuestionsOptions.Columns.Add("QOM_Weightage6");

            DataRow drBindAdviserQuestionsAndOptions = null;

            dsGetAdviserQuestions = adviserFPConfigurationBo.GetAdviserMaintainedRiskProfileQuestionAndOptions(adviserVo.advisorId);
            DataTable dtDistinctQuestionID = dsGetAdviserQuestions.Tables[0].DefaultView.ToTable(true, "QM_QuestionId");
            GetRiskScore(dtDistinctQuestionID, dsGetAdviserQuestions);
            if (FromWhere == "")
            {
                if (dsGetAdviserQuestions.Tables.Count > 0)
                {
                    if (dsGetAdviserQuestions.Tables[0].Rows.Count > 0)
                    {
                        int RiskQuestionId = 0;
                        int QuestionSerialNo = 1;

                        foreach (DataRow drQuestions in dtDistinctQuestionID.Rows)
                        {

                            RiskQuestionId = Convert.ToInt32(drQuestions["QM_QuestionId"].ToString());

                            DataRow[] drQuestionOptions = dsGetAdviserQuestions.Tables[0].Select("QM_QuestionId=" + RiskQuestionId);

                            drBindAdviserQuestionsAndOptions = dtBindAdviserQuestionsOptions.NewRow();

                            int OptionSerialNo = 1;

                            foreach (DataRow drOptions in drQuestionOptions)
                            {
                                if (drBindAdviserQuestionsAndOptions["QM_QuestionID"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QM_QuestionID"] = drOptions["QM_QuestionId"];

                                if (drBindAdviserQuestionsAndOptions["QM_Question"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QM_Question"] = QuestionSerialNo.ToString() + "." + " " + drOptions["QM_Question"];

                                if (drBindAdviserQuestionsAndOptions["QOM_OptionId"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QOM_OptionId"] = OptionSerialNo.ToString() + "." + " " + drOptions["QOM_OptionId"] + " " + "{" + drOptions["QOM_Weightage"] + "}";

                                // Option Inserting..
                                if (drBindAdviserQuestionsAndOptions["QM_QuestionOption1"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QM_QuestionOption1"] = OptionSerialNo.ToString() + "." + " " + drOptions["QOM_Option"] + " " + "{" + drOptions["QOM_Weightage"] + "}";


                                else if (drBindAdviserQuestionsAndOptions["QM_QuestionOption2"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QM_QuestionOption2"] = OptionSerialNo.ToString() + "." + " " + drOptions["QOM_Option"] + " " + "{" + drOptions["QOM_Weightage"] + "}";


                                else if (drBindAdviserQuestionsAndOptions["QM_QuestionOption3"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QM_QuestionOption3"] = OptionSerialNo.ToString() + "." + " " + drOptions["QOM_Option"] + " " + "{" + drOptions["QOM_Weightage"] + "}";


                                else if (drBindAdviserQuestionsAndOptions["QM_QuestionOption4"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QM_QuestionOption4"] = OptionSerialNo.ToString() + "." + " " + drOptions["QOM_Option"] + " " + "{" + drOptions["QOM_Weightage"] + "}";


                                else if (drBindAdviserQuestionsAndOptions["QM_QuestionOption5"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QM_QuestionOption5"] = OptionSerialNo.ToString() + "." + " " + drOptions["QOM_Option"] + " " + "{" + drOptions["QOM_Weightage"] + "}";


                                else if (drBindAdviserQuestionsAndOptions["QM_QuestionOption6"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QM_QuestionOption6"] = OptionSerialNo.ToString() + "." + " " + drOptions["QOM_Option"] + " " + "{" + drOptions["QOM_Weightage"] + "}";


                                if (drBindAdviserQuestionsAndOptions["QOM_Weightage1"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QOM_Weightage1"] = drOptions["QOM_Weightage"];

                                else if (drBindAdviserQuestionsAndOptions["QOM_Weightage2"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QOM_Weightage2"] = drOptions["QOM_Weightage"];

                                else if (drBindAdviserQuestionsAndOptions["QOM_Weightage3"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QOM_Weightage3"] = drOptions["QOM_Weightage"];

                                else if (drBindAdviserQuestionsAndOptions["QOM_Weightage4"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QOM_Weightage4"] = drOptions["QOM_Weightage"];

                                else if (drBindAdviserQuestionsAndOptions["QOM_Weightage5"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QOM_Weightage5"] = drOptions["QOM_Weightage"];

                                else if (drBindAdviserQuestionsAndOptions["QOM_Weightage6"].ToString() == "")
                                    drBindAdviserQuestionsAndOptions["QOM_Weightage6"] = drOptions["QOM_Weightage"];

                                OptionSerialNo = OptionSerialNo + 1;
                            }
                            dtBindAdviserQuestionsOptions.Rows.Add(drBindAdviserQuestionsAndOptions);
                            QuestionSerialNo = QuestionSerialNo + 1;
                        }
                    }
                }
                if (dtBindAdviserQuestionsOptions.Rows.Count > 0)
                {
                    msgNoRecords.Visible = false;
                    repAdviserQuestions.DataSource = dtBindAdviserQuestionsOptions;
                    repAdviserQuestions.DataBind();
                }
                else
                {
                    msgNoRecords.Visible = true;
                }
            }
            else
            {
                if (dsGetAdviserQuestions.Tables.Count > 0)
                {
                    if (dsGetAdviserQuestions.Tables[0].Rows.Count > 0)
                    {
                        DataRow[] drQuestionOptions = dsGetAdviserQuestions.Tables[0].Select("QM_QuestionId=" + QuestionId);

                        drBindAdviserQuestionsAndOptions = dtBindAdviserQuestionsOptions.NewRow();

                        foreach (DataRow drOptions in drQuestionOptions)
                        {
                            if (drBindAdviserQuestionsAndOptions["QM_QuestionID"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QM_QuestionID"] = drOptions["QM_QuestionId"];

                            if (drBindAdviserQuestionsAndOptions["QM_Question"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QM_Question"] = drOptions["QM_Question"];

                            if (drBindAdviserQuestionsAndOptions["QOM_OptionId"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QOM_OptionId"] = drOptions["QOM_OptionId"];

                            // Option Inserting..
                            if (drBindAdviserQuestionsAndOptions["QM_QuestionOption1"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QM_QuestionOption1"] = drOptions["QOM_Option"];


                            else if (drBindAdviserQuestionsAndOptions["QM_QuestionOption2"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QM_QuestionOption2"] = drOptions["QOM_Option"];


                            else if (drBindAdviserQuestionsAndOptions["QM_QuestionOption3"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QM_QuestionOption3"] = drOptions["QOM_Option"];


                            else if (drBindAdviserQuestionsAndOptions["QM_QuestionOption4"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QM_QuestionOption4"] = drOptions["QOM_Option"];


                            else if (drBindAdviserQuestionsAndOptions["QM_QuestionOption5"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QM_QuestionOption5"] = drOptions["QOM_Option"];


                            else if (drBindAdviserQuestionsAndOptions["QM_QuestionOption6"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QM_QuestionOption6"] = drOptions["QOM_Option"];

                            if(drBindAdviserQuestionsAndOptions["QOM_Weightage1"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QOM_Weightage1"] = drOptions["QOM_Weightage"];

                            else if(drBindAdviserQuestionsAndOptions["QOM_Weightage2"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QOM_Weightage2"] = drOptions["QOM_Weightage"];

                            else if (drBindAdviserQuestionsAndOptions["QOM_Weightage3"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QOM_Weightage3"] = drOptions["QOM_Weightage"];

                            else if (drBindAdviserQuestionsAndOptions["QOM_Weightage4"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QOM_Weightage4"] = drOptions["QOM_Weightage"];

                            else if (drBindAdviserQuestionsAndOptions["QOM_Weightage5"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QOM_Weightage5"] = drOptions["QOM_Weightage"];

                            else if (drBindAdviserQuestionsAndOptions["QOM_Weightage6"].ToString() == "")
                                drBindAdviserQuestionsAndOptions["QOM_Weightage6"] = drOptions["QOM_Weightage"];

                        }
                        dtBindAdviserQuestionsOptions.Rows.Add(drBindAdviserQuestionsAndOptions);
                    }
                }
                FillFormToUpdate(drBindAdviserQuestionsAndOptions);
            }
        }

        private void GetRiskScore(DataTable dtDistinctQuestionID, DataSet dsGetAdviserQuestions)
        {
            int minScore = 0;
            int maxScore = 0;
            
            int QuestionID = 0;

            if (dtDistinctQuestionID.Rows.Count != 0)
            {
                foreach (DataRow dr in dtDistinctQuestionID.Rows)
                {
                    int tempMin = 0;
                    int tempMax = 0;
                    DataTable dtOptionsTemp = new DataTable();

                    dtOptionsTemp.Columns.Add("QOM_Weightage");

                    QuestionID = int.Parse(dr["QM_QuestionID"].ToString());
                   
                    DataRow[] drQuestionOptions = dsGetAdviserQuestions.Tables[1].Select("QM_QuestionId=" + QuestionID);
                    
                    int i = 1;
                    
                    foreach (DataRow drOptions in drQuestionOptions)
                    {
                        DataRow drOptionsRow = dtOptionsTemp.NewRow();

                        if (drOptions["QOM_Weightage"].ToString() != "")
                        {
                            drOptionsRow["QOM_Weightage"] = drOptions.Field<int>("QOM_Weightage");

                            if (i == 1)
                            {
                                tempMin = drOptions.Field<int>("QOM_Weightage");
                                tempMax = drOptions.Field<int>("QOM_Weightage");
                            }
                            if (tempMin > drOptions.Field<int>("QOM_Weightage"))
                                tempMin = drOptions.Field<int>("QOM_Weightage");

                            if (tempMax < drOptions.Field<int>("QOM_Weightage"))
                                tempMax = drOptions.Field<int>("QOM_Weightage");
                        }
                        i = i + 1;

                    }
                    minScore = minScore + tempMin;
                    maxScore = maxScore + tempMax;
                }
                lblMinScore.Text = minScore.ToString();
                ViewState["MinScore"] = minScore;
                ViewState["MaxScore"] = maxScore;
                lblMaxScore.Text = maxScore.ToString();

                txtMinScore.Text = ViewState["MinScore"].ToString();
                txtMaxScore.Text = ViewState["MaxScore"].ToString();
            }
        }

        private void FillFormToUpdate(DataRow drBindAdviserQuestionsAndOptions)
        {
            pnlAdviserQuestionsDisplay.Visible = false;
            pnlAdviserQuestionsMaintanance.Visible = true;
            pnlMaintanceFormTitle.Visible = true;
            tblEditForm.Visible = true;

            trOptions2.Style.Add("visibility", "visible");
            trOptions3.Style.Add("visibility", "visible");
            trOptions4.Style.Add("visibility", "visible");
            trOptions5.Style.Add("visibility", "visible");
            trOptions6.Style.Add("visibility", "visible");

            btnAddOp2.Style.Add("visibility", "hidden");
            btnAddOption3.Style.Add("visibility", "hidden");
            btnOpt4.Style.Add("visibility", "hidden");
            btnOption5.Style.Add("visibility", "hidden");
            btnOpt6.Style.Add("visibility", "hidden");
            

            if (drBindAdviserQuestionsAndOptions["QM_Question"].ToString() != "")
            {
                txtQuestion.Text = drBindAdviserQuestionsAndOptions["QM_Question"].ToString();
            }


            if (drBindAdviserQuestionsAndOptions["QM_QuestionOption1"].ToString() != "")
            {
                txtEnterOption1.Text = drBindAdviserQuestionsAndOptions["QM_QuestionOption1"].ToString();
                txtEnterWeightage1.Text = drBindAdviserQuestionsAndOptions["QOM_Weightage1"].ToString();

                if(drBindAdviserQuestionsAndOptions["QM_QuestionOption2"].ToString() == "")
                    btnAddOp2.Style.Add("visibility", "visible");
            }
            else
            {
                trOptions1.Style.Add("visibility", "hidden");
                txtEnterOption1.Text = string.Empty;
                txtEnterWeightage1.Text = string.Empty;
            }

            if (drBindAdviserQuestionsAndOptions["QM_QuestionOption2"].ToString() != "")
            {
                txtEnterOption2.Text = drBindAdviserQuestionsAndOptions["QM_QuestionOption2"].ToString();
                txtEnterWeightage2.Text = drBindAdviserQuestionsAndOptions["QOM_Weightage2"].ToString();

                if (drBindAdviserQuestionsAndOptions["QM_QuestionOption3"].ToString() == "")
                    btnAddOption3.Style.Add("visibility", "visible");
            }
            else
            {
                trOptions2.Style.Add("visibility", "hidden");
                txtEnterOption2.Text = string.Empty;
                txtEnterWeightage2.Text = string.Empty;
            }

            if (drBindAdviserQuestionsAndOptions["QM_QuestionOption3"].ToString() != "")
            {
                txtEnterOption3.Text = drBindAdviserQuestionsAndOptions["QM_QuestionOption3"].ToString();
                txtEnterWeightage3.Text = drBindAdviserQuestionsAndOptions["QOM_Weightage3"].ToString();

                if (drBindAdviserQuestionsAndOptions["QM_QuestionOption4"].ToString() == "")
                    btnOpt4.Style.Add("visibility", "visible");
            }
            else
            {
                trOptions3.Style.Add("visibility", "hidden");
                txtEnterOption3.Text = string.Empty;
                txtEnterWeightage3.Text = string.Empty;
            }

            if (drBindAdviserQuestionsAndOptions["QM_QuestionOption4"].ToString() != "")
            {
                txtEnterOption4.Text = drBindAdviserQuestionsAndOptions["QM_QuestionOption4"].ToString();
                txtEnterWeightage4.Text = drBindAdviserQuestionsAndOptions["QOM_Weightage4"].ToString();

                if (drBindAdviserQuestionsAndOptions["QM_QuestionOption5"].ToString() == "")
                    btnOption5.Style.Add("visibility", "visible");
            }
            else
            {
                trOptions4.Style.Add("visibility", "hidden");
                txtEnterOption4.Text = string.Empty;
                txtEnterWeightage4.Text = string.Empty;
            }

            if (drBindAdviserQuestionsAndOptions["QM_QuestionOption5"].ToString() != "")
            {
                txtEnterOption5.Text = drBindAdviserQuestionsAndOptions["QM_QuestionOption5"].ToString();
                txtEnterWeightage5.Text = drBindAdviserQuestionsAndOptions["QOM_Weightage5"].ToString();

                if (drBindAdviserQuestionsAndOptions["QM_QuestionOption6"].ToString() == "")
                    btnOpt6.Style.Add("visibility", "visible");
            }
            else
            {
                trOptions5.Style.Add("visibility", "hidden");
                txtEnterOption5.Text = string.Empty;
                txtEnterWeightage5.Text = string.Empty;
            }

            if (drBindAdviserQuestionsAndOptions["QM_QuestionOption6"].ToString() != "")
            {
                txtEnterOption6.Text = drBindAdviserQuestionsAndOptions["QM_QuestionOption6"].ToString();
                txtEnterWeightage6.Text = drBindAdviserQuestionsAndOptions["QOM_Weightage6"].ToString();
            }
            else
            {
                trOptions6.Style.Add("visibility", "hidden");
                txtEnterOption6.Text = string.Empty;
                txtEnterWeightage6.Text = string.Empty;
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "Message", "DisableMaintananceFormControls();", true);


        }
        public void BindAdviserAssumptions()
        {
            //DataSet dsRiskScore;
            DataTable dt = new DataTable();
            dt = adviserFPConfigurationBo.GetAdviserRiskScore(adviserVo.advisorId);
            DataTable dtRiskScore = new DataTable();
            dtRiskScore.Columns.Add("XRC_RiskClass");
            dtRiskScore.Columns.Add("WRPR_RiskScoreLowerLimit");
            dtRiskScore.Columns.Add("WRPR_RiskScoreUpperLimit");
            dtRiskScore.Columns.Add("XRC_RiskClassCode");
            DataRow drRiskScore;
            foreach (DataRow dr in dt.Rows)
            {
                drRiskScore = dtRiskScore.NewRow();
                drRiskScore["XRC_RiskClassCode"] = dr["XRC_RiskClassCode"].ToString();
                drRiskScore["XRC_RiskClass"] = dr["XRC_RiskClass"].ToString();
                drRiskScore["WRPR_RiskScoreLowerLimit"] = dr["WRPR_RiskScoreLowerLimit"].ToString();
                drRiskScore["WRPR_RiskScoreUpperLimit"] = dr["WRPR_RiskScoreUpperLimit"].ToString();
                dtRiskScore.Rows.Add(drRiskScore);
            }
            Session["Data"] = dtRiskScore;
            RadGrid1.DataSource = dtRiskScore;
            RadGrid1.DataBind();
        }
       
        public void SetUpNewQuestionsAndOptions()
        {
            //Reset Question..
            txtQuestion.Text = string.Empty;

            // Reset Options..
            txtEnterOption1.Text = string.Empty;
            txtEnterOption2.Text = string.Empty;
            txtEnterOption3.Text = string.Empty;
            txtEnterOption4.Text = string.Empty;
            txtEnterOption5.Text = string.Empty;
            txtEnterOption6.Text = string.Empty;

            // Reset Option Weightage..
            txtEnterWeightage1.Text = string.Empty;
            txtEnterWeightage2.Text = string.Empty;
            txtEnterWeightage3.Text = string.Empty;
            txtEnterWeightage4.Text = string.Empty;
            txtEnterWeightage5.Text = string.Empty;
            txtEnterWeightage6.Text = string.Empty;
        }

        protected void RadGrid1_UpdateCommand(object source, GridCommandEventArgs e)
        {
            try
            {
                decimal lowerLimit = 0;
                decimal upperLimit = 0;
                int minScore;
                int maxScore;
                GridEditableItem gridEditableItem = (GridEditableItem)e.Item;
                DropDownList ddl = (DropDownList)e.Item.FindControl("ddlPickRiskClass");
                TextBox txtLower = (TextBox)e.Item.FindControl("txtLowerLimit");
                TextBox txtUpper = (TextBox)e.Item.FindControl("txtUpperLimit");
                lowerLimit = Convert.ToDecimal(txtLower.Text);
                upperLimit = Convert.ToDecimal(txtUpper.Text);
                int index = e.Item.ItemIndex;
                DataTable dtTemp = (DataTable)Session["Data"];
                string classCode = (dtTemp.Rows[index]["XRC_RiskClassCode"].ToString());

                minScore = int.Parse(ViewState["MinScore"].ToString());
                maxScore = int.Parse(ViewState["MaxScore"].ToString());

                int lastRow = dtTemp.Rows.Count;

                if (lowerLimit <= upperLimit)
                {
                    if (index != 0)
                    {
                        if (lowerLimit != (Convert.ToInt32(dtTemp.Rows[index - 1]["WRPR_RiskScoreUpperLimit"].ToString()) + 1))
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Message", "javascript:showmessage();", true);
                        }

                        else if (index == (lastRow - 1))
                        {
                            if (upperLimit != maxScore)
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Message", "javascript:showmessage();", true);
                            }
                            else
                            {
                                //adviserFPConfigurationBo.UpdateRiskClassScore(classCode, lowerLimit, upperLimit, adviserVo.advisorId, adviserVo.UserId);
                                //BindAdviserAssumptions();
                                //RadGrid1.Rebind();

                                foreach (DataRow dr in dtTemp.Rows)
                                {
                                    if (dr["XRC_RiskClassCode"].ToString() == classCode)
                                    {
                                        dr["WRPR_RiskScoreLowerLimit"] = lowerLimit.ToString();
                                        dr["WRPR_RiskScoreUpperLimit"] = upperLimit.ToString();
                                    }
                                }

                            }
                        }
                        else
                        {
                            //adviserFPConfigurationBo.UpdateRiskClassScore(classCode, lowerLimit, upperLimit, adviserVo.advisorId, adviserVo.UserId);
                            //BindAdviserAssumptions();
                            //RadGrid1.Rebind();
                            if ((Convert.ToInt32(dtTemp.Rows[index + 1]["WRPR_RiskScoreLowerLimit"].ToString())) != 0)
                            {
                                if (upperLimit != (Convert.ToInt32(dtTemp.Rows[index + 1]["WRPR_RiskScoreUpperLimit"].ToString()) - 1))
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Message", "javascript:showmessage();", true);
                                }
                            }
                            else
                            {
                                foreach (DataRow dr in dtTemp.Rows)
                                {
                                    if (dr["XRC_RiskClassCode"].ToString() == classCode)
                                    {
                                        dr["WRPR_RiskScoreLowerLimit"] = lowerLimit.ToString();
                                        dr["WRPR_RiskScoreUpperLimit"] = upperLimit.ToString();
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        if (lowerLimit != minScore || upperLimit > maxScore)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Message", "javascript:showmessage();", true);
                        }
                        else   if ((Convert.ToInt32(dtTemp.Rows[index + 1]["WRPR_RiskScoreLowerLimit"].ToString())) != 0)
                            {
                                if (upperLimit != (Convert.ToInt32(dtTemp.Rows[index + 1]["WRPR_RiskScoreLowerLimit"].ToString()) - 1))
                                {
                                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Message", "javascript:showmessage();", true);
                                }
                            }
                            else
                            {
                                foreach (DataRow dr in dtTemp.Rows)
                                {
                                    if (dr["XRC_RiskClassCode"].ToString() == classCode)
                                    {
                                        dr["WRPR_RiskScoreLowerLimit"] = lowerLimit.ToString();
                                        dr["WRPR_RiskScoreUpperLimit"] = upperLimit.ToString();
                                    }

                                }
                            }
                            //adviserFPConfigurationBo.UpdateRiskClassScore(classCode, lowerLimit, upperLimit, adviserVo.advisorId, adviserVo.UserId);
                            //BindAdviserAssumptions();
                            //RadGrid1.Rebind();
                        }
                 
                   
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Message", "javascript:showmessage();", true);
                }
                //Session["RiskClassScore"] = dtTemp;
                Session["Data"]=dtTemp;
            }
            catch (Exception ex)
            {
                RadGrid1.Controls.Add(new LiteralControl("Unable to update Employee. Reason: " + ex.Message));
                e.Canceled = true;
            }
        }

        protected void RadGrid1_InsertCommand(object source, GridCommandEventArgs e)
        {
            //try
            //{
            //    decimal lowerLimit = 0;
            //    decimal upperLimit = 0;
            //    GridEditableItem gridEditableItem = (GridEditableItem)e.Item;
            //    DropDownList ddl = (DropDownList)e.Item.FindControl("ddlPickRiskClass");
            //    TextBox txtLower = (TextBox)e.Item.FindControl("txtLowerLimit");
            //    TextBox txtUpper = (TextBox)e.Item.FindControl("txtUpperLimit");
            //    lowerLimit = Convert.ToDecimal(txtLower.Text);
            //    upperLimit = Convert.ToDecimal(txtUpper.Text);
            //    adviserFPConfigurationBo.InsertUpdateRiskClassScore(ddl.SelectedValue, lowerLimit, upperLimit, adviserVo.advisorId, adviserVo.UserId);
            //    RadGrid1.Rebind();
            //}
            //catch (Exception ex)
            //{
            //    RadGrid1.Controls.Add(new LiteralControl("Unable to insert Employee. Reason: " + ex.Message));
            //    e.Canceled = true;
            //}
        }

        protected void RadGrid1_DeleteCommand(object source, GridCommandEventArgs e)
        {
            //try
            //{
            //    //GridEditableItem gridEditableItem = (GridEditableItem)e.Item;
            //    string riskClassCode = RadGrid1.MasterTableView.DataKeyValues[e.Item.ItemIndex]["XRC_RiskClassCode"].ToString();
            //    adviserFPConfigurationBo.DeleteRiskClassScore(riskClassCode, adviserVo.advisorId);
            //    BindAdviserAssumptions();
            //    RadGrid1.Rebind();
            //}
            //catch (Exception ex)
            //{
            //    RadGrid1.Controls.Add(new LiteralControl("Unable to delete Employee. Reason: " + ex.Message));
            //    e.Canceled = true;
            //}
        }

        protected void RadGrid1_ItemCommand(object source, GridCommandEventArgs e)
        {
            //if (e.CommandName == RadGrid.InitInsertCommandName)
            //{
            //    e.Canceled = true;
            //    RadGrid1.EditIndexes.Clear();
            //    GridEditableItem item = (GridEditableItem)e.Item;
            //    DropDownList ddl = (DropDownList)e.Item.FindControl("ddlPickRiskClass");
            //    ddl.Enabled = false;
            //    e.Item.OwnerTableView.EditFormSettings.UserControlName = "ddlPickRiskClass";
            //    e.Item.OwnerTableView.InsertItem();
            //}
            //else if (e.CommandName == RadGrid.EditCommandName)
            //{
            //    DropDownList ddl = (DropDownList)e.Item.FindControl("ddlPickRiskClass");
            //    ddl.Enabled = false;
            //    e.Item.OwnerTableView.IsItemInserted = false;
            //    e.Item.OwnerTableView.EditFormSettings.UserControlName = "ddlPickRiskClass";
            //}
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridCommandItem)
            {
                e.Item.FindControl("InitInsertButton").Parent.Visible = false;
            }
        }
        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {

        }

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if ((e.Item is GridEditFormItem) && (e.Item.IsInEditMode))
            {
                GridEditFormItem editform = (GridEditFormItem)e.Item;
                DropDownList ddl = (DropDownList)editform.FindControl("ddlPickRiskClass");
                int adviserId = adviserVo.advisorId;
                HtmlTableRow trPickClassDdl = (HtmlTableRow)editform.FindControl("trPickClassDdl");
                HtmlTableRow trRisktextBox = (HtmlTableRow)editform.FindControl("trRisktextBox");

                if (e.Item.RowIndex == -1)
                {
                    //trPickClassDdl.Visible = true;
                    trRisktextBox.Visible = false;

                    //dsGlobal = riskprofilebo.GetAdviserRiskClasses(adviserId);
                    //if (dsGlobal.Tables[0].Rows.Count > 0)
                    //{
                    //    ddl.DataSource = dsGlobal.Tables[0];
                    //    ddl.DataValueField = dsGlobal.Tables[0].Columns["XRC_RiskClassCode"].ToString();
                    //    ddl.DataTextField = dsGlobal.Tables[0].Columns["XRC_RiskClass"].ToString();
                    //    ddl.DataBind();
                    //}
                    //ddl.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Risk Class", "Select Risk Class"));
                }
                else
                {
                    trPickClassDdl.Visible = false;
                    trRisktextBox.Visible = true;
                }
            }
        }

        protected void btnSubmitAndEnterNewQuestion_Click(object sender, EventArgs e)
        {
            bool bRiskDependency = false;
            int questionId = 0;
            bool updateQuestionStatus = false;
            bool updateOptionStatus = false;
            int optionId = 0;
            DataSet dtParameter = SetDataTable();
            //SetParameterForQuestions();
            adviserDRQVo.AdviserId = adviserVo.advisorId;
            adviserDRQVo.Question = dtParameter.Tables[0].Rows[0]["QM_Question"].ToString();
            adviserDRQVo.Purpose = "RiskProfile";

            bRiskDependency = adviserFPConfigurationBo.CheckAdviserRiskProfileDependency(adviserVo.advisorId);

            if (bRiskDependency == false)
            {
                if (btnSubmitAndEnterNewQuestion.Text == "Submit & Add new question")
                {
                    questionId = adviserFPConfigurationBo.CreateAdvisorDynamicRiskQuestions(adviserDRQVo);

                    adviserDRQVo.QuestionId = questionId;

                    for (int i = 0; i <= dtParameter.Tables[1].Rows.Count - 1; i++)
                    {
                        if (dtParameter.Tables[1].Rows[i]["QM_QuestionOption"].ToString() != "")
                            adviserDRQVo.Option = dtParameter.Tables[1].Rows[i]["QM_QuestionOption"].ToString();

                        if (dtParameter.Tables[1].Rows[i]["QOM_Weightage"].ToString() != "")
                            adviserDRQVo.Weightage = int.Parse(dtParameter.Tables[1].Rows[i]["QOM_Weightage"].ToString());

                        optionId = adviserFPConfigurationBo.CreateAdvisorDynamicRiskQuestionsOptions(adviserDRQVo);
                    }
                }
                else if (btnSubmitAndEnterNewQuestion.Text == "Update & Add new question")
                {
                    DataSet dsGetDataForOptions = new DataSet();
                    DataRow[] drOptionId = null;
                    adviserDRQVo.QuestionId = Convert.ToInt32(ViewState["QuestionId"].ToString());
                    updateQuestionStatus = adviserFPConfigurationBo.UpdateAdvisorDynamicRiskQuestions(adviserDRQVo);

                    if (Session["GetDataForQuestionOptions"] != "")
                    {
                        dsGetDataForOptions = (DataSet)Session["GetDataForQuestionOptions"];

                        drOptionId = dsGetDataForOptions.Tables[0].Select("QM_QuestionId=" + adviserDRQVo.QuestionId);
                    }
                    int checkInsertOrUpdate = 0;
                    checkInsertOrUpdate = drOptionId.Length;

                    for (int i = 0; i <= dtParameter.Tables[1].Rows.Count - 1; i++)
                    {
                        if (checkInsertOrUpdate != 0)
                            adviserDRQVo.OptionId = Convert.ToInt32(drOptionId[i]["QOM_OptionId"].ToString());
                        else
                            adviserDRQVo.OptionId = 0;


                        if (dtParameter.Tables[1].Rows[i]["QM_QuestionOption"].ToString() != "")
                            adviserDRQVo.Option = dtParameter.Tables[1].Rows[i]["QM_QuestionOption"].ToString();

                        if (dtParameter.Tables[1].Rows[i]["QOM_Weightage"].ToString() != "")
                            adviserDRQVo.Weightage = int.Parse(dtParameter.Tables[1].Rows[i]["QOM_Weightage"].ToString());

                        if (adviserDRQVo.OptionId != 0)
                            updateOptionStatus = adviserFPConfigurationBo.UpdateAdvisorDynamicRiskQuestionsOptions(adviserDRQVo);
                        else
                            optionId = adviserFPConfigurationBo.CreateAdvisorDynamicRiskQuestionsOptions(adviserDRQVo);

                        if (checkInsertOrUpdate != 0)
                            checkInsertOrUpdate = checkInsertOrUpdate - 1;

                    }
                }
                SetUpNewQuestionsAndOptions();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Warning! Dependency found..!! Please remove any existing customers risk profile..');", true);
            }
        }

        private DataSet SetDataTable()
        {
            DataSet dsGetDataToInsert = new DataSet();

            DataTable dtGetDataToInsertQuestions = new DataTable();
            DataTable dtGetDataToInsertQuestionOptions = new DataTable();

            DataRow drGetDataToInsertQuestions;
            DataRow drGetDataToInsertQuestionOptions;

            dtGetDataToInsertQuestions.Columns.Add("QM_Question");

            drGetDataToInsertQuestions = dtGetDataToInsertQuestions.NewRow();

            if (txtQuestion.Text != "")
                drGetDataToInsertQuestions[0] = txtQuestion.Text;

            dtGetDataToInsertQuestions.Rows.Add(drGetDataToInsertQuestions);


            dtGetDataToInsertQuestionOptions.Columns.Add("QM_QuestionOption");
            dtGetDataToInsertQuestionOptions.Columns.Add("QOM_Weightage");
            string txtopt1 = null;
            string txtopt2 = null;
            string txtopt3 = null;
            string txtopt4 = null;
            string txtopt5 = null;
            string txtopt6 = null;
           

            for (int i = 0; i <= 6; i++)
            {
                drGetDataToInsertQuestionOptions = dtGetDataToInsertQuestionOptions.NewRow();

                if ((txtEnterOption1.Text != "") && (txtopt1 == null))
                {
                    txtopt1 = txtEnterOption1.Text;
                    drGetDataToInsertQuestionOptions["QM_QuestionOption"] = txtEnterOption1.Text;
                    drGetDataToInsertQuestionOptions["QOM_Weightage"] = txtEnterWeightage1.Text;

                    dtGetDataToInsertQuestionOptions.Rows.Add(drGetDataToInsertQuestionOptions);
                }

                else if ((txtEnterOption2.Text != "") && (txtopt2 == null))
                {
                    txtopt2 = txtEnterOption2.Text;
                    drGetDataToInsertQuestionOptions["QM_QuestionOption"] = txtEnterOption2.Text;
                    drGetDataToInsertQuestionOptions["QOM_Weightage"] = txtEnterWeightage2.Text;

                    dtGetDataToInsertQuestionOptions.Rows.Add(drGetDataToInsertQuestionOptions);
                }

                else if ((txtEnterOption3.Text != "") && (txtopt3 == null))
                {
                    txtopt3 = txtEnterOption3.Text;
                    drGetDataToInsertQuestionOptions["QM_QuestionOption"] = txtEnterOption3.Text;
                    drGetDataToInsertQuestionOptions["QOM_Weightage"] = txtEnterWeightage3.Text;

                    dtGetDataToInsertQuestionOptions.Rows.Add(drGetDataToInsertQuestionOptions);
                }
                else if ((txtEnterOption4.Text != "") && (txtopt4 == null))
                {
                    txtopt4 = txtEnterOption4.Text;
                    drGetDataToInsertQuestionOptions["QM_QuestionOption"] = txtEnterOption4.Text;
                    drGetDataToInsertQuestionOptions["QOM_Weightage"] = txtEnterWeightage4.Text;

                    dtGetDataToInsertQuestionOptions.Rows.Add(drGetDataToInsertQuestionOptions);
                }

                else if ((txtEnterOption5.Text != "") && (txtopt5 == null))
                {
                    txtopt5 = txtEnterOption5.Text;
                    drGetDataToInsertQuestionOptions["QM_QuestionOption"] = txtEnterOption5.Text;
                    drGetDataToInsertQuestionOptions["QOM_Weightage"] = txtEnterWeightage5.Text;

                    dtGetDataToInsertQuestionOptions.Rows.Add(drGetDataToInsertQuestionOptions);
                }

                else if ((txtEnterOption6.Text != "") && (txtopt6 == null))
                {
                    txtopt6 = txtEnterOption6.Text;
                    drGetDataToInsertQuestionOptions["QM_QuestionOption"] = txtEnterOption6.Text;
                    drGetDataToInsertQuestionOptions["QOM_Weightage"] = txtEnterWeightage6.Text;

                    dtGetDataToInsertQuestionOptions.Rows.Add(drGetDataToInsertQuestionOptions);
                }

                

            }

            dsBindBothQuestionOptions.Tables.Add(dtGetDataToInsertQuestions);
            dsBindBothQuestionOptions.Tables.Add(dtGetDataToInsertQuestionOptions);



            return dsBindBothQuestionOptions;

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            bool bRiskDependency = false;
            int questionId = 0;
            bool updateQuestionStatus = false;
            bool updateOptionStatus = false;
            int optionId = 0;
            DataSet dtParameter = SetDataTable();
            //SetParameterForQuestions();
            adviserDRQVo.AdviserId = adviserVo.advisorId;
            adviserDRQVo.Question = dtParameter.Tables[0].Rows[0]["QM_Question"].ToString();
            adviserDRQVo.Purpose = "RiskProfile";

            bRiskDependency = adviserFPConfigurationBo.CheckAdviserRiskProfileDependency(adviserVo.advisorId);

            if (bRiskDependency == false)
            {
                if (btnSubmit.Text == "Submit")
                {

                    questionId = adviserFPConfigurationBo.CreateAdvisorDynamicRiskQuestions(adviserDRQVo);

                    adviserDRQVo.QuestionId = questionId;

                    for (int i = 0; i <= dtParameter.Tables[1].Rows.Count - 1; i++)
                    {
                        if (dtParameter.Tables[1].Rows[i]["QM_QuestionOption"].ToString() != "")
                            adviserDRQVo.Option = dtParameter.Tables[1].Rows[i]["QM_QuestionOption"].ToString();

                        if (dtParameter.Tables[1].Rows[i]["QOM_Weightage"].ToString() != "")
                            adviserDRQVo.Weightage = int.Parse(dtParameter.Tables[1].Rows[i]["QOM_Weightage"].ToString());

                        optionId = adviserFPConfigurationBo.CreateAdvisorDynamicRiskQuestionsOptions(adviserDRQVo);
                    }
                }
                else if (btnSubmit.Text == "Update")
                {
                    DataSet dsGetDataForOptions = new DataSet();
                    DataRow[] drOptionId = null;
                    adviserDRQVo.QuestionId = Convert.ToInt32(ViewState["QuestionId"].ToString());
                    updateQuestionStatus = adviserFPConfigurationBo.UpdateAdvisorDynamicRiskQuestions(adviserDRQVo);

                    if (Session["GetDataForQuestionOptions"] != "")
                    {
                        dsGetDataForOptions = (DataSet)Session["GetDataForQuestionOptions"];

                        drOptionId = dsGetDataForOptions.Tables[0].Select("QM_QuestionId=" + adviserDRQVo.QuestionId);
                    }
                    int checkInsertOrUpdate = 0;
                    checkInsertOrUpdate = drOptionId.Length;
                    for (int i = 0; i <= dtParameter.Tables[1].Rows.Count - 1; i++)
                    {
                        if (checkInsertOrUpdate != 0)
                            adviserDRQVo.OptionId = Convert.ToInt32(drOptionId[i]["QOM_OptionId"].ToString());
                        else
                            adviserDRQVo.OptionId = 0;


                        if (dtParameter.Tables[1].Rows[i]["QM_QuestionOption"].ToString() != "")
                            adviserDRQVo.Option = dtParameter.Tables[1].Rows[i]["QM_QuestionOption"].ToString();

                        if (dtParameter.Tables[1].Rows[i]["QOM_Weightage"].ToString() != "")
                            adviserDRQVo.Weightage = int.Parse(dtParameter.Tables[1].Rows[i]["QOM_Weightage"].ToString());

                        if (adviserDRQVo.OptionId != 0)
                            updateOptionStatus = adviserFPConfigurationBo.UpdateAdvisorDynamicRiskQuestionsOptions(adviserDRQVo);
                        else
                            optionId = adviserFPConfigurationBo.CreateAdvisorDynamicRiskQuestionsOptions(adviserDRQVo);

                        if (checkInsertOrUpdate != 0)
                            checkInsertOrUpdate = checkInsertOrUpdate - 1;

                    }
                }
                pnlAdviserQuestionsDisplay.Visible = true;
                pnlAdviserQuestionsMaintanance.Visible = false;
                MaintanceFormTitle.Visible = false;
                pnlMaintanceFormTitle.Visible = false;
                GetAndBindAdviserQuestionsAndAnswers(0, string.Empty);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Warning! Dependency found..!! Please remove any existing customers risk profile..');", true);
            }
        }

        public void SetParameterForQuestions()
        {
            adviserDRQVo.AdviserId = adviserVo.advisorId;

            if (txtQuestion.Text != "")
                adviserDRQVo.Question = txtQuestion.Text;

            adviserDRQVo.Purpose = "RiskProfile";

            if (txtEnterOption1.Text != "")
                stquestionOptions[1] = txtEnterOption1.Text;

            if (txtEnterOption2.Text != "")
                stquestionOptions[1] = txtEnterOption2.Text;

            if (txtEnterOption3.Text != "")
                stquestionOptions[1] = txtEnterOption3.Text;

            if (txtEnterOption4.Text != "")
                stquestionOptions[1] = txtEnterOption4.Text;

            if (txtEnterOption5.Text != "")
                stquestionOptions[1] = txtEnterOption5.Text;

            if (txtEnterOption6.Text != "")
                stquestionOptions[1] = txtEnterOption6.Text;

            if (txtEnterWeightage1.Text != "")
                stquestionOptionsWeightage[1] = int.Parse(txtEnterWeightage1.Text);

            if (txtEnterWeightage2.Text != "")
                stquestionOptionsWeightage[2] = int.Parse(txtEnterWeightage2.Text);

            if (txtEnterWeightage3.Text != "")
                stquestionOptionsWeightage[3] = int.Parse(txtEnterWeightage3.Text);

            if (txtEnterWeightage4.Text != "")
                stquestionOptionsWeightage[4] = int.Parse(txtEnterWeightage1.Text);

            if (txtEnterWeightage5.Text != "")
                stquestionOptionsWeightage[5] = int.Parse(txtEnterWeightage5.Text);

            if (txtEnterWeightage6.Text != "")
                stquestionOptionsWeightage[6] = int.Parse(txtEnterWeightage6.Text);
        }

        protected void btnAddQuestions_Click(object sender, EventArgs e)
        {
            pnlMaintanceFormTitle.Visible = true;
            tblEditForm.Visible = false;
            pnlAdviserQuestionsDisplay.Visible = false;
            pnlAdviserQuestionsMaintanance.Visible = true;
            SetUpNewQuestionsAndOptions();
            tblEditForm.Visible = true;
            tdback.Visible = true;
            tdEditForm.Visible = false;
            tdDelete.Visible = false;
            trOptions2.Style.Add("visibility", "hidden");
            trOptions3.Style.Add("visibility", "hidden");
            trOptions4.Style.Add("visibility", "hidden");
            trOptions5.Style.Add("visibility", "hidden");
            trOptions6.Style.Add("visibility", "hidden");

            btnAddOp2.Style.Add("visibility", "visible");
            btnAddOption3.Style.Add("visibility", "hidden");
            btnOpt4.Style.Add("visibility", "hidden");
            btnOption5.Style.Add("visibility", "hidden");
            btnOpt6.Style.Add("visibility", "hidden");

            btnSubmit.Text = "Submit";
            btnSubmitAndEnterNewQuestion.Text = "Submit & Add new question";

        }

        protected void repAdviserQuestions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string FromWhere = null;
            if (e.CommandName == "QuestionEditUpdateLink")
            {
                FromWhere = "QuestionEditUpdateLink";
                QuestionId = int.Parse(e.CommandArgument.ToString());
                GetAndBindAdviserQuestionsAndAnswers(QuestionId, FromWhere);
                btnSubmitAndEnterNewQuestion.Text = "Update & Add new question";
                btnSubmit.Text = "Update";
                ViewState["QuestionId"] = QuestionId;
                Session["GetDataForQuestionOptions"] = dsGetAdviserQuestions;
                Session["EditOrUpdate"] = "EditOrUpdate";

                tblEditForm.Visible = true;
                tdback.Visible = true;
                tdEditForm.Visible = true;
                tdDelete.Visible = true;

                //SetControlsToEditOrUpdate();
            }

        }

        private void SetControlsToEditOrUpdate()
        {
            DataTable dtGetQuestions = new DataTable();
            DataTable dtGetOptions = new DataTable();

            if (dsBindBothQuestionOptions.Tables.Count > 0)
            {
                dtGetQuestions = dsBindBothQuestionOptions.Tables[0];
                if(dsBindBothQuestionOptions.Tables.Count == 2)
                    dtGetOptions = dsBindBothQuestionOptions.Tables[1];

                txtQuestion.Text = dtGetQuestions.Rows[1]["QM_Question"].ToString();

                foreach (DataRow dr in dtGetOptions.Rows)
                {
                    if (txtEnterOption1.Text == null)
                        txtEnterOption1.Text = dr["QM_QuestionOption"].ToString();

                    if (txtEnterOption2.Text == null)
                        txtEnterOption2.Text = dr["QM_QuestionOption"].ToString();

                    if (txtEnterOption3.Text == null)
                        txtEnterOption3.Text = dr["QM_QuestionOption"].ToString();

                    if (txtEnterOption4.Text == null)
                        txtEnterOption4.Text = dr["QM_QuestionOption"].ToString();

                    if (txtEnterOption5.Text == null)
                        txtEnterOption5.Text = dr["QM_QuestionOption"].ToString();

                    if (txtEnterOption6.Text == null)
                        txtEnterOption6.Text = dr["QM_QuestionOption"].ToString();


                    if (txtEnterWeightage1.Text == null)
                        txtEnterWeightage1.Text = dr["QOM_Weightage"].ToString();

                    if (txtEnterWeightage2.Text == null)
                        txtEnterWeightage2.Text = dr["QOM_Weightage"].ToString();

                    if (txtEnterWeightage3.Text == null)
                        txtEnterWeightage3.Text = dr["QOM_Weightage"].ToString();

                    if (txtEnterWeightage4.Text == null)
                        txtEnterWeightage4.Text = dr["QOM_Weightage"].ToString();

                    if (txtEnterWeightage5.Text == null)
                        txtEnterWeightage5.Text = dr["QOM_Weightage"].ToString();

                    if (txtEnterWeightage6.Text == null)
                        txtEnterWeightage6.Text = dr["QOM_Weightage"].ToString();                    
                }
            }

        }

        protected void btnDeleteQuestions_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Message", "javascript:DeleteConfirmation();", true);
        }

        protected void hiddenDeleteQuestion_Click(object sender, EventArgs e)
        {
            bool bRiskDependency = false;
            bool bStatus = false;
            bool bOptionStatus = false;
            int questionId = 0;
            int optionId = 0;
            int adviserId = 0;
            DataSet dsGetDataForOptionsToDelete = new DataSet();
            DataRow[] drOptionId = null;

            adviserId = adviserVo.advisorId;

            bRiskDependency = adviserFPConfigurationBo.CheckAdviserRiskProfileDependency(adviserVo.advisorId);


            if (bRiskDependency == false)
            {
                questionId = int.Parse(ViewState["QuestionId"].ToString());

                if (hdnDeletemsgValue.Value == "1")
                {
                    if (Session["GetDataForQuestionOptions"] != "")
                    {
                        dsGetDataForOptionsToDelete = (DataSet)Session["GetDataForQuestionOptions"];

                        drOptionId = dsGetDataForOptionsToDelete.Tables[0].Select("QM_QuestionId=" + questionId);
                    }

                    foreach (DataRow dr in drOptionId)
                    {
                        optionId = int.Parse(dr["QOM_OptionId"].ToString());

                        bOptionStatus = adviserFPConfigurationBo.DeleteAdviserQuestionOptions(adviserId, questionId, optionId, 1);
                    }

                    bStatus = adviserFPConfigurationBo.DeleteAdviserQuestionOptions(adviserId, questionId, 0, 0);
                }
                pnlAdviserQuestionsDisplay.Visible = true;
                pnlAdviserQuestionsMaintanance.Visible = false;
                pnlMaintanceFormTitle.Visible = false;
                GetAndBindAdviserQuestionsAndAnswers(0, string.Empty);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Warning! Dependency found..!! Please remove any existing customers risk profile..');", true);
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            pnlMaintanceFormTitle.Visible = false;
            pnlAdviserQuestionsMaintanance.Visible = false;
            pnlAdviserQuestionsDisplay.Visible = true;
        }

        protected void btnSubmitRiskScore_Click(object sender, EventArgs e)
        {
            DataTable dtRiskClassScore = new DataTable();
            if (Session["Data"] != null)
            {
                dtRiskClassScore = (DataTable)Session["Data"];
                string classCode;
                int minScore = 0, MaxScore = 0;
                int minAccountLevel = int.MaxValue;
                int maxAccountLevel = int.MinValue; 
                int minRiskScoreByQuestion = int.Parse(txtMinScore.Text);
                int maxRiskScoreByQuestion = int.Parse(txtMaxScore.Text);
                foreach (DataRow drRiskClassScore in dtRiskClassScore.Rows)
                {
                    // minScore1 = double.Parse(drRiskClassScore["WRPR_RiskScoreLowerLimit"].ToString());
                   int minRiskScore = int.Parse(drRiskClassScore["WRPR_RiskScoreLowerLimit"].ToString());
                   int maxRiskScore = int.Parse(drRiskClassScore["WRPR_RiskScoreUpperLimit"].ToString());
                   minAccountLevel = Math.Min(minAccountLevel, minRiskScore);
                   maxAccountLevel = Math.Max(maxAccountLevel, maxRiskScore);
                }
                if (minAccountLevel == minRiskScoreByQuestion && maxAccountLevel == maxRiskScoreByQuestion)
                {
                    foreach (DataRow dr in dtRiskClassScore.Rows)
                    {
                        classCode = dr["XRC_RiskClassCode"].ToString();
                        int lowerLimit = int.Parse(dr["WRPR_RiskScoreLowerLimit"].ToString());
                        int upperLimit = int.Parse(dr["WRPR_RiskScoreUpperLimit"].ToString());
                        adviserFPConfigurationBo.UpdateRiskClassScore(classCode, lowerLimit, upperLimit, adviserVo.advisorId, adviserVo.UserId);
                        BindAdviserAssumptions();
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Risk Score has been inserted successfully');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Message", "javascript:showAlertmessage();", true);
                }
            }
        }
        public void BindAdviserRiskScoreGrid()
        {
            if (Session["Data"] != null)
            {
                DataTable dtRiskScore = (DataTable)Session["Data"];
                RadGrid1.DataSource = dtRiskScore;
                RadGrid1.DataBind();
            }
            else
            {
                BindAdviserAssumptions();
            }
        }

        protected void btnRiskScoreReset_Click(object sender, EventArgs e)
        {
            bool result;
            if (Session["Data"] != null)
            {
                DataTable dtRiskScore = (DataTable)Session["Data"];
                int minAccountLevel = int.MaxValue;               
                foreach (DataRow drRiskClassScore in dtRiskScore.Rows)
                {
                    // minScore1 = double.Parse(drRiskClassScore["WRPR_RiskScoreLowerLimit"].ToString());
                    int minRiskScore = int.Parse(drRiskClassScore["WRPR_RiskScoreUpperLimit"].ToString());                    
                    minAccountLevel = Math.Min(minAccountLevel, minRiskScore);                    
                }
                if (minAccountLevel != 0)
                {
                    result = modelPortfolioBo.ResetAdviserRiskScore(adviserVo.advisorId);
                    if (result)
                    {
                        // Success Message
                        //ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Goal Score has been reset to Zero');", true);
                    }
                }
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Risk Score has been reset to Zero');", true);
                BindAdviserAssumptions();
            }
        }
    }
}
