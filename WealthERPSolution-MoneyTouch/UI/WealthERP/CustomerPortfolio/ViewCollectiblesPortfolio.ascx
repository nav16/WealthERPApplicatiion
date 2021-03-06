﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewCollectiblesPortfolio.ascx.cs"
    Inherits="WealthERP.CustomerPortfolio.ViewCollectiblesPortfolio" %>
<%@ Register Src="~/General/Pager.ascx" TagPrefix="Pager" TagName="Pager" %>
<table class="TableBackground" style="width: 100%">
    <tr>
        <td class="HeaderCell">
            <asp:Label ID="lblHeader" runat="server" CssClass="HeaderTextBig" Text="Collectibles Portfolio"></asp:Label>
            <hr />
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Label1" runat="server" CssClass="FieldName" Text="Portfolio Name:"></asp:Label>
            <asp:DropDownList ID="ddlPortfolio" runat="server" CssClass="cmbField" AutoPostBack="true"
                OnSelectedIndexChanged="ddlPortfolio_SelectedIndexChanged">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblMessage" runat="server" CssClass="Error" Text="No Records Found!"></asp:Label>
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
            <asp:GridView ID="gvCollectiblesPortfolio" runat="server" AutoGenerateColumns="False"
                CellPadding="4" CssClass="GridViewStyle" DataKeyNames="CollectibleId" OnSelectedIndexChanged="gvCollectiblesPortfolio_SelectedIndexChanged"
                AllowSorting="True" HorizontalAlign="Center" AllowPaging="True" OnPageIndexChanging="gvCollectiblesPortfolio_PageIndexChanging"
                OnSorting="gvCollectiblesPortfolio_Sorting" OnRowCommand="gvCollectiblesPortfolio_RowCommand"
                OnRowEditing="gvCollectiblesPortfolio_RowEditing" OnPreRender="gvCollectiblesPortfolio_PreRender"
                OnSelectedIndexChanging="gvCollectiblesPortfolio_SelectedIndexChanging" OnSorted="gvCollectiblesPortfolio_Sorted"
                OnDataBound="gvCollectiblesPortfolio_DataBound" ShowFooter="True">
                <FooterStyle CssClass="FooterStyle" />
                <RowStyle CssClass="RowStyle" />
                <EditRowStyle HorizontalAlign="Left" VerticalAlign="Top" CssClass="EditRowStyle" />
                <SelectedRowStyle CssClass="SelectedRowStyle" />
                <PagerStyle HorizontalAlign="Center" CssClass="PagerStyle" />
                <HeaderStyle CssClass="HeaderStyle" />
                <AlternatingRowStyle CssClass="AltRowStyle" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlAction" runat="server" AutoPostBack="true" CssClass="GridViewCmbField"
                                OnSelectedIndexChanged="ddlAction_OnSelectedIndexChange">
                                <asp:ListItem Text="Select" />
                                <asp:ListItem Text="View" />
                                <asp:ListItem Text="Edit" />
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Instrument Category" HeaderText="Asset Category"  />
                    <asp:BoundField DataField="Particulars" HeaderText="Particulars" SortExpression="Particulars"
                        ItemStyle-HorizontalAlign="Justify">
                        <ItemStyle HorizontalAlign="Justify"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Purchase Date" HeaderText="Purchase Date (dd/mm/yyyy)" 
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Purchase Value" HeaderText="Purchase Value (Rs)" ItemStyle-HorizontalAlign="Right">
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Current Value" HeaderText="Current Value (Rs)" ItemStyle-HorizontalAlign="Right">
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Remarks" HeaderText="Remarks"  />
                </Columns>
            </asp:GridView>
        </td>
    </tr>
</table>
<div id="DivPager" runat="server" style="display: none">
    <table style="width: 100%">
        <tr>
            <td>
                <Pager:Pager ID="mypager" runat="server"></Pager:Pager>
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="hdnSort" runat="server" Value="InstrumentCategory ASC" />
<asp:HiddenField ID="hdnRecordCount" runat="server" />
