﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddBranch.ascx.cs" Inherits="WealthERP.Advisor.AddBranch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<script language="javascript" type="text/javascript">
    function showmessage() {

        var bool = window.confirm('Do u want to add Agent code?');
        if (bool) {
            document.getElementById("ctrl_AddBranch_hdnMsgValue").value = 1;
            document.getElementById("ctrl_AddBranch_hiddenDelete").click();
            return false;
        }
        else {
            document.getElementById("ctrl_AddBranch_hdnMsgValue").value = 0;
            document.getElementById("ctrl_AddBranch_hiddenDelete").click();
            return true;
        }
    }
   
</script>

<script type="text/javascript">
    function validate(c) {
        if (c.value == "") {
            ValidatorEnable(document.getElementById("<%=RequiredFieldValidator1.ClientID%>"), true);

        }
    }
</script>

<script type="text/javascript">
    function validate2(c) {
        if (c.value == "") {
            ValidatorEnable(document.getElementById("<%=rfvBranchCode.ClientID%>"), true);

        }
    }
</script>

<script type="text/javascript">
    function validate3(c) {
        if (c.value == "") {
            ValidatorEnable(document.getElementById("<%=RequiredFieldValidator2.ClientID%>"), true);

        }
    }
</script>

<script type="text/javascript">
    function validate4(c) {
        if (c.value == "") {
            ValidatorEnable(document.getElementById("<%=RequiredFieldValidator4.ClientID%>"), true);

        }
    }
</script>

<script type="text/javascript">
    function validate5(c) {
        if (c.value == "") {
            ValidatorEnable(document.getElementById("<%=RequiredFieldValidator3.ClientID%>"), true);

        }
    }
</script>

<script language="javascript" type="text/javascript">
    window.onload = function() { assignValueToAgentCode() };
    function assignValueToAgentCode() {
        document.getElementById("<%=txtAgentCode.ClientID%>").value = document.getElementById("<%=txtBranchCode.ClientID%>").value + "99999";
        document.getElementById("ctrl_AddBranch_hdnValue").value = document.getElementById("<%=txtBranchCode.ClientID%>").value + "99999";

    }
</script>

<script language="javascript" type="text/javascript">
    function openpopupAddBranchHead() {
        var rmID = document.getElementById("<%=hdnRmId.ClientID%>").value;
        {
            window.open('PopUp.aspx?pageID=AddStaff&RmId=' + rmID, 'mywindow', 'width=1000,height=500,scrollbars=yes,location=no')
        }
    }
</script>

<html>
<head>
    <meta http-equiv="CACHE-CONTROL" content="NO-CACHE">
    <%-- <script type="text/javascript">
         function Add() {
             //            var a = window.confirm("Do u want to continue");
             var a1 = window.alert("Do u want to continue");
             if (a1) {
                 alert("Proceed");
                 //                alert("Yes");

             }
             else {
                 alert("Stop");

             }
         }
         //    function ViewAssociateRows(BranchAssociateType) {
         //        var content_Prefix = "ctrl_AddBranch_";
         //        CategoryRow = content_Prefix + "AssociateCategoryRow";
         //        LogoRow = content_Prefix + "AssociateLogoRow";
         //        AssociateCategoryRow = document.getElementById(CategoryRow);
         //        AssociateLogoRow = document.getElementById(LogoRow);
         //        if (BranchAssociateType.options[BranchAssociateType.selectedIndex].text == "Associate") {
         //            AssociateCategoryRow.style.display = '';
         //            AssociateLogoRow.style.display = '';
         //        }
         //        else {
         //            AssociateCategoryRow.style.display = 'none';
         //            AssociateLogoRow.style.display = 'none';
         //        }
         //    }
</script> --%>
</head>
<body>
</body>
</html>
<asp:ScriptManager ID="scriptmanager" runat="server">
</asp:ScriptManager>
<%--<asp:UpdatePanel ID="upnl" runat="server">
<ContentTemplate>--%>
<style type="text/css">
    .txtGridMediumField
    {
        font-family: Verdana,Tahoma;
        font-weight: normal;
        font-size: x-small;
        color: #16518A;
        width: 100px;
    }
</style>
<table width="100%" class="TableBackground">
    <tr>
        <td class="HeaderCell">
            <asp:Label ID="lblTitle" runat="server" CssClass="HeaderTextBig" Text="Add Branch/Associate"></asp:Label>
            <hr />
        </td>
    </tr>
</table>
<table style="width: 100%;" class="TableBackground">
    <%-- <tr>
        <td colspan="4">
            <label id="lbl" class="lblRequiredText">
                Note: Fields marked with ' * ' are compulsory</label>
        </td>
    </tr>--%>
    <tr>
        <td class="leftField" width="25%">
            <asp:Label ID="Label3" runat="server" CssClass="FieldName" Text="Code :"></asp:Label>
        </td>
        <td class="rightField" width="25%">
            <asp:TextBox ID="txtBranchCode" runat="server" CssClass="txtField" ValidationGroup="txtBranchCode"
                onblur="return assignValueToAgentCode(validate2(this))"></asp:TextBox>
            <span id="Span1" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ControlToValidate="txtBranchCode" ErrorMessage="Please enter the Branch Code"
                CssClass="rfvPCG" Display="Dynamic" ID="rfvBranchCode" ValidationGroup="VGSave"
                runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revCode" runat="server" Display="Dynamic" CssClass="rfvPCG"
                ErrorMessage="Please check Alphanumeric Format" ControlToValidate="txtBranchCode"
                ValidationExpression="^[0-9a-zA-Z' ']+$">
            </asp:RegularExpressionValidator>
            <asp:Label ID="lblcodeDuplicate" runat="server" CssClass="Error" Visible="false"
                Text="Code already exists"></asp:Label>
        </td>
        <td class="leftField" width="25%">
            <asp:Label ID="Label15" runat="server" CssClass="FieldName" Text="Agent Code :"></asp:Label>
        </td>
        <td class="rightField" width="25%">
            <asp:TextBox ID="txtAgentCode" Enabled="false" runat="server" CssClass="txtField"></asp:TextBox>
            <span id="Span8" class="spnRequiredField">*</span>
        </td>
    </tr>
    <%--<tr>
     <td class="leftField" width="25%">
            <asp:Label ID="Label15" runat="server" CssClass="FieldName" Text="Agent Code :"></asp:Label>
        </td>
        <td class="rightField" width="25%">
            <asp:TextBox ID="txtAgentCode" runat="server" CssClass="txtField"></asp:TextBox>
           <%-- <span id="Span8" class="spnRequiredField">*</span>--%>
    <%--  <br />--%>
    <%-- <asp:RequiredFieldValidator ControlToValidate="txtBranchCode" ErrorMessage="Please enter the Branch Code"
                CssClass="rfvPCG" Display="Dynamic" ID="RequiredFieldValidator6" ValidationGroup="VGSave"
                runat="server"></asp:RequiredFieldValidator>--%>
    <tr>
        <td class="leftField" width="25%">
            <asp:Label ID="Label4" runat="server" CssClass="FieldName" Text="Name :"></asp:Label>
        </td>
        <td class="rightField" width="25%">
            <asp:TextBox ID="txtBranchName" CssClass="txtField" runat="server" MaxLength="25"
                onblur="validate(this)"></asp:TextBox>
            <span id="Span2" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ControlToValidate="txtBranchName" ErrorMessage="Please enter the Branch/Associate Name"
                CssClass="rfvPCG" Display="Dynamic" ID="RequiredFieldValidator1" ValidationGroup="VGSave"
                runat="server"></asp:RequiredFieldValidator>
        </td>
        <td class="leftField" width="25%">
            <asp:Label ID="Label1" runat="server" CssClass="FieldName" Visible="false" Text="Type:"></asp:Label>
        </td>
        <td class="rightfield" width="25%">
            <asp:DropDownList ID="ddlBranchAssociateType" runat="server" CssClass="cmbField"
                Visible="false" OnSelectedIndexChanged="ddlBranchAssociateType_SelectedIndexChanged"
                AutoPostBack="true">
            </asp:DropDownList>
            <%-- <span id="Span4" class="spnRequiredField">*</span> </br>--%>
            <asp:CompareValidator ID="ddlBranchAssociateType_CompareValidator" runat="server"
                ControlToValidate="ddlBranchAssociateType" ErrorMessage="Please select a Branch/Associate Type"
                Operator="NotEqual" ValueToCompare="Select a Type" CssClass="cvPCG" ValidationGroup="VGSave">
            </asp:CompareValidator>
        </td>
    </tr>
    <tr>
        <td class="leftField" width="25%">
            <asp:Label ID="Label13" runat="server" CssClass="FieldName" Text="Pick Zone/Cluster :"></asp:Label>
        </td>
        <td class="rightfield" width="25%">
            <asp:DropDownList ID="ddlZOneCluster" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlZOneCluster_SelectedIndexChanged"
                AutoPostBack="true">
                <asp:ListItem Text="--SELECT--" Value="Select" Selected="True"></asp:ListItem>
                <asp:ListItem Text="Zone" Value="Zone"></asp:ListItem>
                <asp:ListItem Text="Area" Value="Area"></asp:ListItem>
                <asp:ListItem Text="Cluster" Value="Cluster"></asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr id="trZoneCluster" runat="server">
        <td colspan="2">
        </td>
        <td class="leftField" width="25%">
            <asp:Label ID="lb1Zc" runat="server" CssClass="FieldName" Text="Zone :"></asp:Label>
        </td>
        <td class="rightfield" width="25%">
            <asp:DropDownList ID="ddlSelectedZC" runat="server" CssClass="cmbField" AutoPostBack="true">
            </asp:DropDownList>
        </td>
    </tr>
    <tr id="AssociateCategoryRow" runat="server">
        <td class="leftField">
            <asp:Label ID="Label6" runat="server" CssClass="FieldName" Text="Category:"></asp:Label>
        </td>
        <td class="rightfield" width="25%">
            <asp:DropDownList ID="ddlAssociateCategory" runat="server" CssClass="cmbField" ToolTip="Please setup the category if u dont find any data here">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <asp:Label ID="Label5" runat="server" CssClass="HeaderTextSmall" Text="Address"></asp:Label>
            <hr />
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="lblLine1" runat="server" CssClass="FieldName" Text="Line1 (House No/Building) :"></asp:Label>
        </td>
        <td class="rightField">
            <table width="100%" cellspacing="0">
                <tr>
                    <td>
                        <asp:TextBox ID="txtLine1" CssClass="txtLongAddField" onblur="validate3(this)" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <span id="Span3" class="spnRequiredField">*</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:RequiredFieldValidator ControlToValidate="txtLine1" ErrorMessage="Please enter the Address Line1"
                            CssClass="rfvPCG" Display="Dynamic" ID="RequiredFieldValidator2" ValidationGroup="VGSave"
                            runat="server"></asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
        </td>
        <td class="leftField">
            <asp:Label ID="Label21" runat="server" CssClass="FieldName" Text="City :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:TextBox ID="txtCity" runat="server" CssClass="txtField"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label7" runat="server" CssClass="FieldName" Text="Line 2 (Street) :"> </asp:Label>
        </td>
        <td class="rightField">
            <asp:TextBox ID="txtLine2" CssClass="txtLongAddField" runat="server"></asp:TextBox>
        </td>
        <td class="leftField">
            <asp:Label ID="lblPinCode" runat="server" CssClass="FieldName" Text="Pin Code :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:TextBox ID="txtPinCode" runat="server" MinLength="6" onblur="validate4(this)"
                MaxLength="6" CssClass="txtField"></asp:TextBox>
            <span id="Span7" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPinCode"
                ErrorMessage="Pincode Required" CssClass="cvPCG" ValidationGroup="VGSave"
                Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" CssClass="cvPCG"
                ErrorMessage="</br>Please give min. 6 digit Numbers" ValidationGroup="VGSave"
                ValidationExpression="^\d{6,6}$" ControlToValidate="txtPinCode" Display="Dynamic"></asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="Label8" runat="server" CssClass="FieldName" Text="Line 3 (Area) :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:TextBox ID="txtLine3" CssClass="txtLongAddField" runat="server"></asp:TextBox>
        </td>
        <td class="leftField">
            <asp:Label ID="Label11" runat="server" CssClass="FieldName" Text="State :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:DropDownList ID="ddlState" runat="server" CssClass="cmbField">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="leftField" colspan="3">
            <asp:Label ID="Label12" runat="server" CssClass="FieldName" Text="Country :"></asp:Label>
        </td>
        <td class="rightField">
            <asp:DropDownList ID="ddlCountry" runat="server" CssClass="cmbField">
                <asp:ListItem>India</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <asp:Label ID="Label9" runat="server" CssClass="HeaderTextSmall" Text="Head Details"></asp:Label>
            <hr />
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="lblHeadName0" runat="server" CssClass="FieldName" Text="Branch/Associate Head :"></asp:Label>
        </td>
        <td class="rightField" width="15%">
            <asp:DropDownList ID="ddlRmlist" runat="server" Width="90%" CssClass="cmbField">
            </asp:DropDownList>
        </td>
        <td>
            <asp:ImageButton ID="btnAddStaff" ImageUrl="~/App_Themes/Maroon/Images/user_add.png"
                AlternateText="Add Branch Head" runat="server" ToolTip="Click here to Add Branch Head"
                OnClientClick="return openpopupAddBranchHead()" Height="15px" Width="15px" TabIndex="3">
            </asp:ImageButton>
            <asp:ImageButton ID="btnRefresh" ImageUrl="~/Images/refresh.png" AlternateText="Refresh Branch Head"
                runat="server" ToolTip="Click here to Refresh" OnClick="btnRefresh_Click" Height="15px"
                Width="15px" TabIndex="3"></asp:ImageButton>
        </td>
    </tr>
    <tr id="trNoOfTerminals" runat="server">
        <td class="leftField">
            <asp:Label ID="Label22" runat="server" CssClass="FieldName" Text="Number Of Terminals :"></asp:Label>
        </td>
        <td class="rightField" colspan="3">
            <asp:TextBox ID="txtTerminalCount" CssClass="txtField" runat="server" MaxLength="3"></asp:TextBox>
            <br />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" CssClass="cvPCG"
                ErrorMessage="Please give only Numbers" ValidationExpression="\d+" ControlToValidate="txtTerminalCount"
                Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:Button ID="btnAddTerminal" runat="server" OnClick="btnAddTerminal_Click" Text="Add Terminal Id"
                CssClass="PCGMediumButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_AddBranch_btnAddTerminal','M');"
                onmouseout="javascript:ChangeButtonCss('out', 'ctrl_AddBranch_btnAddTerminal','M');" />
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;&nbsp;
        </td>
        <td colspan="3">
            <asp:Label ID="lblISD" runat="server" CssClass="FieldName" Text="ISD"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblSTD" runat="server" Names="Arial" CssClass="FieldName" Size="X-Small"
                Text="STD"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblPhone" runat="server" Names="Arial" CssClass="FieldName" Size="X-Small"
                Text="Phone Number"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="lblPhoneNumber" runat="server" CssClass="FieldName" Text="Telephone Number 1 :"></asp:Label>
        </td>
        <td class="rightField" colspan="3">
            <asp:TextBox ID="txtIsdPhone1" CssClass="txtField" runat="server" Width="55px" MaxLength="5">91</asp:TextBox>
            <asp:TextBox ID="txtStdPhone1" CssClass="txtField" runat="server" Width="55px" MaxLength="4"></asp:TextBox>
            <asp:TextBox ID="txtPhone1" CssClass="txtField" onblur="validate5(this)" runat="server"
                MaxLength="8"></asp:TextBox>
            <span id="Span5" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtPhone1"
                ErrorMessage="<br />Please enter the Contact Number" Display="Dynamic" runat="server"
                CssClass="rfvPCG" ValidationGroup="VGSave">
            </asp:RequiredFieldValidator>
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" CssClass="cvPCG"
                ErrorMessage="<br />Please give only Numbers" ValidationExpression="\d+" ControlToValidate="txtIsdPhone1"
                Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" CssClass="cvPCG"
                ErrorMessage="<br />Please give only Numbers" ValidationExpression="\d+" ControlToValidate="txtStdPhone1"
                Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" CssClass="cvPCG"
                ValidationGroup="VGSave" ErrorMessage="<br />Please give only Numbers" ValidationExpression="^[0-9]+$"
                ControlToValidate="txtPhone1" Display="Dynamic"></asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="lblPhone2" runat="server" CssClass="FieldName" Text="Telephone Number 2 :"></asp:Label>
        </td>
        <td class="rightField" colspan="3">
            <asp:TextBox ID="txtIsdPhone2" CssClass="txtField" runat="server" Width="55px" MaxLength="5">91</asp:TextBox>
            <asp:TextBox ID="txtStdPhone2" CssClass="txtField" runat="server" Width="55px" MaxLength="4"></asp:TextBox>
            <asp:TextBox ID="txtPhone2" CssClass="txtField" runat="server" MaxLength="8"></asp:TextBox>
            <%--         <asp:CompareValidator ID="CompareValidator8" runat="server" ErrorMessage="<br />Enter a numeric value"
                CssClass="cvPCG" Type="Integer" ControlToValidate="txtPhone2" Operator="DataTypeCheck"
                Display="Dynamic"></asp:CompareValidator>
            <asp:CompareValidator ID="CompareValidator6" runat="server" ErrorMessage="<br />Enter a numeric value"
                CssClass="cvPCG" Type="Integer" ControlToValidate="txtIsdPhone2" Operator="DataTypeCheck"
                Display="Dynamic"></asp:CompareValidator>
            <asp:CompareValidator ID="CompareValidator7" runat="server" ErrorMessage="<br />Enter a numeric value"
                CssClass="cvPCG" Type="Integer" ControlToValidate="txtStdPhone2" Operator="DataTypeCheck"
                Display="Dynamic"></asp:CompareValidator>--%>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
                CssClass="cvPCG" ErrorMessage="<br />Please give only Numbers" ValidationExpression="\d+"
                ControlToValidate="txtIsdPhone2" Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server"
                CssClass="cvPCG" ErrorMessage="<br />Please give only Numbers" ValidationExpression="\d+"
                ControlToValidate="txtStdPhone2" Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server"
                CssClass="cvPCG" ValidationGroup="VGSave" ErrorMessage="<br />Please give only Numbers"
                ValidationExpression="^[0-9]+$" ControlToValidate="txtPhone2" Display="Dynamic"></asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="lblFax" runat="server" CssClass="FieldName" Text="Fax :"></asp:Label>
        </td>
        <td class="rightField" colspan="3">
            <asp:TextBox ID="txtIsdFax" CssClass="txtField" runat="server" Width="55px" MaxLength="5">91</asp:TextBox>
            <asp:TextBox ID="txtStdFax" CssClass="txtField" runat="server" Width="55px" MaxLength="4"></asp:TextBox>
            <asp:TextBox ID="txtFax" CssClass="txtField" runat="server" MaxLength="8"></asp:TextBox>
            <%--  <asp:CompareValidator ID="CompareValidator11" runat="server" ErrorMessage="<br />Enter a numeric value"
                CssClass="cvPCG" Type="Integer" ControlToValidate="txtFax" Operator="DataTypeCheck"
                Display="Dynamic"></asp:CompareValidator>
            <asp:CompareValidator ID="CompareValidator9" runat="server" ErrorMessage="<br />Enter a numeric value"
                CssClass="cvPCG" Type="Integer" ControlToValidate="txtIsdFax" Operator="DataTypeCheck"
                Display="Dynamic"></asp:CompareValidator>
            <asp:CompareValidator ID="CompareValidator10" runat="server" ErrorMessage="<br />Enter a numeric value"
                CssClass="cvPCG" Type="Integer" ControlToValidate="txtStdFax" Operator="DataTypeCheck"
                Display="Dynamic"></asp:CompareValidator>--%>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server"
                CssClass="cvPCG" ErrorMessage="<br />Please give only Numbers" ValidationExpression="\d+"
                ControlToValidate="txtIsdFax" Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator14" runat="server"
                CssClass="cvPCG" ErrorMessage="<br />Please give only Numbers" ValidationExpression="\d+"
                ControlToValidate="txtStdFax" Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator15" runat="server"
                CssClass="cvPCG" ValidationGroup="VGSave" ErrorMessage="<br />Please give only Numbers"
                ValidationExpression="^[0-9]+$" ControlToValidate="txtFax" Display="Dynamic"></asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="lblEmail" runat="server" CssClass="FieldName" Text="Email Id :"></asp:Label>
        </td>
        <td class="rightField" colspan="3">
            <asp:TextBox ID="txtEmail" CssClass="txtField" runat="server"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtEmail"
                ValidationGroup="VGSave" ErrorMessage="Please enter a valid Email ID" Display="Dynamic"
                runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                CssClass="revPCG"></asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr id="trCommsharingHeading" runat="server">
        <td colspan="4">
            <asp:Label ID="Label10" runat="server" CssClass="HeaderTextSmall" Text="Commision Sharing Structure"></asp:Label>
            <hr />
        </td>
    </tr>
    <tr id="CommSharingStructureHdr" runat="server">
        <td colspan="4">
            <asp:GridView ID="gvCommStructure" runat="server" AutoGenerateColumns="False" CssClass="GridViewStyle"
                ShowFooter="True" CellPadding="4" OnRowDataBound="gvCommStructure_RowDataBound">
                <RowStyle CssClass="RowStyle" />
                <FooterStyle CssClass="FooterStyle" />
                <PagerStyle CssClass="PagerStyle" />
                <SelectedRowStyle CssClass="SelectedRowStyle" />
                <HeaderStyle CssClass="HeaderStyle" />
                <EditRowStyle CssClass="EditRowStyle" />
                <AlternatingRowStyle CssClass="AltRowStyle" />
                <Columns>
                    <asp:TemplateField HeaderText="Asset Group">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlAssetGroup" runat="server" CssClass="cmbField">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="cmpValidatorAssetGroup" runat="server" ControlToValidate="ddlAssetGroup"
                                ErrorMessage="Please select a asset group" Operator="NotEqual" ValueToCompare="Select Asset Group"
                                Display="Dynamic" CssClass="cvPCG" ValidationGroup="btnAdd">
                            </asp:CompareValidator>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Commission Fee(%)">
                        <ItemTemplate>
                            <asp:TextBox ID="txtCommFee" runat="server" CssClass="txtGridMediumField" MaxLength="5"></asp:TextBox>
                            <cc1:FilteredTextBoxExtender ID="txtCommFee_E" runat="server" Enabled="True" TargetControlID="txtCommFee"
                                FilterType="Custom,Numbers" ValidChars=".">
                            </cc1:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ControlToValidate="txtCommFee" ErrorMessage="Please enter Commission Fee(%)"
                                CssClass="rfvPCG" Display="Dynamic" ID="reqtxtCommFee" ValidationGroup="btnAdd"
                                runat="server"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="RangeValidator1" SetFocusOnError="true" Type="Double" ErrorMessage="Margin should be 0 - 100%"
                                MinimumValue="0" MaximumValue="100" CssClass="rfvPCG" Display="Dynamic" ControlToValidate="txtCommFee"
                                ValidationGroup="btnAdd" runat="server"></asp:RangeValidator>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Upper Limit of Revenue">
                        <ItemTemplate>
                            <asp:TextBox ID="txtRevUpperLimit" runat="server" CssClass="txtGridMediumField"></asp:TextBox>
                            <cc1:FilteredTextBoxExtender ID="txtRevUpperLimit_E" runat="server" Enabled="True"
                                TargetControlID="txtRevUpperLimit" FilterType="Custom, Numbers" ValidChars=".">
                            </cc1:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ControlToValidate="txtRevUpperLimit" ErrorMessage="Please enter Commission upper limit"
                                CssClass="rfvPCG" Display="Dynamic" ID="reqtxtRevUpperLimit" ValidationGroup="btnAdd"
                                runat="server"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ControlToValidate="txtRevUpperLimit"
                                Display="Dynamic" CssClass="rfvPCG" runat="server" ErrorMessage="Not acceptable format"
                                ValidationGroup="btnAdd" ValidationExpression="^\d*(\.(\d{0,2}))?$"></asp:RegularExpressionValidator>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Lower Limit of Revenue">
                        <ItemTemplate>
                            <asp:TextBox ID="txtRevLowerLimit" runat="server" CssClass="txtGridMediumField"></asp:TextBox>
                            <cc1:FilteredTextBoxExtender ID="txtRevLowerLimit_E" runat="server" Enabled="True"
                                TargetControlID="txtRevLowerLimit" FilterType="Custom, Numbers" ValidChars=".">
                            </cc1:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ControlToValidate="txtRevLowerLimit" ErrorMessage="Please enter Commission lower limit"
                                CssClass="rfvPCG" Display="Dynamic" ID="reqtxtRevLowerLimit" ValidationGroup="btnAdd"
                                runat="server"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator13" runat="server" ControlToValidate="txtRevLowerLimit"
                                ErrorMessage="Lower Limit should be less than the Upper Limit" Type="Double"
                                Operator="LessThan" ControlToCompare="txtRevUpperLimit" CssClass="cvPCG" ValidationGroup="btnAdd"
                                Display="Dynamic"></asp:CompareValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ControlToValidate="txtRevLowerLimit"
                                Display="Dynamic" CssClass="rfvPCG" runat="server" ValidationGroup="btnAdd" ErrorMessage="Not acceptable format"
                                ValidationExpression="^\d*(\.(\d{0,2}))?$"></asp:RegularExpressionValidator>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Start Date">
                        <ItemTemplate>
                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="txtGridMediumField"></asp:TextBox>
                            <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" TargetControlID="txtStartDate"
                                Format="dd/MM/yyyy">
                            </cc1:CalendarExtender>
                            <cc1:TextBoxWatermarkExtender ID="txtStartDate_TextBoxWatermarkExtender" runat="server"
                                TargetControlID="txtStartDate" WatermarkText="dd/mm/yyyy">
                            </cc1:TextBoxWatermarkExtender>
                            <asp:RequiredFieldValidator ID="reqtxtStartDate" runat="server" ControlToValidate="txtStartDate"
                                CssClass="rfvPCG" ValidationGroup="btnAdd" Display="Dynamic" ErrorMessage="Please select a start Date"></asp:RequiredFieldValidator>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="End Date">
                        <ItemTemplate>
                            <asp:TextBox ID="txtEndDate" runat="server" CssClass="txtGridMediumField"></asp:TextBox>
                            <%-- <cc1:calendarextender id="txtEndDate_CalendarExtender" runat="server" targetcontrolid="txtEndDate"
                                format="dd/MM/yyyy">
                            </cc1:calendarextender>--%>
                            <cc1:CalendarExtender ID="txtEndDate_CalendarExtender" runat="server" Format="dd/MM/yyyy"
                                TargetControlID="txtEndDate" Enabled="True">
                            </cc1:CalendarExtender>
                            <cc1:TextBoxWatermarkExtender ID="txtEndDate_TextBoxWatermarkExtender" runat="server"
                                TargetControlID="txtEndDate" WatermarkText="dd/mm/yyyy">
                            </cc1:TextBoxWatermarkExtender>
                            <asp:RequiredFieldValidator ID="reqtxtEndDate" runat="server" ControlToValidate="txtEndDate"
                                CssClass="rfvPCG" ValidationGroup="btnAdd" Display="Dynamic" ErrorMessage="Please select a End Date"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator14" runat="server" ControlToValidate="txtEndDate"
                                ErrorMessage="End Date should be greater than Start Date" Type="Date" Operator="GreaterThanEqual"
                                ControlToCompare="txtStartDate" CssClass="cvPCG" ValidationGroup="VGSave"
                                Display="Dynamic">
                            </asp:CompareValidator>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Button ID="ButtonAdd" runat="server" CssClass="PCGButton" OnClick="ButtonAdd_Click"
                                Text="Add More" ValidationGroup="btnAdd" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <%--   <asp:TemplateField HeaderText="End Date">
                        <ItemTemplate>
                            <asp:Button ID="btnAddMore" runat="server" CssClass="ButtonField" ></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                </Columns>
            </asp:GridView>
            <hr />
        </td>
    </tr>
    <tr id="CommSharingStructureGv" runat="server">
        <td colspan="4">
            &nbsp;
        </td>
    </tr>
    <tr id="AssociateLogoHdr" runat="server">
        <td colspan="4">
            <asp:Label ID="Label14" runat="server" CssClass="HeaderTextSmall" Text="Logo"></asp:Label>
            <hr />
        </td>
    </tr>
    <tr id="AssociateLogoRow" runat="server">
        <td class="leftField">
            <asp:Label ID="Label2" runat="server" CssClass="FieldName" Text="Upload Associate's Logo:"></asp:Label>
        </td>
        <td class="rightField" colspan="3">
            <asp:FileUpload ID="FileUpload" runat="server" Height="22px" />
        </td>
    </tr>
    <%--<tr>
        <td class="style4">
        </td>
        <td class="style2">
        </td>
    </tr>--%>
</table>
</ContentTemplate> </asp:UpdatePanel>
<table class="TableBackground" style="width: 100%">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td class="SubmitCell" colspan="2">
            <asp:Button ID="btnSubmit" runat="server" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_AddBranch_btnSubmit','S');"
                onmouseout="javascript:ChangeButtonCss('out', 'ctrl_AddBranch_btnSubmit','S');"
                Text="Submit" OnClick="btnSaveChanges_Click"  />
        </td>
    </tr>
    <tr id="trAddBranchCode" runat="server">
        <td class="leftField">
            <asp:Label ID="lb1BranchCode" runat="server" CssClass="FieldName" Text="Add Branch code"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Button ID="BtnBranchCode" runat="server" Text="Agent Code" CssClass="PCGMediumButton"
                OnClick="BtnBranchCode_Click" />
        </td>
        <td class="leftField">
            <asp:Label ID="lb1ViewBranch" runat="server" CssClass="FieldName" Text="View Branch"></asp:Label>
        </td>
        <td class="rightField">
            <asp:Button ID="BtnBranchCode1" runat="server" Text="View Branch" CssClass="PCGMediumButton"
                OnClick="BtnBranchCode1_Click" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:HiddenField ID="hdnMsgValue" runat="server" />
            <asp:HiddenField ID="hdnValue" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:Button ID="hiddenDelete" runat="server" OnClick="hiddenDelete_Click" Text=""
                BorderStyle="None" BackColor="Transparent" />
            <asp:HiddenField ID="hdnRmId" runat="server" />
        </td>
    </tr>
    <%-- <tr>
     <asp:Button runat="server" ID="Button1"  onClick="Button1_Click"
            Text="Submit" Visible="false" />
    <asp:HiddenField runat="server" ID="hfConfirmValue" />
    </tr>--%>
</table>
