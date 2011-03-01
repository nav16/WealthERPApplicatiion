﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Calculators.ascx.cs"
    Inherits="WealthERP.General.Calculators" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style type="text/css">
    .style1
    {
        color: #FF0000;
    }
    .FieldName
    {
        color: #000000;
    }
</style>
<asp:ScriptManager ID="scrptMgr" runat="server">
</asp:ScriptManager>

<script id="myScript" language="javascript" type="text/javascript">
    function OnChanged(sender, args) {
        document.getElementById("<%= hidTabIndex.ClientID %>").value = sender.get_activeTab()._tabIndex;
        //uncheckallCehckBoxes();
        return false;
    }
</script>

<script type="text/javascript">
    $(document).ready(function() {
        $('.ScreenTip1').bubbletip($('#div1'), { deltaDirection: 'right' })
    });
</script>

<table width="100%">
    <tr>
        <td>
            <cc1:TabContainer ID="tabCalculators" runat="server" Width="100%" Style="visibility: visible"
                OnClientActiveTabChanged="OnChanged" ActiveTabIndex="2">
                <cc1:TabPanel ID="tabpnlEMICalculator" runat="server" HeaderText="EMI Calculator"
                    Width="100%">
                    <HeaderTemplate>
                        EMI(Loan)Calculators</HeaderTemplate>
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblmandatory" runat="server" Text="All Fields are mandatory" 
                                        CssClass="FieldName"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblLOanAmount" runat="server" Text="Loan Amount:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtLoanAmount" runat="server" CssClass="Field"></asp:TextBox>&nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtLoanAmount"
                                        ErrorMessage="Invalid Amount" ValidationExpression="(\$)?(\d)+\,?(\d)+"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style1">
                                    <asp:Label ID="lblTenure" runat="server" Text="Tenure:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left" class="style1">
                                    <asp:TextBox ID="txtTenureYears" runat="server" CssClass="Field"></asp:TextBox>
                                    <cc1:TextBoxWatermarkExtender ID="txtTenureYears_TextBoxWatermarkExtender" runat="server"
                                        TargetControlID="txtTenureYears" WatermarkText="Years" Enabled="True">
                                    </cc1:TextBoxWatermarkExtender>
                                    <asp:TextBox ID="txtTenureMonths" runat="server" CssClass="Field"></asp:TextBox>
                                    &nbsp;<asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Invalid" ControlToValidate="txtTenureYears"
                                        MinimumValue="0" MaximumValue="10000" Display="Dynamic" Type="Integer"></asp:RangeValidator>
                                         <asp:RangeValidator ID="RangeValidator6" runat="server" ControlToValidate="txtTenureMonths"
                                                            Display="Dynamic" ErrorMessage="Invalid!" MaximumValue="11" MinimumValue="0"
                                                            Type="Integer"></asp:RangeValidator>
                                    <cc1:TextBoxWatermarkExtender ID="txtTenureMonths_TextBoxWatermarkExtender" runat="server"
                                        TargetControlID="txtTenureMonths" WatermarkText="Months" Enabled="True">
                                    </cc1:TextBoxWatermarkExtender>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblInterestRate" runat="server" Text="Interest Rate(%)p.a.:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtInterest" runat="server" CssClass="Field"></asp:TextBox>&nbsp;<asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="txtInterest"
                                        Display="Dynamic" ErrorMessage="Invalid!" MaximumValue="99.99" MinimumValue="0.0"
                                        Type="Double"></asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblInstallmentFrequency" runat="server" Text="Installment Frequency:"
                                        CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlFrequency" runat="server" CssClass="cmbField">
                                        <asp:ListItem Text="Daily" Value="DA"></asp:ListItem>
                                        <asp:ListItem Text="Weekly" Value="WK"></asp:ListItem>
                                        <asp:ListItem Text="FortNightly" Value="FN"></asp:ListItem>
                                        <asp:ListItem Text="Monthly" Value="MN"></asp:ListItem>
                                        <asp:ListItem Text="Quarterly" Value="QT"></asp:ListItem>
                                        <asp:ListItem Text="Half Yearly" Value="HY"></asp:ListItem>
                                        <asp:ListItem Text="Yearly" Value="YR"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                           <tr>
                                <td align="right">
                                    <asp:Label ID="lblStartDate" runat="server" Text="Installment Start Date:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="Field"></asp:TextBox>&nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date"
                                        ControlToValidate="txtStartDate" ValidationExpression="^(((((0[1-9])|(1\d)|(2[0-8]))\/((0[1-9])|(1[0-2])))|((31\/((0[13578])|(1[02])))|((29|30)\/((0[1,3-9])|(1[0-2])))))\/((20[0-9][0-9])|(19[0-9][0-9])))|((29\/02\/(19|20)(([02468][048])|([13579][26]))))$"></asp:RegularExpressionValidator>
                                    <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" TargetControlID="txtStartDate"
                                        Format="dd/MM/yyyy" Enabled="True">
                                    </cc1:CalendarExtender>
                                    <cc1:TextBoxWatermarkExtender ID="txtStartDate_TextBoxWatermarkExtender" runat="server"
                                        TargetControlID="txtStartDate" WatermarkText="dd/mm/yyyy" Enabled="True">
                                    </cc1:TextBoxWatermarkExtender>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblEndDate" runat="server" Text="Installment End Date:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="Field"></asp:TextBox>&nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date"
                                        ControlToValidate="txtEndDate" ValidationExpression="^(((((0[1-9])|(1\d)|(2[0-8]))\/((0[1-9])|(1[0-2])))|((31\/((0[13578])|(1[02])))|((29|30)\/((0[1,3-9])|(1[0-2])))))\/((20[0-9][0-9])|(19[0-9][0-9])))|((29\/02\/(19|20)(([02468][048])|([13579][26]))))$"></asp:RegularExpressionValidator>
                                    <cc1:CalendarExtender ID="txtEndDate_CalendarExtender" runat="server" TargetControlID="txtEndDate"
                                        Format="dd/MM/yyyy" Enabled="True">
                                    </cc1:CalendarExtender>
                                    <cc1:TextBoxWatermarkExtender ID="txtEndDate_TextBoxWatermarkExtender" runat="server"
                                        TargetControlID="txtEndDate" WatermarkText="dd/mm/yyyy" Enabled="True">
                                    </cc1:TextBoxWatermarkExtender>
                                </td>
                              <%--  <td>
                                    <asp:Label ID="output" runat="server" CssClass="Field"></asp:Label>
                                </td>--%>
                              
                                  <tr>
                                    <td colspan="2">
                                        <asp:Button ID="btnCalculateEMI" runat="server" CssClass="PCGButton" OnClick="btnCalculateEMI_Click"
                                            Text="Calculate" />
                                    </td>
                                    <td align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                            </tr>
                        </table>
                        <table id="tblResult" runat="server" visible="False">
                            <tr id="Tr1" runat="server">
                                <td id="Td1" runat="server">
                                    <table>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="lblEMIAmount" runat="server" Text="EMI Amount:" CssClass="FieldName"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="lblEMIAmountValue" runat="server" CssClass="Field"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="lblNoOfInstallments" runat="server" Text="Number Of Installments:"
                                                    CssClass="FieldName"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="lblNoOfInstallmentsValue" runat="server" CssClass="Field"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td id="Td2" runat="server">
                                    <asp:Label ID="lblPaymentScheduleHeader" runat="server" Text="Payment Schedule" CssClass="HeaderTextSmall"></asp:Label>
                                </td>
                            </tr>
                            <tr id="Tr3" runat="server">
                                <td id="Td3" runat="server">
                                    <asp:GridView ID="gvRepaymentSchedule" CssClass="GridViewStyle" runat="server" AutoGenerateColumns="False"
                                        ShowFooter="True">
                                        <RowStyle CssClass="RowStyle" />
                                        <AlternatingRowStyle CssClass="AltRowStyle" />
                                        <Columns>
                                            <asp:BoundField DataField="Period" HeaderText="Period">
                                                <HeaderStyle HorizontalAlign="Left" />
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="InstallmentDate" HeaderText="Installment Date">
                                                <HeaderStyle HorizontalAlign="Left" />
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="InstallmentValue" HeaderText="Installment Value">
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Principal" HeaderText="Principal">
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CummulativePrincipal" HeaderText="Cummulative Principal Paid">
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Interest" HeaderText="Interest">
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CummulativeInterest" HeaderText="Cummulative Interest Paid">
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Balance" HeaderText="Balance">
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:BoundField>
                                        </Columns>
                                        <EditRowStyle CssClass="EditRowStyle" />
                                        <FooterStyle CssClass="FooterStyle" />
                                        <HeaderStyle CssClass="HeaderStyle" />
                                        <PagerStyle HorizontalAlign="Center" CssClass="PagerStyle" />
                                        <SelectedRowStyle CssClass="SelectedRowStyle" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </cc1:TabPanel>
                <cc1:TabPanel ID="tabpnlPV" runat="server" HeaderText="Present Value Calculator" Width="100%">
                    <HeaderTemplate>
                        Present Value Calculator</HeaderTemplate>
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td>
                                    <asp:UpdatePanel runat="server" ID="uplPresentValue" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <table>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label ID="Label1" runat="server" Text="Do you wish to input? :" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:DropDownList ID="ddlChooseTypePV" runat="server" 
                                                            CssClass="cmbField" AutoPostBack="True" 
                                                            onselectedindexchanged="ddlChooseTypePV_SelectedIndexChanged">
                                                            <asp:ListItem Value="0" Text="-Select-"></asp:ListItem>
                                                            <asp:ListItem Value="1" Text="Payment Instalment" ></asp:ListItem>
                                                            <asp:ListItem Value="2" Text="Future Value" ></asp:ListItem>
                                                            <asp:ListItem Value="3" Text="Both" ></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="trFutureValue">
                                                    <td align="right">
                                                        <asp:Label ID="lblPVFutureValue" runat="server" Text="Future Value:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtPVFutureValue" runat="server" CssClass="Field"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtPVFutureValue"
                                                            ErrorMessage="Invalid Amount" ValidationExpression="(\$)?(\d)+\,?(\d)+"></asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="trPVPaymentMade">
                                                    <td align="right">
                                                        <asp:Label ID="lblPVPaymentMade" runat="server" Text="Payment Instalment(Loan Instalment):"
                                                            CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtPVPaymentMade" runat="server" CssClass="Field"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtPVPaymentMade"
                                                            ErrorMessage="Invalid Amount" ValidationExpression="(\$)?(\d)+\,?(\d)+"></asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                                
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label ID="lblPVInterestRate" runat="server" Text="Interest Rate(%)p.a:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtPVInterestRate" runat="server" CssClass="Field"></asp:TextBox>
                                                        <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtPVInterestRate"
                                                            Display="Dynamic" ErrorMessage="Invalid!" MaximumValue="99.99" MinimumValue="0.0"
                                                            Type="Double"></asp:RangeValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label ID="lblPaymentFrequency" runat="server" Text="Payment Frequency:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:DropDownList ID="ddlPVPaymentFrequency" runat="server" CssClass="cmbField">
                                                            <asp:ListItem Text="Daily" Value="DA"></asp:ListItem>
                                                            <asp:ListItem Text="Weekly" Value="WK"></asp:ListItem>
                                                            <asp:ListItem Text="FortNightly" Value="FN"></asp:ListItem>
                                                            <asp:ListItem Text="Monthly" Value="MN"></asp:ListItem>
                                                            <asp:ListItem Text="Quarterly" Value="QT"></asp:ListItem>
                                                            <asp:ListItem Text="Half Yearly" Value="HY"></asp:ListItem>
                                                            <asp:ListItem Text="Yearly" Value="YR"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label ID="lblPVNoOfPayments" runat="server" Text="Total No. of Instalments(no.of Periods):"
                                                            CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtPVNoOfPayments" runat="server" CssClass="Field" ToolTip="Input the No. of Years * Payment frequency (eg: Payment frequency is depend on what you have selected in DropDownList i.e. Daily(365),Weekly(52),Half Yearly(2),yearly(1)..etc)"></asp:TextBox>
                                                        <asp:RangeValidator ID="RangeValidator4" runat="server" ControlToValidate="txtPVNoOfPayments"
                                                            Display="Dynamic" ErrorMessage="Invalid!" MaximumValue="99.99" MinimumValue="0.0"
                                                            Type="Double"></asp:RangeValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label ID="txtPVType" runat="server" CssClass="FieldName" Text="Payments Are Due at:"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:RadioButtonList ID="rblPVType" runat="server" CssClass="Field" RepeatDirection="Horizontal"
                                                            Width="347px">
                                                            <asp:ListItem Selected="True" Text="the end of the period" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="the beginning of the period" Value="1"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:Button ID="btnCalculatePV" runat="server" CssClass="PCGButton" OnClick="btnCalculatePV_Click"
                                                            Text="Calculate" />
                                                    </td>
                                                </tr>
                                                <tr id="trPVResult" runat="server" visible="False">
                                                    <td id="Td4" runat="server" align="right">
                                                        <asp:Label ID="lblPV" runat="server" CssClass="FieldName" Text="Present Value:"></asp:Label>
                                                    </td>
                                                    <td id="Td5" runat="server" align="left">
                                                        <asp:Label ID="lblPVValue" runat="server" CssClass="Field"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </cc1:TabPanel>
                <cc1:TabPanel ID="tabpnlFV" runat="server" HeaderText="Future Value Calculator" Width="100%">
                    <HeaderTemplate>
                        Future Value Calculator</HeaderTemplate>
                    <ContentTemplate>
                    <table>
                    <tr>
                    <td>
                     <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Conditional">
                     <ContentTemplate>
                     
                    <table>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label2" runat="server" Text="Do you wish to input? :" CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlchooseTypeFV" runat="server" 
                                        CssClass="cmbField" AutoPostBack="True" 
                                        onselectedindexchanged="ddlchooseTypeFV_SelectedIndexChanged1">
                                        <asp:ListItem Text="-Select-" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Payment Instalment" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Present Value" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Both" Value="3"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr runat="server" id="trFVPresentValue">
                                <td align="right">
                                    <asp:Label ID="lblFVPresentValue" runat="server" Text="Present Value:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFVFutureValue" runat="server" CssClass="Field"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtFVFutureValue"
                                        ErrorMessage="Invalid Amount" ValidationExpression="(\$)?(\d)+\,?(\d)+"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr runat="server" id="trFvPaymentMade">
                                <td align="right">
                                    <asp:Label ID="lblFVPaymentMade" runat="server" Text="Payment Instalment(Loan Instalment):"
                                        CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFVPaymentMade" runat="server" CssClass="Field"></asp:TextBox><asp:RegularExpressionValidator
                                        ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtFVPaymentMade"
                                        ErrorMessage="Invalid Amount" ValidationExpression="(\$)?(\d)+\,?(\d)+"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblFVInterestRate" runat="server" Text="Interest Rate(%)p.a:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFVInterestRate" runat="server" CssClass="Field"></asp:TextBox><asp:RangeValidator
                                        ID="RangeValidator5" runat="server" ControlToValidate="txtFVInterestRate" Display="Dynamic"
                                        ErrorMessage="Invalid!" MaximumValue="99.99" MinimumValue="0.0" Type="Double"></asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblFVPaymentFrequency" runat="server" Text="Payment Frequency:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlFVPaymentFrequency" runat="server" CssClass="cmbField">
                                        <asp:ListItem Text="Daily" Value="DA"></asp:ListItem>
                                        <asp:ListItem Text="Weekly" Value="WK"></asp:ListItem>
                                        <asp:ListItem Text="FortNightly" Value="FN"></asp:ListItem>
                                        <asp:ListItem Text="Monthly" Value="MN"></asp:ListItem>
                                        <asp:ListItem Text="Quarterly" Value="QT"></asp:ListItem>
                                        <asp:ListItem Text="Half Yearly" Value="HY"></asp:ListItem>
                                        <asp:ListItem Text="Yearly" Value="YR"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblFVNoOfPayments" runat="server" Text="Total No. of Instalments(no.of Periods):"
                                        CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFVNoOfPayments" runat="server" CssClass="Field" ToolTip="Input the No. of Years * Payment frequency (eg: Payment frequency is depend on what you have selected in DropDownList i.e. Daily(365),Weekly(52),Half Yearly(2),yearly(1)..etc)"></asp:TextBox>
                                    <asp:RangeValidator ID="RangeValidator7" runat="server" ControlToValidate="txtFVNoOfPayments"
                                                            Display="Dynamic" ErrorMessage="Invalid!" MaximumValue="99.99" MinimumValue="0.0"
                                                            Type="Double"></asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="txtFVType" runat="server" Text="Payments Are Due at:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:RadioButtonList ID="rblFVType" runat="server" CssClass="Field" RepeatDirection="Horizontal">
                                        <asp:ListItem Text="the end of the period" Value="0" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="the beginning of the period" Value="1"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="btnCalculateFV" runat="server" CssClass="PCGButton" OnClick="btnCalculateFV_Click"
                                            Text="Calculate" />
                                    </td>
                                </tr>
                                <tr id="trFVResult" runat="server" visible="False">
                                    <td id="Td6" runat="server" align="right">
                                        <asp:Label ID="lblFV" runat="server" CssClass="FieldName" Text="Future Value:"></asp:Label>
                                    </td>
                                    <td id="Td7" runat="server" align="left">
                                        <asp:Label ID="lblFVValue" runat="server" CssClass="Field"></asp:Label>
                                    </td>
                                </tr>
                            </tr>
                        </table>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                    </td>
                    </tr>
                    </table>
                        
                    </ContentTemplate>
                </cc1:TabPanel>
            </cc1:TabContainer>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hidTabIndex" Value="0" runat="server" />
