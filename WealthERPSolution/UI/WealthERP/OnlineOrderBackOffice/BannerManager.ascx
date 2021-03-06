﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BannerManager.ascx.cs"
    Inherits="WealthERP.OnlineOrderBackOffice.BannerManager" %>
<%--<%@ Register Src="~/General/Pager.ascx" TagPrefix="Pager" TagName="Pager" %>
--%><%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
--%><%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
<style type="text/css">
    .GridPager a, .GridPager span
    {
    }
    .GridPager a
    {
        color: #969696;
    }
    .GridPager span
    {
        color: #000;
    }
</style>

<script type="text/javascript" language="javascript">
    function keyPress(sender, args) {
        if (args.keyCode == 13) {
            return false;
        }
    }

</script>

<telerik:RadScriptManager ID="RadScriptManager1" runat="server">
</telerik:RadScriptManager>
<table width="100%">
    <tr>
        <td colspan="3" style="width: 100%;">
            <div class="divPageHeading">
                <table cellspacing="0" width="100%">
                    <tr>
                        <td align="left">
                            Content Manager
                        </td>
                        <td align="right" id="td4" runat="server" style="padding-bottom: 2px;">
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<telerik:RadTabStrip ID="RadTabStripAdsUpload" runat="server" EnableTheming="True"
    Skin="Telerik" EnableEmbeddedSkins="False" MultiPageID="multipageAdsUpload" SelectedIndex="0">
    <Tabs>
        <telerik:RadTab runat="server" Text="Banner Management" Value="Banner" TabIndex="0">
        </telerik:RadTab>
        <telerik:RadTab runat="server" Text="Scroller Management" Value="Scroller">
        </telerik:RadTab>
        <telerik:RadTab runat="server" Text="Demo Video Management" Value="Demo">
        </telerik:RadTab>
        <telerik:RadTab runat="server" Text="FAQ Management" Value="FAQ">
        </telerik:RadTab>
        <telerik:RadTab runat="server" Text="Customer Notification" Value="Notification">
        </telerik:RadTab>
        <telerik:RadTab runat="server" Text="MF Scheme Rank" Value="MFRank">
        </telerik:RadTab>
    </Tabs>
</telerik:RadTabStrip>
<telerik:RadMultiPage ID="multipageAdsUpload" EnableViewState="true" runat="server">
    <telerik:RadPageView ID="rpvBanner" runat="server">
        <asp:Panel ID="Banner">
            <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

                <script type="text/javascript">
                    var uploadedFilesCount = 0;
                    var isEditMode;
                    function validateRadUpload(source, e) {
                        // When the RadGrid is in Edit mode the user is not obliged to upload file.
                        if (isEditMode == null || isEditMode == undefined) {
                            e.IsValid = false;

                            if (uploadedFilesCount > 0) {
                                e.IsValid = true;
                            }
                        }
                        isEditMode = null;
                    }

                    function OnClientFileUploaded(sender, eventArgs) {
                        uploadedFilesCount++;
                    }




                    
                    }
             
                </script>

            </telerik:RadCodeBlock>
            <table id="tableGrid" runat="server" width="40%">
                <tr>
                    <td>
                        <telerik:RadGrid ID="RadGrid1" runat="server" Skin="Telerik" CssClass="GridPager"
                            GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                            ShowStatusBar="true" AllowAutomaticDeletes="false" AllowAutomaticInserts="false"
                            OnItemCreated="RadGrid1_ItemCreated" PageSize="3" OnInsertCommand="RadGrid1_InsertCommand"
                            OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand"
                            OnUpdateCommand="RadGrid1_UpdateCommand" OnItemCommand="RadGrid1_ItemCommand"
                            OnItemDataBound="RadGrid1_ItemDataBound" AllowAutomaticUpdates="false" HorizontalAlign="NotSet"
                            DataKeyNames="PBD_Id,PDB_ExpiryDate,PAG_AssetGroupCode">
                            <MasterTableView CommandItemDisplay="Top" EditMode="PopUp" DataKeyNames="PBD_Id,PDB_ExpiryDate,PAG_AssetGroupCode">
                                <Columns>
                                    <telerik:GridEditCommandColumn EditText="Update" UniqueName="editColumn" CancelText="Cancel"
                                        UpdateText="Update">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridBoundColumn UniqueName="PAG_AssetGroupName" HeaderText="Asset Group"
                                        DataField="PAG_AssetGroupName">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="PDB_ExpiryDate" HeaderText="Expiry Date" DataField="PDB_ExpiryDate">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="PDB_BannerImage" HeaderText="image Name" DataField="PDB_BannerImage">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn UniqueName="deleteColumn" ConfirmText="Are you sure you want to delete this Banner?"
                                        ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="LinkButton" CommandName="Delete"
                                        Text="Delete">
                                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings InsertCaption="Add" FormTableStyle-HorizontalAlign="Center" CaptionFormatString="Edit"
                                    FormCaptionStyle-CssClass="TableBackground" PopUpSettings-Modal="true" PopUpSettings-ZIndex="20"
                                    EditFormType="Template" FormCaptionStyle-Width="100%" PopUpSettings-Height="300px"
                                    PopUpSettings-Width="500px">
                                    <FormTemplate>
                                        <table>
                                            <tr id="trAddCategory">
                                                <td class="leftField">
                                                    <asp:Label ID="lblAssetGroup" runat="server" Text="AssetGroup:" CssClass="FieldName"></asp:Label>
                                                </td>
                                                <td class="rightField">
                                                    <asp:DropDownList ID="ddlAssetGroupName" runat="server" CssClass="cmbLongField" DataValueField='<%# Eval("PAG_AssetGroupCode") %>'>
                                                        <asp:ListItem Selected="True" Value="0">SELECT</asp:ListItem>
                                                        <asp:ListItem Selected="False" Value="IP">IPO</asp:ListItem>
                                                        <asp:ListItem Selected="False" Value="FI">BOND</asp:ListItem>
                                                        <asp:ListItem Selected="False" Value="MF">Mutual Fund</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <span id="Span2" class="spnRequiredField">*</span>
                                                    <br />
                                                    <asp:RequiredFieldValidator ID="Requiredfieldvalidator2" runat="server" ControlToValidate="ddlAssetGroupName"
                                                        ErrorMessage="Please,Select an AssetGroup." InitialValue="0" ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup" : "btnUpdateGroup" %>'
                                                        SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr id="trRiskClassTxt">
                                                <td class="leftField">
                                                    <asp:Label ID="lblExpireDate" runat="server" Text="ExpireDate:" CssClass="FieldName"></asp:Label>
                                                </td>
                                                <td class="rightField">
                                                    <telerik:RadDateTimePicker runat="server" ID="dtpExpireDate">
                                                        <Calendar ID="Calendar4" runat="server" EnableKeyboardNavigation="true">
                                                        </Calendar>
                                                    </telerik:RadDateTimePicker>
                                                    <span id="Span6" class="spnRequiredField">*</span>
                                                    <br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="dtpExpireDate"
                                                        ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup" : "btnUpdateGroup" %>'
                                                        ErrorMessage="Please select an Expire Date" Display="Dynamic" runat="server"
                                                        CssClass="rfvPCG">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr id="tr1">
                                                <td class="leftField">
                                                </td>
                                                <td class="rightField">
                                                    <asp:FileUpload ID="FileUpload" runat="server" Height="22px" />
                                                    <span id="Span1" class="spnRequiredField">*</span>
                                                    <br />
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="FileUpload"
                                                        runat="Server" ValidationGroup="btnInsertGroup" ErrorMessage="Only .jpeg,.jpg, .gif and.png File allowed"
                                                        Display="Dynamic" ValidationExpression="^.*\.((j|J)(p|P)(e|E)(g|G)|(j|J)(p|P)(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$"
                                                        CssClass="rfvPCG" />
                                                    <br />
                                                    <asp:RequiredFieldValidator ID="FileUpload_RequiredFieldValidator" ControlToValidate="FileUpload"
                                                        ValidationGroup="btnInsertGroup" ErrorMessage="Please select an image for upload."
                                                        Display="Dynamic" runat="server" CssClass="rfvPCG">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="2">
                                                    <asp:Button ID="Button1" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                                        ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup" : "btnUpdateGroup" %>'
                                                        CssClass="PCGButton" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'>
                                                    </asp:Button>&nbsp;
                                                    <asp:Button ID="Button2" CssClass="PCGButton" Text="Cancel" runat="server" CausesValidation="False"
                                                        CommandName="Cancel"></asp:Button>
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
                            </ClientSettings>
                        </telerik:RadGrid>
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hdnButtonText" runat="server" />
        </asp:Panel>
    </telerik:RadPageView>
    <telerik:RadPageView ID="rpvScroller" runat="server">
        <asp:Panel ID="Scroller" runat="server">
            <telerik:RadGrid ID="RadGrid2" runat="server" Skin="Telerik" GridLines="None" AllowPaging="True"
                AllowSorting="True" CssClass="GridPager" AutoGenerateColumns="False" ShowStatusBar="true" AllowAutomaticDeletes="false"
                AllowAutomaticInserts="false" PageSize="3" OnInsertCommand="RadGrid2_InsertCommand"
                OnNeedDataSource="RadGrid2_NeedDataSource" OnDeleteCommand="RadGrid2_DeleteCommand"
                OnUpdateCommand="RadGrid2_UpdateCommand" OnItemCommand="RadGrid2_ItemCommand"
                OnItemDataBound="RadGrid2_ItemDataBound" AllowAutomaticUpdates="false" HorizontalAlign="NotSet"
                DataKeyNames="PUHD_Id,PUHD_IsActive,PAG_AssetGroupCode,PUHD_HelpDetails">
                <MasterTableView CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="PUHD_Id,PUHD_CreatedOn,PUHD_IsActive,PAG_AssetGroupCode,PUHD_HelpDetails">
                    <Columns>
                        <telerik:GridEditCommandColumn EditText="Update" UniqueName="editColumn" CancelText="Cancel"
                            UpdateText="Update">
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="PAG_AssetGroupName" HeaderText="Asset Group"
                            DataField="PAG_AssetGroupName">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="PUHD_HelpDetails" HeaderText="Scroller Text"
                            DataField="PUHD_HelpDetails">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="PUHD_CreatedOn" HeaderText="Created On" DataField="PUHD_CreatedOn">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="PUHD_IsActive" HeaderText="Is Active" DataField="PUHD_IsActive">
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn UniqueName="deleteColumn" ConfirmText="Are you sure you want to delete this ?"
                            ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="LinkButton" CommandName="Delete"
                            Text="Delete">
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings InsertCaption="Add" FormTableStyle-HorizontalAlign="Center" CaptionFormatString="Edit"
                        FormCaptionStyle-CssClass="TableBackground" PopUpSettings-Modal="true" PopUpSettings-ZIndex="20"
                        EditFormType="Template" FormCaptionStyle-Width="100%" PopUpSettings-Height="300px"
                        PopUpSettings-Width="500px">
                        <FormTemplate>
                            <table>
                                <tr id="trAddCategory">
                                    <td class="leftField">
                                        <asp:Label ID="lblAssetGroup1" runat="server" Text="AssetGroup:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:DropDownList ID="ddlAssetGroupName1" runat="server" CssClass="cmbLongField"
                                            DataValueField='<%# Eval("PAG_AssetGroupCode") %>'>
                                            <asp:ListItem Selected="True" Value="0">SELECT</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="IP">IPO</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="FI">BOND</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="MF">Mutual Fund</asp:ListItem>
                                        </asp:DropDownList>
                                        <span id="Span2" class="spnRequiredField">*</span>
                                        <br />
                                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator3" runat="server" ControlToValidate="ddlAssetGroupName1"
                                            ErrorMessage="Please,Select an AssetGroup." InitialValue="0" ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="tr2">
                                    <td class="leftField">
                                        <asp:Label ID="Label1" runat="server" Text="Scroller Text:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" CssClass="txtField"
                                            Text='<%# Eval("PUHD_HelpDetails") %>'></asp:TextBox>
                                        <span id="Span3" class="spnRequiredField">*</span>
                                        <br />
                                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator4" runat="server" ControlToValidate="TextBox1"
                                            ErrorMessage="Scroller Text can't be blank." ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="tr3">
                                    <td class="leftField">
                                        <asp:Label ID="Label2" runat="server" Text="IS Active:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:CheckBox ID="CheckBox" runat="server" Checked='<%# Convert.IsDBNull(Eval("PUHD_IsActive")) ? false :Convert.ToInt16( Eval("PUHD_IsActive"))==1 ? true : false %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button ID="Button1" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                            ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            CssClass="PCGButton" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'>
                                        </asp:Button>&nbsp;
                                        <asp:Button ID="Button2" CssClass="PCGButton" Text="Cancel" runat="server" CausesValidation="False"
                                            CommandName="Cancel"></asp:Button>
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
                </ClientSettings>
            </telerik:RadGrid>
        </asp:Panel>
    </telerik:RadPageView>
    <telerik:RadPageView ID="rpvDemo" runat="server">
        <asp:Panel ID="Panel1" runat="server">
            <telerik:RadGrid ID="RadGrid3" runat="server" Skin="Telerik" CssClass="RadGrid" GridLines="None"
                AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true"
                AllowAutomaticDeletes="false" AllowAutomaticInserts="false" PageSize="3" OnInsertCommand="RadGrid3_InsertCommand"
                OnNeedDataSource="RadGrid3_NeedDataSource" OnDeleteCommand="RadGrid3_DeleteCommand"
                OnUpdateCommand="RadGrid3_UpdateCommand" OnItemCommand="RadGrid3_ItemCommand"
                OnItemDataBound="RadGrid3_ItemDataBound" AllowAutomaticUpdates="false" HorizontalAlign="NotSet"
                DataKeyNames="PUHD_Id,PUHD_IsActive,PAG_AssetGroupCode,PUHD_HelpDetails,PUHD_Heading,PUHD_HelpFormatType">
                <MasterTableView CommandItemDisplay="Top" EditMode="PopUp" DataKeyNames="PUHD_Id,PUHD_IsActive,PUHD_CreatedOn,PAG_AssetGroupCode,PUHD_HelpDetails,PUHD_Heading,PUHD_HelpFormatType">
                    <Columns>
                        <telerik:GridEditCommandColumn EditText="Update" UniqueName="editColumn" CancelText="Cancel"
                            UpdateText="Update">
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="PAG_AssetGroupName" HeaderText="Asset Group"
                            DataField="PAG_AssetGroupName">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="PUHD_Heading" HeaderText="Video Heading" DataField="PUHD_Heading">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="PUHD_HelpDetails" HeaderText="Video Link" DataField="PUHD_HelpDetails">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="PUHD_CreatedOn" HeaderText="Created On" DataField="PUHD_CreatedOn">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="PUHD_IsActive" HeaderText="Is Active" DataField="PUHD_IsActive">
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn UniqueName="deleteColumn" ConfirmText="Are you sure you want to delete this ?"
                            ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="LinkButton" CommandName="Delete"
                            Text="Delete">
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings InsertCaption="Add" FormTableStyle-HorizontalAlign="Center" CaptionFormatString="Edit"
                        FormCaptionStyle-CssClass="TableBackground" PopUpSettings-Modal="true" PopUpSettings-ZIndex="20"
                        EditFormType="Template" FormCaptionStyle-Width="100%" PopUpSettings-Height="300px"
                        PopUpSettings-Width="500px">
                        <FormTemplate>
                            <table>
                                <tr id="trAddCategory">
                                    <td class="leftField">
                                        <asp:Label ID="lblAssetGroup1" runat="server" Text="AssetGroup:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:DropDownList ID="ddlAssetGroupName1" runat="server" CssClass="cmbLongField"
                                            DataValueField='<%# Eval("PAG_AssetGroupCode") %>'>
                                            <asp:ListItem Selected="True" Value="0">SELECT</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="IP">IPO</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="FI">BOND</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="MF">Mutual Fund</asp:ListItem>
                                        </asp:DropDownList>
                                        <span id="Span2" class="spnRequiredField">*</span>
                                        <br />
                                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator3" runat="server" ControlToValidate="ddlAssetGroupName1"
                                            ErrorMessage="Please,Select an AssetGroup." InitialValue="0" ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="tr4">
                                    <td class="leftField">
                                        <asp:Label ID="Label3" runat="server" Text="Video Heading:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:TextBox ID="txtDemoHeading" runat="server" TextMode="MultiLine" CssClass="txtField"
                                            Text='<%# Eval("PUHD_Heading") %>'></asp:TextBox>
                                        <span id="Span4" class="spnRequiredField">*</span>
                                        <br />
                                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator5" runat="server" ControlToValidate="txtDemoHeading"
                                            ErrorMessage="Video Heading can't be blank." ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="tr5">
                                    <td class="leftField">
                                        <asp:Label ID="Label4" runat="server" Text="Content Format:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:DropDownList ID="ddlFormatType" AutoPostBack="true" runat="server" CssClass="cmbLongField"
                                            OnSelectedIndexChanged="ddlFormatType_SelectedIndexChanged" DataValueField='<%# Eval("PUHD_HelpFormatType") %>'>
                                            <asp:ListItem Selected="True" Value="0">SELECT</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="YTL">YouTube Link</asp:ListItem>
                                            <asp:ListItem Selected="False" Value="PDF">PDF</asp:ListItem>
                                        </asp:DropDownList>
                                        <span id="Span5" class="spnRequiredField">*</span>
                                        <br />
                                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator6" runat="server" ControlToValidate="ddlFormatType"
                                            ErrorMessage="Please,Select an Format Type." InitialValue="0" ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="tr2" runat="server" visible="false">
                                    <td class="leftField">
                                        <asp:Label ID="Label1" runat="server" Text="Video Link:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" CssClass="txtField"
                                            Text='<%# Eval("PUHD_HelpDetails") %>'></asp:TextBox>
                                        <span id="Span3" class="spnRequiredField">*</span>
                                        <br />
                                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator4" runat="server" ControlToValidate="TextBox1"
                                            ErrorMessage="Video Link can't be blank." ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="tr6" runat="server" visible="false">
                                    <td class="leftField">
                                    </td>
                                    <td class="rightField">
                                        <asp:FileUpload ID="VideoFileUpload" runat="server" Height="22px" />
                                        <span id="Span1" class="spnRequiredField">*</span>
                                        <br />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="VideoFileUpload"
                                            runat="Server" ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            ErrorMessage="Only .pdf File allowed" Display="Dynamic" ValidationExpression="^.*\.((p|P)(d|D)(f|F))$"
                                            CssClass="rfvPCG" />
                                        <br />
                                        <asp:RequiredFieldValidator ID="FileUpload_RequiredFieldValidator" ControlToValidate="VideoFileUpload"
                                            ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            ErrorMessage="Please select an pdf for upload." Display="Dynamic" runat="server"
                                            CssClass="rfvPCG">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="tr3">
                                    <td class="leftField">
                                        <asp:Label ID="Label2" runat="server" Text="IS Active:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:CheckBox ID="CheckBox" runat="server" Checked='<%# Convert.IsDBNull(Eval("PUHD_IsActive")) ? false :Convert.ToInt16( Eval("PUHD_IsActive"))==1 ? true : false %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button ID="Button1" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                            ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            CssClass="PCGButton" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'>
                                        </asp:Button>&nbsp;
                                        <asp:Button ID="Button2" CssClass="PCGButton" Text="Cancel" runat="server" CausesValidation="False"
                                            CommandName="Cancel"></asp:Button>
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
                </ClientSettings>
            </telerik:RadGrid>
        </asp:Panel>
    </telerik:RadPageView>
    <telerik:RadPageView ID="rpvFAQ" runat="server">
        <telerik:RadGrid ID="RadGrid4" runat="server" Skin="Telerik" CssClass="RadGrid" GridLines="None"
            AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true"
            AllowAutomaticDeletes="false" AllowAutomaticInserts="false" PageSize="3" OnInsertCommand="RadGrid4_InsertCommand"
            OnNeedDataSource="RadGrid4_NeedDataSource" OnDeleteCommand="RadGrid4_DeleteCommand"
            AllowAutomaticUpdates="false" HorizontalAlign="NotSet" DataKeyNames="PUHD_Id,PUHD_IsActive,PAG_AssetGroupCode,PUHD_HelpDetails,PUHD_Heading">
            <MasterTableView CommandItemDisplay="Top" EditMode="PopUp" DataKeyNames="PUHD_Id,PUHD_IsActive,PUHD_CreatedOn,PAG_AssetGroupCode,PUHD_HelpDetails,PUHD_Heading">
                <Columns>
                    <telerik:GridBoundColumn UniqueName="PAG_AssetGroupName" HeaderText="Asset Group"
                        DataField="PAG_AssetGroupName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="PUHD_Heading" HeaderText="FAQ Heading" DataField="PUHD_Heading">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="PUHD_HelpDetails" HeaderText="FAQ(Pdf) Name"
                        DataField="PUHD_HelpDetails">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="PUHD_CreatedOn" HeaderText="Created On" DataField="PUHD_CreatedOn">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="PUHD_IsActive" HeaderText="Is Active" DataField="PUHD_IsActive">
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn UniqueName="deleteColumn" ConfirmText="Are you sure you want to delete this ?"
                        ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="LinkButton" CommandName="Delete"
                        Text="Delete">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings InsertCaption="Add" FormTableStyle-HorizontalAlign="Center" CaptionFormatString="Edit"
                    FormCaptionStyle-CssClass="TableBackground" PopUpSettings-Modal="true" PopUpSettings-ZIndex="20"
                    EditFormType="Template" FormCaptionStyle-Width="100%" PopUpSettings-Height="300px"
                    PopUpSettings-Width="500px">
                    <FormTemplate>
                        <table>
                            <tr id="trAddCategory">
                                <td class="leftField">
                                    <asp:Label ID="lblAssetGroup1" runat="server" Text="AssetGroup:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td class="rightField">
                                    <asp:DropDownList ID="ddlAssetGroupName1" runat="server" CssClass="cmbLongField"
                                        DataValueField='<%# Eval("PAG_AssetGroupCode") %>'>
                                        <asp:ListItem Selected="True" Value="0">SELECT</asp:ListItem>
                                        <asp:ListItem Selected="False" Value="IP">IPO</asp:ListItem>
                                        <asp:ListItem Selected="False" Value="FI">BOND</asp:ListItem>
                                        <asp:ListItem Selected="False" Value="MF">Mutual Fund</asp:ListItem>
                                    </asp:DropDownList>
                                    <span id="Span2" class="spnRequiredField">*</span>
                                    <br />
                                    <asp:RequiredFieldValidator ID="Requiredfieldvalidator3" runat="server" ControlToValidate="ddlAssetGroupName1"
                                        ErrorMessage="Please,Select an AssetGroup." InitialValue="0" ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                        SetFocusOnError="true"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr id="tr4">
                                <td class="leftField">
                                    <asp:Label ID="Label3" runat="server" Text="FAQ Heading:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td class="rightField">
                                    <asp:TextBox ID="txtFAQHeading" runat="server" TextMode="MultiLine" CssClass="txtField"
                                        Text='<%# Eval("PUHD_Heading") %>'></asp:TextBox>
                                    <span id="Span4" class="spnRequiredField">*</span>
                                    <br />
                                    <asp:RequiredFieldValidator ID="Requiredfieldvalidator5" runat="server" ControlToValidate="txtFAQHeading"
                                        ErrorMessage="FAQ Heading can't be blank." ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup" : "btnUpdateGroup1" %>'
                                        SetFocusOnError="true"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr id="tr2">
                                <td class="leftField">
                                </td>
                                <td class="rightField">
                                    <asp:FileUpload ID="FileUpload" runat="server" Height="22px" />
                                    <span id="Span1" class="spnRequiredField">*</span>
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="FileUpload"
                                        runat="Server" ValidationGroup="btnInsertGroup" ErrorMessage="Only .pdf File allowed"
                                        Display="Dynamic" ValidationExpression="^.*\.((p|P)(d|D)(f|F))$" CssClass="rfvPCG" />
                                    <br />
                                    <asp:RequiredFieldValidator ID="FileUpload_RequiredFieldValidator" ControlToValidate="FileUpload"
                                        ValidationGroup="btnInsertGroup" ErrorMessage="Please select an pdf for upload."
                                        Display="Dynamic" runat="server" CssClass="rfvPCG">
                                    </asp:RequiredFieldValidator>
                                </td>
                                </td>
                            </tr>
                            <tr id="tr3">
                                <td class="leftField">
                                    <asp:Label ID="Label2" runat="server" Text="IS Active:" CssClass="FieldName"></asp:Label>
                                </td>
                                <td class="rightField">
                                    <asp:CheckBox ID="CheckBox" runat="server" Checked='<%# Convert.IsDBNull(Eval("PUHD_IsActive")) ? false :Convert.ToInt16( Eval("PUHD_IsActive"))==1 ? true : false %>' />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Button ID="Button1" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                        ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                        CssClass="PCGButton" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'>
                                    </asp:Button>&nbsp;
                                    <asp:Button ID="Button2" CssClass="PCGButton" Text="Cancel" runat="server" CausesValidation="False"
                                        CommandName="Cancel"></asp:Button>
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
            </ClientSettings>
        </telerik:RadGrid>
    </telerik:RadPageView>
    <telerik:RadPageView ID="rpvNotification" runat="server">
        <asp:Panel ID="Notification" runat="server" ScrollBars="Horizontal" Width="100%"
            Height="80%">
            <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">

                <script type="text/javascript">
                    function ShowEditForm(id, rowIndex) {
                        var grid = $find("<%= rgNotification.ClientID %>");
                        window.radopen("../InvestorOnline.aspx" + id, "UserListDialog1");
                        return false;
                    }
                    function refreshGrid(arg) {
                        if (!arg) {
                            $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("Rebind");
                        }
                        else {
                            $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("RebindAndNavigate");
                        }
                    }
                    function RowDblClick(sender, eventArgs) {
                        window.radopen("../InvestorOnline.aspx?EmployeeID=" + eventArgs.getDataKeyValue("CTNS_Id"), "UserListDialog");
                    }
                    var crnt = 0;
                    function PreventClicks() {

                        if (typeof (Page_ClientValidate('Button1')) == 'function') {
                            Page_ClientValidate();
                        }

                        if (Page_IsValid) {
                            if (++crnt > 1) {

                                return false;
                            }
                            return true;
                        }
                        else {
                            return false;
                        }
                    }
           
              
                </script>

            </telerik:RadCodeBlock>
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="rgNotification" LoadingPanelID="gridLoadingPanel">
                            </telerik:AjaxUpdatedControl>
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="rgNotification">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="rgNotification" LoadingPanelID="gridLoadingPanel">
                            </telerik:AjaxUpdatedControl>
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>
            <telerik:RadAjaxLoadingPanel runat="server" ID="gridLoadingPanel">
            </telerik:RadAjaxLoadingPanel>
            <telerik:RadGrid ID="rgNotification" runat="server" Skin="Telerik" CssClass="RadGrid"
                GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                ShowStatusBar="true" AllowAutomaticDeletes="false" AllowAutomaticInserts="false"
                PageSize="10" OnInsertCommand="rgNotification_InsertCommand" OnNeedDataSource="rgNotification_NeedDataSource"
                OnDeleteCommand="rgNotification_DeleteCommand" OnUpdateCommand="rgNotification_UpdateCommand"
                OnItemCreated="rgNotification_ItemCreated" OnItemCommand="rgNotification_ItemCommand"
                OnItemDataBound="rgNotification_ItemDataBound" AllowAutomaticUpdates="false"
                HorizontalAlign="Left">
                <MasterTableView CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="CTNS_Id,PAG_AssetGroupCode ,PAG_AssetGroupName,CTNS_TransactionTypes ,
                CTNS_NotificationHeader ,
                CNT_ID ,CNT_NotificationType,
                CTNS_PriorDays ,
                CTNS_IsSMSEnabled ,
               CTNS_IsDashBoardEnabled,
                CTNS_ISEmailEnabled,CNT_SPName
                 ">
                    <Columns>
                        <telerik:GridEditCommandColumn EditText="Edit" UniqueName="editColumn" CancelText="Cancel"
                            UpdateText="Update">
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="CTNS_NotificationHeader" HeaderText="Notification Heading"
                            ItemStyle-Width="100px" DataField="CTNS_NotificationHeader">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="CNT_NotificationType" HeaderText="Notification Type"
                            DataField="CNT_NotificationType">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="PAG_AssetGroupName" HeaderText="Asset Group"
                            DataField="PAG_AssetGroupName">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="TransType" HeaderText="Transaction/Product Types"
                            DataField="TransType">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="CTNS_PriorDays" HeaderText="Prior Days" DataField="CTNS_PriorDays">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplateEditColumnSMS" HeaderText="Edit/View SMS">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditLinkSMS" Visible='<%# Eval("CTNS_IsSMSEnabled") %>' runat="server"
                                    Text="Edit/View"></asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplateEditColumnEmail" HeaderText="Edit/View Email">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditLinkEmail" Visible='<%# Eval("CTNS_ISEmailEnabled") %>' runat="server"
                                    Text="Edit/View"></asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplateEditColumnDashBoard" HeaderText="Edit/View DashBoard">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditLinkDashBoard" Visible='<%# Eval("CTNS_IsDashBoardEnabled") %>'
                                    runat="server" Text="Edit/View"></asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridButtonColumn UniqueName="SendSMS" ConfirmText="Are you sure you want to Send SMS ?"
                            ConfirmDialogType="Classic" ConfirmTitle="SendSMS" ButtonType="LinkButton" CommandName="SMS"
                            Text="Send SMS">
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                        </telerik:GridButtonColumn>
                        <telerik:GridButtonColumn UniqueName="SendEMail" ConfirmText="Are you sure you want to Send Email ?"
                            ConfirmDialogType="Classic" ConfirmTitle="SendEmail" ButtonType="LinkButton"
                            CommandName="EMail" Text="Send Email">
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                        </telerik:GridButtonColumn>
                        <telerik:GridButtonColumn UniqueName="GenerateOnDashBoard" ConfirmText="Are you sure you want to Generate Notification On Dashboard?"
                            ConfirmDialogType="Classic" ConfirmTitle="Generate Notification On Dashboard"
                            ButtonType="LinkButton" CommandName="DashBoard" Text="Generate Notification">
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                        </telerik:GridButtonColumn>
                        <telerik:GridBoundColumn UniqueName="CTNS_CreatedOn" HeaderText="Created On" DataField="CTNS_CreatedOn">
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn UniqueName="deleteColumn" ConfirmText="Are you sure you want to delete this customer notification?"
                            ConfirmDialogType="Classic" ConfirmTitle="Delete" ButtonType="LinkButton" CommandName="Delete"
                            Text="Delete">
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings InsertCaption="Add" FormTableStyle-HorizontalAlign="Center" CaptionFormatString="Edit"
                        FormCaptionStyle-CssClass="TableBackground" PopUpSettings-Modal="true" PopUpSettings-ZIndex="20"
                        EditFormType="Template" FormCaptionStyle-Width="100%" PopUpSettings-Height="300px"
                        PopUpSettings-Width="500px">
                        <FormTemplate>
                            <table>
                                <tr id="tr4">
                                    <td class="leftField">
                                        <asp:Label ID="Label3" runat="server" Text="Notification Heading:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:TextBox ID="txtNotificationHeading" on runat="server" TextMode="MultiLine" CssClass="txtField"
                                            Text='<%# Eval("CTNS_NotificationHeader") %>'></asp:TextBox>
                                        <span id="Span4" class="spnRequiredField">*</span>
                                        <br />
                                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator5" runat="server" ControlToValidate="txtNotificationHeading"
                                            ErrorMessage="Notification Heading can't be blank." ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            SetFocusOnError="true" Enabled="true"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="trAddCategory">
                                    <td class="leftField">
                                        <asp:Label ID="lblAssetGroup1" runat="server" Text="AssetGroup:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:DropDownList ID="ddlAssetGroupName1" runat="server" CssClass="cmbLongField"
                                            AutoPostBack="true" OnSelectedIndexChanged="ddlAssetGroupName_OnSelectedIndexChanged">
                                        </asp:DropDownList>
                                        <span id="Span2" class="spnRequiredField">*</span>
                                        <br />
                                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator3" runat="server" ControlToValidate="ddlAssetGroupName1"
                                            ErrorMessage="Please,Select an AssetGroup." InitialValue="0" ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            SetFocusOnError="true" Enabled="true"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="leftField">
                                        <asp:Label ID="Label6" runat="server" Text="Notification Type:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="NotificationType_OnSelectedIndexChanged"
                                            CssClass="cmbLongField">
                                        </asp:DropDownList>
                                        <span id="Span8" class="spnRequiredField">*</span>
                                        <br />
                                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator8" runat="server" ControlToValidate="DropDownList1"
                                            ErrorMessage="Please,Select an Notification Type." InitialValue="0" ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            SetFocusOnError="true" Enabled="true"></asp:RequiredFieldValidator>
                                    </td>
                                    <td class="leftField">
                                        <asp:Label ID="Label7" runat="server" Text="Prior Days:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:TextBox ID="txtPriorDays" runat="server" MaxLength="2" Text='<%# Eval("CTNS_PriorDays") %>'></asp:TextBox>
                                        <br />
                                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator9" runat="server" ControlToValidate="txtPriorDays"
                                            ErrorMessage="This field Can't be Blank." ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            SetFocusOnError="true" Enabled="true"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="txtPriorDays_CompareValidator" ControlToValidate="txtPriorDays"
                                            runat="server" Display="Dynamic" ErrorMessage="<br />Please enter a numeric value ."
                                            Type="Integer" Operator="DataTypeCheck" CssClass="cvPCG" Enabled="true"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr id="trTransType" runat="server">
                                    <td class="leftField">
                                        <asp:Label ID="Label1" runat="server" Text="Transaction/Product Types:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:CheckBoxList ID="chkbltranstype" runat="server" CheckBoxes="true" AutoPostBack="true">
                                        </asp:CheckBoxList>
                                    </td>
                                </tr>
                                <tr id="tr7">
                                    <td class="leftField">
                                        <asp:Label ID="Label8" runat="server" Text="IS SMS Enabled:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:CheckBox ID="chkSMS" runat="server" Checked='<%# Convert.IsDBNull(Eval("CTNS_IsSMSEnabled")) ? false :Convert.ToInt16( Eval("CTNS_IsSMSEnabled"))==1 ? true : false %>' />
                                    </td>
                                    <td class="leftField">
                                        <asp:Label ID="Label9" runat="server" Text="IS  Email Enabled:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:CheckBox ID="chkEmail" runat="server" Checked='<%# Convert.IsDBNull(Eval("CTNS_ISEmailEnabled")) ? false :Convert.ToInt16( Eval("CTNS_ISEmailEnabled"))==1 ? true : false %>' />
                                    </td>
                                    <td class="leftField">
                                        <asp:Label ID="Label5" runat="server" Text="IS DashBoard Enabled:" CssClass="FieldName"></asp:Label>
                                    </td>
                                    <td class="rightField">
                                        <asp:CheckBox ID="chkDashBoard" runat="server" Checked='<%# Convert.IsDBNull(Eval("CTNS_IsDashBoardEnabled")) ? false :Convert.ToInt16( Eval("CTNS_IsSMSEnabled"))==1 ? true : false %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button ID="Button1" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                            ValidationGroup='<%# (Container is GridEditFormInsertItem) ? "btnInsertGroup1" : "btnUpdateGroup1" %>'
                                            CausesValidation="true" CssClass="PCGButton" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'>
                                        </asp:Button>&nbsp;
                                        <asp:Button ID="Button2" CssClass="PCGButton" Text="Cancel" runat="server" CausesValidation="false"
                                            CommandName="Cancel"></asp:Button>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </FormTemplate>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>
            <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server"
                EnableShadow="true">
                <Windows>
                    <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog1" runat="server" Title="Editing record"
                        Height="600px" Width="950px" OnClientShow="setCustomPosition" Left="30" Top="25"
                        ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>

            <script type="text/javascript">
                function setCustomPosition(sender, args) {
                    sender.moveTo(sender.get_left(), sender.get_top());
                }
            </script>

        </asp:Panel>
    </telerik:RadPageView>
    <telerik:RadPageView ID="rpvSchemeRank" runat="server">
        <table id="tblwerpGrd" runat="server" width="99%">
            <tr>
                <td class="leftLabel">
                </td>
                <td>
                    <asp:Panel ID="Panel2" runat="server" Width="70%">
                        <telerik:RadGrid ID="rgSchemeRanking" runat="server" GridLines="Both" AllowPaging="True"
                            ShowFooter="true" PageSize="10" AllowSorting="True" AutoGenerateColumns="false"
                            ShowStatusBar="true" AllowFilteringByColumn="true" AllowAutomaticDeletes="True"
                            AllowAutomaticInserts="false" AllowAutomaticUpdates="false" Skin="Telerik" EnableEmbeddedSkins="false"
                            Width="100%" OnItemDataBound="rgSchemeRanking_ItemDataBound" OnNeedDataSource="rgSchemeRanking_NeedDataSource"
                            OnDeleteCommand="rgSchemeRanking_OnDeleteCommand" OnUpdateCommand="rgSchemeRanking_OnUpdateCommand"
                            OnInsertCommand="rgSchemeRanking_OnInsertCommand">
                            <ExportSettings HideStructureColumns="false" ExportOnlyData="true" FileName="Scheme rank">
                            </ExportSettings>
                            <MasterTableView CommandItemDisplay="Top" CommandItemSettings-ShowRefreshButton="false"
                                EditMode="PopUp" CommandItemSettings-AddNewRecordText="Add New Rank to Scheme"
                                DataKeyNames="AMFSR_Id,AMFSR_SchemeRank,PASP_SchemePlanCode,PAIC_AssetInstrumentCategoryCode,PA_AMCCode">
                                <Columns>
                                    <telerik:GridEditCommandColumn EditText="Edit" UniqueName="editColumn" CancelText="Cancel"
                                        UpdateText="Update">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridBoundColumn UniqueName="AMFSR_SchemeRank" HeaderText="Rank" DataField="AMFSR_SchemeRank"
                                        SortExpression="AMFSR_SchemeRank" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                        AutoPostBackOnFilter="true" ItemStyle-Wrap="false">
                                        <HeaderStyle></HeaderStyle>
                                        <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="PASP_SchemePlanName" HeaderText="Scheme Name"
                                        AllowFiltering="true" DataField="PASP_SchemePlanName" SortExpression="PASP_SchemePlanName"
                                        ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                        <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="PAIC_AssetInstrumentCategoryName" HeaderText="Category"
                                        AllowFiltering="true" DataField="PAIC_AssetInstrumentCategoryName" SortExpression="PAIC_AssetInstrumentCategoryName"
                                        ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                        <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn UniqueName="deleteColumn" ConfirmText="Are you sure you want to delete?"
                                        ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="LinkButton" CommandName="Delete"
                                        Text="Delete">
                                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings EditFormType="Template" FormTableStyle-HorizontalAlign="Center"
                                    FormCaptionStyle-CssClass="TableBackground" PopUpSettings-Modal="true" PopUpSettings-ZIndex="20"
                                    FormCaptionStyle-Width="100%" PopUpSettings-Height="200px" PopUpSettings-Width="800px">
                                    <FormTemplate>
                                        <table cellspacing="2" cellpadding="2">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblAMC" runat="server" Text="AMC:" CssClass="FieldName"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlAMC" runat="server" CssClass="form-control input-sm" AutoPostBack="false">
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="rfvtxtTransactionDate" ControlToValidate="ddlAMC"
                                                        ErrorMessage="<br />Please select AMC" Style="color: Red;" Display="Dynamic"
                                                        runat="server" InitialValue="0" ValidationGroup="btnOK">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCategory" runat="server" Text="Category:" CssClass="FieldName"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control input-sm"
                                                        AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_OnSelectedIndexChanged">
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddlCategory"
                                                        ErrorMessage="<br />Please select category" Style="color: Red;" Display="Dynamic"
                                                        runat="server" InitialValue="0" ValidationGroup="btnOK">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblScheme" runat="server" Text="Scheme:" CssClass="FieldName"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control input-sm"
                                                        class="form-control">
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="ddlScheme"
                                                        ErrorMessage="<br />Please select Scheme" Style="color: Red;" Display="Dynamic"
                                                        runat="server" InitialValue="0" ValidationGroup="btnOK">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblRank" runat="server" Text="Rank:" CssClass="FieldName"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlSchemeRank" runat="server" CssClass="form-control input-sm"
                                                        class="form-control">
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="ddlSchemeRank"
                                                        ErrorMessage="<br />Please select Rank" Style="color: Red;" Display="Dynamic"
                                                        runat="server" InitialValue="0" ValidationGroup="btnOK">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ValidationGroup="btnOK" ID="btnOK" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                                        runat="server" CssClass="PCGButton" CausesValidation="True" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'>
                                                    </asp:Button>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                                        CssClass="PCGButton" CommandName="Cancel"></asp:Button>
                                                </td>
                                            </tr>
                                            <tr>
                                            </tr>
                                        </table>
                                    </FormTemplate>
                                </EditFormSettings>
                            </MasterTableView>
                            <ClientSettings>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </telerik:RadPageView>
</telerik:RadMultiPage>
