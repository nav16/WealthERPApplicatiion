﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OnlineNCDIssueSetup.ascx.cs"
    Inherits="WealthERP.OnlineOrderBackOffice.OnlineNCDIssueSetup" %>
<asp:ScriptManager ID="scrptMgr" runat="server">
    <Services>
        <asp:ServiceReference Path="AutoComplete.asmx" />
    </Services>
</asp:ScriptManager>

<script type="text/javascript">
    var popUp;
    function PopUpShowing(sender, eventArgs) {
        popUp = eventArgs.get_popUp();
        var gridWidth = sender.get_element().offsetWidth;
        var gridHeight = sender.get_element().offsetHeight;
        var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
        var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
        popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
        popUp.style.top = ((gridHeight - popUpHeight) / 2 + sender.get_element().offsetTop).toString() + "px";
    } 
</script>

<style type="text/css">
    .table
    {
        border: 1px solid orange;
    }
    .leftLabel
    {
        width: 18%;
        text-align: right;
    }
    .rightData
    {
        width: 18%;
        text-align: left;
    }
</style>
<%-- <asp:Panel ID="Panel2" runat="server" CssClass="Landscape" Width="100%" ScrollBars="Horizontal">--%>
<table width="100%">
    <tr>
        <td>
            <div class="divPageHeading">
                <table cellspacing="0" cellpadding="3" width="100%">
                    <tr>
                        <td align="left">
                            NCD Issue Setup
                        </td>
                        <td align="right">
                            <asp:LinkButton ID="lnkBtnEdit" runat="server" CssClass="LinkButtons" Text="Edit"
                                OnClick="lnkBtnEdit_Click"></asp:LinkButton>
                            &nbsp; &nbsp;
                            <asp:LinkButton runat="server" ID="lnlBack" CssClass="LinkButtons" Text="Back" Visible="false"
                                OnClick="lnlBack_Click"></asp:LinkButton>&nbsp; &nbsp;
                            <asp:LinkButton runat="server" ID="lnkDelete" CssClass="LinkButtons" Text="Delete"
                                OnClientClick="javascript: return confirm('Are you sure you want to Delete the Order?')"></asp:LinkButton>&nbsp;
                            <%-- OnClick="lnkDelete_Click"--%>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<%--<telerik:RadWindow ID="radwindowPopup" runat="server" VisibleOnPageLoad="false" Height="30%"
    Width="400px" Modal="true" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="None"
    Title="Add New Folio">
    <ContentTemplate>
        <div style="padding: 20px">
            <table width="100%">
                <tr>
                    <td class="leftField" style="width: 10%">
                        <asp:Label ID="lb1IssuerName" runat="server" Text="Issuer Name: " CssClass="FieldName"></asp:Label>
                    </td>
                    <td>
                     <asp:TextBox ID="txtIssuer" runat="server" CssClass="txtField"></asp:TextBox><br />
                        <span id="Span21"></span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator33" ControlToValidate="txtIssuer" ErrorMessage="Please enter Issue name"
                            ValidationGroup="vgOK" Display="Dynamic" runat="server" CssClass="rfvPCG">
                        </asp:RequiredFieldValidator>
                    </td>
                     
                </tr>
                <tr>
                    <td class="leftField" style="width: 10%">
                        <asp:Label ID="lb1IssuerCode" runat="server" Text="Issuer Code: " CssClass="FieldName"></asp:Label>
                    </td>
                    <td class="rightField" style="width: 25%">
                        <asp:TextBox ID="txtNewFolio" runat="server" CssClass="txtField"></asp:TextBox><br />
                        <span id="spnNewFolioValidation"></span>
                        <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="txtNewFolio" ErrorMessage="Please enter folio name"
                            ValidationGroup="vgOK" Display="Dynamic" runat="server" CssClass="rfvPCG">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="leftField" style="width: 10%">
                        <asp:Button ID="btnSubmitFolio" runat="server" Text="Submit" CssClass="PCGButton"
                            OnClick="btnOk_Click" ValidationGroup="vgOK" />
                    </td>
                    <td class="rightField" style="width: 25%">
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="PCGButton" CausesValidation="false"
                            OnClick="btnCancel_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </ContentTemplate>
</telerik:RadWindow>--%>
<table width="80%" runat="server" id="tbIssue">
    <tr>
        <td class="leftLabel">
            <asp:Label ID="lb1Product" runat="server" Text="Product:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:DropDownList ID="ddlProduct" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="205px" OnSelectedIndexChanged="ddlProduct_Selectedindexchanged">
                <asp:ListItem Value="Select">Select</asp:ListItem>
                <asp:ListItem Value="IP">IPO</asp:ListItem>
                <asp:ListItem Value="NCD">Bonds</asp:ListItem>
            </asp:DropDownList>
            <span id="Span7" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Select Product"
                CssClass="rfvPCG" ControlToValidate="ddlProduct" ValidationGroup="SetUpSubmit"
                Display="Dynamic" InitialValue="Select"></asp:RequiredFieldValidator>
        </td>
        <td class="leftLabel" ID="tdlblCategory" runat="server" >
            <asp:Label ID="lblCategory" runat="server" Text="Category:" CssClass="FieldName"></asp:Label>
        </td>
        <td align="rightData" ID="tdddlCategory" runat="server">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="205px">
                <asp:ListItem Value="Select">Select</asp:ListItem>
                <asp:ListItem Value="NCD">NCD</asp:ListItem>
                <asp:ListItem Value="Infrastructurebonds">Infrastructure bonds</asp:ListItem>
            </asp:DropDownList>
            <span id="Span4" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select Category"
                CssClass="rfvPCG" ControlToValidate="ddlProduct" ValidationGroup="SetUpSubmit"
                Display="Dynamic" InitialValue="Select"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="leftLabel">
            <asp:Label ID="lb1Name" runat="server" Text="Name:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtName" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span12" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please Enter Name"
                CssClass="rfvPCG" ControlToValidate="txtName" ValidationGroup="SetUpSubmit" Display="Dynamic"
                InitialValue=""></asp:RequiredFieldValidator>
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1Issuer" runat="server" Text="Issuer:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:DropDownList ID="ddlIssuer" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="205px">
            </asp:DropDownList>
            <span id="Span10" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Select Issuer"
                CssClass="rfvPCG" ControlToValidate="ddlIssuer" ValidationGroup="SetUpSubmit"
                Display="Dynamic" InitialValue="Select"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="leftLabel">
            <asp:Label ID="lb1ActiveFormRange" runat="server" Text="Active Form Range:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtFormRange" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span13" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Please Enter FromRange"
                CssClass="rfvPCG" ControlToValidate="txtFormRange" ValidationGroup="SetUpSubmit"
                Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator2" ControlToValidate="txtFormRange" runat="server"
                ControlToCompare="txtToRange" Display="Dynamic" ErrorMessage="From range Should Be Greater Than To Range"
                Type="Double" Operator="LessThan" CssClass="cvPCG"></asp:CompareValidator>
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1ToRange" runat="server" Text="To:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtToRange" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span14" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please Enter ToRange"
                CssClass="rfvPCG" ControlToValidate="txtToRange" ValidationGroup="SetUpSubmit"
                Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator3" ControlToValidate="txtToRange" runat="server"
                ControlToCompare="txtFormRange" Display="Dynamic" ErrorMessage="To range Should Be Less Than To Range"
                Type="Double" Operator="GreaterThan" CssClass="cvPCG"></asp:CompareValidator>
        </td>
    </tr>
    <tr id="trIssueTypes" runat="server">
        <td class="leftLabel">
            <asp:Label ID="Label6" runat="server" Text="Issue Type:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:DropDownList ID="ddlIssueType" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlIssueType_Selectedindexchanged"
                AutoPostBack="true" Width="205px">
                <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                <asp:ListItem Text="Book Building(%)" Value="BookBuilding"></asp:ListItem>
                <asp:ListItem Text="FixedPrice" Value="FixedPrice"></asp:ListItem>
            </asp:DropDownList>
            <span id="Span21" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator33" runat="server" ErrorMessage="Please Enter FromRange"
                CssClass="rfvPCG" ControlToValidate="ddlIssueType" ValidationGroup="SetUpSubmit"
                Display="Dynamic" InitialValue="Select"></asp:RequiredFieldValidator>
        </td>
        <td colspan="2">
            &nbsp;
        </td>
    </tr>
    <tr id="trBookBuildingAndCapprices" runat="server">
        <td class="leftLabel" id="tdBookBuilding" runat="server">
            <asp:Label ID="Label7" runat="server" Text="Book Building(%):" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtBookBuildingPer" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span26" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator34" runat="server" ErrorMessage="Please Enter BookBuilding Percentage"
                CssClass="rfvPCG" ControlToValidate="txtBookBuildingPer" ValidationGroup="SetUpSubmit"
                Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
        </td>
        <td class="leftLabel">
            <asp:Label ID="Label9" runat="server" Text="Cap Price:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtCapPrice" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span28" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator36" runat="server" ErrorMessage="Please Enter Cap Price"
                CssClass="rfvPCG" ControlToValidate="txtCapPrice" ValidationGroup="SetUpSubmit"
                Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr id="trFloorAndFixedPrices" runat="server">
        <td id="tdLbFloorPrice" runat="server" class="leftLabel">
            <asp:Label ID="Label11" runat="server" Text="Floor Price:" CssClass="FieldName"></asp:Label>
        </td>
        <td id="tdTxtFloorPrice" runat="server" class="rightData">
            <asp:TextBox ID="txtFloorPrice" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span27" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator35" runat="server" ErrorMessage="Please Enter Floor Price"
                CssClass="rfvPCG" ControlToValidate="txtFloorPrice" ValidationGroup="SetUpSubmit"
                Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator5" Display="Dynamic" ValidationGroup="SetUpSubmit"
                runat="server" ErrorMessage="Date of Floor Price between 1 to 999999999"
                ControlToValidate="txtFloorPrice" MaximumValue="999999999" MinimumValue="1" Type="Integer"
                CssClass="cvPCG"></asp:RangeValidator>
        </td>
        <td id="tdLbFixedPrice" runat="server" class="leftLabel">
            <asp:Label ID="Label10" runat="server" Text="Fixed Price:" CssClass="FieldName"></asp:Label>
        </td>
        <td id="tdtxtFixedPrice" runat="server" class="rightData">
            <asp:TextBox ID="txtFixedPrice" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span29" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator37" runat="server" ErrorMessage="Please Enter Fixed Price"
                CssClass="rfvPCG" ControlToValidate="txtFixedPrice" ValidationGroup="SetUpSubmit"
                Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator4" Display="Dynamic" ValidationGroup="SetUpSubmit"
                runat="server" ErrorMessage="<br />Date of Fixed Price between 1 to 999999999"
                ControlToValidate="txtFixedPrice" MaximumValue="999999999" MinimumValue="1" Type="Integer"
                CssClass="cvPCG"></asp:RangeValidator>
        </td>
    </tr>
    <tr id="trSyndicateAndMemberCodes" runat="server">
        <td id="Td1" runat="server" class="leftLabel">
            <asp:Label ID="Label8" runat="server" Text="Syndicate Member:" CssClass="FieldName"></asp:Label>
        </td>
        <td id="Td2" runat="server" class="rightData">
            <asp:TextBox ID="txtSyndicateMemberCode" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
        </td>
        <td id="Td3" runat="server" class="leftLabel">
            <asp:Label ID="Label12" runat="server" Text="Broker:" CssClass="FieldName"></asp:Label>
        </td>
        <td id="Td4" runat="server" class="rightData">
            <asp:TextBox ID="txtBrokerCode" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
        </td>
    </tr>
    <tr id="trRegistrarAndNoofBidsAlloweds" runat="server">
        <td id="Td5" runat="server" class="leftLabel">
            <asp:Label ID="Label13" runat="server" Text="Registrar:" CssClass="FieldName"></asp:Label>
        </td>
        <td id="Td6" runat="server" class="rightData">
            <asp:TextBox ID="txtRegistrar" runat="server" CssClass="txtField"></asp:TextBox>
        </td>
        <td id="Td7" runat="server" class="leftLabel">
            <asp:Label ID="Label14" runat="server" Text="No Of Bids Allowed:" CssClass="FieldName"></asp:Label>
        </td>
        <td id="Td8" runat="server" class="rightData">
            <asp:TextBox ID="txtNoOfBids" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="leftLabel">
            <asp:Label ID="lb1InitialCqNo" runat="server" Text="Initial Cheque Number:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtInitialCqNo" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1FaceValue" runat="server" Text="Face Value:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtFaceValue" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span16" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Face Value" Display="Dynamic" ControlToValidate="txtFaceValue"
                InitialValue="" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator9" ControlToValidate="txtFaceValue" runat="server"
                Display="Dynamic" ErrorMessage="<br />Please enter a numeric value" Type="Double"
                Operator="DataTypeCheck" CssClass="cvPCG"></asp:CompareValidator>
        </td>
    </tr>
    <tr id="trModeofIssue" runat="server">
        <td class="leftLabel" runat="server" visible="false">
            <asp:Label ID="lb1Price" runat="server" Text="Price (floor and fixed):" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData" runat="server" visible="false">
            <asp:TextBox ID="txtPrice" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span17" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Price" Display="Dynamic" ControlToValidate="txtPrice"
                InitialValue="" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" ControlToValidate="txtPrice" runat="server"
                Display="Dynamic" ErrorMessage="Please enter a numeric value" Type="Double" Operator="DataTypeCheck"
                CssClass="cvPCG"></asp:CompareValidator>
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1ddlModeofIssue" runat="server" Text="Mode of Issue:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:DropDownList ID="ddlModeofIssue" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="205px">
                <asp:ListItem Value="Select">Select</asp:ListItem>
                <asp:ListItem Value="Dematerialized">Dematerialized</asp:ListItem>
                <asp:ListItem Value="Physical">Physical</asp:ListItem>
                <asp:ListItem Value="Both">Both</asp:ListItem>
            </asp:DropDownList>
            <span id="Span9" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Select Mode of Issue" Display="Dynamic" ControlToValidate="ddlModeofIssue"
                InitialValue="Select" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr id="trRatingAndModeofTrading" runat="server">
        <td class="leftLabel">
            <asp:Label ID="lb1Rating" runat="server" Text="Rating:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtRating" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1ModeOfTrading" runat="server" Text="Mode Of Trading:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:DropDownList ID="ddlModeOfTrading" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="205px">
                <asp:ListItem Value="Select">Select</asp:ListItem>
                <asp:ListItem Value="Dematerialized">Dematerialized</asp:ListItem>
                <asp:ListItem Value="Physical">Physical</asp:ListItem>
                <asp:ListItem Value="Both">Both</asp:ListItem>
            </asp:DropDownList>
            <span id="Span11" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Select Mode Of Trading" Display="Dynamic" ControlToValidate="ddlModeOfTrading"
                InitialValue="Select" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="leftLabel">
            <asp:Label ID="lb1Opendate" runat="server" Text="Open Date:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <telerik:RadDatePicker ID="txtOpenDate" CssClass="txtField" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01"
                TabIndex="17" Width="200px">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <span id="Span18" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Open Date" Display="Dynamic" ControlToValidate="txtOpenDate"
                InitialValue="" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1CloseDate" runat="server" Text="Close Date:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <telerik:RadDatePicker ID="txtCloseDate" CssClass="txtField" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01"
                Width="200px" TabIndex="17">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <span id="Span19" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Close Date" Display="Dynamic" ControlToValidate="txtCloseDate"
                InitialValue="" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="leftLabel">
            <asp:Label ID="lb1OpenTime" runat="server" Text="Open Time:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <%-- <telerik:RadTimePicker ID="txtOpenTime" runat="server" ZIndex="30001" TimeView-TimeFormat="HH:mm"
                Width="200px">
            </telerik:RadTimePicker>--%>
            <asp:DropDownList ID="ddlOpenTimeHours" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="60px" />
            <asp:DropDownList ID="ddlOpenTimeMinutes" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="60px" />
            <asp:DropDownList ID="ddlOpenTimeSeconds" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="60px" />
            <%-- <asp:TextBox ID="txtOpenTimes" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>--%>
            <span id="Span20" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Time" Display="Dynamic" ControlToValidate="ddlOpenTimeHours"
                InitialValue="HH" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Time" Display="Dynamic" ControlToValidate="ddlOpenTimeMinutes"
                InitialValue="MM" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator29" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Time" Display="Dynamic" ControlToValidate="ddlOpenTimeSeconds"
                InitialValue="SS" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1Closetime" runat="server" Text="Close Time:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:DropDownList ID="ddlCloseTimeHours" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="60px" />
            <asp:DropDownList ID="ddlCloseTimeMinutes" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="60px" />
            <asp:DropDownList ID="ddlCloseTimeSeconds" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="60px" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator30" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter  Time" Display="Dynamic" ControlToValidate="ddlCloseTimeHours"
                InitialValue="HH" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator31" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter  Time" Display="Dynamic" ControlToValidate="ddlCloseTimeMinutes"
                InitialValue="MM" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator32" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter  Time" Display="Dynamic" ControlToValidate="ddlCloseTimeSeconds"
                InitialValue="SS" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="leftLabel">
            <asp:Label ID="lb1RevisionDate" runat="server" Text="Revision Date:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <%--<asp:TextBox ID="txtRevisionDate" runat="server" CssClass="txtField"></asp:TextBox>--%>
            <telerik:RadDatePicker ID="txtRevisionDates" CssClass="txtField" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01"
                Width="200px" TabIndex="17">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <%-- <span id="Span22" class="spnRequiredField">*</span>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" CssClass="rfvPCG"
                        ErrorMessage="Please Enter Revision Date" Display="Dynamic" ControlToValidate="txtRevisionDates"
                        InitialValue="" ValidationGroup="SetUpSubmit">
                    </asp:RequiredFieldValidator>--%>
        </td>
        <td class="leftLabel">
            &nbsp;
        </td>
        <td class="rightData">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td class="leftLabel">
            <asp:Label ID="lb1TradingLot" runat="server" Text="Trading Lot:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtTradingLot" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span22" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Trading Lot" Display="Dynamic" ControlToValidate="txtTradingLot"
                InitialValue="" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator1" Display="Dynamic" ValidationGroup="SetUpSubmit"
                runat="server" ErrorMessage="<br />Please enter a numeric value" ControlToValidate="txtTradingLot"
                MaximumValue="2147483647" MinimumValue="0" Type="Double" CssClass="cvPCG"></asp:RangeValidator>
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1BiddingLot" runat="server" Text="Bidding Lot:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtBiddingLot" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span25" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Bidding Lot" Display="Dynamic" ControlToValidate="txtBiddingLot"
                InitialValue="" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator2" Display="Dynamic" ValidationGroup="SetUpSubmit"
                runat="server" ErrorMessage="<br />Please enter a numeric value" ControlToValidate="txtBiddingLot"
                MaximumValue="2147483647" MinimumValue="0" Type="Double" CssClass="cvPCG"></asp:RangeValidator>
        </td>
    </tr>
     <tr runat="server" ID="trMaxQty" >
        <td class="leftLabel">
            <asp:Label ID="Label15" runat="server" Text="Max Qty:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtMaxQty" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span30" class="spnRequiredField">*</span>
            <br />
            <asp:RangeValidator ID="RangeValidator7" Display="Dynamic" ValidationGroup="SetUpSubmit"
                runat="server" ErrorMessage="<br />Date of Max Qty between 1 to 999999999"
                ControlToValidate="txtMaxQty" MaximumValue="999999999" MinimumValue="1" Type="Integer"
                CssClass="cvPCG"></asp:RangeValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator38" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Max Qty" Display="Dynamic" ControlToValidate="txtMaxQty"
                InitialValue="" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
        </td>
           <td class="leftLabel">
            <asp:Label ID="lb1IsPrefix" runat="server" Text="Is Prefix:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtIsPrefix" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
        </td>
        
    </tr>
    <tr runat="server" ID="trMinQty">
        <td class="leftLabel">
            <asp:Label ID="lb1MinApplicationsize" runat="server" Text="Min Qty:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtMinAplicSize" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span23" class="spnRequiredField">*</span>
            <br />
            <asp:RangeValidator ID="RangeValidator6" Display="Dynamic" ValidationGroup="SetUpSubmit"
                runat="server" ErrorMessage="<br />Date of Min Qty between 1 to 999999999"
                ControlToValidate="txtFloorPrice" MaximumValue="999999999" MinimumValue="1" Type="Integer"
                CssClass="cvPCG"></asp:RangeValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Min AplicationSize" Display="Dynamic" ControlToValidate="txtMinAplicSize"
                InitialValue="" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
        </td>
        <td colspan="2">&nbsp;</td>
     <%--   <td class="leftLabel">
            <asp:Label ID="lb1IsPrefix" runat="server" Text="Is Prefix:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtIsPrefix" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
        </td>--%>
    </tr>
    <tr>
        <td class="leftLabel">
            <asp:Label ID="lb1Trading" runat="server" Text="Multiples of:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtTradingInMultipleOf" runat="server" CssClass="txtField" Width="200px"></asp:TextBox>
            <span id="Span15" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" CssClass="rfvPCG"
                ErrorMessage="Please Enter Trading In Multiple Of" Display="Dynamic" ControlToValidate="txtTradingInMultipleOf"
                InitialValue="" ValidationGroup="SetUpSubmit">
            </asp:RequiredFieldValidator>
            <br />
            <asp:RangeValidator ID="RangeValidator3" Display="Dynamic" ValidationGroup="SetUpSubmit"
                runat="server" ErrorMessage="<br />Please enter a numeric value" ControlToValidate="txtTradingInMultipleOf"
                MaximumValue="2147483647" MinimumValue="0" Type="Double" CssClass="cvPCG"></asp:RangeValidator>
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1ListedInExchange" runat="server" Text="Listed In Exchange:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:DropDownList ID="ddlListedInExchange" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="205px" OnSelectedIndexChanged="ddlListedInExchange_SelectedIndexChanged">
            </asp:DropDownList>
            <%-- <asp:TextBox ID="txtListedInExchange" runat="server" CssClass="txtField"></asp:TextBox>--%>
        </td>
    </tr>
    <tr class="leftLabel" visible="false" id="trExchangeCode">
        <td>
            &nbsp;
        </td>
        <td class="rightData">
            &nbsp;
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1Code" runat="server" Text="Code:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtNcdBsnCode" runat="server" CssClass="txtField"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="leftLabel">
            <asp:Label ID="lb1BankName" runat="server" Text="Bank Name:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:DropDownList ID="ddlBankName" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="205px">
            </asp:DropDownList>
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1BankBranch" runat="server" Text="Bank Branch:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:DropDownList ID="ddlBankBranch" runat="server" CssClass="cmbField" AutoPostBack="true"
                Width="205px">
            </asp:DropDownList>
        </td>
    </tr>
    <tr id="trIsActiveandPutCallOption" runat="server">
        <td class="leftLabel">
            &nbsp;
        </td>
        <td class="rightData">
            <asp:CheckBox ID="chkIsActive" runat="server" CssClass="txtField" Text="Is Active">
            </asp:CheckBox>
        </td>
        <td class="leftLabel">
            <asp:Label ID="lb1PutCallOption" runat="server" Text="Put Call Option:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtPutCallOption" runat="server" CssClass="txtField" Width="205px"></asp:TextBox>
            <asp:CompareValidator ID="CompareValidator4" ControlToValidate="txtCloseDate" runat="server"
                Display="Dynamic" ErrorMessage="<br />Please enter a Put Call Option" Type="Date"
                Operator="DataTypeCheck" CssClass="cvPCG"></asp:CompareValidator>
        </td>
    </tr>
    <tr id="trNomineeReQuired" runat="server">
        <td class="leftLabel">
            &nbsp;
        </td>
        <td class="rightData">
            <asp:CheckBox ID="chkNomineeReQuired" runat="server" CssClass="txtField" Text="Nominee Required">
            </asp:CheckBox>
        </td>
        <td class="leftLabel" colspan="3">
            &nbsp;
        </td>
    </tr>
    <tr id="trBtnSubmit" runat="server">
        <td class="leftLabel">
            <asp:Button ID="btnSetUpSubmit" runat="server" Text="Submit" CssClass="PCGButton"
                ValidationGroup="SetUpSubmit" OnClick="btnSetUpSubmit_Click" />
            <%-- </td>
        <td class="rightData">--%>
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="PCGButton" ValidationGroup="SetUpSubmit"
                OnClick="btnUpdate_Click" />
            <asp:Button ID="btnProspect" runat="server" Text="Prospect" CssClass="PCGButton"
                OnClick="btnProspect_Click" />
            <%-- ValidationGroup="SetUpSubmit"--%>
        </td>
        <td class="leftLabel">
            &nbsp;
        </td>
        <td class="rightData">
            &nbsp;
        </td>
    </tr>
    <tr id="trIssueId" visible="false">
        <td class="leftLabel">
            &nbsp;
        </td>
        <td class="rightData">
            <asp:TextBox ID="txtIssueId" runat="server" CssClass="txtField" Visible="false"></asp:TextBox>
        </td>
        <td class="leftLabel" colspan="3">
            &nbsp;
        </td>
    </tr>
</table>
<asp:Panel ID="pnlCategory" runat="server" CssClass="Landscape" Width="100%">
    <table id="Table1" runat="server" width="80%">
        <tr>
            <td class="leftLabel">
                &nbsp;
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <telerik:RadGrid ID="rgEligibleInvestorCategories" runat="server" AllowSorting="True"
                                enableloadondemand="True" PageSize="5" AutoGenerateColumns="False" EnableEmbeddedSkins="False"
                                GridLines="None" ShowFooter="True" PagerStyle-AlwaysVisible="true" AllowPaging="false"
                                ShowStatusBar="True" Skin="Telerik" AllowFilteringByColumn="true" OnNeedDataSource="rgEligibleInvestorCategories_OnNeedDataSource"
                                OnItemCommand="rgEligibleInvestorCategories_ItemCommand" OnItemDataBound="rgEligibleInvestorCategories_ItemDataBound">
                                <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" DataKeyNames="AIM_IssueId,AIIC_InvestorCatgeoryId"
                                    AutoGenerateColumns="false" Width="100%" EditMode="PopUp" CommandItemSettings-AddNewRecordText="Create InvestorCategory"
                                    CommandItemDisplay="Top">
                                    <Columns>
                                        <telerik:GridTemplateColumn AllowFiltering="false">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbDetails" runat="server" CommandName="ExpandCollapse" Font-Underline="False"
                                                    Font-Bold="true" UniqueName="DetailsCategorieslink" OnClick="btnCategoriesExpandAll_Click"
                                                    Font-Size="Medium">+</asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridEditCommandColumn EditText="Edit" UniqueName="editColumn" CancelText="Cancel"
                                            UpdateText="Update">
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridBoundColumn DataField="AIIC_InvestorCatgeoryName" HeaderStyle-Width="20px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            HeaderText="Category Name" UniqueName="AIIC_InvestorCatgeoryName" SortExpression="AIIC_InvestorCatgeoryName"
                                            AllowFiltering="true">
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AIIC_ChequePayableTo" HeaderStyle-Width="200px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            HeaderText="ChequePayableTo" UniqueName="AIIC_ChequePayableTo" SortExpression="AIIC_ChequePayableTo">
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AIIC_MInBidAmount" HeaderStyle-Width="200px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            HeaderText="MInBid Amount" UniqueName="AIIC_MInBidAmount" SortExpression="AIIC_MInBidAmount">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AIIC_MaxBidAmount" HeaderStyle-Width="200px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            HeaderText="MaxBid Amount" UniqueName="AIIC_MaxBidAmount" SortExpression="AIIC_MaxBidAmount">
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn AllowFiltering="false">
                                            <ItemTemplate>
                                                <tr>
                                                    <td colspan="1.5%">
                                                        &nbsp;
                                                    </td>
                                                    <td colspan="3%">
                                                        <asp:Panel ID="pnlCategoriesDetailschild" runat="server" Style="display: inline"
                                                            CssClass="Landscape" ScrollBars="Horizontal" Visible="false">
                                                            <telerik:RadGrid ID="rgCategoriesDetails" runat="server" AutoGenerateColumns="False"
                                                                enableloadondemand="True" PageSize="5" EnableEmbeddedSkins="False" GridLines="None"
                                                                ShowFooter="True" PagerStyle-AlwaysVisible="false" ShowStatusBar="True" Skin="Telerik"
                                                                AllowFilteringByColumn="true" OnNeedDataSource="rgCategoriesDetails_OnNeedDataSource"
                                                                AllowPaging="false">
                                                                <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" DataKeyNames="AIIC_InvestorCatgeoryId"
                                                                    AutoGenerateColumns="false">
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="WCMV_Name" HeaderStyle-Width="30px" UniqueName="WCMV_Name"
                                                                            CurrentFilterFunction="Contains" HeaderText="Investor Type" SortExpression="WCMV_Name"
                                                                            AllowFiltering="true">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="AIICST_InvestorSubTypeCode" HeaderStyle-Width="30px"
                                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                            HeaderText="SubType Code" UniqueName="AIIC_InvestorSubTypeCode" SortExpression="AIIC_InvestorSubTypeCode">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="AIICST_MinInvestmentAmount" HeaderStyle-Width="30px"
                                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                            HeaderText="MinInvestment Amount" UniqueName="AIIC_MinInvestmentAmount" SortExpression="AIIC_MinInvestmentAmount">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="AIICST_MaxInvestmentAmount" HeaderStyle-Width="30px"
                                                                            HeaderText="MaxInvestment Amount" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                                            AutoPostBackOnFilter="true" UniqueName="AIIC_MaxInvestmentAmount" Visible="true">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
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
                                    <EditFormSettings EditFormType="Template" PopUpSettings-Height="600px" PopUpSettings-Width="730px">
                                        <FormTemplate>
                                            <table width="75%" cellspacing="2" cellpadding="2">
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lb1IssueName" runat="server" Text="Issue Name:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:TextBox ID="txtIssueName" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span2" class="spnRequiredField">*</span>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Craeate Issue" Display="Dynamic" ControlToValidate="txtIssueName"
                                                            Enabled="false" ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lb1CategoryName" runat="server" Text="Category Name:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtCategoryName" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span1" class="spnRequiredField">*</span>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Category Name" Display="Dynamic" ControlToValidate="txtCategoryName"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="Label1" runat="server" Text="Category Description:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtCategoryDescription" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span4" class="spnRequiredField">*</span>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Category Description" Display="Dynamic" ControlToValidate="txtCategoryDescription"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="Label2" runat="server" Text="Cheque Payable To:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtChequePayableTo" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span6" class="spnRequiredField">*</span>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter ChequePayableTo" Display="Dynamic" ControlToValidate="txtChequePayableTo"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="Label3" runat="server" Text="Min Bid Amount:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtMinBidAmount" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span7" class="spnRequiredField">*</span>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Min Bid Amount" Display="Dynamic" ControlToValidate="txtMinBidAmount"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="Label4" runat="server" Text="Max Bid Amount:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtMaxBidAmount" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span8" class="spnRequiredField">*</span>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Max Bid Amount" Display="Dynamic" ControlToValidate="txtMaxBidAmount"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr id="trDiscountType" runat="server">
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lb1DiscountType" runat="server" Text="Discount Type:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:DropDownList ID="ddlDiscountType" runat="server" CssClass="cmbField" AutoPostBack="true"
                                                             >
                                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                                            <asp:ListItem Value="Per">Per(%)</asp:ListItem>
                                                            <asp:ListItem Value="Amt">Amt</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <span id="SpanDiscountType" class="spnRequiredField">*</span>
                                                        <asp:RequiredFieldValidator ID="rfvDiscountType" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Select Discount Type" Display="Dynamic" ControlToValidate="ddlDiscountType"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr id="trDiscountValue" runat="server">
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lb1DiscountValue" runat="server" Text="Discount Value:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtDiscountValue" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="SpanDiscountValue" class="spnRequiredField">*</span>
                                                        <asp:RequiredFieldValidator ID="rfvDiscountValue" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Select Discount Value" Display="Dynamic" ControlToValidate="txtDiscountValue"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <telerik:RadGrid ID="rgSubCategories" runat="server" AllowSorting="True" enableloadondemand="True"
                                                            PageSize="10" AllowPaging="True" AutoGenerateColumns="False" EnableEmbeddedSkins="False"
                                                            GridLines="None" ShowFooter="True" PagerStyle-AlwaysVisible="false" ShowStatusBar="True"
                                                            Skin="Telerik" AllowFilteringByColumn="true" OnNeedDataSource="rgSubCategories_OnNeedDataSource"
                                                            DataKeyNames="WCMV_LookupId">
                                                            <MasterTableView>
                                                                <Columns>
                                                                    <telerik:GridTemplateColumn HeaderText="Select" ShowFilterIcon="false" AllowFiltering="false">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblchkBxSelect" runat="server" Text="Select"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="cbSubCategories" runat="server" Checked="false" />
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridBoundColumn DataField="WCMV_Name" HeaderStyle-Width="200px" CurrentFilterFunction="Contains"
                                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Sub Category"
                                                                        UniqueName="WCMV_Name" SortExpression="WCMV_Name" AllowFiltering="true">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="WCMV_LookupId" HeaderStyle-Width="200px" CurrentFilterFunction="Contains"
                                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="LookupId" UniqueName="WCMV_LookupId"
                                                                        SortExpression="WCMV_LookupId" Visible="false">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Sub Category Code" ShowFilterIcon="false"
                                                                        AllowFiltering="false">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblSubCategoryCode" runat="server" Text="Sub Category Code"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtSubCategoryCode" runat="server" CssClass="txtField"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="MinInvestmentAmount" ShowFilterIcon="false"
                                                                        AllowFiltering="false">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblMinInvestmentAmount" runat="server" Text="MinInvestmentAmount"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtMinInvestmentAmount" runat="server" CssClass="txtField"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Max Investment Amount" ShowFilterIcon="false"
                                                                        AllowFiltering="false">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblMaxInvestmentAmount" runat="server" Text="Max Investment Amount"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtMaxInvestmentAmount" runat="server" CssClass="txtField"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                        </telerik:RadGrid>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Button ID="btnOK" Text="OK" runat="server" CssClass="PCGButton" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                                            CausesValidation="True" ValidationGroup="btnOK" />
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                                            CssClass="PCGButton" CommandName="Cancel"></asp:Button>
                                                    </td>
                                                    <td class="leftLabel" colspan="2">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </FormTemplate>
                                    </EditFormSettings>
                                </MasterTableView>
                                <ClientSettings>
                                </ClientSettings>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:Panel ID="pnlSeries" runat="server" Width="100%">
    <table id="tblSeries" runat="server" width="80%">
        <tr>
            <td class="leftLabel">
                &nbsp;
            </td>
            <td>
                <table width="100%">
                    <tr>
                        <td class="leftLabel">
                            <telerik:RadGrid ID="rgSeries" runat="server" AllowSorting="True" enableloadondemand="True"
                                PageSize="5" AutoGenerateColumns="False" EnableEmbeddedSkins="False" GridLines="None"
                                ShowFooter="True" PagerStyle-AlwaysVisible="true" ShowStatusBar="True" OnItemDataBound="rgSeries_ItemDataBound"
                                Skin="Telerik" AllowFilteringByColumn="True" OnNeedDataSource="rgSeries_OnNeedDataSource"
                                OnItemCommand="rgSeries_ItemCommand" AllowPaging="false">
                                <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" DataKeyNames="AID_IssueDetailId"
                                    AutoGenerateColumns="false" Width="100%" EditMode="PopUp" CommandItemSettings-AddNewRecordText="Create New Series"
                                    CommandItemDisplay="Top" CommandItemSettings-ShowRefreshButton="false">
                                    <Columns>
                                        <telerik:GridTemplateColumn AllowFiltering="false">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbDetails" runat="server" CommandName="ExpandCollapse" Font-Underline="False"
                                                    Font-Bold="true" UniqueName="Detailslink" OnClick="btnExpandAll_Click" Font-Size="Medium">+</asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridEditCommandColumn EditText="Edit" UniqueName="editColumn" CancelText="Cancel"
                                            HeaderStyle-Width="70px" UpdateText="Update">
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridBoundColumn DataField="AID_IssueDetailName" HeaderStyle-Width="100px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            HeaderText="Series Name" UniqueName="AID_IssueDetailName" SortExpression="AID_IssueDetailName"
                                            AllowFiltering="true">
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AID_Tenure" HeaderStyle-Width="100px" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Tenure" UniqueName="AID_Tenure"
                                            SortExpression="AID_Tenure" AllowFiltering="true">
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AID_BuyBackFacility" HeaderStyle-Width="20px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            HeaderText="IsBuyBack Available" UniqueName="AID_BuyBackFacility" SortExpression="AID_BuyBackFacility"
                                            AllowFiltering="true">
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn AllowFiltering="false">
                                            <ItemTemplate>
                                                <tr>
                                                    <td colspan="1.5%">
                                                        &nbsp;
                                                    </td>
                                                    <td colspan="3%">
                                                        <asp:Panel ID="pnlchild" runat="server" Style="display: inline" CssClass="Landscape"
                                                            Width="50%" ScrollBars="Horizontal" Visible="false">
                                                            <telerik:RadGrid ID="rgSeriesCategories" runat="server" AutoGenerateColumns="False"
                                                                enableloadondemand="True" PageSize="5" EnableEmbeddedSkins="False" GridLines="None"
                                                                ShowFooter="True" PagerStyle-AlwaysVisible="true" ShowStatusBar="True" Skin="Telerik"
                                                                AllowFilteringByColumn="true" OnNeedDataSource="rgSeriesCategories_OnNeedDataSource"
                                                                AllowPaging="false">
                                                                <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" DataKeyNames="AID_IssueDetailId"
                                                                    AutoGenerateColumns="false">
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="AIIC_InvestorCatgeoryName" HeaderStyle-Width="30px"
                                                                            CurrentFilterFunction="Contains" HeaderText="Investor CatgeoryName" SortExpression="AIIC_InvestorCatgeoryName"
                                                                            AllowFiltering="true">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="AIDCSR_DefaultInterestRate" HeaderStyle-Width="30px"
                                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                            HeaderText="Default InterestRate" UniqueName="AIDCSR_DefaultInterestRate" SortExpression="AIDCSR_DefaultInterestRate">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="AIDCSR_AnnualizedYieldUpto" HeaderStyle-Width="30px"
                                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                            HeaderText="Annualized YieldUpto" UniqueName="AIDCSR_AnnualizedYieldUpto" SortExpression="AIDCSR_AnnualizedYieldUpto">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="AIDCSR_DefaultInterestRate" HeaderStyle-Width="30px"
                                                                            HeaderText="Interest Frequency" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                                            AutoPostBackOnFilter="true" UniqueName="AIDCSR_InterestFrequency" Visible="true">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
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
                                    <EditFormSettings EditFormType="Template" PopUpSettings-Height="350px" PopUpSettings-Width="530px">
                                        <FormTemplate>
                                            <table width="75%" cellspacing="2" cellpadding="2">
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lb1SereiesName" runat="server" Text="Series Name:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtSereiesName" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span24" class="spnRequiredField">*</span>
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Sereies Name" Display="Dynamic" ControlToValidate="txtSereiesName"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <%--  <td class="rightData">
                                                        &nbsp;
                                                    </td>--%>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lb1Tenure" runat="server" Text="Tenure:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:TextBox ID="txtTenure" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span1" class="spnRequiredField">*</span>
                                                        <%--  <asp:DropDownList ID="ddlTenure" runat="server" CssClass="cmbField">
                                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                                            <asp:ListItem Value="Month">Month</asp:ListItem>
                                                            <asp:ListItem Value="Year">Year</asp:ListItem>
                                                        </asp:DropDownList>--%>
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Tenure" Display="Dynamic" ControlToValidate="txtTenure"
                                                            ValidationGroup="btnOK" InitialValue="">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:CompareValidator ID="CompareValidator9" ControlToValidate="txtTenure" runat="server"
                                                            Display="Dynamic" ErrorMessage="<br />Please enter a Integer" Type="Integer"
                                                            Operator="DataTypeCheck" CssClass="cvPCG"></asp:CompareValidator>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:DropDownList ID="ddlTenure" runat="server" CssClass="cmbField">
                                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                                            <asp:ListItem Value="Month">Month</asp:ListItem>
                                                            <asp:ListItem Value="Year">Year</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <%-- <span id="Span25" class="spnRequiredField">*</span>
                                                                
                                                                    <br />--%>
                                                        <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" CssClass="rfvPCG"
                                                                    ErrorMessage="Please Enter Sereies Name" Display="Dynamic" ControlToValidate="ddlTenure" Enabled="false"
                                                                    ValidationGroup="btnOK" InitialValue="Select"  >
                                                                </asp:RequiredFieldValidator>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lb1InterestFrequency" runat="server" Text="Interest Frequency:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:TextBox ID="txtInterestFrequency" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span3" class="spnRequiredField">*</span>
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Interest Frequency" Display="Dynamic" ControlToValidate="txtInterestFrequency"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:CheckBox ID="chkBuyAvailability" runat="server" CssClass="cmbField" Text="Is Buy Back Available">
                                                        </asp:CheckBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lb1InterestType" runat="server" Text="Interest Type:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:DropDownList ID="ddlInterestType" runat="server" CssClass="cmbField">
                                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                                            <asp:ListItem Value="Fixed">Fixed</asp:ListItem>
                                                            <asp:ListItem Value="Floating">Floating</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <span id="Span5" class="spnRequiredField">*</span>
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Interest Type" Display="Dynamic" ControlToValidate="txtInterestFrequency"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                    <td class="rightData">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="Label5" runat="server" Text="Sequence:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtSequence" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span32" class="spnRequiredField">*</span>
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator40" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Sequence" Display="Dynamic" ControlToValidate="txtSequence"
                                                            ValidationGroup="btnOK">
                                                            <%--<asp:CompareValidator ID="CompareValidator2" ControlToValidate="txtSequence" runat="server"
                                                                Display="Dynamic" ErrorMessage="Enter integer " Type="Integer" Operator="NotEqual"
                                                                CssClass="cvPCG"></asp:CompareValidator>--%>
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                    <td class="rightData">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <telerik:RadGrid ID="rgSeriesCat" runat="server" AllowSorting="True" enableloadondemand="True"
                                                            PageSize="5" AllowPaging="True" AutoGenerateColumns="false" EnableEmbeddedSkins="False"
                                                            GridLines="None" ShowFooter="True" PagerStyle-AlwaysVisible="true" ShowStatusBar="True"
                                                            Skin="Telerik" AllowFilteringByColumn="true" OnNeedDataSource="rgSeriesCat_OnNeedDataSource">
                                                            <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" AutoGenerateColumns="false"
                                                                DataKeyNames="AIIC_InvestorCatgeoryId">
                                                                <Columns>
                                                                    <telerik:GridTemplateColumn HeaderText="Select" AllowFiltering="false">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblchkBxSelect" runat="server" Text="Select"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="cbSeriesCat" runat="server" Checked="false" />
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridBoundColumn DataField="AIIC_InvestorCatgeoryId" HeaderStyle-Width="20px"
                                                                        Visible="false" ShowFilterIcon="false" CurrentFilterFunction="Contains" HeaderText="CatgoryID"
                                                                        SortExpression="AIIC_InvestorCatgeoryId">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="AIIC_InvestorCatgeoryName" HeaderStyle-Width="60px"
                                                                        CurrentFilterFunction="Contains" HeaderText="category Name" SortExpression="AIIC_InvestorCatgeoryName"
                                                                        AllowFiltering="true" ShowFilterIcon="false">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="InterestRate(%)" AllowFiltering="false">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblInterest" runat="server" Text="Interest Rate(%)"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtInterestRate" runat="server" CssClass="txtField"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Annualized Yield(%)" AllowFiltering="false">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblAnnualized" runat="server" Text="Annualized Yield(%)"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtAnnualizedYield" runat="server" CssClass="txtField"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                        </telerik:RadGrid>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Button ID="btnOK" Text="OK" runat="server" CssClass="PCGButton" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                                            CausesValidation="True" ValidationGroup="btnOK" />
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                                            CssClass="PCGButton" CommandName="Cancel"></asp:Button>
                                                    </td>
                                                    <td class="rightData">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <%--<tr>
                                                            <td colspan="3">
                                                                &nbsp;&nbsp;&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                &nbsp;&nbsp;&nbsp;
                                                            </td>
                                                        </tr>--%>
                                            </table>
                                        </FormTemplate>
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Panel>
<%--<asp:Panel ID="pnlCategory" runat="server" CssClass="Landscape" Width="100%">
    <table id="Table1" runat="server" width="80%">
        <tr>
            <td class="leftLabel">
                &nbsp;
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <telerik:RadGrid ID="rgEligibleInvestorCategories" runat="server" AllowSorting="True"
                                enableloadondemand="True" PageSize="5" AllowPaging="True" AutoGenerateColumns="False"
                                EnableEmbeddedSkins="False" GridLines="None" ShowFooter="True" PagerStyle-AlwaysVisible="true"
                                ShowStatusBar="True" Skin="Telerik" AllowFilteringByColumn="true" OnNeedDataSource="rgEligibleInvestorCategories_OnNeedDataSource"
                                OnItemCommand="rgEligibleInvestorCategories_ItemCommand" OnItemDataBound="rgEligibleInvestorCategories_ItemDataBound">
                                <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" DataKeyNames="AIM_IssueId,AIIC_InvestorCatgeoryId"
                                    AutoGenerateColumns="false" Width="100%" EditMode="PopUp" CommandItemSettings-AddNewRecordText="Create InvestorCategory"
                                    CommandItemDisplay="Top">
                                    <Columns>
                                        <telerik:GridTemplateColumn AllowFiltering="false">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbDetails" runat="server" CommandName="ExpandCollapse" Font-Underline="False"
                                                    Font-Bold="true" UniqueName="DetailsCategorieslink" OnClick="btnCategoriesExpandAll_Click"
                                                    Font-Size="Medium">+</asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridEditCommandColumn EditText="Edit" UniqueName="editColumn" CancelText="Cancel"
                                            UpdateText="Update">
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridBoundColumn DataField="AIIC_InvestorCatgeoryName" HeaderStyle-Width="20px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            HeaderText="Catgeory Name" UniqueName="AIIC_InvestorCatgeoryName" SortExpression="AIIC_InvestorCatgeoryName"
                                            AllowFiltering="true">
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AIIC_ChequePayableTo" HeaderStyle-Width="200px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            HeaderText="ChequePayableTo" UniqueName="AIIC_ChequePayableTo" SortExpression="AIIC_ChequePayableTo">
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AIIC_MInBidAmount" HeaderStyle-Width="200px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            HeaderText="MInBid Amount" UniqueName="AIIC_MInBidAmount" SortExpression="AIIC_MInBidAmount">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AIIC_MaxBidAmount" HeaderStyle-Width="200px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            HeaderText="MaxBid Amount" UniqueName="AIIC_MaxBidAmount" SortExpression="AIIC_MaxBidAmount">
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn AllowFiltering="false">
                                            <ItemTemplate>
                                                <tr>
                                                    <td colspan="1.5%">
                                                        &nbsp;
                                                    </td>
                                                    <td colspan="3%">
                                                        <asp:Panel ID="pnlCategoriesDetailschild" runat="server" Style="display: inline"
                                                            CssClass="Landscape" ScrollBars="Horizontal" Visible="false">
                                                            <telerik:RadGrid ID="rgCategoriesDetails" runat="server" AutoGenerateColumns="False"
                                                                enableloadondemand="True" PageSize="5" AllowPaging="True" EnableEmbeddedSkins="False"
                                                                GridLines="None" ShowFooter="True" PagerStyle-AlwaysVisible="false" ShowStatusBar="True"
                                                                Skin="Telerik" AllowFilteringByColumn="true" OnNeedDataSource="rgCategoriesDetails_OnNeedDataSource">
                                                                <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" DataKeyNames="AIIC_InvestorCatgeoryId"
                                                                    AutoGenerateColumns="false">
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="WCMV_Name" HeaderStyle-Width="30px" UniqueName="WCMV_Name"
                                                                            CurrentFilterFunction="Contains" HeaderText="Investor Type" SortExpression="WCMV_Name"
                                                                            AllowFiltering="true">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="AIICS_InvestorSubTypeCode" HeaderStyle-Width="30px"
                                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                            HeaderText="SubType Code" UniqueName="AIIC_InvestorSubTypeCode" SortExpression="AIIC_InvestorSubTypeCode">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="AIICS_MinInvestmentAmount" HeaderStyle-Width="30px"
                                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                            HeaderText="MinInvestment Amount" UniqueName="AIIC_MinInvestmentAmount" SortExpression="AIIC_MinInvestmentAmount">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="AIICS_MaxInvestmentAmount" HeaderStyle-Width="30px"
                                                                            HeaderText="MaxInvestment Amount" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                                            AutoPostBackOnFilter="true" UniqueName="AIIC_MaxInvestmentAmount" Visible="true">
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="20px" Wrap="false" />
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
                                    <EditFormSettings EditFormType="Template" PopUpSettings-Height="450px" PopUpSettings-Width="700px">
                                        <FormTemplate>
                                            <table width="75%" cellspacing="2" cellpadding="2">
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lb1IssueName" runat="server" Text="Issue Name:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:TextBox ID="txtIssueName" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span2" class="spnRequiredField">*</span>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Craeate Issue" Display="Dynamic" ControlToValidate="txtIssueName"
                                                            Enabled="false" ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lb1CategoryName" runat="server" Text="Category Name:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtCategoryName" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span1" class="spnRequiredField">*</span>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Category Name" Display="Dynamic" ControlToValidate="txtCategoryName"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="Label1" runat="server" Text="Category Description:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtCategoryDescription" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span4" class="spnRequiredField">*</span>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Category Description" Display="Dynamic" ControlToValidate="txtCategoryDescription"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="Label2" runat="server" Text="Cheque Payable To:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtChequePayableTo" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span6" class="spnRequiredField">*</span>                                                      
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter ChequePayableTo" Display="Dynamic" ControlToValidate="txtChequePayableTo"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="Label3" runat="server" Text="Min Bid Amount:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtMinBidAmount" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span7" class="spnRequiredField">*</span>                                                       
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Min Bid Amount" Display="Dynamic" ControlToValidate="txtMinBidAmount"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                 
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="Label4" runat="server" Text="Max Bid Amount:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtMaxBidAmount" runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span8" class="spnRequiredField">*</span>
                                                      
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" CssClass="rfvPCG"
                                                            ErrorMessage="Please Enter Max Bid Amount" Display="Dynamic" ControlToValidate="txtMaxBidAmount"
                                                            ValidationGroup="btnOK">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                   
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <telerik:RadGrid ID="rgSubCategories" runat="server" AllowSorting="True" enableloadondemand="True"
                                                            PageSize="10" AllowPaging="True" AutoGenerateColumns="False" EnableEmbeddedSkins="False"
                                                            GridLines="None" ShowFooter="True" PagerStyle-AlwaysVisible="false" ShowStatusBar="True"
                                                            Skin="Telerik" AllowFilteringByColumn="true" OnNeedDataSource="rgSubCategories_OnNeedDataSource"
                                                            DataKeyNames="WCMV_LookupId">
                                                            <MasterTableView>
                                                                <Columns>
                                                                    <telerik:GridTemplateColumn HeaderText="Select" ShowFilterIcon="false" AllowFiltering="false">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblchkBxSelect" runat="server" Text="Select"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="cbSubCategories" runat="server" Checked="false" />
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridBoundColumn DataField="WCMV_Name" HeaderStyle-Width="200px" CurrentFilterFunction="Contains"
                                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Sub Category"
                                                                        UniqueName="WCMV_Name" SortExpression="WCMV_Name" AllowFiltering="true">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="WCMV_LookupId" HeaderStyle-Width="200px" CurrentFilterFunction="Contains"
                                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="LookupId" UniqueName="WCMV_LookupId"
                                                                        SortExpression="WCMV_LookupId" Visible="false">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Sub Category Code" ShowFilterIcon="false"
                                                                        AllowFiltering="false">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblSubCategoryCode" runat="server" Text="Sub Category Code"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtSubCategoryCode" runat="server" CssClass="txtField"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="MinInvestmentAmount" ShowFilterIcon="false"
                                                                        AllowFiltering="false">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblMinInvestmentAmount" runat="server" Text="MinInvestmentAmount"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtMinInvestmentAmount" runat="server" CssClass="txtField"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Max Investment Amount" ShowFilterIcon="false"
                                                                        AllowFiltering="false">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblMaxInvestmentAmount" runat="server" Text="Max Investment Amount"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtMaxInvestmentAmount" runat="server" CssClass="txtField"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                        </telerik:RadGrid>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Button ID="btnOK" Text="OK" runat="server" CssClass="PCGButton" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                                            CausesValidation="True" ValidationGroup="btnOK" />
                                                        
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                                            CssClass="PCGButton" CommandName="Cancel"></asp:Button>
                                                    </td>
                                                    <td class="leftLabel" colspan="2">
                                                        &nbsp;
                                                    </td>
                                                  
                                                </tr>
                                               
                                            </table>
                                        </FormTemplate>
                                    </EditFormSettings>
                                </MasterTableView>
                                <ClientSettings>
                                </ClientSettings>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Panel>--%>