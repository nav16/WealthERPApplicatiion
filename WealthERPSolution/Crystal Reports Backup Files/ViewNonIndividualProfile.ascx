﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewNonIndividualProfile.ascx.cs"
    Inherits="WealthERP.Customer.ViewNonIndividualProfile" %>

<script src="../Scripts/tabber.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    function showassocation() {

        var bool = window.confirm('Customer has associations,cannot be deteted');
        if (bool) {
            document.getElementById("ctrl_ViewCustomerIndividualProfile_hdnassociation").value = 1;
            document.getElementById("ctrl_ViewCustomerIndividualProfile_hiddenassociationfound").click();
            return false;
        }
        else {
            document.getElementById("ctrl_ViewCustomerIndividualProfile_hdnassociation").value = 0;
            document.getElementById("ctrl_ViewCustomerIndividualProfile_hiddenassociationfound").click();
            return true;
        }
    }
   
   
</script>

<table width="100%">
    <tr>
        <td colspan="3">
            <div class="divPageHeading">
                <table cellspacing="0" cellpadding="3" width="100%">
                    <tr>
                        <td align="left">
                            Profile
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<table class="TableBackground" style="width: 50%;">
    <%--<tr>
        <td class="rightField" colspan="2">
            <asp:Label ID="Label26" runat="server" CssClass="HeaderTextBig" Text="Profile"></asp:Label>
            <hr />
        </td>
    </tr>--%>
    <%--<tr>
    <td>
    </td>
    <td>
    <asp:Checkbox ID="chkprospectn" runat="server" CssClass="txtField"  Text="Prospect" 
                AutoPostBack="false"  Enabled = "false" /></asp:Label>
                </td>
    </tr>--%>
    <tr>
        <td class="leftField" style="width: 35%">
            <asp:Label ID="lblBranchName" runat="server" CssClass="FieldName" Text="Branch Name:"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblBranch" runat="server" CssClass="FieldName" Text="Branch Name:"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblRMName" runat="server" CssClass="FieldName" Text="RM Name:"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblRM" runat="server" CssClass="FieldName" Text="RM Name:"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblCustomerType" runat="server" CssClass="FieldName" Text="Customer Type:"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblType" runat="server" CssClass="FieldName" Text="Customer Type:"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="lblCustomerSubType" runat="server" CssClass="FieldName" Text="Customer SubType:"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblSubType" runat="server" CssClass="FieldName" Text="Customer SubType:"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label2" runat="server" CssClass="FieldName" Text="Date of Profiling :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblProfilingDate" runat="server" Text="Label" CssClass="Field"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label4" runat="server" CssClass="FieldName" Text="Name of Company :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblCompanyName" runat="server" Text="Label" CssClass="Field"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label5" runat="server" CssClass="FieldName" Text="Customer Code :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblCustomerCode" runat="server" Text="Label" CssClass="Field"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label10" runat="server" CssClass="FieldName" Text="Date Of Registration :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblRegistrationDate" runat="server" Text="Label" CssClass="Field"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label11" runat="server" CssClass="FieldName" Text="Date Of Commencement :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblCommencementDate" runat="server" Text="Label" CssClass="Field"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label12" runat="server" CssClass="FieldName" Text="Reg. No. with ROC-Registrar :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblRegistrationNum" runat="server" Text="Label" CssClass="Field"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label13" runat="server" CssClass="FieldName" Text="Place Of Registration :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblRegistrationPlace" runat="server" Text="Label" CssClass="Field"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label14" runat="server" CssClass="FieldName" Text="Company Website :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblCompanyWebsite" runat="server" Text="Label" CssClass="Field"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label15" runat="server" CssClass="FieldName" Text="Contact Person Name :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblName" runat="server" Text="Label" CssClass="Field"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label8" runat="server" CssClass="FieldName" Text="PAN Number :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Label ID="lblPanNum" runat="server" Text="" CssClass="Field"></asp:Label>
            &nbsp; &nbsp; &nbsp;
            <asp:CheckBox ID="chkdummypan" runat="server" CssClass="txtField" Text="Dummy PAN"
                AutoPostBack="true" Enabled="false" />
        </td>
    </tr>
</table>
<div class="tabber" style="width: 100%">
    <div class="tabbertab" style="width: 100%">
        <h6>
            Correspondence Address</h6>
        <table style="width: 100%;">
            <tr>
                <td colspan="4" class="rightField">
                    <asp:Label ID="Label1" runat="server" Text="Correspondence Address" CssClass="HeaderTextSmall"></asp:Label>
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="leftField">
                    <asp:Label ID="Label3" runat="server" Text="Line1(House No./Building) :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField">
                    <asp:Label ID="lblCorrLine1" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="rightField">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="leftField">
                    <asp:Label ID="Label6" runat="server" Text="Line2(Street) :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField">
                    <asp:Label ID="lblCorrLine2" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="style21">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="leftField">
                    <asp:Label ID="Label7" runat="server" Text="Line3(Area) :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField">
                    <asp:Label ID="lblCorrLine3" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label9" runat="server" Text="City :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:DropDownList ID="ddlCorrAdrCity"  Enabled="false" runat="server" CssClass="cmbField">
                    </asp:DropDownList>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label16" runat="server" Text="State :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:DropDownList ID="ddlCorrAdrState"  Enabled="false" runat="server" CssClass="cmbField">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label19" runat="server" Text="Pincode :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblCorrPinCode" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label17" runat="server" Text="Country :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblCorrCountry" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div class="tabbertab">
        <h6>
            Permanent Address</h6>
        <table style="width: 100%;">
            <tr>
                <td colspan="4" class="rightField">
                    <asp:Label ID="Label18" runat="server" Text="Permanent Address " CssClass="HeaderTextSmall"></asp:Label>
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="leftField">
                    <asp:Label ID="Label60" runat="server" Text="Line1(House No./Building) :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField">
                    <asp:Label ID="lblPermLine1" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="leftField">
                    <asp:Label ID="Label20" runat="server" Text="Line2(Street) :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField">
                    <asp:Label ID="lblPermLine2" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="leftField">
                    <asp:Label ID="Label21" runat="server" Text="Line3(Area) :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField">
                    <asp:Label ID="lblPermLine3" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label22" runat="server" Text="City :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:DropDownList ID="ddlPermAdrCity"  Enabled="false" runat="server" CssClass="cmbField">
                    </asp:DropDownList>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label23" runat="server" Text="State :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:DropDownList ID="ddlPermAdrState" Enabled="false" runat="server" CssClass="cmbField">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label24" runat="server" Text="Pincode :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblPermPinCode" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label25" runat="server" Text="Country :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblPermCountry" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div class="tabbertab">
        <h6>
            Contact Details</h6>
        <table style="width: 100%;">
            <tr>
                <td colspan="4" class="rightField">
                    <asp:Label ID="Label35" runat="server" Text="Contact Details" CssClass="HeaderTextSmall"></asp:Label>
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label36" runat="server" Text="Telephone No.(Res) :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblResPhone" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label41" runat="server" Text="Fax :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblResFax" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label37" runat="server" Text="Telephone No.(Off) :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblOfcPhone" runat="server" Text="Label" CssClass="Field"></asp:Label>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label39" runat="server" Text="Email :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblEmail" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label40" runat="server" Text="Alternate Email :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblAltEmail" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="lblmob1" runat="server" Text="Mobile1 :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblMobile1" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="lblmob2" runat="server" Text="Mobile2 :" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblMobile2" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div class="tabbertab">
        <h6>
            Additional Information</h6>
        <table width="100%">
            <tr>
                <td colspan="4">
                    <asp:Label ID="Label44" runat="server" Text="Additional Information" CssClass="HeaderTextSmall"></asp:Label>
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label26" runat="server" Text="Occupation:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                   <asp:DropDownList ID="ddlOccupation" Enabled="false" runat="server" CssClass="cmbField">
                        </asp:DropDownList>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label28" runat="server" Text="AnnualIncome:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblAnnualIncome" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label29" runat="server" Text="Nationality:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblNationality" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label30" runat="server" Text="MinNo1:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblMinNo1" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label32" runat="server" Text="MinNo2:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblMinNo2" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label34" runat="server" Text="MinNo3:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblMinNo3" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label31" runat="server" Text="ESCNo:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblESCNo" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label38" runat="server" Text="UINNo:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblUINNo" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label43" runat="server" Text="POA:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblPOA" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
             <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label51" runat="server" Text="Subbroker:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblSubbroker" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label56" runat="server" Text="Date of birth:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblDOB" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label58" runat="server" Text="Mother's Maiden Name:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblmothersname" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label33" runat="server" Text="GuardianName:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblGuardianName" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label45" runat="server" Text="GuardianRelation:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblGuardianRelation" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label47" runat="server" Text="GuardianPANNum:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblGuardianPANNum" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label27" runat="server" Text="Alert Preferences:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:CheckBox ID="chkmailn" runat="server" CssClass="txtField" Text="Via Mail" AutoPostBack="true"
                        Enabled="false" />
                    &nbsp; &nbsp;
                    <asp:CheckBox ID="chksmsn" runat="server" CssClass="txtField" Text="Via SMS" Checked="true"
                        AutoPostBack="true" Enabled="false" />
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label46" runat="server" Text="GuardianMinNo:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblGuardianMinNo" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label42" runat="server" Text="Guardian Date Of Birth:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblGuardianDateOfBirth" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label48" runat="server" Text="Other BankName:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblOtherBankName" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label50" runat="server" Text="TaxStatus:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblTaxStatus" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label52" runat="server" Text="Category:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblCategory" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label49" runat="server" Text="Other City:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblOtherCity" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label53" runat="server" Text="Other State:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblOtherState" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
                <td class="leftField" width="25%">
                    <asp:Label ID="Label55" runat="server" Text="Other Country:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightField" width="25%">
                    <asp:Label ID="lblOtherCountry" runat="server" Text="Label" CssClass="Field"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
    </div>
</div>
<table width="100%">
    <tr id="trDelete" runat="server">
        <td colspan="3" class="SubmitCell">
            <asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete"
                Visible="false" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_ViewNonIndividualProfile_btnDelete');"
                onmouseout="javascript:ChangeButtonCss('out', 'ctrl_ViewNonIndividualProfile_btnDelete');" />
            <asp:HiddenField ID="hdnassociationcount" runat="server" />
        </td>
    </tr>
</table>