﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OnlineAdviserSIPSummaryBooks.ascx.cs"
    Inherits="WealthERP.OnlineOrderBackOffice.OnlineAdviserSIPSummaryBooks" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register Src="~/General/Pager.ascx" TagPrefix="Pager" TagName="Pager" %>
<asp:ScriptManager ID="scriptmanager" runat="server">
</asp:ScriptManager>
<table width="100%">
    <tr>
        <td>
            <div class="divPageHeading">
                <table cellspacing="0" cellpadding="3" width="100%">
                    <tr>
                        <td align="left">
                            Systematic Book
                        </td>
                        <td align="right" style="width: 10px">
                            <asp:ImageButton Visible="false" ID="btnExport" ImageUrl="~/App_Themes/Maroon/Images/Export_Excel.png"
                                runat="server" AlternateText="Excel" ToolTip="Export To Excel" OnClick="btnExportFilteredData_OnClick"
                                OnClientClick="setFormat('excel')" Height="20px" Width="25px"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<div id="divConditional" runat="server" style="padding-top: 4px">
    <table class="TableBackground" cellpadding="2">
        <tr>
            <td align="right">
                <asp:Label ID="lblSystematicType" runat="server" Text="Systematic Type:" CssClass="FieldName"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlSystematicType" runat="server" CssClass="cmbField">
                    <asp:ListItem Text="Select"></asp:ListItem>
                    <asp:ListItem Text="SIP" Value="SIP"></asp:ListItem>
                    <asp:ListItem Text="SWP" Value="SWP"></asp:ListItem>
                </asp:DropDownList>
                <span id="Span3" class="spnRequiredField">*</span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="ddlSystematicType"
                    ErrorMessage="<br />Select systematic type" CssClass="cvPCG" Display="Dynamic"
                    runat="server" InitialValue="Select" ValidationGroup="btnViewSIP">
                </asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:Label runat="server" class="FieldName" Text="Mode:" ID="lblMode"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlMode" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlMode_OnSelectedIndexChanged"
                    AutoPostBack="true">
                    <asp:ListItem Value="1" Text="Online"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Demat"></asp:ListItem>
                    <asp:ListItem Value="0" Text="Offline" Enabled="false"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="ddlMode"
                    ErrorMessage="<br />Select Mode" CssClass="cvPCG" Display="Dynamic" runat="server"
                    InitialValue="Select" ValidationGroup="btnViewSIP">
                </asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:Label runat="server" class="FieldName" Text="SIP Type:" ID="Label4"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlSIP" runat="server" CssClass="cmbField" AutoPostBack="true">
                    <asp:ListItem Value="BSSIP" Text="BSE Normal SIP "></asp:ListItem>
                    <asp:ListItem Value="BXSIP" Text="X-SIP"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="ddlSIP"
                    ErrorMessage="<br />Select SIP Type" CssClass="cvPCG" Display="Dynamic" runat="server"
                    InitialValue="Select" ValidationGroup="btnViewSIP">
                </asp:RequiredFieldValidator>
            </td>
            <td id="tdlblRejectReason" runat="server">
                <asp:Label runat="server" class="FieldName" Text="AMC:" ID="lblAccount"></asp:Label>
            </td>
            <td>
                <asp:DropDownList CssClass="cmbField" ID="ddlAMCCode" Width="100%" runat="server"
                    AutoPostBack="false">
                    <%--<asp:ListItem Text="All" Value="0"></asp:ListItem>--%>
                </asp:DropDownList>
            </td>
            <td id="tdSearchtype" runat="server" class="rightField">
                <asp:Label runat="server" class="FieldName" Text="Search Type:" ID="Label2"></asp:Label>
                <asp:DropDownList CssClass="cmbField" ID="ddlSearchtype" runat="server" OnSelectedIndexChanged="ddlSearchtype_SelectedIndexChanged"
                    AutoPostBack="true">
                    <asp:ListItem Text="Next Systematic Date" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Start Date" Value="2"></asp:ListItem>
                    <asp:ListItem Text="End Date" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Request Date" Value="4"></asp:ListItem>
                    <asp:ListItem Text="Status" Value="5"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td id="tdStatusType" runat="server" class="leftField">
                <asp:Label runat="server" class="FieldName" Text="Status Type:" ID="Label3"></asp:Label>
                <asp:DropDownList CssClass="cmbField" ID="ddlStatus" runat="server" AutoPostBack="false">
                    <asp:ListItem Text="Cancelled" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Active" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Matured" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <%--    </table>
</div>
<div id="div2" runat="server" style="padding-top: 4px">
    <table class="TableBackground" cellpadding="3">--%>
        <tr>
            <td id="tdlblFromDate" runat="server" align="right">
                <asp:Label class="FieldName" ID="lblFromTran" Text="From :" runat="server" />
            </td>
            <td id="tdTxtFromDate" runat="server" class="leftField">
                <telerik:RadDatePicker ID="txtFrom" CssClass="txtField" runat="server" Culture="English (United States)"
                    Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                    <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                        ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                    </Calendar>
                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    <DateInput ID="DateInput1" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                    </DateInput>
                </telerik:RadDatePicker>
                <div id="dvTransactionDate" runat="server" class="dvInLine">
                    <span id="Span1" class="spnRequiredField">*</span>
                    <asp:RequiredFieldValidator ID="rfvtxtTransactionDate" ControlToValidate="txtFrom"
                        ErrorMessage="<br />Please select a From Date" CssClass="cvPCG" Display="Dynamic"
                        runat="server" InitialValue="" ValidationGroup="btnViewSIP">
                    </asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator9" runat="server" ErrorMessage="<br />The date format should be dd/mm/yyyy"
                        Type="Date" ControlToValidate="txtFrom" CssClass="cvPCG" Operator="DataTypeCheck"
                        Display="Dynamic" ValidationGroup="btnViewSIP"></asp:CompareValidator>
                </div>
            </td>
            <td id="tdlblToDate" runat="server" align="right">
                <asp:Label ID="lblToTran" Text="To :" CssClass="FieldName" runat="server" />
            </td>
            <td id="tdTxtToDate" runat="server">
                <telerik:RadDatePicker ID="txtTo" CssClass="txtField" runat="server" Culture="English (United States)"
                    Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                    <Calendar def ID="Calendar2" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                        ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                    </Calendar>
                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    <DateInput ID="DateInput2" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                    </DateInput>
                </telerik:RadDatePicker>
                <div id="Div1" runat="server" class="dvInLine">
                    <span id="Span2" class="spnRequiredField">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtTo"
                        ErrorMessage="<br />Please select a To Date" CssClass="cvPCG" Display="Dynamic"
                        runat="server" InitialValue="" ValidationGroup="btnViewSIP">
                    </asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="<br />The date format should be dd/mm/yyyy"
                        Type="Date" ControlToValidate="txtTo" CssClass="cvPCG" Operator="DataTypeCheck"
                        Display="Dynamic" ValidationGroup="btnViewSIP"></asp:CompareValidator>
                </div>
                <asp:CompareValidator ID="CompareValidator14" runat="server" ControlToValidate="txtTo"
                    ErrorMessage="<br/> To Date should be greater than From Date" Type="Date" Operator="GreaterThanEqual"
                    ControlToCompare="txtFrom" CssClass="cvPCG" ValidationGroup="btnViewSIP" Display="Dynamic">
                </asp:CompareValidator>
                <%--</td>
            <td id="tdBtnOrder" runat="server">--%>
                &nbsp
            </td>
            <td>
                <asp:Button ID="btnViewSIP" runat="server" CssClass="PCGButton" Text="Go" ValidationGroup="btnViewSIP"
                    OnClick="btnViewOrder_Click" />
            </td>
        </tr>
    </table>
</div>
<table style="width: 100%" class="TableBackground">
    <tr id="trNoRecords" runat="server" visible="false">
        <td align="center">
            <div id="divNoRecords" runat="server" class="failure-msg" visible="true">
                No Record Found
            </div>
        </td>
    </tr>
</table>
<asp:Panel ID="pnlSIPSumBook" runat="server" class="Landscape" Width="100%" ScrollBars="Horizontal"
    Visible="false">
    <table width="100%">
        <tr id="trExportFilteredDupData" runat="server">
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="gvSIPSummaryBookMIS" runat="server" GridLines="None" AutoGenerateColumns="False"
                    PageSize="10" AllowSorting="true" AllowPaging="True" ShowStatusBar="True" ShowFooter="true"
                    Skin="Telerik" EnableEmbeddedSkins="false" AllowFilteringByColumn="true" Width="102%"
                    AllowAutomaticInserts="false" OnNeedDataSource="gvSIPSummaryBookMIS_OnNeedDataSource"
                    OnItemDataBound="gvSIPSummaryBookMIS_OnItemDataBound" OnUpdateCommand="gvSIPSummaryBookMIS_UpdateCommand"
                    OnItemCommand="gvSIPSummaryBookMIS_OnItemCommand">
                    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" FileName="OrderMIS">
                    </ExportSettings>
                    <MasterTableView DataKeyNames="CMFSS_SystematicSetupId,CMFSS_IsCanceled,AcceptCount,InProcessCount,RejectedCount,CMFA_AccountId,PASP_SchemePlanCode,CMFSS_IsSourceAA,C_CustomerId,CMFSS_TotalInstallment,CMFSS_CurrentInstallmentNumber,CMFSS_EndDate,WOS_OrderStepCode"
                        Width="102%" AllowMultiColumnSorting="True" AutoGenerateColumns="false" CommandItemDisplay="None"
                        EditMode="PopUp">
                        <CommandItemSettings ShowExportToWordButton="false" ShowExportToExcelButton="false"
                            ShowExportToCsvButton="false" ShowAddNewRecordButton="false" ShowRefreshButton="false" />
                        <Columns>
                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="30px" UniqueName="chkBoxColumn"
                                Visible="false">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkItem" runat="server" CssClass="chkItem"></asp:CheckBox>
                                </ItemTemplate>
                                <ItemStyle Width="20px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_RegistrationDate" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}"
                                AllowFiltering="true" HeaderText="Request Date/Time" UniqueName="CMFSS_RegistrationDate"
                                SortExpression="CMFSS_RegistrationDate" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn AllowFiltering="true" DataField="CMFSS_SystematicSetupId"
                                AutoPostBackOnFilter="true" HeaderText="Request No." ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                SortExpression="CMFSS_SystematicSetupId" FooterStyle-HorizontalAlign="Right"
                                HeaderStyle-Width="90px">
                                <ItemStyle Wrap="false" Width="" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkprAmcB" runat="server" CommandName="Select" Text='<%# Eval("CMFSS_SystematicSetupId").ToString() %>'>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="BMFSRD_BSESIPREGID" AllowFiltering="true" HeaderText="BSE Exchange No"
                                UniqueName="BMFSRD_BSESIPREGID" SortExpression="BMFSRD_BSESIPREGID" ShowFilterIcon="false"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="75px"
                                FilterControlWidth="50px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="U_UMId" AllowFiltering="true" HeaderText="User Id"
                                UniqueName="U_UMId" SortExpression="U_UMId" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="75px" FilterControlWidth="50px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="C_FirstName" HeaderText="Customer Name" AllowFiltering="true"
                                HeaderStyle-Wrap="false" SortExpression="C_FirstName" ShowFilterIcon="false"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="100px"
                                UniqueName="C_FirstName" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CustCode" HeaderText="Client Id" AllowFiltering="true"
                                HeaderStyle-Wrap="false" SortExpression="CustCode" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="100px" UniqueName="CustCode" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="C_PANNum" HeaderText="PAN No" AllowFiltering="true"
                                HeaderStyle-Wrap="false" SortExpression="C_PANNum" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="100px" UniqueName="C_PANNum" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="C_Mobile1" HeaderText="Mobile No" AllowFiltering="true"
                                HeaderStyle-Wrap="false" SortExpression="C_Mobile1" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="100px" UniqueName="C_Mobile1"
                                FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="C_Email" HeaderText="Email Id" AllowFiltering="true"
                                HeaderStyle-Wrap="false" SortExpression="C_Email" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="100px" UniqueName="C_Email" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PA_AMCName" HeaderText="Fund Name" AllowFiltering="true"
                                HeaderStyle-Wrap="false" SortExpression="PA_AMCName" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="100px" UniqueName="PA_AMCName"
                                FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFA_FolioNum" AllowFiltering="true" HeaderText="Folio"
                                UniqueName="CMFA_FolioNum" SortExpression="CMFA_FolioNum" ShowFilterIcon="false"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="80px"
                                FilterControlWidth="60px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PASP_SchemePlanName" HeaderText="SchemePlanName"
                                AllowFiltering="true" SortExpression="PASP_SchemePlanName" ShowFilterIcon="false"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="PASP_SchemePlanName"
                                FooterStyle-HorizontalAlign="Left" HeaderStyle-Width="250px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PAISC_AssetInstrumentSubCategoryName" HeaderText="Sub Category"
                                AllowFiltering="true" HeaderStyle-Wrap="false" SortExpression="PAISC_AssetInstrumentSubCategoryName"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                UniqueName="PAISC_AssetInstrumentSubCategoryName" FooterStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="100px">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <%--  <telerik:GridBoundColumn DataField="XF_Frequency" AllowFiltering="true"
                                HeaderText="Order Type" UniqueName="XF_Frequency" SortExpression="XF_Frequency"
                                ShowFilterIcon="false" HeaderStyle-Width="80px" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridBoundColumn Visible="false" DataField="CMFT_Price" AllowFiltering="false"
                                HeaderText="Actioned NAV" DataFormatString="{0:N0}" UniqueName="CMFT_Price" SortExpression="CMFT_Price"
                                ShowFilterIcon="false" HeaderStyle-Width="80px" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn Visible="false" DataField="CMFT_TransactionDate" DataFormatString="{0:dd/MM/yyyy}"
                                AllowFiltering="false" HeaderText="Date" UniqueName="CMFT_TransactionDate" SortExpression="CMFT_TransactionDate"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                HeaderStyle-Width="80px" FilterControlWidth="60px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_DividendOption" HeaderText="Dividend Type"
                                AllowFiltering="true" HeaderStyle-Wrap="false" SortExpression="CMFSS_DividendOption"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                UniqueName="CMFSS_DividendOption" FooterStyle-HorizontalAlign="Left" HeaderStyle-Width="100px">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn Visible="false" DataField="DivedendFrequency" HeaderText="Div-Reinvestment Freq."
                                AllowFiltering="true" HeaderStyle-Wrap="false" SortExpression="DivedendFrequency"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                UniqueName="DivedendFrequency" FooterStyle-HorizontalAlign="Left" HeaderStyle-Width="100px">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn Visible="false" DataField="WOS_OrderStep" HeaderText="Status"
                                AllowFiltering="false" HeaderStyle-Wrap="false" SortExpression="WOS_OrderStep"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                HeaderStyle-Width="100px" UniqueName="WOS_OrderStep" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn Visible="false" DataField="CMFT_TransactionNumber" HeaderText="Transaction No"
                                AllowFiltering="false" HeaderStyle-Wrap="false" SortExpression="CMFT_TransactionNumber"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                HeaderStyle-Width="100px" UniqueName="CMFT_TransactionNumber" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_Amount" AllowFiltering="false" HeaderText="Amount"
                                DataFormatString="{0:N2}" UniqueName="CMFSS_Amount" SortExpression="CMFSS_Amount"
                                ShowFilterIcon="false" HeaderStyle-Width="80px" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridNumericColumn DataField="Unit" AllowFiltering="false" HeaderText="Unit"
                                UniqueName="Unit" SortExpression="Unit" ShowFilterIcon="false" HeaderStyle-Width="80px"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" DataFormatString="{0:N0}">
                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridNumericColumn>
                            <telerik:GridBoundColumn Visible="false" DataField="CMFOD_Units" AllowFiltering="false"
                                HeaderText="Order Units" DataFormatString="{0:N0}" UniqueName="CMFOD_Units" SortExpression="CMFOD_Units"
                                ShowFilterIcon="false" HeaderStyle-Width="80px" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="XF_Frequency" HeaderText="SIP Frequency" AllowFiltering="false"
                                HeaderStyle-Wrap="false" SortExpression="XF_Frequency" ShowFilterIcon="false"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="100px"
                                UniqueName="XF_Frequency" FooterStyle-HorizontalAlign="Left">
                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_StartDate" DataFormatString="{0:dd/MM/yyyy}"
                                AllowFiltering="true" HeaderText="Start Date" UniqueName="CMFSS_StartDate" SortExpression="CMFSS_StartDate"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                HeaderStyle-Width="80px" FilterControlWidth="60px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_EndDate" DataFormatString="{0:dd/MM/yyyy}"
                                AllowFiltering="true" HeaderText="End Date" UniqueName="CMFSS_EndDate" SortExpression="CMFSS_EndDate"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                HeaderStyle-Width="80px" FilterControlWidth="60px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_NextSIPDueDate" DataFormatString="{0:dd/MM/yyyy}"
                                AllowFiltering="true" HeaderText="Next SIP Date" UniqueName="CMFSS_NextSIPDueDate"
                                SortExpression="CMFSS_NextSIPDueDate" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="80px" FilterControlWidth="60px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_TotalInstallment" AllowFiltering="false"
                                HeaderText="Total Installment" UniqueName="CMFSS_TotalInstallment" SortExpression="CMFSS_TotalInstallment"
                                ShowFilterIcon="false" HeaderStyle-Width="80px" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_CurrentInstallmentNumber" AllowFiltering="false"
                                HeaderText="Current Installment" UniqueName="CMFSS_CurrentInstallmentNumber"
                                SortExpression="CMFSS_TotalInstallment" ShowFilterIcon="false" HeaderStyle-Width="80px"
                                Visible="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <%-- <telerik:GridBoundColumn DataField="AcceptCount" AllowFiltering="false" HeaderText="Accepted"
                                UniqueName="AcceptCount" SortExpression="AcceptCount" ShowFilterIcon="false"
                                HeaderStyle-Width="80px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridTemplateColumn AllowFiltering="false" DataField="AcceptCount" AutoPostBackOnFilter="true"
                                HeaderText="Accepted" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                SortExpression="AcceptCount" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="90px">
                                <ItemStyle Wrap="false" Width="" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkpraccept" runat="server" CommandName="Accepted" Text='<%# Eval("AcceptCount").ToString() %>'>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="SIPDueCount" AllowFiltering="false" HeaderText="Pending"
                                UniqueName="SIPDueCount" SortExpression="SIPDueCount" ShowFilterIcon="false"
                                HeaderStyle-Width="80px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <%-- <telerik:GridBoundColumn DataField="InProcessCount" AllowFiltering="false" HeaderText="In Process"
                                UniqueName="InProcessCount" SortExpression="InProcessCount" ShowFilterIcon="false"
                                HeaderStyle-Width="80px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridTemplateColumn AllowFiltering="false" DataField="InProcessCount" AutoPostBackOnFilter="true"
                                HeaderText="In Process" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                SortExpression="InProcessCount" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="90px">
                                <ItemStyle Wrap="false" Width="" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkprInprcs" runat="server" CommandName="In Process" Text='<%# Eval("InProcessCount").ToString() %>'>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <%--   <telerik:GridBoundColumn DataField="RejectedCount" AllowFiltering="false" HeaderText="Rejected"
                                UniqueName="RejectedCount" SortExpression="RejectedCount" ShowFilterIcon="false"
                                HeaderStyle-Width="80px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridTemplateColumn AllowFiltering="false" DataField="RejectedCount" AutoPostBackOnFilter="true"
                                HeaderText="Rejected" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                SortExpression="RejectedCount" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="90px">
                                <ItemStyle Wrap="false" Width="" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkprreject" runat="server" CommandName="Rejected" Text='<%# Eval("RejectedCount").ToString() %>'>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn AllowFiltering="false" DataField="ExecutedCount" AutoPostBackOnFilter="true"
                                HeaderText="Executed" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                SortExpression="ExecutedCount" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="90px">
                                <ItemStyle Wrap="false" Width="" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkprexecuted" runat="server" CommandName="Executed" Text='<%# Eval("ExecutedCount").ToString() %>'>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="SystemRejectCount" AllowFiltering="false" HeaderText="System Rejected"
                                UniqueName="SystemRejectCount" SortExpression="SystemRejectCount" ShowFilterIcon="false"
                                HeaderStyle-Width="80px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_InstallmentOther" AllowFiltering="false"
                                HeaderText="Other" UniqueName="CMFSS_InstallmentOther" SortExpression="CMFSS_InstallmentOther"
                                ShowFilterIcon="false" HeaderStyle-Width="80px" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn Visible="false" DataField="XS_Status" AllowFiltering="false"
                                HeaderText="Order Status" HeaderStyle-Width="80px" UniqueName="XS_Status" SortExpression="XS_Status"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Channel" AllowFiltering="false" HeaderText="Channel"
                                HeaderStyle-Width="80px" UniqueName="Channel" SortExpression="Channel" ShowFilterIcon="false"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_CreatedOn" AllowFiltering="false" HeaderText="Created On"
                                UniqueName="CMFSS_CreatedOn" SortExpression="CMFSS_CreatedOn" ShowFilterIcon="false"
                                HeaderStyle-Width="80px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_CreatedBy" AllowFiltering="false" HeaderText="Created By"
                                UniqueName="CMFSS_CreatedBy" SortExpression="CMFSS_CreatedBy" ShowFilterIcon="false"
                                HeaderStyle-Width="80px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_ModifiedOn" AllowFiltering="false" HeaderText="Modified On"
                                UniqueName="CMFSS_ModifiedOn" SortExpression="CMFSS_ModifiedOn" ShowFilterIcon="false"
                                HeaderStyle-Width="80px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_ModifiedBy" AllowFiltering="false" HeaderText="Modified By"
                                UniqueName="CMFSS_ModifiedBy" SortExpression="CMFSS_ModifiedBy" ShowFilterIcon="false"
                                HeaderStyle-Width="80px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_CancelBy" AllowFiltering="false" HeaderText="Canceled By"
                                HeaderStyle-Width="80px" UniqueName="CMFSS_CancelBy" SortExpression="CMFSS_CancelBy"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_CancelDate" AllowFiltering="false" HeaderText="Canceled On"
                                HeaderStyle-Width="80px" UniqueName="CMFSS_CancelDate" SortExpression="CMFSS_CancelDate"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_IsCanceled" AllowFiltering="false" HeaderText="Status"
                                HeaderStyle-Width="80px" UniqueName="CMFSS_IsCanceled" SortExpression="CMFSS_IsCanceled"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFSS_Remark" AllowFiltering="false" HeaderText="Remark"
                                HeaderStyle-Width="80px" UniqueName="CMFSS_Remark" SortExpression="CMFSS_Remark"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridEditCommandColumn Visible="true" HeaderStyle-Width="60px" UniqueName="editColumn"
                                EditText="Cancel" CancelText="Cancel" UpdateText="OK">
                            </telerik:GridEditCommandColumn>
                            <%--  <telerik:GridTemplateColumn UniqueName="Action" ItemStyle-Width="60px" AllowFiltering="false" HeaderText="Action"
                                Visible="true">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkAction" runat="server" CommandName="Update" Text="Cancel" ConfirmText="Do you want to Cancel this SIP? Click OK to proceed"
                                        UniqueName="Action" >
                                        </asp:LinkButton>
                                  <%--  </telerik:GridButtonColumn>--%>
                            <%-- <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/Images/Buy-Button.png" />--%>
                        </Columns>
                        <EditFormSettings FormTableStyle-Height="60%" EditFormType="Template" FormMainTableStyle-Width="300px">
                            <FormTemplate>
                                <table style="background-color: White;" border="0">
                                    <tr>
                                        <td colspan="4">
                                            <div class="divSectionHeading" style="vertical-align: text-bottom">
                                                SIP Cancel Request
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="leftField">
                                            <asp:Label ID="Label1" runat="server" CssClass="FieldName" Text="Request No.:"></asp:Label>
                                        </td>
                                        <td class="rightField">
                                            <asp:TextBox ID="txtSystematicSetupId" runat="server" CssClass="txtField" Style="width: 250px;"
                                                Text='<%# Bind("CMFSS_SystematicSetupId") %>'></asp:TextBox>
                                        </td>
                                        <td colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="leftField">
                                            <asp:Label ID="Label20" runat="server" Text="Remark:" CssClass="FieldName"></asp:Label>
                                        </td>
                                        <td class="rightField">
                                            <asp:TextBox ID="txtRemark" runat="server" CssClass="txtField" Style="width: 250px;"></asp:TextBox>
                                        </td>
                                        <td colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <td colspan="2">
                                        &nbsp;
                                    </td>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <asp:Button ID="Button1" Text="OK" runat="server" CssClass="PCGButton" CommandName="Update"
                                                ValidationGroup="btnSubmit">
                                                <%-- OnClientClick='<%# (Container is GridEditFormInsertItem) ?  " javascript:return ShowPopup();": "" %>'--%>
                                            </asp:Button>
                                        </td>
                                        <td align="left">
                                            <asp:Button ID="Button2" Text="Cancel" runat="server" CausesValidation="False" CssClass="PCGButton"
                                                CommandName="Cancel"></asp:Button>
                                        </td>
                                    </tr>
                                </table>
                            </FormTemplate>
                        </EditFormSettings>
                    </MasterTableView>
                    <ClientSettings>
                        <Resizing AllowColumnResize="true" />
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    </ClientSettings>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnRegister" Text="Register In BSE" runat="server" CausesValidation="False"
                    CssClass="PCGButton" CommandName="Register" OnClick="btnRegister_OnClick"></asp:Button>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:HiddenField ID="hdnAmc" runat="server" />
<asp:HiddenField ID="hdnOrderStatus" runat="server" />
