﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MFSchemeDetails.ascx.cs"
    Inherits="WealthERP.OnlineOrderManagement.MFSchemeDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:ScriptManager ID="scrptMgr" runat="server" EnablePageMethods="true">
</asp:ScriptManager>

<script src="../Scripts/jquery.min.js" type="text/javascript"></script>

<script src="../Scripts/bootstrap.js" type="text/javascript"></script>

<link href="../Base/CSS/bootstrap-theme.css" rel="stylesheet" type="text/css" />
<link href="../Base/CSS/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="../Base/CSS/bootstrap.min.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    .header
    {
        background: #258dc8; /* Old browsers */
        background: -moz-linear-gradient(top,  #258dc8 0%, #2475c7 100%); /* FF3.6+ */
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#258dc8), color-stop(100%,#2475c7)); /* Chrome,Safari4+ */
        background: -webkit-linear-gradient(top,  #258dc8 0%,#2475c7 100%); /* Chrome10+,Safari5.1+ */
        background: -o-linear-gradient(top,  #258dc8 0%,#2475c7 100%); /* Opera 11.10+ */
        background: -ms-linear-gradient(top,  #258dc8 0%,#2475c7 100%); /* IE10+ */
        background: linear-gradient(to bottom,  #258dc8 0%,#2475c7 100%); /* W3C */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#258dc8', endColorstr='#2475c7',GradientType=0 ); /* IE6-9 */
        height: 20px;
        text-align: center;
        font-color: white;
    }
    .tddate
    {
        background: #ffffff; /* Old browsers */
        background: -moz-linear-gradient(top,  #ffffff 0%, #f6f6f6 47%, #ededed 100%); /* FF3.6+ */
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#ffffff), color-stop(47%,#f6f6f6), color-stop(100%,#ededed)); /* Chrome,Safari4+ */
        background: -webkit-linear-gradient(top,  #ffffff 0%,#f6f6f6 47%,#ededed 100%); /* Chrome10+,Safari5.1+ */
        background: -o-linear-gradient(top,  #ffffff 0%,#f6f6f6 47%,#ededed 100%); /* Opera 11.10+ */
        background: -ms-linear-gradient(top,  #ffffff 0%,#f6f6f6 47%,#ededed 100%); /* IE10+ */
        background: linear-gradient(to bottom,  #ffffff 0%,#f6f6f6 47%,#ededed 100%); /* W3C */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#ededed',GradientType=0 ); /* IE6-9 */
    }
    .alignment tr th
    {
        text-align: justify;
        width: 40%;
    }
    .alignment tr td
    {
        text-align: justify;
        width: 60%;
    }
    @media only screen and (max-width: 800px)
    {
        /* Force table to not be like tables anymore */    #no-more-tables table, #no-more-tables thead, #no-more-tables tbody, #no-more-tables th, #no-more-tables td, #no-more-tables tr
        {
            display: block;
        }
        /* Hide table headers (but not display: none;, for accessibility) */    #no-more-tables thead tr
        {
            position: absolute;
            top: -9999px;
            left: -9999px;
        }
        #no-more-tables tr
        {
            border: 1px solid #ccc;
        }
        #no-more-tables td
        {
            /* Behave  like a "row" */
            border: none;
            border-bottom: 1px solid #eee;
            position: relative;
            padding-left: 60%;
            white-space: normal;
            text-align: left;
        }
        #no-more-tables td:before
        {
            /* Now like a table header */
            position: absolute; /* Top/left values mimic padding */
            top: 6px;
            left: 6px;
            width: 80%;
            padding-right: 10px;
            white-space: nowrap;
            text-align: left;
            font-weight: bold;
            z-index: auto;
        }
        /*
	Label the data
	*/    #no-more-tables td:before
        {
            content: attr(data-title);
        }
    }
    .alignCenter
    {
        text-align: center;
    }
    table, th
    {
        border: 1px solid black;
    }
    .dottedBottom
    {
        border-bottom-style: inset;
        border-bottom-width: thin;
        margin-bottom: 1%;
        border-collapse: collapse;
        border-spacing: 10px;
    }
    .readOnlyFieldsss
    {
        font-family: Verdana,Tahoma;
        font-weight: normal;
        font-size: small;
        color: Black;
    }
    .DetailfieldFontSize
    {
        font-family: Times New Roman;
        font-weight: bold;
        font-size: small;
        color: #000;
    }
</style>
<table width="100%" style="border-color: #0396cc">
    <tr>
        <td align="left">
            <b style="font-family: Times New Roman; color: #0396cc">Scheme Research</b>
        </td>
    </tr>
</table>
<asp:UpdatePanel ID="UPnlSchmResrch" runat="server" RenderMode="Inline">
    <ContentTemplate>
        <div id="dvDemo" class="row " style="margin-left: 11%; margin-bottom: 0.5%; margin-right: 5%;
            padding-top: 0.5%; padding-bottom: 0.5%;" visible="false" runat="server">
            <div class="col-md-12 col-xs-12 col-sm-12" style="margin-bottom: 1%">
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlAMC" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlAMC_SelectedIndexChanged"
                        AutoPostBack="true">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvtxtTransactionDate" ControlToValidate="ddlAMC"
                        ErrorMessage="<br />Please select AMC" Style="color: Red;" Display="Dynamic"
                        runat="server" InitialValue="0" ValidationGroup="btnViewscheme">
                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <fieldset>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control input-sm"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_OnSelectedIndexChanged">
                        </asp:DropDownList>
                    </fieldset>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control input-sm"
                        class="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="ddlScheme"
                        ErrorMessage="<br />Please select Scheme" Style="color: Red;" Display="Dynamic"
                        runat="server" InitialValue="0" ValidationGroup="btnViewscheme">
                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-1">
                    <asp:Button ID="Button2" runat="server" class="btn btn-sm btn-primary" Text="Go"
                        OnClick="Go_OnClick" ValidationGroup="btnViewscheme"></asp:Button>
                </div>
            </div>
        </div>
        <div id="Div2" style="margin-bottom: 2%; width: 80%; padding-bottom: 1%; margin-left: auto;
            margin-right: auto;" visible="false" runat="server">
            <div>
                <div class="col-md-5" style="margin-bottom: 10px;">
                    <asp:Label ID="lblSchemeName" runat="server" Style="font-size: large; font-family: Times New Roman;
                        font-weight: bold;"></asp:Label>
                </div>
                <div class="col-md-2" style="width: 16%;">
                    <div>
                        <b style="font-family: Times New Roman; text-align: center;">NAV</b>
                    </div>
                    <div>
                        <asp:Label ID="lblNAV" runat="server"></asp:Label>
                        <br />
                        <asp:Label ID="lblAsonDate" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="col-md-2" style="margin-left: 0%;">
                    <div>
                        <b style="font-family: Times New Roman; text-align: center;">NAV Change</b>
                    </div>
                    <div>
                        <asp:Image runat="server" ID="ImagNAV" /><asp:Label ID="lblNAVDiff" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="col-md-1">
                    <b style="font-family: Times New Roman;">Rating </b>
                    <br />
                    <asp:Image runat="server" ID="imgSchemeRating" />
                </div>
                <div class="col-md-2" style="visibility:hidden;">
                    <asp:LinkButton ID="lnkAddToCompare" runat="server" CssClass="btn btn-primary btn-primary"
                        OnClick="lnkAddToCompare_OnClick" ValidationGroup="btnGo" Style="margin-bottom: 5px"> Add To Compare <span class="glyphicon glyphicon-shopping-list">
                            </span></asp:LinkButton>
                    <asp:DropDownList ID="ddlAction" runat="server" AutoPostBack="true" CssClass="form-control input-sm"
                        OnSelectedIndexChanged="ddlAction_OnSelectedIndexChanged" Width="100px">
                        <asp:ListItem Text="Action" Value="Select Action"></asp:ListItem>
                        <asp:ListItem Text="Purchase" Value="Buy" Enabled="false"></asp:ListItem>
                        <asp:ListItem Text="SIP" Value="SIP" Enabled="false"></asp:ListItem>
                        <asp:ListItem Text="Redeem" Value="Redeem" Enabled="false"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div style="margin-bottom: 2%; width: 80%; padding-bottom: 1%; margin-left: auto;
            margin-right: auto;">
            <asp:Panel ID="pnlDetails" runat="server" Height="490px">
                <telerik:RadTabStrip ID="RadTabStripAdsUpload" runat="server" EnableTheming="True"
                    EnableEmbeddedSkins="true" MultiPageID="multipageAdsUpload" SelectedIndex="0"
                    Skin="Outlook">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Snapshot" Value="Snapshot" TabIndex="0" Selected="true">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="NAV History" Value="NAVPerformance" TabIndex="1">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Scheme Return" Value="SchemeReturn" TabIndex="2">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Risk And Rating" Value="RiskAndRating" TabIndex="3">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Fund Manager Profile" Value="FundManagerProfile"
                            TabIndex="4">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Portfolio" Value="Portfolio" TabIndex="5">
                        </telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="multipageAdsUpload" EnableViewState="true" runat="server">
                    <telerik:RadPageView ID="RadPageView1" runat="server" Selected="true">
                        <div>
                            <div style="float: left; width: 50%; min-width: 320px;">
                                <table class="col-md-12 table-bordered table-striped table-condensed cf">
                                    <tbody class="alignment">
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">AMC </b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblAMC" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Fund Manager</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblFundManager" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Return 1st yr (%)</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblFundReturn1styear" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Return 3rd yr (%)</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblFundReturn3rdyear" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Return 5th yr (%)</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblFundReturn5thyear" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Min Investment Amount</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblMinInvestment" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Multiple of</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblMinMultipleOf" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Exit Load</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblExitLoad" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div style="float: left; width: 50%; min-width: 320px;">
                                <table class="col-md-12 table-bordered table-striped table-condensed cf">
                                    <tbody class="alignment">
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Category</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblCategory" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Scheme Benchmark</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblBanchMark" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Benchmark Return 1st yr (%)</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblBenchmarkReturn" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Benchmark Return 3rd yr (%)</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblBenchMarkReturn3rd" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Benchmark Return 5th yr (%)</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblBenchMarkReturn5th" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Min SIP Amount</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblMinSIP" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <th>
                                                <b class="DetailfieldFontSize">Multiple of</b>
                                            </th>
                                            <td>
                                                <asp:Label ID="lblSIPMultipleOf" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView2" runat="server">
                        <div id="divChart" runat="server" visible="false" style="margin-bottom: 2%; width: 100%;
                            margin-left: auto; margin-right: auto; border-top-style: inset; border-bottom-style: inset;
                            border-left-style: inset; border-right-style: inset; border-width: thin;">
                            <div>
                                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                            </div>
                            <div id="SchemeChartinformation" runat="server" visible="false">
                                &nbsp;&nbsp;<asp:Button ID="btn1m" runat="server" class="btn btn-sm btn-primary"
                                    Text="1m" OnClick="btnHistory_OnClick"></asp:Button>
                                <asp:Button ID="btn3m" runat="server" class="btn btn-sm btn-primary" Text="3m" OnClick="btnHistory_OnClick">
                                </asp:Button>
                                <asp:Button ID="btn6m" runat="server" class="btn btn-sm btn-primary" Text="6m" OnClick="btnHistory_OnClick">
                                </asp:Button>
                                <asp:Button ID="btn1y" runat="server" class="btn btn-sm btn-primary" Text="1y" OnClick="btnHistory_OnClick">
                                </asp:Button>
                                <asp:Button ID="btn2y" runat="server" class="btn btn-sm btn-primary" Text="2y" OnClick="btnHistory_OnClick">
                                </asp:Button>
                                &nbsp;&nbsp;<telerik:RadDatePicker ID="rdpFromDate" Label="From" DateInput-EmptyMessage="From Date"
                                    MinDate="01/01/1000" MaxDate="01/01/3000" CssClass="calender" runat="server">
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="rdpFromDate"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG" ValidationGroup="btnHistoryChat"></asp:RequiredFieldValidator>
                                <telerik:RadDatePicker ID="rdpToDate" Label="To" DateInput-EmptyMessage="To Date"
                                    MinDate="01/01/1000" MaxDate="01/01/3000" CssClass="calender" runat="server">
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="rdpFromDate"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG" ValidationGroup="btnHistoryChat"></asp:RequiredFieldValidator>
                                <asp:Button ID="btnHistoryChat" runat="server" class="btn btn-sm btn-primary" Text="Go"
                                    ValidationGroup="btnHistoryChat" OnClick="btnHistoryChat_OnClick"></asp:Button>
                            </div>
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView7" runat="server">
                        <div>
                            <asp:Literal ID="ltrReturn" runat="server"></asp:Literal>
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView3" runat="server">
                        <div>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblRatingAsOnPopUp" runat="server" CssClass="readOnlyFields"></asp:Label>
                                        </td>
                                        <td>
                                            <span class="DetailfieldFontSize">RATING</span>
                                        </td>
                                        <td>
                                            <span class="DetailfieldFontSize">RISK</span>
                                        </td>
                                        <td>
                                            <span class="DetailfieldFontSize">RATING OVERALL</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="DetailfieldFontSize">3 YEAR</span>
                                        </td>
                                        <td>
                                            <asp:Image runat="server" ID="imgRating3yr" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSchemeRisk3yr" runat="server" CssClass="DetailfieldFontSize"> </asp:Label>
                                        </td>
                                        <td rowspan="3">
                                            <asp:Image runat="server" ID="imgRatingOvelAll" ImageAlign="Middle" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="DetailfieldFontSize">5 YEAR</span>
                                        </td>
                                        <td>
                                            <asp:Image runat="server" ID="imgRating5yr" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSchemeRisk5yr" runat="server" CssClass="DetailfieldFontSize"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="DetailfieldFontSize">10 YEAR</span>
                                        </td>
                                        <td>
                                            <asp:Image runat="server" ID="imgRating10yr" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSchemeRisk10yr" runat="server" CssClass="DetailfieldFontSize"></asp:Label>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView4" runat="server">
                        <div>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr class="searchable-spec cell top sub-name small bordered">
                                        <td>
                                            <b class="DetailfieldFontSize">FundManager</b>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblFundMAnagername" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="searchable-spec cell top sub-name small bordered">
                                        <td>
                                            <b class="DetailfieldFontSize">Qualification</b>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblQualification" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="searchable-spec cell top sub-name small bordered">
                                        <td>
                                            <b class="DetailfieldFontSize">Designation</b>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDesignation" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="searchable-spec cell top sub-name small bordered">
                                        <td>
                                            <b class="DetailfieldFontSize">Experience</b>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblExperience" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView5" runat="server">
                        <div id="no-more-tables" style="width: 100%">
                            <div style="width: 20%; margin-right: 5px;">
                                <table class="col-md-12 table-bordered table-striped table-condensed cf" width="100%">
                                    <thead class="cf">
                                        <tr style="border-style: inset; background-color: #2480c7; font-size: small; color: White;
                                            text-align: center;">
                                            <th data-title="Fund Name" class="alignCenter">
                                                <b>Top Holding</b>
                                            </th>
                                            <th data-title="Holding(%)" class="alignCenter">
                                                <b>Weight (%)</b>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rpSchemeDetails" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td data-title="Fund Name">
                                                        <asp:Label ID="lblFundName" CssClass="DetailfieldFontSize" runat="server" Text='<%# Eval("co_name")%>'></asp:Label>
                                                    </td>
                                                    <td data-title="Holding(%)">
                                                        <asp:Label ID="lblHolding" CssClass="DetailfieldFontSize" runat="server" Text='<%# Eval("perc_hold")%>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                            <div style="width: 21%; float: left; margin-left: 78px;">
                                <asp:Literal ID="ltrHolding" runat="server"></asp:Literal>
                            </div>
                            <div style="width: 25%; float: left; margin-left: 8px;">
                                <table class="col-md-12 table-bordered table-striped table-condensed cf" width="100%">
                                    <thead class="cf">
                                        <tr style="border-style: inset; background-color: #2480c7; font-size: small; color: White;
                                            text-align: center;">
                                            <th data-title="Sector" class="alignCenter">
                                                <b>Top Sector</b>
                                            </th>
                                            <th data-title="Holding(%)" class="alignCenter">
                                                <b>Weight (%)</b>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="RepSector" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td data-title="Sector">
                                                        <asp:Label ID="lblSector" CssClass="DetailfieldFontSize" runat="server" Text='<%# Eval("sector")%>'></asp:Label>
                                                    </td>
                                                    <td data-title="Holding(%)">
                                                        <asp:Label ID="lblsecWeight" CssClass="DetailfieldFontSize" runat="server" Text='<%# Eval("holdingpercentage")%>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                            <div style="width: 21%; float: left; margin-left: 8px;">
                                <asp:Literal runat="server" ID="ltrSector"></asp:Literal>
                            </div>
                            <div style="width: 28%; margin-right: 5px;">
                                <table class="col-md-12 table-bordered table-striped table-condensed cf" width="100%">
                                    <thead class="cf">
                                        <tr style="border-style: inset; background-color: #2480c7; font-size: small; color: White;
                                            text-align: center">
                                            <th data-title="Fund Name" class="alignCenter">
                                                <b>Asset allocation</b>
                                            </th>
                                            <th data-title="Holding(%)" class="alignCenter">
                                                <b>Weight (%)</b>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="RepAsset" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td data-title="Fund Name">
                                                        <asp:Label ID="lblasset" runat="server" CssClass="DetailfieldFontSize" Text='<%# Eval("asset")%>'></asp:Label>
                                                    </td>
                                                    <td data-title="Holding(%)">
                                                        <asp:Label ID="lblassetvalue" CssClass="DetailfieldFontSize" runat="server" Text='<%# Eval("assetvalue")%>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                            <div style="width: 21%; float: left; margin-left: 8px;">
                                <asp:Literal ID="ltrAssets" runat="server"></asp:Literal>
                                <asp:Literal ID="raj" runat="server"></asp:Literal>
                            </div>
                            <br />
                            <div style="width: 22%; float: left; margin-left: 8px;">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th class="header">
                                                <font color="#fff">Morning Star </font>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div>
                                                    <asp:Image ID="imgStyleBox" runat="server" /></div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div style="width: 19%; float: left; min-width: 19%; margin-left: 10px;">
                                <table class="table table-bordered" style="margin-left: 2px;">
                                    <thead>
                                        <tr>
                                            <th colspan="2" class="header">
                                                <font color="#fff">Additional Information</font>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <td>
                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="http://www.amfiindia.com/intermediary/other-data/scheme-details"
                                                    Target="_blank">Scheme Information Document-SID </asp:HyperLink>
                                            </td>
                                        </tr>
                                        <tr class="searchable-spec cell top sub-name small bordered">
                                            <td>
                                                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="http://www.amfiindia.com/research-information/other-data/sai"
                                                    Target="_blank">Statement of Additional Information-SAI</asp:HyperLink>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </asp:Panel>
        </div>
        <asp:HiddenField ID="hidCurrentScheme" runat="server" />
    </ContentTemplate>
    <Triggers>
    
    </Triggers>
</asp:UpdatePanel>
