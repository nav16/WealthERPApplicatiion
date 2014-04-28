﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="IPOIssueList.ascx.cs"
    Inherits="WealthERP.OnlineOrderManagement.IPOIssueList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:ScriptManager ID="scrptMgr" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table class="tblMessage" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <div class="divOnlinePageHeading">
                        <div class="divClientAccountBalance">
                            <asp:Label ID="Label1" runat="server" Text="Available Limits:" CssClass="BalanceLabel" Visible="false"> </asp:Label>
                            <asp:Label ID="lblAvailableLimits" runat="server" Text="" CssClass="BalanceAmount" Visible="false"></asp:Label>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td>
                    <div class="divPageHeading">
                        <table cellspacing="0" cellpadding="3" width="100%">
                            <tr>
                                <td align="left">
                                    IPO Issue List
                                </td>
                                <td align="right">
                                   <%-- <asp:ImageButton ID="btnNcdIssueList" runat="server" ImageUrl="~/Images/Export_Excel.png"
                                        AlternateText="Excel" ToolTip="Export To Excel" Visible="true" OnClientClick="setFormat('excel')"
                                        Height="25px" Width="25px" OnClick="btnNcdIssueList_Click"></asp:ImageButton>--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <table width="60%" runat="server" id="tbNcdIssueList">
            <tr>
                <td class="leftLabel">
                    <asp:Label ID="lb1Type" runat="server" Text="Type:" CssClass="FieldName"></asp:Label>
                </td>
                <td class="rightData">
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="cmbField" AutoPostBack="true">
                        <asp:ListItem Value="Select">Select</asp:ListItem>
                        <asp:ListItem Value="Curent">Current Issues</asp:ListItem>
                        <asp:ListItem Value="Closed" Enabled="false">Closed Issues</asp:ListItem>
                        <asp:ListItem Value="Future">Future Issues</asp:ListItem>
                    </asp:DropDownList>
                    <span id="Span4" class="spnRequiredField">*</span>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select Type"
                        CssClass="rfvPCG" ControlToValidate="ddlType" ValidationGroup="btnGo" Display="Dynamic"
                        InitialValue="Select"></asp:RequiredFieldValidator>
                </td>
                <td class="rightData">
                    <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="PCGButton" ValidationGroup="btnGo"
                        OnClick="btnGo_Click" />
                </td>
            </tr>
        </table>
        <asp:Panel ID="pnlSchemeMIS" runat="server" ScrollBars="Horizontal" Width="100%">
        <div class="divControlContiner" id="divControlContainer" runat="server">
            <table width="100%">
                <tr>
                    <td>
                        <telerik:RadGrid ID="RadGridIPOIssueList" runat="server" AllowSorting="True" enableloadondemand="True"
                            PageSize="10" AllowPaging="True" AutoGenerateColumns="False" EnableEmbeddedSkins="False"
                            GridLines="None" ShowFooter="True" PagerStyle-AlwaysVisible="true" ShowStatusBar="True"
                            Skin="Telerik" AllowFilteringByColumn="false" OnItemCommand="RadGridIPOIssueList_OnItemCommand">
                            <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" DataKeyNames="AIM_IssueId"
                                AutoGenerateColumns="false" Width="100%">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="AIM_IssueName" HeaderStyle-Width="200px" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="true" AutoPostBackOnFilter="true" HeaderText="Issue Name" UniqueName="AIM_IssueName"
                                        SortExpression="AIM_IssueName">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_IssueSizeQty" HeaderStyle-Width="200px" HeaderText="Issue Size"
                                        ShowFilterIcon="false" UniqueName="AIM_IssueSizeQty" Visible="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_IssueSizeAmt" HeaderStyle-Width="200px" HeaderText="Issue Size Amount"
                                        ShowFilterIcon="false" UniqueName="AIM_IssueSizeAmt" Visible="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_Rating" HeaderStyle-Width="200px" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" HeaderText="Grading" UniqueName="AIM_Rating" SortExpression="AIM_Rating">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_IsBookBuilding" HeaderStyle-Width="200px"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Basis" UniqueName="AIM_Rating"
                                        SortExpression="AIM_IsBookBuilding">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_FaceValue" HeaderStyle-Width="200px" HeaderText="Face Value"
                                        ShowFilterIcon="false" UniqueName="AIM_FaceValue" Visible="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_MInQty" HeaderStyle-Width="200px" HeaderText="Minimum Quantity"
                                        ShowFilterIcon="false" UniqueName="AIM_MInQty" Visible="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_TradingInMultipleOf" HeaderStyle-Width="200px"
                                        HeaderText="Multiples of Qty" ShowFilterIcon="false" UniqueName="AIM_TradingInMultipleOf"
                                        Visible="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_MaxQty" HeaderStyle-Width="200px" HeaderText="Maximum Qty"
                                        ShowFilterIcon="false" UniqueName="AIM_MaxQty" Visible="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_FloorPrice" HeaderStyle-Width="200px" HeaderText="Min Bid Price"
                                        ShowFilterIcon="false" UniqueName="AIM_FloorPrice" Visible="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_CapPrice" HeaderStyle-Width="200px" HeaderText="Max Bid Price"
                                        ShowFilterIcon="false" UniqueName="AIM_CapPrice" Visible="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_FixedPrice" HeaderStyle-Width="200px" HeaderText="Max Bid Price"
                                        Visible="false" ShowFilterIcon="false" UniqueName="AIM_FixedPrice">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_OpenDate" HeaderStyle-Width="200px" HeaderText="Open Date"
                                        ShowFilterIcon="false" UniqueName="AIM_OpenDate" Visible="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AIM_CloseDate" HeaderStyle-Width="200px" HeaderText="Open Date"
                                        ShowFilterIcon="false" UniqueName="AIM_CloseDate" Visible="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn ItemStyle-Width="140px" AllowFiltering="false" HeaderText="Action"
                                        ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgBuy" runat="server" CommandName="Buy" ImageUrl="~/Images/Buy-Button.png"
                                                ToolTip="BUY IPO" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </td>
                </tr>
            </table>
        </div>
        </asp:Panel>
    </ContentTemplate>
    <Triggers>
    </Triggers>
</asp:UpdatePanel>
