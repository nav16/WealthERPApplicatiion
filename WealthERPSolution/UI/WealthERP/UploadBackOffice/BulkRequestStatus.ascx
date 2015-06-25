﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BulkRequestStatus.ascx.cs"
    Inherits="WealthERP.UploadBackOffice.BulkRequestStatus" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
<style type="text/css">
    .RadGrid_Telerik .rgGroupHeader
    {
        background: 0 -6489px repeat-x url('Grid/sprite.gif');
        line-height: 21px;
        color: #000;
        font-weight: BOLD;
    }
    div.RadGrid_Telerik .rgFooter td
    {
        background-image: url('ImageHandler.ashx?mode=get&suite=aspnet-ajax&control=Grid&skin=Telerik&file=rgCommandRow.gif&t=1437799218');
        color: #000;
    }
</style>
<table width="100%">
    <tr>
        <td colspan="3">
            <div class="divPageHeading">
                <table cellspacing="0" width="100%">
                    <tr>
                        <td align="left">
                            Associate Commission Consolidated Report
                        </td>
                        <td align="right" style="padding-bottom: 2px;">
                            <asp:ImageButton ID="btnExportFilteredDupData" ImageUrl="~/App_Themes/Maroon/Images/Export_Excel.png"
                                runat="server" AlternateText="Excel" ToolTip="Export To Excel" OnClick="btnExportFilteredDupData_OnClick"
                                OnClientClick="setFormat('CSV')" Height="25px" Width="25px" Visible="false">
                            </asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<table id="tblMenu" cellspacing="0" width="100%">
    <tr>
        <td align="right">
            <asp:Label ID="lblReportType" runat="server" Text="Select Type: " CssClass="FieldName"></asp:Label>
        </td>
        <td>
            <asp:RadioButton ID="rbAssocicatieAll" runat="server" Text="ALL" GroupName="AssociationSelection"
                CssClass="txtField" AutoPostBack="true" OnCheckedChanged="rbAssocicatieAll_AssociationSelection"
                Checked="true" />
            <asp:RadioButton ID="rdAssociateInd" runat="server" Text="Individual" GroupName="AssociationSelection"
                CssClass="txtField" AutoPostBack="true" OnCheckedChanged="rbAssocicatieAll_AssociationSelection" />
        </td>
        <td align="right" id="tdlblAgentCode" runat="server" visible="false">
            <asp:Label ID="lblAgentCode" runat="server" Text="AgentCode:" CssClass="FieldName"></asp:Label>
        </td>
        <td id="tdtxtAgentCode" runat="server" visible="false">
            <asp:TextBox ID="txtAgentCode" runat="server" CssClass="txtField"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtAgentCode"
                ErrorMessage="<br />Please Enter AgentCode" Display="Dynamic" runat="server"
                CssClass="rfvPCG" ValidationGroup="btnGo"></asp:RequiredFieldValidator>
        </td>
        <td align="right">
            <asp:Label ID="lblFrom" runat="server" Text="From Date: " CssClass="FieldName"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="txtField">
            </asp:TextBox>
            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromDate"
                Format="dd/MM/yyyy">
            </cc1:CalendarExtender>
            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtFromDate"
                WatermarkText="dd/mm/yyyy">
            </cc1:TextBoxWatermarkExtender>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtFromDate"
                CssClass="rfvPCG" ErrorMessage="<br />Please select a  Date" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="btnGo"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" CssClass="rfvPCG" ControlToValidate="txtFromDate"
                Display="Dynamic" ErrorMessage="Invalid Date" ValidationGroup="btnGo" Operator="DataTypeCheck"
                Type="Date">
            </asp:CompareValidator>
        </td>
        <td align="left" class="leftField">
            <asp:Label ID="lblTo" runat="server" Text="To Date: " CssClass="FieldName"></asp:Label>
        </td>
        <td colspan="2" class="rightField">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="txtField"></asp:TextBox>
            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToDate"
                Format="dd/MM/yyyy">
            </cc1:CalendarExtender>
            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server" TargetControlID="txtToDate"
                WatermarkText="dd/mm/yyyy">
            </cc1:TextBoxWatermarkExtender>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtToDate"
                CssClass="rfvPCG" ErrorMessage="<br />Please select a Date" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="btnGo"></asp:RequiredFieldValidator>
            <%--<asp:RegularExpressionValidator ID="rev1" runat="server" CssClass="rfvPCG" ValidationExpression="[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]"
            ControlToValidate="txtTo" Display="Dynamic" ErrorMessage="Invalid Date" ValidationGroup="MFSubmit">
            </asp:RegularExpressionValidator>--%>
            <asp:CompareValidator ID="CompareValidator2" runat="server" CssClass="rfvPCG" ControlToValidate="txtToDate"
                Display="Dynamic" ErrorMessage="Invalid Date" ValidationGroup="btnGo" Operator="DataTypeCheck"
                Type="Date">
            </asp:CompareValidator>
            <asp:CompareValidator ID="cvtodate" runat="server" ErrorMessage="<br/>To Date should not less than From Date"
                Type="Date" ControlToValidate="txtToDate" ControlToCompare="txtFromDate" Operator="GreaterThanEqual"
                CssClass="cvPCG" Display="Dynamic" ValidationGroup="btnGo"></asp:CompareValidator>
        </td>
        <td align="left">
            <asp:Button ID="btnSubmit" runat="server" Text="GO" CssClass="PCGButton" ValidationGroup="btnGo"
                OnClick="btnSubmit_OnClick" />
        </td>
    </tr>
</table>
<asp:Panel ID="pnlOrderList" runat="server" class="Landscape" Width="100%" Height="80%"
    ScrollBars="Horizontal" Visible="false">
    <table width="100%">
        <tr id="trExportFilteredDupData" runat="server">
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="rdAssociatePayout" runat="server" GridLines="None" AutoGenerateColumns="False"
                    PageSize="10" AllowSorting="true" AllowPaging="True" ShowStatusBar="True" ShowFooter="true"
                    Skin="Telerik" EnableEmbeddedSkins="false" AllowAutomaticInserts="false" OnNeedDataSource="rdAssociatePayout_OnNeedDataSource"
                    AllowFilteringByColumn="true" >
                    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" FileName="AssociatePayOutReport">
                    </ExportSettings>
                    <MasterTableView ShowGroupFooter="true" Width="150%" DataKeyNames="AgentCode,AAC_AdviserAgentId,PAG_AssetGroupCode,AIM_IssueId,PAISC_AssetInstrumentSubCategoryCode ">
                        <GroupByExpressions>
                            <telerik:GridGroupByExpression>
                                <SelectFields>
                                    <telerik:GridGroupByField FieldAlias="AgentCode" FieldName="AgentCode" />
                                </SelectFields>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldName="AgentCode" SortOrder="Ascending" />
                                </GroupByFields>
                            </telerik:GridGroupByExpression>
                        </GroupByExpressions>
                        <Columns>
                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="10%">
                                <HeaderTemplate>
                                    <asp:LinkButton ID="AllDetailslink" runat="server" CommandName="ExpandAllCollapse"
                                        Font-Underline="False" Font-Bold="true" UniqueName="AllDetailslink" Font-Size="Medium"
                                        OnClick="btnExpand_Click">+</asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbDetails" runat="server" CommandName="ExpandCollapse" Font-Underline="False"
                                        Font-Bold="true" UniqueName="Detailslink" OnClick="btnExpandAll_Click" Font-Size="Medium">+</asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <%-- <telerik:GridTemplateColumn UniqueName="ReportHeader">
                     <HeaderTemplate>
                     <table id="Table1" cellspacing="1" cellpadding="1" width="100%" border="1">
                     <tr>
                     <td colspan="2">
                     <asp:Label ID="lblHeader" runat="server"   Text="Associcate Report"></asp:Label>
                     </td>
                     </tr>
                     
                     </table>
                     </HeaderTemplate>
                     </telerik:GridTemplateColumn>--%>
                            <telerik:GridBoundColumn DataField="AgentName" HeaderText="AgentName" UniqueName="AgentName"
                                SortExpression="AgentName" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="100px" AllowFiltering="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PAG_AssetGroupName" HeaderText="Product" UniqueName="PAG_AssetGroupName"
                                SortExpression="PAG_AssetGroupName" ShowFilterIcon="false" CurrentFilterFunction="EqualTo"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="85px" FilterControlWidth="85px"
                                AllowFiltering="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PAISC_AssetInstrumentSubCategoryName" HeaderText="Category "
                                UniqueName="PAISC_AssetInstrumentSubCategoryName" SortExpression="PAISC_AssetInstrumentSubCategoryName"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                HeaderStyle-Width="85px" FilterControlWidth="85px" AllowFiltering="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AIM_IssueName" HeaderText="Issue Name/Scheme Name"
                                UniqueName="AIM_IssueName" SortExpression="AIM_IssueName" ShowFilterIcon="false"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="15%"
                                FilterControlWidth="85px" AllowFiltering="true">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PayOut" HeaderText="Pay Out" UniqueName="PayOut"
                                SortExpression="PayOut" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="80px" FilterControlWidth="60px"
                                Aggregate="Sum" FooterText="Total:" AllowFiltering="false">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TDS" HeaderText="TDS" UniqueName="TDS" SortExpression="TDS"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                HeaderStyle-Width="130px" Aggregate="Sum" FooterText="Total:" DataFormatString="{0:F2}"
                                FooterAggregateFormatString="{0:F2}" AllowFiltering="false">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ServiceTax" HeaderText="Service Tax" UniqueName="ServiceTax"
                                SortExpression="ServiceTax" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="100px" Aggregate="Sum" FooterText="Total:"
                                DataFormatString="{0:F2}" FooterAggregateFormatString="{0:F2}" AllowFiltering="false">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NetPayOut" HeaderText="Net Pay Out" UniqueName="NetPayOut"
                                SortExpression="NetPayOut" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" HeaderStyle-Width="100px" Aggregate="Sum" FooterText="Total:"
                                AllowFiltering="false">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="WCD_Act_Pay_BrokerageDate" HeaderText="Pay Out Date"
                                UniqueName="WCD_Act_Pay_BrokerageDate" SortExpression="WCD_Act_Pay_BrokerageDate"
                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                HeaderStyle-Width="100px" AllowFiltering="false" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="WCD_CommissionType" HeaderText="Commission Type"
                                UniqueName="WCD_CommissionType" SortExpression="WCD_CommissionType" ShowFilterIcon="false"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="100px"
                                AllowFiltering="false">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn AllowFiltering="false">
                                <ItemTemplate>
                                    <tr>
                                        <td colspan="100%">
                                            <asp:Panel ID="pnlchild" runat="server" Style="display: inline" CssClass="Landscape"
                                                Width="100%" ScrollBars="Both" Visible="false">
                                                <%-- <div style="display: inline; position: relative; left: 25px;">--%>
                                                <telerik:RadGrid ID="rgNCDIPOMIS" runat="server" GridLines="None" AutoGenerateColumns="False"
                                                    PageSize="15" AllowSorting="true" AllowPaging="True" ShowStatusBar="True" ShowFooter="true"
                                                    Skin="Telerik" EnableViewState="true" EnableEmbeddedSkins="false" Width="100%"
                                                    AllowFilteringByColumn="true" AllowAutomaticInserts="false" ExportSettings-ExportOnlyData="true"
                                                    EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" >
                                                    <MasterTableView Width="120%" AllowMultiColumnSorting="True" AutoGenerateColumns="false"
                                                        CommandItemDisplay="None" GroupsDefaultExpanded="false" ExpandCollapseColumn-Groupable="true"
                                                        GroupLoadMode="Client" ShowGroupFooter="true">
                                                        <Columns>
                             
                                                            <telerik:GridBoundColumn HeaderStyle-Width="10%" HeaderText="ApplicationNo." DataField="CO_ApplicationNumber"
                                                                HeaderStyle-HorizontalAlign="Right" UniqueName="Application No" SortExpression="CO_ApplicationNumber"
                                                                AutoPostBackOnFilter="true" AllowFiltering="false" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                                FooterStyle-HorizontalAlign="Right">
                                                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                            </telerik:GridBoundColumn>
                                                           
                       
                                                            <telerik:GridBoundColumn HeaderStyle-Width="10%" HeaderText="Transaction Date." DataField="transactionDate"
                                                                HeaderStyle-HorizontalAlign="Right" UniqueName="transactionDate" SortExpression="transactionDate"
                                                                AutoPostBackOnFilter="true" AllowFiltering="false" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                                FooterStyle-HorizontalAlign="Right">
                                                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                            </telerik:GridBoundColumn>
                                                           <telerik:GridBoundColumn HeaderStyle-Width="10%" HeaderText="Ordered Qty\Accepted Quantity"
                                                                DataField="allotedQty" UniqueName="allotedQty" SortExpression="allotedQty" AutoPostBackOnFilter="true"
                                                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AllowFiltering="false">
                                                                <ItemStyle HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                            </telerik:GridBoundColumn>
                                                           
                                                            
                                                            <telerik:GridBoundColumn HeaderStyle-Width="10%" HeaderText="Mobilised Amount" DataField="ParentMobilize_Orders"
                                                                AllowFiltering="false" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                                FooterStyle-HorizontalAlign="Right">
                                                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderStyle-Width="10%" HeaderText="Mobilised No Of Application"
                                                                DataField="ParentMobilize_Amount" AllowFiltering="false" ShowFilterIcon="false"
                                                                CurrentFilterFunction="Contains" FooterStyle-HorizontalAlign="Right">
                                                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderStyle-Width="10%" HeaderText="Brokerage Rate" DataField="rate"
                                                                HeaderStyle-HorizontalAlign="Right" UniqueName="rate" SortExpression="rate" AutoPostBackOnFilter="true"
                                                                AllowFiltering="false" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                                FooterStyle-HorizontalAlign="Right" Visible="false">
                                                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderStyle-Width="10%" HeaderText=" Brokerage Rate unit"
                                                                DataField="WCU_UnitCode" HeaderStyle-HorizontalAlign="Right" UniqueName="WCU_UnitCode"
                                                                SortExpression="WCU_UnitCode" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                                ShowFilterIcon="false" CurrentFilterFunction="Contains" FooterStyle-HorizontalAlign="Right">
                                                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderStyle-Width="10%" HeaderText="Service Tax(%)" DataField="ACSR_ServiceTaxValue"
                                                                HeaderStyle-HorizontalAlign="Right" UniqueName="ACSR_ServiceTaxValue" SortExpression="ACSR_ServiceTaxValue"
                                                                AutoPostBackOnFilter="true" AllowFiltering="false" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                                FooterStyle-HorizontalAlign="Right">
                                                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderStyle-Width="10%" HeaderText="TDS(%)" DataField="ACSR_ReducedValue"
                                                                HeaderStyle-HorizontalAlign="Right" UniqueName="ACSR_ReducedValue" SortExpression="ACSR_ReducedValue"
                                                                AutoPostBackOnFilter="true" AllowFiltering="false" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                                FooterStyle-HorizontalAlign="Right">
                                                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderStyle-Width="10%" HeaderText="Expected Commission"
                                                                DataField="brokeragevalue" HeaderStyle-HorizontalAlign="Right" UniqueName="brokeragevalue"
                                                                SortExpression="brokeragevalue" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                                ShowFilterIcon="false" CurrentFilterFunction="Contains" FooterStyle-HorizontalAlign="Right"
                                                                Aggregate="Sum">
                                                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderStyle-Width="10%" HeaderText="Net Commission" DataField="borkageExpectedvalue"
                                                                HeaderStyle-HorizontalAlign="Right" UniqueName="borkageExpectedvalue" SortExpression="borkageExpectedvalue"
                                                                AutoPostBackOnFilter="true" AllowFiltering="false" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                                FooterStyle-HorizontalAlign="Right" Aggregate="Sum">
                                                                <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                                        <Resizing AllowColumnResize="true" />
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <FooterStyle ForeColor="Black" />
                    </MasterTableView>
                    <ClientSettings>
                        <Resizing AllowColumnResize="true" />
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    </ClientSettings>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Panel>
