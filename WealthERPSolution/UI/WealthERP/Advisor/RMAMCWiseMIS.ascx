﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RMAMCWiseMIS.ascx.cs"
    Inherits="WealthERP.Advisor.RMAMCWiseMIS" %>
<%@ Register Src="~/General/Pager.ascx" TagPrefix="Pager" TagName="Pager" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:ScriptManager ID="scptMgr" runat="server">
</asp:ScriptManager>

<script type="text/javascript">

    function checkdate(sender, args) {
        //create a new date var and set it to the
        //value of the senders selected date
        var selectedDate = new Date();
        selectedDate = sender._selectedDate;
        //create a date var and set it's value to today
        var todayDate = new Date();
        var mssge = "";

        if (selectedDate > todayDate) {

            //set the senders selected date to today
            sender._selectedDate = todayDate;
            //set the textbox assigned to the cal-ex to today
            sender._textbox.set_Value(sender._selectedDate.format(sender._format));
            //alert the user what we just did and why
            alert("Warning! - Date Cannot be in the future. Date value is reset to the current date");
        }
    }
</script>



<script type="text/javascript" language="javascript">
    function CheckValuationDate() {
        var valuationDate = document.getElementById("<%=hdnValuationDate.ClientID %>").value;
        var txtDate = document.getElementById("<%=txtDate.ClientID %>").value;
        txtDate = new Date(txtDate);
        valuationDate = new Date(valuationDate);
        txtDate.setHours(0, 0, 0, 0);
        valuationDate.setHours(0, 0, 0, 0);
        if (txtDate <= valuationDate) {
            return true;
        }
        else {
            alert("Please Select Prior Business Date");
            return false;
        }

    }
</script>
<table width="100%">
    <tr>
        <td colspan="3" style="width: 100%;">
            <div class="divPageHeading">
                <table cellspacing="0" cellpadding="3" width="100%">
                    <tr>
                        <td align="left">
                            MF MIS
                        </td>
                        <td align="right" style="padding-bottom: 2px;">
                            <asp:ImageButton ID="imgBtnExport" ImageUrl="../Images/Export_Excel.png" Visible="false"
                                runat="server" AlternateText="Excel" ToolTip="Export To Excel" OnClick="imgBtnExport_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<table style="width: 100%;">
    <%--    <tr>
        <td class="HeaderTextBig" colspan="3">
            <asp:Label ID="lblMfMIS" runat="server" CssClass="HeaderTextBig" Text="MF MIS"></asp:Label>
            <hr />
        </td>
    </tr>--%>
    <tr>
        <td>
            <table style="width: 62%; margin: 0px; padding: 0px;" cellpadding="1" cellspacing="1">
                <tr>
                    <td align="right">
                        <asp:Label ID="lblMISType" runat="server" CssClass="FieldName">MIS Type:</asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlMISType" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlMISType_SelectedIndexChanged"
                            AutoPostBack="true">
                            <asp:ListItem Value="AMCWiseAUM" Selected="True">AMC Wise AUM</asp:ListItem>
                            <asp:ListItem Value="AMCSchemeWiseAUM">Scheme Wise AUM</asp:ListItem>
                            <asp:ListItem Value="FolioWiseAUM">Folio Wise AUM</asp:ListItem>
                            <asp:ListItem Value="TurnOverSummary">Turn Over Summary</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td align="right">
                        <span id="spnBranch" runat="server">
                            <asp:Label ID="lblBranch" runat="server" CssClass="FieldName" Text="Branch:"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlBranch" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged"
                            AutoPostBack="true">
                            <%--<asp:ListItem Value="1086" Text="All"></asp:ListItem>
                 <asp:ListItem Value="1145" Text="AJAY SINGH"></asp:ListItem>
                 <asp:ListItem Value="1058" Text="INVESTPRO FINANCIAL  SERV"></asp:ListItem> --%>
                        </asp:DropDownList>
                        </span>
                    </td>
                </tr>
                <tr id="trRange" runat="server">
                    <td align="right" valign="top">
                        <asp:Label ID="lblDate" runat="server" CssClass="FieldName">As on Date:</asp:Label>
                    </td>
                    <td valign="top">
                        <%--<asp:TextBox ID="txtDate" runat="server" CssClass="txtField" Height="16px" Width="145px"></asp:TextBox>
            <cc1:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" TargetControlID="txtDate"
                OnClientDateSelectionChanged="checkdate" Format="dd/MM/yyyy">
            </cc1:CalendarExtender>
            <cc1:TextBoxWatermarkExtender ID="txtFromDate_TextBoxWatermarkExtender" runat="server"
                TargetControlID="txtDate" WatermarkText="dd/mm/yyyy">
            </cc1:TextBoxWatermarkExtender>--%>
                        <telerik:RadDatePicker ID="txtDate" CssClass="txtTo" runat="server" Culture="English (United States)"
                            Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                            <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                            </Calendar>
                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                            <DateInput ID="DateInput1" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                            </DateInput>
                        </telerik:RadDatePicker>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtDate"
                            CssClass="rfvPCG" ErrorMessage="<br />Please select a Date" Display="Dynamic"
                            runat="server" InitialValue="" ValidationGroup="btnGo">
                        </asp:RequiredFieldValidator>
                    </td>
                    <td align="right" valign="top">
                        <span id="spnRM" runat="server">
                            <asp:Label ID="lblRM" runat="server" CssClass="FieldName" Text="RM:"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:DropDownList ID="ddlRM" runat="server" CssClass="cmbField" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlRM_SelectedIndexChanged">
                        </asp:DropDownList>
                        </span>
                    </td>
                </tr>
                
            </table>
        </td>
    </tr>
    <tr>
        <td>
        </td>
        <td>
            <asp:Button ID="btnGo" runat="server" Text="Go" ValidationGroup="btnGo" CssClass="PCGButton"
                onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_RMAMCSchemewiseMIS_btnGo', 'S');"
                onmouseout="javascript:ChangeButtonCss('out', 'ctrl_RMAMCSchemewiseMIS_btnGo', 'S');"
                OnClick="btnGo_Click" OnClientClick="return CheckValuationDate();" />
        </td>
        <td>
        </td>
        <td>
        </td>
    </tr>
</table>
   
    <%--<table>
    <tr>    
        <td>
            <asp:Label ID="lblMISType" runat="server" CssClass="FieldName">&nbsp;&nbsp;&nbsp;MIS Type:</asp:Label>
            <asp:DropDownList ID="ddlMISType" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlMISType_SelectedIndexChanged"
                AutoPostBack="true">
                <asp:ListItem Value="AMCWiseAUM" Selected="True">AMC Wise AUM</asp:ListItem>
                <asp:ListItem Value="AMCSchemeWiseAUM">Scheme Wise AUM</asp:ListItem>
                <asp:ListItem Value="FolioWiseAUM">Folio Wise AUM</asp:ListItem>
                <asp:ListItem Value="TurnOverSummary">Turn Over Summary</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td>
            <span id="spnBranch" runat="server">
                <asp:Label ID="lblBranch" runat="server" CssClass="FieldName" Text="Branch:"></asp:Label>
                <asp:DropDownList ID="ddlBranch" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged"
                    AutoPostBack="true"> 
                               
                </asp:DropDownList>
            </span>
        </td>
        <td>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </td>
    </tr>
    <tr id="trRange" runat="server">
        <td>
            <asp:Label ID="lblDate" runat="server" CssClass="FieldName">As on Date:</asp:Label>
            <asp:TextBox ID="txtDate" runat="server" CssClass="txtField"></asp:TextBox>
            <cc1:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" TargetControlID="txtDate"
                OnClientDateSelectionChanged="checkdate" Format="dd/MM/yyyy">
            </cc1:CalendarExtender>
            <cc1:TextBoxWatermarkExtender ID="txtFromDate_TextBoxWatermarkExtender" runat="server"
                TargetControlID="txtDate" WatermarkText="dd/mm/yyyy">
            </cc1:TextBoxWatermarkExtender>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtDate"
                CssClass="rfvPCG" ErrorMessage="<br />Please select a Date" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="btnGo">
            </asp:RequiredFieldValidator><br />
            <asp:Label ID="lblPortfolio" runat="server" Text="&nbsp;&nbsp;&nbsp;&nbsp;Portfolio:" CssClass="FieldName" Visible="false"></asp:Label>
            <asp:DropDownList ID="ddlPortfolio" runat="server" CssClass="cmbField" Visible="false">
            </asp:DropDownList>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnGo" runat="server" Text="Go" ValidationGroup="btnGo" CssClass="PCGButton"
                onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_RMAMCwiseMIS_btnGo', 'S');"
                onmouseout="javascript:ChangeButtonCss('out', 'ctrl_RMAMCwiseMIS_btnGo', 'S');"
                OnClick="btnGo_Click" />
        </td>
        <td>
            <span id="spnRM" runat="server">&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblRM" runat="server" CssClass="FieldName" Text="RM:"></asp:Label>
                <asp:DropDownList ID="ddlRM" runat="server" CssClass="cmbField" 
                onselectedindexchanged="ddlRM_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </span>
        </td>
        <td>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </td>
    </tr>    
    </table>--%>
    <table>
    <tr id="trMessage" runat="server" visible="false">
        <td colspan="3">
            <asp:Label ID="lblMessage" runat="server" CssClass="Error" Text="No Records Found."></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="right">
            <asp:Label ID="lblCurrentPage" class="Field" runat="server"></asp:Label>
            <asp:Label ID="lblTotalRows" class="Field" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <div style="overflow: scroll;height:300px">
                <asp:GridView ID="gvMFMIS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    CellPadding="4" CssClass="GridViewStyle" ShowFooter="True" DataKeyNames="AMCCode"
                    OnSelectedIndexChanged="gvMFMIS_SelectedIndexChanged" Width="100%">
                    <%--OnSorting="gvMFMIS_Sorting" OnDataBound="gvMFMIS_DataBound"--%>
                    <RowStyle CssClass="RowStyle" />
                    <FooterStyle CssClass="FooterStyle" HorizontalAlign="right" />
                    <PagerStyle HorizontalAlign="Center" CssClass="PagerStyle" />
                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <EditRowStyle CssClass="EditRowStyle" />
                    <AlternatingRowStyle CssClass="AltRowStyle" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" SelectText="Details" ItemStyle-Width="12px" />
                        <asp:TemplateField HeaderStyle-Wrap="false">
                            <HeaderTemplate>
                                <asp:Label ID="lblAMC" runat="server" Text="AMC"></asp:Label>
                                <asp:TextBox ID="txtAMCSearch" runat="server" CssClass="GridViewTxtField" onkeydown="return JSdoPostback(event,'ctrl_RMAMCwiseMIS_btnSearch');" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAMCHeader" runat="server" Text='<%# Eval("AMC").ToString() %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="40px" />
                            <HeaderStyle Wrap="False"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:BoundField DataField="AUM" HeaderText="AUM" ItemStyle-HorizontalAlign="Right"
                            ItemStyle-Width="15px" DataFormatString="{0:n2}" HeaderStyle-Wrap="false">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Percentage" HeaderText="AUM %" ItemStyle-HorizontalAlign="Right"
                            ItemStyle-Width="15px" HeaderStyle-Wrap="false">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
            </div>
        </td>
    </tr>
    <tr id="ValuationNotDoneErrorMsg" align="center" style="width: 100%" runat="server">
        <td align="center" style="width: 100%">
            <div class="failure-msg" style="text-align: center" align="center">
                Valuation not done for this adviser....
            </div>
        </td>
    </tr>
    <%-- <tr id="ValuationNotDoneErrorMsg" align="center" style="width: 100%" runat="server">
                    <td align="center" style="width: 100%">
                        <div class="failure-msg" style="text-align:center" align="center">
                            Valuation not done for this adviser....
                        </div>
                    </td>
                </tr>--%>
</table>
<asp:Button ID="btnSearch" runat="server" Text="" BorderStyle="None" BackColor="Transparent"
    OnClick="btnSearch_Click" />
<asp:HiddenField ID="hdnAMCSearchVal" runat="server" Visible="false" />
<asp:HiddenField ID="hdnValuationDate" runat="server" />
<asp:HiddenField ID="hdnrmId" runat="server" Visible="false" />
<asp:HiddenField ID="hdnbranchId" runat="server" Visible="false" />
<asp:HiddenField ID="hdnbranchHeadId" runat="server" Visible="false" />
<asp:HiddenField ID="hdnAll" runat="server" Visible="false" />
<asp:HiddenField ID="hdnXWise" runat="server" Visible="false" />
<asp:HiddenField ID="hdnBranchSelection" runat="server" Visible="false" />
<asp:HiddenField ID="hdnRMSelection" runat="server" Visible="false" />
