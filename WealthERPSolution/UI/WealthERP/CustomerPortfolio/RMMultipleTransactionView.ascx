﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RMMultipleTransactionView.ascx.cs"
    Inherits="WealthERP.CustomerPortfolio.RMMultipleTransactionView" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Charting" Assembly="Telerik.Web.UI" %>
<%@ Register Src="~/General/Pager.ascx" TagPrefix="Pager" TagName="Pager" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:ScriptManager ID="scptMgr" runat="server">
</asp:ScriptManager>

<script type="text/javascript" language="javascript">
    function GetParentCustomerId(source, eventArgs) {
        document.getElementById("<%= txtParentCustomerId.ClientID %>").value = eventArgs.get_value();
        return false;
    };


    function keyPress(sender, args) {
        if (args.keyCode == 13) {
            return false;
        }
    }
</script>

<style type="text/css" media="print">
    ..noDisplay
    {
    }
    .noPrint
    {
        display: none;
    }
    .landScape
    {
        width: 100%;
        height: 100%;
        margin: 0% 0% 0% 0%;
        filter: progid:DXImageTransform.Microsoft.BasicImage(Rotation=3);
    }
    .pageBreak
    {
        page-break-before: always;
    }
</style>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td style="width: 100%;">
                                <div class="divPageHeading">
                                    <table cellspacing="0" cellpadding="3" width="100%">
                                        <tr>
                                            <td align="left">
                                                MF Transaction Grid View
                                            </td>
                                            <td align="right" style="padding-bottom: 2px;">
                                            <asp:LinkButton ID="lbBack" runat="server" Text="Back" onclick="lbBack_Click" Visible="false" CssClass="FieldName"></asp:LinkButton>
                                            <asp:ImageButton ID="btnTrnxExport" ImageUrl="~/Images/Export_Excel.png" Visible="false"
                                            runat="server" AlternateText="Excel" ToolTip="Export To Excel" 
                                            OnClientClick="setFormat('excel')" Height="25px" Width="25px" 
                                                    onclick="btnTrnxExport_Click"></asp:ImageButton> 
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr id="trRangeNcustomer" runat="server">
                            <td align="right">
                                <asp:Label ID="Label2" runat="server" CssClass="FieldName" Text="Date Type :"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButton ID="rbtnPickDate" AutoPostBack="true" Checked="true" OnCheckedChanged="rbtnDate_CheckedChanged"
                                    runat="server" GroupName="Date" />
                                <asp:Label ID="lblPickDate" runat="server" Text="Date Range" CssClass="Field"></asp:Label>
                                &nbsp;
                                <asp:RadioButton ID="rbtnPickPeriod" AutoPostBack="true" OnCheckedChanged="rbtnDate_CheckedChanged"
                                    runat="server" GroupName="Date" />
                                <asp:Label ID="lblPickPeriod" runat="server" Text="Period" CssClass="Field"></asp:Label>
                            </td>
                            <td>
                                &nbsp;&nbsp;
                            </td>
                            <td align="right">
                                <asp:Label ID="lblCustomerGroup" runat="server" CssClass="FieldName" Text="Customer :"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButton ID="rbtnAll" AutoPostBack="true" Checked="true" runat="server" GroupName="GroupAll"
                                    Text="All" CssClass="cmbField" OnCheckedChanged="rbtnAll_CheckedChanged" />
                                &nbsp;
                                <asp:RadioButton ID="rbtnGroup" AutoPostBack="true" runat="server" GroupName="GroupAll"
                                    Text="Group" CssClass="cmbField" OnCheckedChanged="rbtnAll_CheckedChanged" />
                            </td>
                        </tr>
                        
                        <tr id="trRange" visible="false" runat="server" onkeypress="return keyPress(this, event)">
                            <td align="right" valign="top">
                                <asp:Label ID="lblFromDate" runat="server" CssClass="FieldName">From:</asp:Label>
                            </td>
                            <td valign="top">
                                <telerik:RadDatePicker ID="txtFromDate" CssClass="txtField" runat="server" Culture="English (United States)"
                                    Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                                    <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                        ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                                    </Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput ID="DateInput1" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtFromDate"
                                    CssClass="rfvPCG" ErrorMessage="<br />Please select a From Date" Display="Dynamic"
                                    runat="server" InitialValue="" ValidationGroup="btnGo"> </asp:RequiredFieldValidator>
                            </td>
                            
                            <td>
                            &nbsp;&nbsp;
                            </td>
                            <td align="right" valign="top">
                                <asp:Label ID="lblToDate" runat="server" CssClass="FieldName">To:</asp:Label>
                            </td>
                            <td valign="top">
                                <telerik:RadDatePicker ID="txtToDate" CssClass="txtTo" runat="server" Culture="English (United States)"
                                    Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                                    <Calendar ID="Calendar2" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                        ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                                    </Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput ID="DateInput2" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtToDate"
                                    CssClass="rfvPCG" ErrorMessage="<br />Please select a To Date" Display="Dynamic"
                                    runat="server" InitialValue="" ValidationGroup="btnGo"> </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="To Date should not be less than From Date"
                                    Type="Date" ControlToValidate="txtToDate" ControlToCompare="txtFromDate" Operator="GreaterThanEqual"
                                    CssClass="cvPCG" Display="Dynamic" ValidationGroup="btnGo"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr id="trPeriod" visible="false" runat="server">
                            <td align="right" valign="top">
                                <asp:Label ID="lblPeriod" runat="server" CssClass="FieldName">Period:</asp:Label>
                            </td>
                            <td valign="top">
                                <asp:DropDownList ID="ddlPeriod" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span4" class="spnRequiredField"></span>
                                <br />
                                <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlPeriod"
                                    CssClass="rfvPCG" ErrorMessage="Please select a Period" Operator="NotEqual" ValueToCompare="Select a Period"
                                    ValidationGroup="btnGo"> </asp:CompareValidator>
                            </td>
                            <td>
                            &nbsp;&nbsp;
                            </td>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr id="trGroupHead" runat="server">
                            <td align="right" valign="top">
                                <asp:Label ID="lblGroupHead" runat="server" CssClass="FieldName" Text="Group Head :"></asp:Label>
                            </td>
                            <td valign="top">
                                <asp:TextBox ID="txtParentCustomer" runat="server" CssClass="txtField" AutoPostBack="true"
                                    AutoComplete="Off"></asp:TextBox>
                                <cc1:TextBoxWatermarkExtender ID="txtParentCustomer_TextBoxWatermarkExtender" runat="server"
                                    TargetControlID="txtParentCustomer" WatermarkText="Type the Customer Name">
                                </cc1:TextBoxWatermarkExtender>
                                <cc1:AutoCompleteExtender ID="txtParentCustomer_autoCompleteExtender" runat="server"
                                    TargetControlID="txtParentCustomer" ServiceMethod="GetParentCustomerName" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                                    MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="5" CompletionInterval="100"
                                    CompletionListCssClass="AutoCompleteExtender_CompletionList" CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem"
                                    CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                                    UseContextKey="true" OnClientItemSelected="GetParentCustomerId" />
                            </td>
                            <td>
                            &nbsp;&nbsp;
                            </td>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" align="right">
                                <asp:Label ID="Label1" runat="server" CssClass="FieldName" Text="Portfolio :"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlPortfolioGroup" runat="server" CssClass="cmbField">
                                    <asp:ListItem Text="Managed" Value="1">Managed</asp:ListItem>
                                    <asp:ListItem Text="UnManaged" Value="0">UnManaged</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                            &nbsp;&nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnGo" runat="server" OnClick="btnGo_Click" Text="Go" CssClass="PCGButton"
                                    ValidationGroup="btnGo" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_RMMultipleTransactionView_btnGo', 'S');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_RMMultipleTransactionView_btnGo', 'S');" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <table>
            </table>
            <tr>
                <td>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                        <ProgressTemplate>
                            <table width="100%">
                                <tr>
                                    <td align="center">
                                        <asp:Image ID="imgProgress" ImageUrl="~/Images/ajax-loader.gif" AlternateText="Processing"
                                            runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <%--<img alt="Processing" src="~/Images/ajax_loader.gif" style="width: 200px; height: 100px" />--%>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="tbl" runat="server">
                        <asp:Panel ID="Panel2" runat="server" class="Landscape" Width="100%" ScrollBars="Horizontal">
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <div id="dvTransactionsView" runat="server" style="margin: 2px;width: 640px;">
                <telerik:RadGrid ID="gvMFTransactions" runat="server" GridLines="None" AutoGenerateColumns="False" AllowFiltering="true" AllowFilteringByColumn="true"
                    PageSize="10" AllowSorting="true" AllowPaging="True" ShowStatusBar="True" OnItemCommand="gvMFTransactions_OnItemCommand"
                    OnNeedDataSource="gvMFTransactions_OnNeedDataSource" ShowFooter="true" Skin="Telerik" EnableEmbeddedSkins="false" Width="120%"
                    AllowAutomaticInserts="false" ExportSettings-ExportOnlyData="true" > 
                    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true"
                    FileName="View Transactions" Excel-Format="ExcelML">
                    </ExportSettings>
                    <MasterTableView DataKeyNames="TransactionId" 
                        Width="100%" AllowMultiColumnSorting="True" AutoGenerateColumns="false" CommandItemDisplay="None">
                        <Columns>
                          <telerik:GridTemplateColumn HeaderText="View Details" AllowFiltering="false" FooterText="Grand Total:" HeaderStyle-Wrap="false">
                            <ItemStyle Wrap="false" />
                            <ItemTemplate >
                                <asp:LinkButton ID="lnkView" runat="server" CssClass="cmbField" Text="View Details"
                                    OnClick="lnkView_Click">
                                </asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="Customer Name" HeaderText="Customer Name" AllowFiltering="true" HeaderStyle-Wrap="false"
                                SortExpression="Customer Name" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="Customer Name" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                                         
                        <telerik:GridBoundColumn DataField="ADUL_ProcessId" HeaderText="ProcessId" AllowFiltering="true" HeaderStyle-Wrap="false"
                                SortExpression="ADUL_ProcessId" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="ADUL_ProcessId" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                      
                        <telerik:GridBoundColumn DataField="TransactionId" HeaderText="TransactionId" AllowFiltering="false" Visible="false"
                                SortExpression="TransactionId" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="TransactionId" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn DataField="CMFT_SubBrokerCode" HeaderText="SubBrokerCode" AllowFiltering="false" Visible="false"
                                SortExpression="CMFT_SubBrokerCode" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="CMFT_SubBrokerCode" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn DataField="Folio Number" HeaderText="Folio No" AllowFiltering="true"
                                SortExpression="Folio Number" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="Folio Number" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn DataField="Category" HeaderText="Category" AllowFiltering="true" HeaderStyle-Wrap="false"
                                SortExpression="Category" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="Category" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn DataField="AMC" HeaderText="AMC" AllowFiltering="true" HeaderStyle-Wrap="false"
                                SortExpression="AMC" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="AMC" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridTemplateColumn   AllowFiltering="true" HeaderText="Scheme" ShowFilterIcon="false">
                        <ItemStyle Wrap="false" />
                           <ItemTemplate>
                           <asp:LinkButton ID="lnkprAmc" runat="server" CommandName="Scheme" Text='<%# Eval("Scheme Name").ToString() %>' />
                           </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridBoundColumn DataField="PAISC_AssetInstrumentSubCategoryName" HeaderText="Sub Category Name" AllowFiltering="false" HeaderStyle-Wrap="false"
                                SortExpression="PAISC_AssetInstrumentSubCategoryName" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="PAISC_AssetInstrumentSubCategoryName" FooterStyle-HorizontalAlign="Left">
                         <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn DataField="Transaction Type" HeaderText="Type" AllowFiltering="true" HeaderStyle-Wrap="false"
                                SortExpression="Transaction Type" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="Transaction Type" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn DataField="Transaction Date" HeaderText="Date" AllowFiltering="true" HeaderStyle-Wrap="false"
                                SortExpression="Transaction Date" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="Transaction Date" FooterStyle-HorizontalAlign="Center">
                                <ItemStyle Width="" HorizontalAlign="Center" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn DataField="Price" HeaderText="Price (Rs)" AllowFiltering="false"
                                SortExpression="Price" ShowFilterIcon="false" CurrentFilterFunction="Contains" HeaderStyle-Wrap="false"
                                AutoPostBackOnFilter="true" UniqueName="Price" FooterStyle-HorizontalAlign="Right"
                                DataFormatString="{0:n}" Aggregate="Sum">
                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn DataField="Units" HeaderText="Units" AllowFiltering="false" HeaderStyle-Wrap="false"
                                SortExpression="Units" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="Units" FooterStyle-HorizontalAlign="Right"
                                DataFormatString="{0:n}" Aggregate="Sum">
                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn DataField="Amount" HeaderText="Amount (Rs)" AllowFiltering="false" HeaderStyle-Wrap="false"
                                SortExpression="Amount" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="Amount" FooterStyle-HorizontalAlign="Right" DataFormatString="{0:n}" Aggregate="Sum">
                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn DataField="STT" HeaderText="STT (Rs)" AllowFiltering="false" HeaderStyle-Wrap="false"
                                SortExpression="STT" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="STT" FooterStyle-HorizontalAlign="Right" DataFormatString="{0:n}" Aggregate="Sum">
                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Transaction Status" HeaderText="Transaction Status" AllowFiltering="true" HeaderStyle-Wrap="false"
                                SortExpression="Transaction Status" ShowFilterIcon="false" CurrentFilterFunction="Contains" 
                                AutoPostBackOnFilter="true" UniqueName="Transaction Status" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    </ClientSettings>
                </telerik:RadGrid></div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="ErrorMessage" align="center" runat="server">
                        <tr>
                            <td>
                                <div class="failure-msg" align="center">
                                    No Records found.....
                                </div>
                            </td>
                        </tr>
                    </table>
                    
                   <asp:HiddenField ID="hdnRecordCount" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnCurrentPage" runat="server" />
                    <asp:HiddenField ID="hdnCustomerNameSearch" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnSchemeSearch" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnTranType" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnCategory" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnAMC" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnFolioNumber" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnDownloadPageType" runat="server" Visible="true" />
                    <asp:HiddenField ID="hdnDownloadFormat" runat="server" Visible="true" />
                    <asp:HiddenField ID="txtParentCustomerId" runat="server" />
                    <asp:HiddenField ID="txtParentCustomerType" runat="server" />
                    <asp:HiddenField ID="hdnStatus" runat="server" />
                    <asp:HiddenField ID="hdnProcessIdSearch" runat="server" />
                </td>
            </tr>
        </table>
    </ContentTemplate>
   <Triggers>
        <asp:PostBackTrigger ControlID="btnTrnxExport" />
    </Triggers>
</asp:UpdatePanel>
<html>
<body class="Landscape">
</body>
</html>
