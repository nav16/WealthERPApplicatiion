﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RejectedTradeAccountStaging.ascx.cs" Inherits="WealthERP.SuperAdmin.RejectedTradeAccountStaging" %>
<%@ Register Src="~/General/Pager.ascx" TagPrefix="Pager" TagName="Pager" %>

<script type="text/javascript" src="../Scripts/JScript.js"></script>

<script language="javascript" type="text/javascript">
    function checkAllBoxes() {

        //get total number of rows in the gridview and do whatever
        //you want with it..just grabbing it just cause
        var totalChkBoxes = parseInt('<%= gvWERPTrans.Rows.Count %>');
        var gvControl = document.getElementById('<%= gvWERPTrans.ClientID %>');

        //this is the checkbox in the item template...this has to be the same name as the ID of it
        var gvChkBoxControl = "chkBxWPTrans";

        //this is the checkbox in the header template
        var mainChkBox = document.getElementById("chkBxWPTransAll");

        //get an array of input types in the gridview
        var inputTypes = gvControl.getElementsByTagName("input");

        for (var i = 0; i < inputTypes.length; i++) {
            //if the input type is a checkbox and the id of it is what we set above
            //then check or uncheck according to the main checkbox in the header template
            if (inputTypes[i].type == 'checkbox' && inputTypes[i].id.indexOf(gvChkBoxControl, 0) >= 0)
                inputTypes[i].checked = mainChkBox.checked;
        }
    }
    </script>

<table style="width: 100%" class="TableBackground">
    <tr>
        <td class="HeaderCell">
            <asp:Label ID="lblHeader" runat="server" CssClass="HeaderTextBig" Text="Trade Account Staging Rejects"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:LinkButton runat="server" ID="lnkBtnBack" CssClass="LinkButtons" Text="Back"
                OnClick="lnkBtnBack_Click"></asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td class="leftField">
            <asp:Label ID="lblCurrentPage" class="Field" runat="server"></asp:Label>
            <asp:Label ID="lblTotalRows" class="Field" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:GridView ID="gvWERPTrans" runat="server" AutoGenerateColumns="False" CellPadding="4"
                ShowFooter="true" CssClass="GridViewStyle" DataKeyNames="WERPTransactionId" AllowSorting="true"
                OnSorting="gvWERPTrans_Sort">
                <FooterStyle CssClass="FooterStyle" />
                <RowStyle CssClass="RowStyle" />
                <EditRowStyle HorizontalAlign="Left" CssClass="EditRowStyle" />
                <SelectedRowStyle CssClass="SelectedRowStyle" />
                <PagerStyle HorizontalAlign="Center" CssClass="PagerStyle" />
                <HeaderStyle CssClass="HeaderStyle" />
                <AlternatingRowStyle CssClass="AltRowStyle" />
                <Columns>
                    <%--Check Boxes--%>
                    <asp:TemplateField HeaderText="Select">
                        <HeaderTemplate>
                            <asp:Label ID="lblchkBxSelect" runat="server" Text="Select"></asp:Label>
                            <input id="chkBxWPTransAll" name="chkBxWPTransAll" type="checkbox" onclick="checkAllBoxes()" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkBxWPTrans" runat="server" CssClass="cmbField" />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Button ID="btnEditSelectedWPTrans" CssClass="FieldName" OnClick="btnEditSelectedWPTrans_Click"
                                runat="server" Text="Save" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblRejectReason" runat="server" Text="Reject Reason"></asp:Label>
                            <asp:DropDownList ID="ddlRejectReason" AutoPostBack="true" runat="server" CssClass="cmbField"
                                OnSelectedIndexChanged="ddlRejectReason_SelectedIndexChanged">
                            </asp:DropDownList>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblRejectReasonHeader" runat="server" Text='<%# Eval("RejectReason").ToString() %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="lblAdviserName" runat="server" Text="Adviser Org."></asp:Label>
                               <%-- <asp:DropDownList ID="ddlRejectReason" CssClass="cmbLongField" AutoPostBack="true"
                                    runat="server" OnSelectedIndexChanged="ddlRejectReason_SelectedIndexChanged">
                                </asp:DropDownList>--%>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAdviserOrg"  runat="server" Text='<%# Eval("A_OrgName").ToString() %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="lblHdrProcessId" runat="server" Text="Process Id"></asp:Label>
                                <asp:DropDownList ID="ddlProcessId" AutoPostBack="true" CssClass="GridViewCmbField" runat="server" 
                                OnSelectedIndexChanged="ddlProcessId_SelectedIndexChanged">
                                </asp:DropDownList>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblProcessID" runat="server" Text='<%# Eval("ProcessId").ToString() %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblTradeAccountNumber" runat="server" Text="Trade Account Number"></asp:Label>
                            <asp:TextBox ID="txtTradeAccountNumberSearch" Text='<%# hdnTradeAccountNumFilter.Value %>'
                                runat="server" CssClass="txtField" onkeydown="return JSdoPostback(event,'ctrl_RejectedTradeAccountStaging_btnGridSearch');" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="txtTradeAccountNumber" runat="server" Text='<%# Bind("TradeAccountNumber") %>'
                                CssClass="txtField"></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtTradeAccountNumberMultiple" CssClass="txtField" runat="server" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblPanNumber" runat="server" Text="PAN Number"></asp:Label>
                            <asp:DropDownList ID="ddlPanNumber" AutoPostBack="true" runat="server" CssClass="GridViewCmbField"
                                OnSelectedIndexChanged="ddlPanNumber_SelectedIndexChanged">
                            </asp:DropDownList>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="txtPanNumber" runat="server" Text='<%# Bind("PANNum") %>' CssClass="txtField"></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtPanNumberMultiple" runat="server" CssClass="txtField" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    
                    <%--<asp:BoundField DataField="ProcessId" HeaderText="Process Id" />--%>
                    <%--<asp:BoundField DataField="ProcessID" HeaderText="ProcessId" />
                    <asp:BoundField DataField="WERPCustomerName" HeaderText="WERP Customer Name" SortExpression="WERPCustomerName" />
                    <asp:BoundField DataField="FolioExists" HeaderText="Does Folio Exist" />
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblFolio" runat="server" Text="Folio"></asp:Label>
                            <asp:TextBox ID="txtFolioSearch" runat="server" CssClass="txtField" onkeydown="return JSdoPostback(event,'ctrl_RejectedWERPTransaction_btnGridSearch');" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="txtFolioWPTrans" runat="server" Text='<%# Bind("Folio") %>'></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtFolioMultiple" CssClass="FieldName" runat="server" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Transaction Number">
                        <ItemTemplate>
                            <asp:TextBox ID="txtTransNumber" runat="server" Text='<%# Bind("TransactionNumber") %>'></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtTransNumberMultiple" CssClass="FieldName" runat="server" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="IsRejected" HeaderText="Is Rejected" />
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblIsRejected" runat="server" Text="Is Rejected"></asp:Label>
                            <asp:DropDownList ID="ddlIsRejected" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlIsRejected_SelectedIndexChanged">
                            </asp:DropDownList>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblIsRejectedHeader" runat="server" Text='<%# Eval("IsRejected").ToString() %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="RejectReason" HeaderText="Reject Reason" />
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblRejectReason" runat="server" Text="Reject Reason"></asp:Label>
                            <asp:DropDownList ID="ddlRejectReason" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlRejectReason_SelectedIndexChanged">
                            </asp:DropDownList>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblRejectReasonHeader" runat="server" Text='<%# Eval("RejectReason").ToString() %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                </Columns>
            </asp:GridView>
        </td>
    </tr>
    <tr id="trReprocess" runat="server">
        <td class="SubmitCell">
            <asp:Button ID="btnReprocess" OnClick="btnReprocess_Click" runat="server" Text="Reprocess"
                CssClass="PCGLongButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_RejectedWERPTransaction_btnReprocess','S');"
                onmouseout="javascript:ChangeButtonCss('out', 'ctrl_RejectedWERPTransaction_btnReprocess','S');" />
            <asp:Button ID="btnDelete" runat="server" CssClass="PCGLongButton" Text="Delete Records"
                OnClick="btnDelete_Click" />
        </td>
    </tr>
    <tr id="trMessage" runat="server" visible="false">
        <td class="Message">
            <label id="lblEmptyMsg" class="FieldName">
                There are no records to be displayed!</label>
        </td>
    </tr>
    <tr id="trErrorMessage" runat="server" visible="false">
        <td class="Message">
            <asp:Label ID="lblError" CssClass="Message" runat="server">
            </asp:Label>
        </td>
    </tr>
</table>
<div id="DivPager" runat="server" style="display: none">
    <table style="width: 100%">
        <tr align="center">
            <td>
                <Pager:Pager ID="mypager" runat="server"></Pager:Pager>
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="hdnRecordCount" runat="server" />
<asp:HiddenField ID="hdnCurrentPage" runat="server" />
<asp:HiddenField ID="hdnSort" runat="server" Value="WERPCustomerName ASC" />
<asp:HiddenField ID="hdnPanFilter" runat="server" Visible="false" />
<asp:HiddenField ID="hdnRejectReasonFilter" runat="server" Visible="false" />
<asp:HiddenField ID="hdnTradeAccountNumFilter" runat="server" Visible="false" />
<asp:HiddenField ID="hdnProcessIdFilter" runat="server" Visible="false" />
<asp:Button ID="btnGridSearch" runat="server" Text="" OnClick="btnGridSearch_Click"
    BorderStyle="None" BackColor="Transparent" />