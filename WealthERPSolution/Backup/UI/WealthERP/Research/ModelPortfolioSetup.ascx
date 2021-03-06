﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ModelPortfolioSetup.ascx.cs" Inherits="WealthERP.Research.ModelPortfolioSetup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<telerik:RadScriptManager ID="RadScriptManager1" runat="server">
</telerik:RadScriptManager> 

<script src="../Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="../Scripts/jquery-ui-1.7.2.custom.min.js" type="text/javascript"></script>
<script src="../Scripts/jquery.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.3.1.min.js" type="text/javascript"></script>

<script src="../Scripts/jQuery.bubbletip-1.0.6.js" type="text/javascript"></script>

<script type="text/javascript">
    function SumValidate() {
           
        var btnText = document.getElementById("<%=hdnButtonText.ClientID %>").value;        
        var equity = 0;
        var debt = 0;
        var cash = 0;
        var alternate = 0;
        var sum = 0;

        if (btnText == "Edit") {           
            equity = document.getElementById('ctrl_ModelPortfolioSetup_RadGrid1_ctl00_ctl05_txtEquity').value;
            cash = document.getElementById('ctrl_ModelPortfolioSetup_RadGrid1_ctl00_ctl05_txtCash').value;
            alternate = document.getElementById('ctrl_ModelPortfolioSetup_RadGrid1_ctl00_ctl05_txtAlternate').value;
            debt = document.getElementById('ctrl_ModelPortfolioSetup_RadGrid1_ctl00_ctl05_txtDebt').value;
            sum = parseFloat(equity) + parseFloat(cash) + parseFloat(alternate) + parseFloat(debt);
        }
       
        if (btnText == "Insert") {
            equity = document.getElementById('ctrl_ModelPortfolioSetup_RadGrid1_ctl00_ctl02_ctl03_txtEquity').value;
            cash = document.getElementById('ctrl_ModelPortfolioSetup_RadGrid1_ctl00_ctl02_ctl03_txtCash').value;
            alternate = document.getElementById('ctrl_ModelPortfolioSetup_RadGrid1_ctl00_ctl02_ctl03_txtAlternate').value;
            debt = document.getElementById('ctrl_ModelPortfolioSetup_RadGrid1_ctl00_ctl02_ctl03_txtDebt').value;

            sum = parseFloat(equity) + parseFloat(cash) + parseFloat(alternate) + parseFloat(debt);
        }
     
        if (sum == 100) {
            return true;
        }
        else {
            alert('Total allocation should be 100%');       
            return false;           
        }
    }

</script>

<script type="text/javascript">
    $(document).ready(function() {
         $(".flip").click(function() { $(".panel").slideToggle(); });
     });    
</script>
<%--<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
  <script type="text/javascript">
      var popUp;
      function PopUpShowing(sender, eventArgs) {
          popUp = eventArgs.get_popUp();
          var gridWidth = sender.get_element().offsetWidth;
          var gridHeight = sender.get_element().offsetHeight;
          var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("800px"));
          var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("800px"));
          popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
          popUp.style.top = ((gridHeight - popUpHeight) / 2 + sender.get_element().offsetTop).toString() + "px";
      } 
  </script>
</telerik:RadCodeBlock>--%>
    
<table class="TableBackground" style="width: 100%;">
<tr>
    <td class="HeaderTextBig" colspan="2">
        <img src="../Images/helpImage.png" height="25px" width="25px" style="float: right;"
                class="flip" />
            <asp:Label ID="lblAttatchScheme" runat="server" CssClass="HeaderTextBig" Text="SetUp ModelPortfolio"></asp:Label>            
            <hr />
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <div class="panel">
                <p>
                    Add, Edit & Delete the criteria for the Model Portfolio.
                    <%--<br />
                    2.Match orders to the receive transactions.--%>
                </p>
            </div>
        </td>
    </tr>   
</table>

<table id="tableGrid" runat="server" width="100%">
<tr>
    <td>
     <telerik:RadGrid ID="RadGrid1" runat="server" Skin="Telerik" CssClass="RadGrid" GridLines="None" AllowPaging="True" 
    PageSize="20" AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" AllowAutomaticDeletes="false" Height="800px"
    AllowAutomaticInserts="false" OnItemDataBound="RadGrid1_ItemDataBound" OnDataBound="RadGrid1_DataBound" OnDeleteCommand="RadGrid1_DeleteCommand" 
    OnUpdateCommand="RadGrid1_UpdateCommand"  OnItemCommand="RadGrid1_ItemCommand" OnInsertCommand="RadGrid1_InsertCommand"    
    AllowAutomaticUpdates="false" HorizontalAlign="NotSet" DataKeyNames="XAMP_ModelPortfolioCode">
        <MasterTableView CommandItemDisplay="Top" EditMode="PopUp" DataKeyNames="XAMP_ModelPortfolioCode,XRC_RiskClassCode">
            <Columns>
                 <telerik:GridEditCommandColumn UpdateText="Update" UniqueName="EditCommandColumn" EditText="Edit"
                    CancelText="Cancel">
                    <HeaderStyle Width="85px"></HeaderStyle>
                 </telerik:GridEditCommandColumn>
                                 
                <telerik:GridBoundColumn UniqueName="XAMP_ModelPortfolioName" HeaderText="Model Portfolio" DataField="XAMP_ModelPortfolioName">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn UniqueName="XRC_RiskClass" HeaderText="Risk Class" DataField="XRC_RiskClass">
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn UniqueName="XAMP_IsRiskModel" HeaderText="Model Type" DataField="XAMP_IsRiskModel">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="XAMP_MinAUM" HeaderText="Min Investment" DataField="XAMP_MinAUM">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn UniqueName="XAMP_MaxAUM" HeaderText="Max Investment" DataField="XAMP_MaxAUM">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn UniqueName="XAMP_MinAge" HeaderText="Min Age" DataField="XAMP_MinAge">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn UniqueName="XAMP_MaxAge" HeaderText="Max Age" DataField="XAMP_MaxAge">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn UniqueName="XAMP_MinTimeHorizon" HeaderText="Min Time Horizon (Months)" DataField="XAMP_MinTimeHorizon">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn UniqueName="XAMP_MaxTimeHorizon" HeaderText="Max Time Horizon (Months)" DataField="XAMP_MaxTimeHorizon">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn UniqueName="XAMP_Description" HeaderText="Description" DataField="XAMP_Description">
                </telerik:GridBoundColumn>
                
                <%--<telerik:GridBoundColumn UniqueName="AssetClass" HeaderText="Asset Class" DataField="AssetClass">
                </telerik:GridBoundColumn>--%>
                
                <%--<telerik:GridBoundColumn UniqueName="Allocation" HeaderText="% Alloc" DataField="Allocation">
                </telerik:GridBoundColumn>--%>
                
                <telerik:GridBoundColumn UniqueName="XAMP_ROR" HeaderText="ROR(%)" DataField="XAMP_ROR">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn UniqueName="XAMP_RiskPercentage" HeaderText="Risk(%)" DataField="XAMP_RiskPercentage">
                </telerik:GridBoundColumn>
                
                <%--<telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Remove" ConfirmText="Are you sure you want to Remove this Row?" 
                ShowInEditForm="true" ImageUrl="../Images/Telerik/Delete.gif" Text="Remove Row" UniqueName="Remove">
                </telerik:GridButtonColumn>--%> 
                <telerik:GridBoundColumn UniqueName="XAMP_CreatedOn" HeaderText="Created Date" DataField="XAMP_CreatedOn" 
                 DataFormatString="{0:d}" HtmlEncode="false">
                </telerik:GridBoundColumn>
                
                <telerik:GridButtonColumn CommandName="Delete" Text="Delete" ConfirmText="Are you sure you want to Remove this Record?"  UniqueName="DeleteColumn">
                </telerik:GridButtonColumn>
            </Columns>
            <EditFormSettings InsertCaption="Add" FormTableStyle-HorizontalAlign="Center" CaptionFormatString="Edit" FormCaptionStyle-CssClass="TableBackground"
            PopUpSettings-Modal="true" PopUpSettings-ZIndex="20" EditFormType="Template" FormCaptionStyle-Width="100%" 
            PopUpSettings-Height="500px" PopUpSettings-Width="900px">            
                <FormTemplate>
                    <table>
                      <tr id="trAddNamePortfolio" runat="server">
                        <td class="leftField">
                            <asp:Label ID="lblNamePortfolio" runat="server" Text="Portfolio Name :" CssClass="FieldName"></asp:Label>
                        </td>
                        <td class="rightField">
                            <asp:TextBox ID="txtNamePortfolio" CssClass="txtField" Text='<%# Bind( "XAMP_ModelPortfolioName") %>' runat="server">
                            </asp:TextBox> <span id="Span6" class="spnRequiredField">*</span>                              
                        </td>
                        <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtNamePortfolio"
                            ErrorMessage="Please Name the Portfolio" Display="Dynamic" runat="server"
                            CssClass="rfvPCG" ValidationGroup="Button1">
                        </asp:RequiredFieldValidator>
                        </td>
                      </tr>
                      <tr id="trRiskClassDdl" runat="server">
                        <td class="leftField">
                            <asp:Label ID="lblPickClass" runat="server" Text="Risk class :" CssClass="FieldName"></asp:Label>
                        </td>
                        <td class="rightField">
                           <asp:DropDownList ID="ddlPickRiskClass" runat="server" CssClass="cmbField" >                                                                             
                           </asp:DropDownList><span id="Span1" class="spnRequiredField">*</span>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" Text="Please Select Risk Class" InitialValue="Select Risk Class" 
                            ControlToValidate="ddlPickRiskClass" Display="Dynamic" runat="server"
                            CssClass="rfvPCG" ValidationGroup="Button1">
                            </asp:RequiredFieldValidator>
                        </td>
                      </tr>
                      <tr id="trRiskClassTxt" runat="server">
                        <td class="leftField">
                            <asp:Label ID="lblClass" runat="server" Text="Risk class :" CssClass="FieldName"></asp:Label>
                        </td>
                        <td class="rightField">
                           <asp:TextBox ID="txtPickRiskClass" CssClass="txtField" Text='<%# Bind( "XRC_RiskClass") %>' Enabled="false" runat="server">
                           </asp:TextBox>
                        </td>
                      </tr>
                      <tr id="trIsRiskClass" runat="server">
                        <td class="leftField">
                            <asp:Label ID="lblIsRiskClass" runat="server" Text="Select Model Type:" CssClass="FieldName"></asp:Label>
                        </td>
                        <td class="rightField">
                           <asp:DropDownList ID="ddlModelType" runat="server" AutoPostBack="true" CssClass="cmbField" onselectedindexchanged="ddlModelType_SelectedIndexChanged">      
                          <asp:ListItem Text="Goal Profile" Value="GC"></asp:ListItem> 
                            <asp:ListItem Text="Risk Profile" Value="RC"></asp:ListItem>   
                                                                           
                           </asp:DropDownList><span id="Span9" class="spnRequiredField">*</span>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Text="Please Select Model Type" InitialValue="Select Model Type" 
                            ControlToValidate="ddlModelType" Display="Dynamic" runat="server"
                            CssClass="rfvPCG" ValidationGroup="Button1">
                            </asp:RequiredFieldValidator>
                        </td>
                      </tr>
                       <tr id="trIsRiskClassText" runat="server">
                        <td class="leftField">
                            <asp:Label ID="lblIsRiskClassText" runat="server" Text="Model Type:" CssClass="FieldName"></asp:Label>
                        </td>
                        <td class="rightField">
                           <asp:TextBox ID="txtIsRiskClass" CssClass="txtField" Text='<%# Bind( "XAMP_IsRiskModel") %>' Enabled="false" runat="server">
                           </asp:TextBox>
                        </td>
                      </tr>
                      <tr>
                        <td class="leftField">
                            <asp:Label ID="lblDescription" runat="server" Text="Description :" CssClass="FieldName"></asp:Label>
                        </td>
                        <td class="rightField" colspan="4">
                            <asp:TextBox ID="txtDescription" TextMode="MultiLine" Text='<%# Bind( "XAMP_Description") %>'
                            Width="250px" Height="80Px" runat="server">
                            </asp:TextBox>
                        </td>
                      </tr>
                      <tr>
                        <td></td>
                        <td align="center">
                            <asp:Label ID="lblDebt" runat="server" Text="Debt(%)" CssClass="FieldName"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblEquity" runat="server" Text="Equity(%)" CssClass="FieldName"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblCash" runat="server" Text="Cash(%)" CssClass="FieldName"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblAlternate" runat="server" Text="Alternate(%)" CssClass="FieldName"></asp:Label>
                        </td>
                      </tr>
                      
                      <tr>
                        <td></td>
                        <td>
                            <asp:TextBox ID="txtDebt" runat="server" Text='<%# Bind( "Debt") %>' CssClass="txtField">
                            </asp:TextBox><span id="Span2" class="spnRequiredField">*</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEquity" runat="server" Text='<%# Bind( "Equity") %>' CssClass="txtField">
                            </asp:TextBox><span id="Span3" class="spnRequiredField">*</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCash" runat="server" Text='<%# Bind( "Cash") %>' CssClass="txtField">
                            </asp:TextBox><span id="Span4" class="spnRequiredField">*</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAlternate" runat="server" Text='<%# Bind( "Alternate") %>' CssClass="txtField">
                            </asp:TextBox><span id="Span5" class="spnRequiredField">*</span>
                        </td>
                      </tr>
                      <tr>
                        <td></td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ControlToValidate="txtDebt"
                                ErrorMessage="Enter the debt allocation" Display="Dynamic" runat="server"
                                CssClass="rfvPCG" ValidationGroup="Button1">
                            </asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="rvAssumptionValue" runat="server" 
                            ControlToValidate="txtDebt" CssClass="cvPCG" Display="Dynamic" 
                            ErrorMessage="Enter value less than 100" MaximumValue="100" 
                            MinimumValue="0.0" Type="Double" ValidationGroup="Button1"></asp:RangeValidator>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="txtEquity"
                                ErrorMessage="Enter the equity allocation" Display="Dynamic" runat="server"
                                CssClass="rfvPCG" ValidationGroup="Button1">
                            </asp:RequiredFieldValidator>
                             
                            <asp:RangeValidator ID="RangeValidator1" runat="server" 
                              ControlToValidate="txtEquity" CssClass="cvPCG" Display="Dynamic" 
                              ErrorMessage="Enter value less than 100" MaximumValue="100" 
                              MinimumValue="0.0" Type="Double" ValidationGroup="Button1"></asp:RangeValidator>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ControlToValidate="txtCash"
                                ErrorMessage="Enter the cash allocation" Display="Dynamic" runat="server"
                                CssClass="rfvPCG" ValidationGroup="Button1">
                            </asp:RequiredFieldValidator>
                             
                            <asp:RangeValidator ID="RangeValidator2" runat="server" 
                              ControlToValidate="txtCash" CssClass="cvPCG" Display="Dynamic" 
                              ErrorMessage="Enter value less than 100" MaximumValue="100" 
                              MinimumValue="0.0" Type="Double" ValidationGroup="Button1"></asp:RangeValidator>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ControlToValidate="txtAlternate"
                                ErrorMessage="Enter the alternate allocation" Display="Dynamic" runat="server"
                                CssClass="rfvPCG" ValidationGroup="Button1">
                            </asp:RequiredFieldValidator>
                             
                            <asp:RangeValidator ID="RangeValidator3" runat="server" 
                              ControlToValidate="txtAlternate" CssClass="cvPCG" Display="Dynamic" 
                              ErrorMessage="Enter value less than 100" MaximumValue="100" 
                              MinimumValue="0.0" Type="Double" ValidationGroup="Button1"></asp:RangeValidator>
                              
                              
                            <%-- <asp:CustomValidator id="CustomValidator1" runat=server ControlToValidate = "txtDebt"
                                  ValidationGroup="Button1" ErrorMessage = "Allocation sum must be 100%!" Display="Dynamic"
                                  ClientValidationFunction="validateLength" >
                             </asp:CustomValidator>--%>
                        </td>
                      </tr>
                      <tr>
                        <td></td>
                        <td align="center">
                            <asp:Label ID="lblMin" runat="server" Text="Minimum" CssClass="FieldName"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblMax" runat="server" Text="Maximum" CssClass="FieldName"></asp:Label>
                        </td>    
                      </tr>
                      <tr id="trInvestmentAmount" runat="server">
                        <td class="leftField" style="width:130px">
                            <asp:Label ID="lblInvestmentAmount" runat="server" Text="Investment Amount:" CssClass="FieldName"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMinAUM" runat="server" Text='<%# Bind("MinAUM") %>' CssClass="txtField">
                            </asp:TextBox>                            
                        </td>
                        <td>
                            <asp:TextBox ID="txtMaxAUM" runat="server" Text='<%# Bind("MaxAUM") %>' CssClass="txtField">
                            </asp:TextBox>                           
                        </td>
                      </tr>
                      <tr>
                        <td></td>
                        <td>
                            <asp:RegularExpressionValidator runat="server" id="rexMinAUM" controltovalidate="txtMinAUM" validationexpression="^([0-9]*|\d*\.\d{1}?\d*)$" 
                            Display="Dynamic" CssClass="cvPCG" ValidationGroup="Button1" errormessage="Invalid min amount" />
                        </td>
                        <td>
                            <asp:RegularExpressionValidator runat="server" id="rexMaxAUM" controltovalidate="txtMaxAUM" validationexpression="^([0-9]*|\d*\.\d{1}?\d*)$" 
                            Display="Dynamic" CssClass="cvPCG" ValidationGroup="Button1" errormessage="Invalid max amount" />
                        </td>
                      </tr>
                      <tr>
                        <td class="leftField">
                            <asp:Label ID="lblAge" runat="server" Text="Age (Years) :" CssClass="FieldName"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMinAge" runat="server" Text='<%# Bind( "XAMP_MinAge") %>' CssClass="txtField">
                            </asp:TextBox><span id="Span7" class="spnRequiredField">*</span>
                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server"
                                TargetControlID="txtMinAge" WatermarkText="Years">
                            </cc1:TextBoxWatermarkExtender> 
                            <asp:RequiredFieldValidator ID="rfvMinAge" ControlToValidate="txtMinAge"
                            ErrorMessage="<br />Please enter the Minimum age" Display="Dynamic" runat="server"
                            CssClass="rfvPCG" ValidationGroup="Button1"></asp:RequiredFieldValidator> 
                            <asp:RangeValidator ID="rvMinAge" CssClass="cvPCG" runat="server" ValidationGroup="Button1" ErrorMessage="<br />Age should lie between the range of 1 and 150" ControlToValidate="txtMinAge" MinimumValue="1" MaximumValue="150" Display="Dynamic" Type="Double"></asp:RangeValidator>
                                    <%--<asp:CompareValidator ID="cv2MinAge" runat="server"  ErrorMessage="<br />Age should be greater than or equal to 20"
                            ControlToValidate="txtMinAge" ValueToCompare="20" Operator="GreaterThanEqual"
                            CssClass="cvPCG" Display="Dynamic" ValidationGroup="Button1"></asp:CompareValidator> --%>                          
                        </td>
                        <td>
                            <asp:TextBox ID="txtMaxAge" runat="server" Text='<%# Bind( "XAMP_MaxAge") %>' CssClass="txtField">
                            </asp:TextBox><span id="Span8" class="spnRequiredField">*</span>
                             <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server"
                                TargetControlID="txtMaxAge" WatermarkText="Years">
                            </cc1:TextBoxWatermarkExtender> 
                            <asp:RequiredFieldValidator ID="rfvMaxAge" ControlToValidate="txtMaxAge"
                            ErrorMessage="<br />Please enter the maximum age" Display="Dynamic" runat="server"
                            CssClass="rfvPCG" ValidationGroup="Button1"></asp:RequiredFieldValidator>
                            
                            <asp:CompareValidator ID="cv2MaxAge" runat="server" ErrorMessage="<br />Max age should be greater than min age" Type="Integer"
                             ControlToValidate="txtMaxAge" ControlToCompare="txtMinAge" Operator="GreaterThanEqual"
                            CssClass="cvPCG" Display="Dynamic" ValidationGroup="Button1"></asp:CompareValidator>                              
                        </td>
                      </tr>
                      <tr>
                        <td></td>
                        <td>
                            <asp:RegularExpressionValidator runat="server" id="rexMinAge" controltovalidate="txtMinAge" validationexpression="^\d+$" 
                            Display="Dynamic" CssClass="cvPCG" ValidationGroup="Button1"  errormessage="Invalid min age" />
                        </td>
                        <td>
                            <asp:RegularExpressionValidator runat="server" id="rexMaxAge" controltovalidate="txtMaxAge" validationexpression="^\d+$" 
                            Display="Dynamic" CssClass="cvPCG" ValidationGroup="Button1" errormessage="Invalid max age" />
                        </td>
                      </tr>
                      <%--<tr>
                        <td></td>
                        <td align="center">
                            <asp:Label ID="lblMinTimeHorizonYear" runat="server" Text="Minimum year" CssClass="FieldName"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblMinTimeHorizonMonth" runat="server" Text="Minimum month" CssClass="FieldName"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblMaxTimeHorizonYear" runat="server" Text="Maximum year" CssClass="FieldName"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblMaxTimeHorizonMonth" runat="server" Text="Maximum month" CssClass="FieldName"></asp:Label>
                        </td>
                      </tr>--%>
                      <%--<tr>
                        <td class="leftField">
                            <asp:Label ID="lblTimeHorizon" runat="server" Text="Time Horizon (Year):" CssClass="FieldName"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMinTimeHorizonYear" runat="server"  Text='<%# Bind( "MinYear") %>' CssClass="txtField">
                            </asp:TextBox>
                            <cc1:TextBoxWatermarkExtender ID="txtMinTimeHorizonYear_TextBoxWatermarkExtender" runat="server"
                                TargetControlID="txtMinTimeHorizonYear" WatermarkText="Minimum year">
                            </cc1:TextBoxWatermarkExtender>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMaxTimeHorizonYear" runat="server" Text='<%# Bind( "MaxYear") %>' CssClass="txtField">
                            </asp:TextBox>
                            <cc1:TextBoxWatermarkExtender ID="txtMaxTimeHorizonYear_TextBoxWatermarkExtender" runat="server"
                                TargetControlID="txtMaxTimeHorizonYear" WatermarkText="Maximum year">
                            </cc1:TextBoxWatermarkExtender>
                        </td>
                      </tr>--%>
                      <tr id="trTimeHorizon" runat="server">
                        <td class="leftField">
                            <asp:Label ID="Label1" runat="server" Text="Time Horizon(Months):" CssClass="FieldName"></asp:Label>
                        </td>
                        
                        <td>
                            <asp:TextBox ID="txtMinTimeHorizonMonth" runat="server" Text='<%# Bind( "MinMonth") %>' CssClass="txtField">
                            </asp:TextBox>
                            <cc1:TextBoxWatermarkExtender ID="txtMinTimeHorizonMonth_TextBoxWatermarkExtender" runat="server"
                                TargetControlID="txtMinTimeHorizonMonth" WatermarkText="Months">
                            </cc1:TextBoxWatermarkExtender>                            
                        </td>
                        <td>
                            <asp:TextBox ID="txtMaxTimeHorizonMonth" runat="server" Text='<%# Bind( "MaxMonth") %>' CssClass="txtField">
                            </asp:TextBox>
                            <cc1:TextBoxWatermarkExtender ID="txtMaxTimeHorizonMonth_TextBoxWatermarkExtender" runat="server"
                                TargetControlID="txtMaxTimeHorizonMonth" WatermarkText="Months">
                            </cc1:TextBoxWatermarkExtender>                            
                        </td>
                      </tr>
                      <tr>
                        <td></td>
                        <td>
                            <asp:RegularExpressionValidator runat="server" id="rexMinMonth" controltovalidate="txtMinTimeHorizonMonth" validationexpression="^\d+$" 
                            Display="Dynamic" CssClass="cvPCG" ValidationGroup="Button1" errormessage="Invalid time" />
                        </td>
                        <td>
                            <asp:RegularExpressionValidator runat="server" id="rexMaxMonth" controltovalidate="txtMaxTimeHorizonMonth" validationexpression="^\d+$" 
                            Display="Dynamic" CssClass="cvPCG" ValidationGroup="Button1" errormessage="Invalid time" />
                        </td>
                      </tr>
                      <tr>
                            <td align="right" colspan="2">
                                <asp:Button ID="Button1" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' ValidationGroup="Button1" 
                                  CssClass="PCGButton"   runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' OnClientClick="return SumValidate();">
                                </asp:Button>&nbsp;
                                <asp:Button ID="Button2" CssClass="PCGButton" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel">
                                </asp:Button>
                            </td>
                            <td>
                            </td>
                        </tr>
                      </table>
                </FormTemplate>
            </EditFormSettings>
        </MasterTableView>
        <ClientSettings>
        <ClientEvents />
           <%--<ClientEvents OnPopUpShowing="PopUpShowing" />--%>
        </ClientSettings>
    </telerik:RadGrid>     
    </td>
    <td></td>
    </tr>
<%--<tr>
    <td>
        <asp:Button ID="btnSubmit" runat="server" CssClass="PCGButton" Text="Submit" onclick="btnSubmit_Click" 
           />
    </td>
    <td></td>
    </tr>
  --%>
</table>

<asp:HiddenField ID="hdnButtonText" runat="server" />