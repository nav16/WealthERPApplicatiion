<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NCDIssueBooks.ascx.cs"
    Inherits="WealthERP.OnlineOrderManagement.NCDIssueBooks" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
<asp:ScriptManager ID="scrptMgr" runat="server">
    <Services>
        <asp:ServiceReference Path="AutoComplete.asmx" />
    </Services>
</asp:ScriptManager>
<style type="text/css">
    .table
    {
        border: 1px solid orange;
    }
    .leftLabel
    {
        width: 15%;
        text-align: right;
    }
    .rightData
    {
        width: 18%;
        text-align: left;
    }
    .rightDataTwoColumn
    {
        width: 25%;
        text-align: left;
    }
    .rightDataFourColumn
    {
        width: 50%;
        text-align: left;
    }
    .rightDataThreeColumn
    {
        width: 41%;
        text-align: left;
    }
    .tdSectionHeading
    {
        padding-bottom: 6px;
        padding-top: 6px;
        width: 100%;
    }
    .divSectionHeading table td span
    {
        padding-bottom: 5px !important;
    }
    .fltlft
    {
        float: left;
        padding-left: 3px;
        width: 20%;
    }
    .divCollapseImage
    {
        float: left;
        padding-left: 5px;
        width: 2%;
        float: right;
        text-align: right;
        cursor: pointer;
        cursor: hand;
    }
    .imgCollapse
    {
        background: Url(../Images/Section-Expand.png);
        cursor: pointer;
        cursor: hand;
    }
    .imgExpand
    {
        background: Url(../Images/Section-Collapse.png) no-repeat left top;
        cursor: pointer;
        cursor: hand;
    }
    .fltlftStep
    {
        float: left;
    }
    .StepOneContentTable, .StepTwoContentTable, .StageRequestTable, .StepThreeContentTable, .StepFourContentTable
    {
        width: 100%;
    }
    .SectionBody
    {
        width: 100%;
    }
    .collapse
    {
        text-align: right;
    }
    .divStepStatus
    {
        float: left;
        padding-left: 2px;
        padding-right: 5px;
    }
</style>
<table width="100%">
    <tr>
        <td>
            <div class="divPageHeading">
                <table width="100%">
                    <tr>
                        <td align="left">
                            NCD Order Book
                        </td>
                        <td align="right">
                            <asp:ImageButton ID="ibtExportSummary" ImageUrl="~/App_Themes/Maroon/Images/Export_Excel.png"
                                runat="server" AlternateText="Excel" ToolTip="Export To Excel" OnClick="ibtExportSummary_OnClick"
                                Height="25px" Width="25px"></asp:ImageButton>
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
            <td id="td1" runat="server">
                <asp:Label runat="server" class="FieldName" Text="Order Status:" ID="Label1"></asp:Label>
                <asp:DropDownList CssClass="cmbField" ID="ddlOrderStatus" runat="server" AutoPostBack="false">
                </asp:DropDownList>
            </td>
            <td id="tdlblFromDate" runat="server" align="right">
                <asp:Label class="FieldName" ID="lblFromTran" Text="From :" runat="server" />
            </td>
            <td id="tdTxtFromDate" runat="server">
                <telerik:RadDatePicker ID="txtOrderFrom" CssClass="txtField" runat="server" Culture="English (United States)"
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
                    <asp:RequiredFieldValidator ID="rfvtxtTransactionDate" ControlToValidate="txtOrderFrom"
                        ErrorMessage="<br />Please select a From Date" CssClass="cvPCG" Display="Dynamic"
                        runat="server" InitialValue="">
                    </asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator9" runat="server" ErrorMessage="<br />The date format should be dd/mm/yyyy"
                        Type="Date" ControlToValidate="txtOrderFrom" CssClass="cvPCG" Operator="DataTypeCheck"
                        Display="Dynamic"></asp:CompareValidator>
                </div>
            </td>
            <td id="tdlblToDate" runat="server">
                <asp:Label ID="lblToTran" Text="To :" CssClass="FieldName" runat="server" />
            </td>
            <td id="tdTxtToDate" runat="server">
                <telerik:RadDatePicker ID="txtOrderTo" CssClass="txtField" runat="server" Culture="English (United States)"
                    Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                    <Calendar ID="Calendar2" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                        ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                    </Calendar>
                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    <DateInput ID="DateInput2" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                    </DateInput>
                </telerik:RadDatePicker>
                <div id="Div1" runat="server" class="dvInLine">
                    <span id="Span2" class="spnRequiredField">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtOrderTo"
                        ErrorMessage="<br />Please select a To Date" CssClass="cvPCG" Display="Dynamic"
                        runat="server" InitialValue="">
                    </asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="<br />The date format should be dd/mm/yyyy"
                        Type="Date" ControlToValidate="txtOrderTo" CssClass="cvPCG" Operator="DataTypeCheck"
                        Display="Dynamic"></asp:CompareValidator>
                </div>
                <asp:CompareValidator ID="CompareValidator14" runat="server" ControlToValidate="txtOrderTo"
                    ErrorMessage="<br/> To Date should be greater than From Date" Type="Date" Operator="GreaterThanEqual"
                    ControlToCompare="txtOrderFrom" CssClass="cvPCG" ValidationGroup="btnViewOrder"
                    Display="Dynamic">
                </asp:CompareValidator>
            </td>
            <td id="tdBtnOrder" runat="server">
                <asp:Button ID="btnViewOrder" runat="server" CssClass="PCGButton" Text="Go" ValidationGroup="btnViewOrder"
                    OnClick="btnViewOrder_Click" />
            </td>
        </tr>
    </table>
</div>
<asp:Panel ID="pnlGrid" runat="server" CssClass="Landscape" Width="99%" ScrollBars="Horizontal" Visible="false">
    <table id="tblCommissionStructureRule" runat="server">
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td>
                            <telerik:RadGrid ID="gvBBList" runat="server" AllowSorting="True" enableloadondemand="True"
                                PageSize="10" AllowPaging="True" AutoGenerateColumns="False" EnableEmbeddedSkins="False"
                                GridLines="None" ShowFooter="True" PagerStyle-AlwaysVisible="true" ShowStatusBar="True"
                                Skin="Telerik" AllowFilteringByColumn="false" OnNeedDataSource="gvBBList_OnNeedDataSource">
                                <%--OnNeedDataSource="gvBBList_OnNeedDataSource"--%>
                                <MasterTableView DataKeyNames="CO_OrderId,PFIIM_IssuerId" Width="100%" AllowMultiColumnSorting="True"
                                    AutoGenerateColumns="false">
                                    <Columns>
                                        <telerik:GridTemplateColumn>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbDetails" runat="server" CommandName="ExpandCollapse" Font-Underline="False"
                                                    Font-Bold="true" UniqueName="Detailslink" OnClick="btnExpandAll_Click" Font-Size="Medium">+</asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="PFIIM_IssuerId" HeaderStyle-Width="60px" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Scrip ID" UniqueName="OnlIssuerId"
                                            SortExpression="IssuerId">
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width=" " Wrap="true" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CO_OrderDate" DataFormatString="{0:dd/MM/yyyy hh:mm:ss}"
                                            AllowFiltering="true" HeaderText="Transaction Date" UniqueName="CO_OrderDate"
                                            SortExpression="CO_OrderDate" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                            AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CO_OrderId" AllowFiltering="true" HeaderText="Transaction No."
                                            UniqueName="CO_OrderId" SortExpression="CO_OrderId" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                            AutoPostBackOnFilter="true" HeaderStyle-Width="80px" FilterControlWidth="75px">
                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AIM_MaxApplNo" AllowFiltering="true" HeaderText="Application No."
                                            UniqueName="AIM_MaxApplNo" SortExpression="AIM_MaxApplNo" ShowFilterIcon="false"
                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="80px"
                                            FilterControlWidth="60px">
                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Scrip" SortExpression="Scrip" AutoPostBackOnFilter="true"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                            HeaderStyle-Width="160px" HeaderText="Scrip Name" UniqueName="Scrip">
                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                        </telerik:GridBoundColumn>
                                        <%-- <telerik:GridBoundColumn DataField="Scrip" SortExpression="Scrip" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderStyle-Width="160px" HeaderText="Scrip Name" UniqueName="Scrip">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn DataField="BBStartDate" SortExpression="BBStartDate" AutoPostBackOnFilter="true"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                            DataFormatString="{0:dd/MM/yyyy hh:mm:ss}" HeaderText="Start Date" UniqueName="BBStartDate"
                                            HeaderStyle-Width="77px">
                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="BBEndDate" SortExpression="BBEndDate" AutoPostBackOnFilter="true"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                            HeaderText="End Date" UniqueName="BBEndDate" HeaderStyle-Width="77px" DataFormatString="{0:dd/MM/yyyy hh:mm:ss}">
                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="BBAmounttoinvest" AllowFiltering="false" HeaderText="Amount to invest"
                                            UniqueName="BBAmounttoinvest" HeaderStyle-Width="77px">
                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="WOS_OrderStep" AllowFiltering="false" HeaderText="Status"
                                            HeaderStyle-Width="70px" UniqueName="WOS_OrderStep" SortExpression="WOS_OrderStep"
                                            ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="100px" UniqueName="Action"
                                            HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlaction" OnSelectedIndexChanged="ddlAction_SelectedIndexChanged"
                                                    CssClass="cmbField" runat="server" EnableEmbeddedSkins="false" Skin="Telerik"
                                                    AllowCustomText="true" Width="100px" AutoPostBack="true">
                                                    <asp:ListItem Text="select" Value="select" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="View" Value="Edit"></asp:ListItem>
                                                    <asp:ListItem Text="Modify" Value="Modify" Enabled="false"></asp:ListItem>
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn>
                                            <ItemTemplate>
                                                <tr>
                                                    <td colspan="100%">
                                                        <asp:Panel ID="pnlchild" runat="server" Style="display: inline" CssClass="Landscape"
                                                            Width="100%" ScrollBars="Horizontal" Visible="false">
                                                            <%-- <div style="display: inline; position: relative; left: 25px;">--%>
                                                            <telerik:RadGrid ID="gvChildDetails" runat="server" AutoGenerateColumns="False" enableloadondemand="True"
                                                                PageSize="10" AllowPaging="True" EnableEmbeddedSkins="False" GridLines="None"
                                                                ShowFooter="True" PagerStyle-AlwaysVisible="true" ShowStatusBar="True" Skin="Telerik"
                                                                AllowFilteringByColumn="false" OnNeedDataSource="gvChildDetails_OnNeedDataSource">
                                                                <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" DataKeyNames="PFIIM_IssuerId,CO_OrderId,PFISD_SeriesId"
                                                                    AutoGenerateColumns="false" Width="100%">
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="PFISD_SeriesId" HeaderStyle-Width="60px" CurrentFilterFunction="Contains"
                                                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Series" UniqueName="PFISD_SeriesId"
                                                                            SortExpression="PFISD_SeriesId">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBTenure" SortExpression="BBTenure" AutoPostBackOnFilter="true"
                                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                                            HeaderText="Tenure (months)" UniqueName="BBTenure" HeaderStyle-Width="77px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBCouponrate" SortExpression="BBCouponrate" AutoPostBackOnFilter="true"
                                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                                            HeaderText="Coupon rate(%)" UniqueName="BBCouponrate" HeaderStyle-Width="55px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="true" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBInterestPaymentFreq" AllowFiltering="false"
                                                                            HeaderText="Interest Payment Freq" UniqueName="BBInterestPaymentFreq" HeaderStyle-Width="65px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBRenewedcouponrate" AllowFiltering="false" HeaderText="Renewed coupon rate(%)"
                                                                            UniqueName="BBRenewedcouponrate" HeaderStyle-Width="81px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBFacevalue" AllowFiltering="false" HeaderText="Face value"
                                                                            UniqueName="BBFacevalue" HeaderStyle-Width="77px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBYieldatCall" AllowFiltering="false" HeaderText="Yield at Call(%)"
                                                                            UniqueName="BBYieldatCall" HeaderStyle-Width="77px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBYieldatMaturity" AllowFiltering="false" HeaderText="Yield at Maturity(%)"
                                                                            UniqueName="BBYieldatMaturity" HeaderStyle-Width="77px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBYieldatbuyback" AllowFiltering="false" HeaderText="Yield at buyback(%)"
                                                                            UniqueName="BBYieldatbuyback" HeaderStyle-Width="77px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBLockinPeriod" AllowFiltering="false" HeaderText="Lockin Period"
                                                                            UniqueName="BBLockinPeriod" HeaderStyle-Width="77px" DataFormatString="{0:N0}">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBCallOption" AllowFiltering="false" HeaderText="Call Option"
                                                                            UniqueName="BBCallOption" HeaderStyle-Width="77px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBBuybackfacility" AllowFiltering="false" HeaderText="Buyback facility"
                                                                            UniqueName="BBBuybackfacility" HeaderStyle-Width="77px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBQtytoinvest" AllowFiltering="false" HeaderText="Qty to invest"
                                                                            UniqueName="BBQtytoinvest" HeaderStyle-Width="77px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="BBAmounttoinvest" AllowFiltering="false" HeaderText="Amount to invest"
                                                                            UniqueName="BBAmounttoinvest" HeaderStyle-Width="77px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="Channel" AllowFiltering="true" HeaderText="Channel"
                                                                            UniqueName="Channel" SortExpression="Channel" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                                            AutoPostBackOnFilter="true" HeaderStyle-Width="80px" FilterControlWidth="60px">
                                                                            <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                </MasterTableView>
                                                            </telerik:RadGrid>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:HiddenField  ID="hdnOrderStatus" runat="server"/>