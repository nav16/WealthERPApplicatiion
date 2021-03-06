﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GroupAccountSetup.ascx.cs"
    Inherits="WealthERP.Customer.GroupAccountSetup" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:ScriptManager ID="ScriptManager1" runat="server">
    <Services>
        <asp:ServiceReference Path="~/CustomerPortfolio/AutoComplete.asmx" />
    </Services>
</asp:ScriptManager>

<script src="../Scripts/jquery.js" type="text/javascript"></script>

<script type="text/javascript" language="javascript">
    function GetParentCustomerId(source, eventArgs) {
        document.getElementById("<%= txtParentCustomerId.ClientID %>").value = eventArgs.get_value();
        return false;
    };
    function GetMemberCustomerId(source, eventArgs) {
        document.getElementById("<%= txtMemberCustomerId.ClientID %>").value = eventArgs.get_value();
        return false;
    };


</script>

<script type="text/javascript">
    function checkRMSelectedOrNot() {
        if (document.getElementById("<%=ddlSelectRMs.ClientID%>").value == "Select RM") {
            alert('Please Select RM');
        }
    }

</script>

<table width="100%" class="TableBackground">
   <tr>
<td colspan="3" style="width: 100%;">
<div class="divPageHeading">
    <table cellspacing="0"  width="100%">
        <tr>
        <td align="left">Add Grouping</td>
        <td  align="right" style="padding-bottom:2px;">
        </td>
        </tr>
    </table>
</div>
</td>
</tr>
</table>
<asp:UpdatePanel ID="upGroupAccRM" runat="server">
<ContentTemplate>
<table>
    <tr>
    <td align="right">
            <asp:Label ID="lblSelectRM" runat="server" style="text-align: right" Text="Select RM: " CssClass="FieldName"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlSelectRMs" style="vertical-align: middle" CssClass="cmbField" runat="server" AutoPostBack="true" onselectedindexchanged="ddlSelectRMs_SelectedIndexChanged">
            
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
    </tr>
    <tr>
        <td align="right">
            <asp:Label ID="lblStaffCode" runat="server" CssClass="FieldName" Text="Staff Code: "></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtStaffCode" runat="server" Enabled="false" ReadOnly="true" CssClass="txtField"></asp:TextBox>
        </td>
        <td>
         <asp:Label ID="lblBranch" runat="server" Text="Branch: " CssClass="FieldName"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblRMsBranch" runat="server" Text="" CssClass="FieldName"></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="right">
            <asp:Label ID="lblParentCustomer" runat="server" CssClass="FieldName" Text="Pick Parent Customer:"></asp:Label>
        </td>
        <td colspan="3">
            <asp:HiddenField ID="txtParentCustomerId" runat="server" OnValueChanged="txtParentCustomer_TextChanged" />
            <asp:HiddenField ID="txtParentCustomerType" runat="server" />
           <asp:TextBox ID="txtParentCustomer" onblur="checkRMSelectedOrNot()" runat="server" CssClass="txtField" AutoComplete="Off"
                AutoPostBack="true"></asp:TextBox>
            <cc1:TextBoxWatermarkExtender ID="txtParentCustomer_TextBoxWatermarkExtender" runat="server"
                TargetControlID="txtParentCustomer" WatermarkText="Type the Customer Name">
            </cc1:TextBoxWatermarkExtender>
            <ajaxToolkit:AutoCompleteExtender ID="txtParentCustomer_autoCompleteExtender" runat="server"
                TargetControlID="txtParentCustomer" ServiceMethod="GetParentCustomers" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="5" CompletionInterval="100"
                CompletionListCssClass="AutoCompleteExtender_CompletionList" CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem"
                CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                UseContextKey="true" OnClientItemSelected="GetParentCustomerId" />
            <span id="Span1" class="spnRequiredField">*<br />
            </span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtParentCustomer"
                ErrorMessage="Please Enter Customer Name" Display="Dynamic" runat="server" CssClass="rfvPCG"
                ValidationGroup="btnSubmit">
            </asp:RequiredFieldValidator>
        </td>
    </tr>
     <tr>
        <td align="right">
            <asp:Label ID="lblPanParent" runat="server" CssClass="FieldName" Text="PAN Number:"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtPanParent" runat="server" CssClass="txtField" BackColor="Transparent"
                BorderStyle="None"></asp:TextBox>
        </td>
        <td>
            <asp:Label ID="lblAddressParent" runat="server" CssClass="FieldName" Text="Address:"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtAddressParent" runat="server" CssClass="txtField" BackColor="Transparent"
                BorderStyle="None" Width="300px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td align="right">
            <asp:Label ID="lblMemberCustomer" runat="server" CssClass="FieldName" Text="Pick Member Customer:"></asp:Label>
        </td>
        <td colspan="3">
            <asp:HiddenField ID="txtMemberCustomerId" runat="server" />
            <asp:TextBox ID="txtMemberCustomer" onblur="checkRMSelectedOrNot()" runat="server" CssClass="txtField" AutoComplete="Off"
                AutoPostBack="true" OnTextChanged="txtMemberCustomer_TextChanged"></asp:TextBox>
            <cc1:TextBoxWatermarkExtender ID="txtMemberCustomer_TextBoxWatermarkExtender" runat="server"
                TargetControlID="txtMemberCustomer" WatermarkText="Type the Customer Name">
            </cc1:TextBoxWatermarkExtender>
            <ajaxToolkit:AutoCompleteExtender runat="server" ID="txtMemberCustomer_AutoCompleteExtender"
                TargetControlID="txtMemberCustomer" ServiceMethod="GetMemberCustomerNamesForGrouping" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="5" CompletionInterval="100"
                CompletionListCssClass="AutoCompleteExtender_CompletionList" CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem"
                CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                UseContextKey="true" OnClientItemSelected="GetMemberCustomerId" />
            <span id="spFirstName" class="spnRequiredField">*<br />
            </span>
            <asp:RequiredFieldValidator ID="rfvFirstName" ControlToValidate="txtMemberCustomer"
                ErrorMessage="Please Enter Customer Name" Display="Dynamic" runat="server" CssClass="rfvPCG"
                ValidationGroup="btnSubmit">
            </asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
         <td align="right">
            <asp:Label ID="lblPanMember" runat="server" CssClass="FieldName" Text="PAN Number:"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtPanMember" runat="server" CssClass="txtField" BackColor="Transparent"
                BorderStyle="None"></asp:TextBox>
        </td>
        <td>
            <asp:Label ID="lblAddressMember" runat="server" CssClass="FieldName" Text="Address:"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtAddressMember" runat="server" CssClass="txtField" BackColor="Transparent"
                BorderStyle="None" Width="300px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="lblRelationship" runat="server" CssClass="FieldName" Text="Relationship:"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlRelationship" runat="server"  CssClass="cmbField">
            </asp:DropDownList>
            <span id="Span2" class="spnRequiredField">*</span>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlRelationship"
                ValidationGroup="btnSubmit" ErrorMessage="Select a Relationship" Operator="NotEqual"
                ValueToCompare="Select" CssClass="cvPCG"></asp:CompareValidator>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td class="SubmitCell">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                ValidationGroup="btnSubmit" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_GroupAccountSetup_btnSubmit', 'S');"
                onmouseout="javascript:ChangeButtonCss('out', 'ctrl_GroupAccountSetup_btnSubmit', 'S');" />
        </td>
        <td class="SubmitCell">
            <asp:Button ID="btnSave" runat="server" Text="Save and Associate More" OnClick="btnSave_Click"
                ValidationGroup="btnSubmit" CssClass="PCGLongButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_GroupAccountSetup_btnSave', 'L');"
                onmouseout="javascript:ChangeButtonCss('out', 'ctrl_GroupAccountSetup_btnSave', 'L');" />
        </td>
    </tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
