﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OnlineMainHost.aspx.cs"
    Inherits="WealthERP.OnlineMainHost" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Latest compiled and minified JavaScript -->
    <%-- <link href="../Base/CSS/bootstrap-theme.css" rel="stylesheet" type="text/css" />
    <link href="../Base/CSS/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../Base/CSS/bootstrap.min.css" rel="stylesheet" type="text/css" />--%>
    <link href="../Base/CSS/bootstrap-3.3.6.min.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/jquery-2.1.1.min.js" type="text/javascript"></script>

    <script src="../Scripts/bootstrap-3.3.6.min.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui-1.7.2.custom.min.js" type="text/javascript"></script>

    <script src="../Scripts/jQuery.bubbletip-1.0.6.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript" src="Scripts/JScript.js"></script>

</head>
<body>
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
        function ShowModal() {

            $("#btnShowPopup").click();

        }
        function calcIFrameHeight(ifrm_id) {
            try {

                setTimeout("calc('" + ifrm_id + "')", 500);
            }
            catch (e) { }
        }


   
   
    </script>

    <button type="button" style="display: none;" id="btnShowPopup" data-toggle="modal"
        data-target="#myModal">
    </button>

    <script type="text/javascript" language="javascript">
        function GetTransactPanelSchemePlanCode(source, eventArgs) {
            isItemSelected = true;
            document.getElementById("<%= schemeCode.ClientID %>").value = eventArgs.get_value();
            return false;
        }
        function GetSchemePlanCode(source, eventArgs) {
            isItemSelected = true;
            document.getElementById("<%= schemeCode.ClientID %>").value = eventArgs.get_value();
            //        LoadBottomPanelControl('MFSchemeDetails', '&schemeCode=' + eventArgs.get_value());
            return false;
        }
        function ddlchange(ddl) {

            var value = ddl.value + '&exchangeType=' + ddlchannel.value;
            LoadTransactPanel(value);
        }
    </script>

    <style type="text/css">
        #topframe
        {
            width: 100%;
            border: none;
        }
        #bottomframe
        {
            width: 100%;
            border: none;
        }
        #left_menu
        {
            float: left;
            width: 18%;
            display: block;
        }
        #content
        {
            float: left;
            width: 80.50%;
        }
        #UpdateProgress1
        {
            background-color: #CF4342;
            color: White;
            top: 0px;
            right: 0px;
            position: fixed;
        }
        #UpdateProgress1 img
        {
            vertical-align: middle;
            margin: 2px;
        }
        .fltlft
        {
            float: left;
            padding-left: 3px;
            width: 20%;
        }
        .div-with-header
        {
            height: 40px;
            background: url('Images/sbi-capsec-header.png') no-repeat left top;
            width: 100%;
            min-width: 980px;
            float: left;
        }
        .div-container
        {
            border: 3px;
            border-style: solid;
            color: #3299FF;
            width: 100%;
            float: right;
            margin-top: 0px;
            padding-top: 0px;
            border-top: 1px;
        }
        .div-log-out
        {
            float: right;
            padding-right: 10px;
            background: url('Images/sign-out.png') no-repeat left top;
            padding-top: 30px;
            padding-right: 30px;
        }
        .user-name
        {
            color: #EA8A04;
            font-family: Arial;
            font-size: 12px;
            font-weight: bold;
        }
        .product-header
        {
            background: url('Images/product-header.png');
            background-repeat: repeat;
            height: 20px;
            width: 100%;
            min-width: 980px;
            float: left;
        }
        .product-header-text
        {
            float: left;
            color: White;
            font-family: Arial;
            font-size: 15px;
            font-weight: bold;
            padding-left: 15px;
        }
        .prduct-main-menu
        {
            float: left;
            width: 100%;
            min-width: 980px;
            height: 30px;
            padding-top: 0px;
            padding-bottom: 0px;
        }
        #mycrawler
        {
            float: left;
            width: 100%;
            height: 20px;
            padding-top: 0px;
            padding-bottom: 0px;
        }
        .top-menu-frame
        {
            float: left;
            width: 100%;
            height: 30px;
        }
        .bottom-content-frame
        {
            float: left;
            width: 100%;
        }
        .selected
        {
            background: url('Images/product-menu-hover.png') no-repeat top left !important;
            color: White;
            font-weight: bold;
        }
    </style>
    <style>
        ul, li
        {
            font-size: 14px;
            font-family: Arial, Helvetica, sans-serif;
            line-height: 21px;
            text-align: left;
        }
        #menuMF, #menuNCD, #menuIPO
        {
            list-style: none;
            max-width: 1285px;
            min-width: 940px;
            margin: 0px 15px 1px 17px;
            height: 30px;
            padding: 0px 10px 0px 10px; /* Rounded Corners */
            -moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            border-radius: 10px; /* Background color and gradients */
            background: #01aaeb;
            background: -moz-linear-gradient(top, #01aaeb, #01aaeb);
            background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#01aaeb), to(#01aaeb)); /* Borders */
            -moz-box-shadow: inset 0px 0px 1px #edf9ff;
            -webkit-box-shadow: inset 0px 0px 1px #edf9ff;
            box-shadow: inset 0px 0px 1px #edf9ff;
        }
        #menuMF li, #menuNCD li, #menuIPO li
        {
            float: left;
            display: block;
            text-align: center;
            position: relative;
            padding: 4px 10px 4px 10px;
            margin-right: 30px;
            margin-top: 1px;
            border: none;
        }
        #menuMF li:hover, #menuNCD li:hover, #menuIPO li:hover
        {
            border: 1px solid #777777;
            padding: 4px 9px 4px 9px; /* Background color and gradients */
            background: #014360;
            background: -moz-linear-gradient(top, #014360, #014360);
            background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#014360), to(#014360)); /* Rounded corners */
            -moz-border-radius: 5px 5px 0px 0px;
            -webkit-border-radius: 5px 5px 0px 0px;
            border-radius: 5px 5px 0px 0px;
        }
        #menuMF li a, #menuNCD li a, #menuIPO li a
        {
            font-family: Times New Roman;
            font-size: 14px;
            color: #EEEEEE;
            display: block;
            outline: 0;
            text-decoration: none;
        }
        #menuMF li:hover a, #menuNCD li:hover a, #menuIPO li:hover a
        {
            color: #fff;
            cursor: pointer;
        }
        #menuMF li .drop, #menuNCD li .drop, #menuIPO li .drop
        {
            padding-right: 21px;
            background: url('Images/drop-arrow.png') no-repeat right 8px;
        }
        #menuMF li:hover .drop, #menuNCD li:hover .drop, #menuIPO li:hover .drop
        {
            background: url('Images/drop-arrow-mo.png') no-repeat right 7px;
        }
        .dropdown_1column, .dropdown_2columns, .dropdown_3columns, .dropdown_4columns, .dropdown_5columns
        {
            float: left;
            position: absolute;
            left: -999em; /* Hides the drop down */
            text-align: left;
            z-index: 100;
            border-top: none; /* Gradient background */
            background: #F4F4F4;
            background: -moz-linear-gradient(top, #EEEEEE, #BBBBBB);
            background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#EEEEEE), to(#BBBBBB)); /* Rounded Corners */
        }
        .dropdown_1column
        {
            width: 160px;
        }
        .dropdown_2columns
        {
            width: 280px;
        }
        .dropdown_3columns
        {
            width: 420px;
        }
        .dropdown_4columns
        {
            width: 560px;
        }
        .dropdown_5columns
        {
            width: 700px;
        }
        #menuMF li:hover .dropdown_1column, #menuNCD li:hover .dropdown_1column, #menuIPO li:hover .dropdown_1column
        {
            left: -1px;
            top: auto;
        }
        .col_1, .col_2, .col_3, .col_4, .col_5
        {
            display: inline;
            float: left;
            position: relative;
        }
        .col_1
        {
            width: 160px;
        }
        .col_2
        {
            width: 270px;
        }
        .col_3
        {
            width: 410px;
        }
        .col_4
        {
            width: 550px;
        }
        .col_5
        {
            width: 690px;
        }
        #menuMF .menu_right, #menuNCD .menu_right, #menuIPO .menu_right
        {
            float: right;
            margin-right: 0px;
        }
        #menuMF li .align_right, #menuNCD li .align_right, #menuIPO li .align_right
        {
            /* Rounded Corners */
            -moz-border-radius: 5px 0px 5px 5px;
            -webkit-border-radius: 5px 0px 5px 5px;
            border-radius: 5px 0px 5px 5px;
        }
        #menuMF li:hover .align_right, #menuNCD li:hover .align_right, #menuIPO li:hover .align_right
        {
            left: auto;
            right: -1px;
            top: auto;
        }
        #menuMF p, #menuMF h2, #menuMF h3, #menuMF ul li, #menuNCD p, #menuNCD h2, #menuNCD h3, #menuNCD ul li, #menuIPO p, #menuIPO h2, #menuIPO h3, #menuIPO ul li
        {
            font-family: Arial, Helvetica, sans-serif;
            line-height: 21px;
            font-size: 12px;
            text-align: left;
        }
        #menuMF h2, #menuNCD h2, #menuIPO h2
        {
            font-size: 21px;
            font-weight: 400;
            letter-spacing: -1px;
            margin: 7px 0 14px 0;
            padding-bottom: 14px;
            border-bottom: 1px solid #666666;
        }
        #menuMF h3, #menuNCD h3, #menuIPO h3
        {
            font-size: 14px;
            margin: 7px 0 14px 0;
            padding-bottom: 7px;
            border-bottom: 1px solid #888888;
        }
        #menuMF p, #menuNCD p, #menuIPO p
        {
            line-height: 18px;
            margin: 0 0 10px 0;
        }
        #menuMF li:hover div a, #menuNCD li:hover div a, #menuIPO li:hover div a
        {
            font-size: 12px;
            color: #fff;
        }
        #menuMF li:hover div a:hover, #menuNCD li:hover div a:hover, #menuIPO li:hover div a:hover
        {
            color: #fff;
        }
        .strong
        {
            font-weight: bold;
        }
        .italic
        {
            font-style: italic;
        }
        .imgshadow
        {
            /* Better style on light background */
            background: #FFFFFF;
            padding: 4px;
            border: 1px solid #777777;
            margin-top: 5px;
            -moz-box-shadow: 0px 0px 5px #666666;
            -webkit-box-shadow: 0px 0px 5px #666666;
            box-shadow: 0px 0px 5px #666666;
        }
        .img_left
        {
            /* Image sticks to the left */
            width: auto;
            float: left;
            margin: 5px 15px 5px 5px;
        }
        #menuMF li .black_box, #menuNCD li .black_box, #menuIPO li .black_box
        {
            background-color: #333333;
            color: #eeeeee;
            text-shadow: 1px 1px 1px #000;
            padding: 4px 6px 4px 6px; /* Rounded Corners */
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px; /* Shadow */
            -webkit-box-shadow: inset 0 0 3px #000000;
            -moz-box-shadow: inset 0 0 3px #000000;
            box-shadow: inset 0 0 3px #000000;
        }
        #menuMF li ul, #menuNCD li ul, #menuIPO li ul
        {
            list-style: none;
            padding: 0;
        }
        #menuMF li ul li, #menuNCD li ul li, #menuIPO li ul li
        {
            font-size: 12px;
            line-height: 24px;
            position: relative;
            padding: 0;
            margin: 0;
            float: none;
            text-align: left;
            width: 160px;
        }
        #menuMF li ul li:hover, #menuNCD li ul li:hover, #menuIPO li ul li:hover
        {
            background: none;
            border: none;
            padding: 0;
            margin: 0;
        }
        #menuMF li .greybox li, #menuNCD li .greybox li, #menuIPO li .greybox li
        {
            background: #014360;
            border: 1px solid #bbbbbb;
            padding: 4px 6px 4px 6px;
            width: 160px; /* Rounded Corners */
        }
        #menuMF li .greybox li:hover, #menuNCD li .greybox li:hover, #menuIPO li .greybox li:hover
        {
            color: #ffffff;
            border: 1px solid #bbbbbb;
            background: #01aaeb;
            padding: 4px 6px 4px 6px;
            width: 160px; /* Rounded Corners */
        }
        #lisearchscheme, #Div1
        {
            margin-top: 1px;
        }
        #lisearchscheme input, #Div1 input
        {
            height: 28px;
            width: 100%;
            margin-top: 2px;
            padding: 0 12px 0 25px;
            background: white url("http://cssdeck.com/uploads/media/items/5/5JuDgOa.png") 8px 6px no-repeat;
            border-width: 1px;
            border-style: solid;
            border-color: #a8acbc #babdcc #c0c3d2;
            border-radius: 13px;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            -ms-box-sizing: border-box;
            -o-box-sizing: border-box;
            box-sizing: border-box;
        }
        #lisearchscheme input:focus, #Div1 input:focus
        {
            outline: none;
            border-color: #66b1ee;
            -webkit-box-shadow: 0 0 2px rgba(85, 168, 236, 0.9);
            -moz-box-shadow: 0 0 2px rgba(85, 168, 236, 0.9);
            -ms-box-shadow: 0 0 2px rgba(85, 168, 236, 0.9);
            -o-box-shadow: 0 0 2px rgba(85, 168, 236, 0.9);
            box-shadow: 0 0 2px rgba(85, 168, 236, 0.9);
        }
        .results
        {
            position: relative;
            top: 35px;
            left: 0;
            right: 0;
            z-index: 10;
            padding: 0;
            margin: 0;
            border-width: 1px;
            border-style: solid;
            border-color: #cbcfe2 #c8cee7 #c4c7d7;
            border-radius: 3px;
            background-color: #fdfdfd;
            background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #fdfdfd), color-stop(100%, #eceef4));
            background-image: -webkit-linear-gradient(top, #fdfdfd, #eceef4);
            background-image: -moz-linear-gradient(top, #fdfdfd, #eceef4);
            background-image: -ms-linear-gradient(top, #fdfdfd, #eceef4);
            background-image: -o-linear-gradient(top, #fdfdfd, #eceef4);
            background-image: linear-gradient(top, #fdfdfd, #eceef4);
            -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            -ms-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            -o-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            visiblity: hidden;
        }
        .resultschild
        {
            display: block;
        }
        .results div
        {
            display: block;
            position: relative;
            margin: 0 -1px;
            padding: 6px 40px 6px 10px;
            color: #808394;
            font-weight: 500;
            text-shadow: 0 1px #fff;
            border: 1px solid transparent;
            border-radius: 3px;
            visiblity: hidden;
        }
        .results div
        {
            font-weight: 100;
        }
        .results div:hover
        {
            text-decoration: none;
            color: White;
            cursor: pointer;
            text-shadow: 0 -1px rgba(0, 0, 0, 0.3);
            border-color: #2380dd #2179d5 #1a60aa;
            background-color: #338cdf;
            background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #59aaf4), color-stop(100%, #338cdf));
            background-image: -webkit-linear-gradient(top, #59aaf4, #338cdf);
            background-image: -moz-linear-gradient(top, #59aaf4, #338cdf);
            background-image: -ms-linear-gradient(top, #59aaf4, #338cdf);
            background-image: -o-linear-gradient(top, #59aaf4, #338cdf);
            background-image: linear-gradient(top, #59aaf4, #338cdf);
            -webkit-box-shadow: inset 0 1px rgba(255, 255, 255, 0.2), 0 1px rgba(0, 0, 0, 0.08);
            -moz-box-shadow: inset 0 1px rgba(255, 255, 255, 0.2), 0 1px rgba(0, 0, 0, 0.08);
            -ms-box-shadow: inset 0 1px rgba(255, 255, 255, 0.2), 0 1px rgba(0, 0, 0, 0.08);
            -o-box-shadow: inset 0 1px rgba(255, 255, 255, 0.2), 0 1px rgba(0, 0, 0, 0.08);
            box-shadow: inset 0 1px rgba(255, 255, 255, 0.2), 0 1px rgba(0, 0, 0, 0.08);
        }
        :-moz-placeholder
        {
            color: White;
            font-weight: 100;
        }
        ::-webkit-input-placeholder
        {
            color: White;
            font-weight: 100;
        }
        .lblMode
        {
            text-align: center;
            color: White;
            font-size: medium;
            font-family: Times New Roman;
            font-weight: bold;
        }
        #ddlMode
        {
            height: 28px;
        }
        #btnMode
        {
            height: 29px;
        }
    </style>
    
   
    <asp:HiddenField ID="hidUserLogOutPageUrl" Value="" runat="server" />
    <asp:HiddenField ID="hidUserLogInPageUrl" Value="" runat="server" />
    <div>
        <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true" />
        <div class="div-with-header">
            <div style="float: right; width: 10%; padding-top: 8px; padding-right: 28%;">
                <asp:ImageButton ID="imgbtn" runat="server" ImageUrl="../Images/sign-out.png" OnClick="lnkLogOut_Click">
                </asp:ImageButton>
            </div>
            <div style="float: right; width: 15%; padding-top: 10px; padding-right: 3%;">
                <asp:Label ID="lblWelcomeUser" runat="server" Text="" CssClass="user-name"></asp:Label>
                <asp:Label ID="lblTest" runat="server" Text="" CssClass="user-name" Visible="false"></asp:Label>
            </div>
        </div>
        <div class="product-header" style="float: left; clear: both;">
            <asp:Label ID="lblOnlieProductType" runat="server" Text="" CssClass="product-header-text"></asp:Label>
        </div>
        <div id="dvScrollerCnt" class="col-md-12" style="margin: 2px 15px 5px 15px; padding: 0px 0px 0px 0px;
            font-family: Times New Roman; clear: both; height: 20px; color: #fff; background: #000;
            max-width: 1285px; min-width: 940px;">
            <div class="col-md-1" style="width: 6%; padding-right: 0px; margin-right: 0px; padding-left: 1px;
                color: #000; background: #fff">
                <b>What's New </b>
            </div>
            <div id="scroller" runat="server" class="col-md-11" style="padding: 0px 0px 0px 1px">
                <marquee style="border-radius: 2px; font-size: small" direction="left" scrolldelay="150"
                    onmouseover="this.stop();" onmouseout="this.start();">
        <asp:datalist ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="heading" ItemStyle-Wrap="False" id="dlScroller" CellPadding="2"  RepeatDirection="Horizontal" CellSpacing="2" Runat="server">
     <ItemTemplate>
          <asp:Label ID="lblScroller" Text='<%# DataBinder.Eval(Container.DataItem,"PUHD_HelpDetails")%>' Runat="server">
          </asp:Label><br>
     </ItemTemplate>
     <SeparatorTemplate>
          <span>|||</span>
     </SeparatorTemplate>
</asp:datalist>
</marquee>
            </div>
        </div>
        <div id="mainmenuMF" runat="server" style="width: 100%; clear: both;">
            <ul id="menuMF">
                <li>
                    <asp:LinkButton ID="MFSchemeRelateInformation" runat="server" OnClick="MenuLink_Click"
                        CommandName="LoadBottomPanelControl('MFSchemeRelateInformation','login');">HOME</asp:LinkButton>
                </li>
                <li><a onclick="" class="drop">MARKET</a>
                    <div class="dropdown_1column">
                        <div class="col_1">
                            <ul class="greybox">
                                <li>
                                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('OnlineMFSchemeCompare','login');">SCHEME COMPARE</asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('MFSchemeRelateInformation','?FilterType=NFO');">NFO</asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="LinkButton6" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('MFSchemeRelateInformation','?FilterType=watchList');">MY WATCHLIST</asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="LinkButton7" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('ProductOnlineFundNews','login');">NEWS</asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li><a onclick="" class="drop">BOOKS</a>
                    <div class="dropdown_1column">
                        <div class="col_1">
                            <ul class="greybox">
                                <li>
                                    <asp:LinkButton ID="LinkButton8" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('OnlineCustomerOrderandTransactionBook','login');">ORDER BOOK</asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="LinkButton4" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('SIPBookSummmaryList','?systematicType=SIP');">SIP BOOK</asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li><a class="drop">HOLDINGS</a>
                    <div class="dropdown_1column">
                        <div class="col_1">
                            <ul class="greybox">
                                <li>
                                    <asp:LinkButton ID="LinkButton9" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('CustomerMFUnitHoldingList','login');">MF HOLDINGS</asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="menu_right">
                    <asp:LinkButton ID="LinkButton10" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('FAQandDemo','?Cat=MF&TYP=FAQ');">FAQ</asp:LinkButton>
                </li>
                <li class="menu_right">
                    <asp:LinkButton ID="LinkButton5" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('FAQandDemo','?Cat=MF&TYP=Demo');">Demo</asp:LinkButton>
                </li>
                <div class="menu_right" style="padding-right: 30px; vertical-align: middle; height: 28px; ">
                    <asp:Button ID="btnMode" Text='Go' runat="server" OnClick="btnMode_OnClick"></asp:Button>
                </div>
                <div class="menu_right" style="padding-right: 10px; padding-top: 1px; vertical-align: middle; ">
                    <asp:DropDownList ID="ddlMode" runat="server" CssClass="form-control input-sm" AutoPostBack="false">
                        <asp:ListItem Text="Online" Value="Online"></asp:ListItem>
                        <asp:ListItem Text="Exchange" Value="Demat"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="menu_right" style="padding-right: 10px; vertical-align: middle; padding-top: 4px; ">
                    <asp:Label ID="lblMode" runat="server" Text="Mode:" CssClass="lblMode"></asp:Label>
                </div>
                <div class="menu_right" style="padding-right: 10px; vertical-align: middle; padding-top: 6px; ">
                  <img  data-toggle="tooltip"  data-placement="bottom" title="Now you can place an order with Exchange from here , Select Mode:Exchange"
                        src="Images/new_icon.gif" />
                     
                </div>
                <div id="lisearchscheme" class="menu_right" style="padding-right: 70px">
                    <asp:TextBox runat="server" ID="SchemeSearch" AutoPostBack="true" OnTextChanged="SchemeSearch_OnTextChanged"
                        Style="margin-top: 0px; float: right; background-color: #D7E9F5" Width="300px"></asp:TextBox>
                    <cc1:TextBoxWatermarkExtender ID="txtSchemeName_water" TargetControlID="SchemeSearch"
                        WatermarkText="Search Scheme" runat="server" EnableViewState="false">
                    </cc1:TextBoxWatermarkExtender>
                    <div id="listPlacement" style="text-align: left; z-index: 300; cursor: pointer;">
                    </div>
                    <ajaxToolkit:AutoCompleteExtender ID="txtSchemeName_AutoCompleteExtender" runat="server"
                        TargetControlID="SchemeSearch" ServiceMethod="GetInvestorScheme" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                        MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="5" CompletionInterval="100"
                        UseContextKey="True" OnClientItemSelected="GetSchemePlanCode" DelimiterCharacters=""
                        CompletionListElementID="listPlacement" Enabled="True" />
                </div>
            </ul>
        </div>
        <div id="mainmenuNCD" runat="server" style="width: 100%; clear: both;">
            <ul id="menuNCD">
                <li><a onclick="" class="drop">TRANSACT</a>
                    <div class="dropdown_1column">
                        <div class="col_1">
                            <ul class="greybox">
                                <li>
                                    <asp:LinkButton ID="LinkButton11" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('NCDIssueList','?BondType=FISDSD');">NCD ISSUE LIST</asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="LinkButton12" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('NCDIssueList','?BondType=FISSGB');">SGB ISSUE LIST</asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="LinkButton13" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('NCDIssueList','?BondType=FITFTF');">NCD TAX FREE LIST</asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li><a onclick="" class="drop">BOOKS</a>
                    <div class="dropdown_1column">
                        <div class="col_1">
                            <ul class="greybox">
                                <li>
                                    <asp:LinkButton ID="LinkButton14" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('NCDIssueBooks','?BondType=FISDSD');">NCD BOOK</asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="LinkButton15" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('NCDIssueBooks','?BondType=FISSGB');">SGB BOOK</asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="LinkButton16" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('NCDIssueBooks','?BondType=FITFTF');">NCD TAX FREE BOOK</asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li><a>HOLDINGS</a>
                    <div class="dropdown_1column">
                        <div class="col_1">
                            <ul class="greybox">
                                <li>
                                    <asp:LinkButton ID="LinkButton17" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('NCDIssueHoldings','?BondType=FISDSD');">NCD HOLDINGS</asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="LinkButton18" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('NCDIssueHoldings','?BondType=FISSGB');">SGB HOLDINGS</asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="LinkButton19" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('NCDIssueHoldings','?BondType=FITFTF');">NCD TAX FREE HOLDINGS</asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="menu_right">
                    <asp:LinkButton ID="LinkButton20" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('FAQandDemo','?Cat=NCD&TYP=FAQ');">FAQ</asp:LinkButton>
                </li>
                <li class="menu_right">
                    <asp:LinkButton ID="LinkButton21" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('FAQandDemo','?Cat=NCD&TYP=Demo');">Demo</asp:LinkButton>
                </li>
            </ul>
        </div>
        <div id="mainmenuIPO" runat="server" style="width: 100%; clear: both;">
            <ul id="menuIPO">
                <li><a onclick="" class="drop">TRANSACT</a>
                    <div class="dropdown_1column">
                        <div class="col_1">
                            <ul class="greybox">
                                <li>
                                    <asp:LinkButton ID="LinkButton22" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('IPOIssueList','login');">IPO/FPO ISSUE LIST</asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li><a onclick="" class="drop">BOOKS</a>
                    <div class="dropdown_1column">
                        <div class="col_1">
                            <ul class="greybox">
                                <li>
                                    <asp:LinkButton ID="LinkButton23" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('CustomerIPOOrderBook','login');">IPO/FPO BOOK</asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li><a>HOLDINGS</a>
                    <div class="dropdown_1column">
                        <div class="col_1">
                            <ul class="greybox">
                                <li>
                                    <asp:LinkButton ID="LinkButton24" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('CustomerIPOHolding','login');">IPO/FPO HOLDINGS</asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="menu_right">
                    <asp:LinkButton ID="LinkButton25" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('FAQandDemo','?Cat=IPO&TYP=FAQ');">FAQ</asp:LinkButton>
                </li>
                <li class="menu_right">
                    <asp:LinkButton ID="LinkButton26" runat="server" OnClick="MenuLink_Click" CommandName="LoadBottomPanelControl('FAQandDemo','?Cat=IPO&TYP=Demo');">Demo</asp:LinkButton>
                </li>
            </ul>
        </div>
        <div runat="server" class="col-md-12" style="margin: 2px 15px 15px 15px; padding: 0px 0px 0px 0px;
            max-width: 1285px; min-width: 940px; clear: both; height: 20px; color: #fff;
            background: #000; font-family: Times New Roman;" id="dvNews">
            <div class="col-md-1" style="width: 6%; padding-right: 0px; margin-right: 0px; padding-left: 1px;
                color: #000; background: #fff">
                <b>Fund News </b>
            </div>
            <div style="padding-left: 0px;" class="col-md-11">
                <marquee direction="left" scrolldelay="150" onmouseover="this.stop();" onmouseout="this.start();"
                    style="border-radius: 2px;">
        <asp:datalist ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="heading" ItemStyle-Wrap="False" id="dlNews" CellPadding="2"  RepeatDirection="Horizontal" CellSpacing="2" Runat="server">
    
     <ItemTemplate>
          <asp:Label ID="lblNews" Text='<%# DataBinder.Eval(Container.DataItem,"heading")%>' Runat="server">
          </asp:Label><br>
     </ItemTemplate>
     <SeparatorTemplate>
          <span>|||</span>
     </SeparatorTemplate>
</asp:datalist>
</marquee>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal" role="dialog" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <%-- <button type="button" class="close" data-dismiss="modal">
                        &times;</button>--%>
                    <asp:Button ID="Button2" runat="server" Text="&times;" OnClick="btnDematTnCCanceled_Click"
                        CssClass="close" />
                    <h4 class="modal-title">
                        BSE STAR AGREEMENT</h4>
                </div>
                <div class="modal-body well">
                    <iframe src="../ReferenceFiles/DematConsentLetter.htm" name="iframeconsentLetter"
                        style="width: 100%; height: 600px"></iframe>
                    <div class="row">
                        <div class="col-sm-4">
                        </div>
                        <div class="col-sm-2">
                            <asp:Button ID="btnDematTnCAccepted" runat="server" Text="Submit" OnClick="btnDematTnCAccepted_Click"
                                CssClass="btn btn-md btn-info " />
                        </div>
                        <div class="col-sm-2">
                            <asp:Button ID="btnDematTnCCanceled" runat="server" Text="Cancel" OnClick="btnDematTnCCanceled_Click"
                                CssClass="btn btn-info " />
                        </div>
                        <div class="col-sm-4">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="margin-top: 10px; z-index: 3;">
        <iframe name="bottomframe" class="bottomframe" width="100%" id="bottomframe" onload="javascript:calcIFrameHeight('bottomframe');"
            src="OnlineBottomHost.aspx" scrolling="no"></iframe>
    </div>
     
    <div id="dvTransact" runat="server" style="clear: both; background-color: #E5F6FF;
        font-weight: bold; font-size: smaller">
        <div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div style="clear: both;">
                        <asp:Button ID="btnBindTransactDdl" runat="server" Style="display: none" OnClick="BindTransactDdl" />
                    </div>
                    <div style="background-color: #0396CC; width: 100%">
                        <div style="padding-left: 20px; color: White;">
                            Transact
                            <asp:Label ID="lblBalance" runat="server" Style="color: White; float: right; padding-right: 20px;
                                margin-left: 10px;"></asp:Label>
                            <b style="color: White; float: right;">Available Balance:</b>
                        </div>
                    </div>
                    <table style="margin: 0 0 0 50px;">
                        <tr>
                            <td>
                                <div id="Div1">
                                    <asp:TextBox runat="server" ID="TextBox1" AutoPostBack="true" OnTextChanged="TextBox1_OnTextChanged"
                                        Style="margin-top: 0px; float: right; background-color: #D7E9F5" Width="300px"></asp:TextBox>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" TargetControlID="TextBox1"
                                        WatermarkText="Search Scheme" runat="server" EnableViewState="false">
                                    </cc1:TextBoxWatermarkExtender>
                                    <div id="Div2" style="text-align: left; z-index: 300; font-style: normal; cursor: pointer;
                                        font-weight: normal; font-size: small">
                                    </div>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="TextBox1"
                                        ServiceMethod="GetInvestorScheme" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                                        MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="5" CompletionInterval="100"
                                        UseContextKey="True" OnClientItemSelected="GetTransactPanelSchemePlanCode" DelimiterCharacters=""
                                        CompletionListElementID="Div2" Enabled="True" />
                                </div>
                            </td>
                            <td align="right" style="vertical-align: middle; display: none;">
                                <asp:Label ID="lblchannel" runat="server" Text="Exchange:" CssClass="FieldName"></asp:Label>
                            </td>
                            <td style="vertical-align: middle; display: none;">
                                <asp:DropDownList ID="ddlchannel" runat="server" CssClass="cmbField" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlchannel_onSelectedChanged">
                                </asp:DropDownList>
                            </td>
                            <td align="right" style="vertical-align: middle;">
                                <asp:Label ID="Label2" runat="server" Text="Transaction Type:" CssClass="FieldName"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="cmbField" AutoPostBack="true"
                                    OnSelectedIndexChanged="DropDownList1_OnSelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div class="top-menu-frame" style="position: Relative">
            <iframe name="topframe" id="topframe" onload="javascript:calcIFrameHeight('topframe');"
                src="OnlineTopHost.aspx" width="100%" scrolling="no"></iframe>
        </div>
    </div>
    <asp:HiddenField ID="schemeCode" runat="server" />
    <asp:HiddenField ID="hdnTransactType" runat="server" />

 
    </form>
</body>
</html>
