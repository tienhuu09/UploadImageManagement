<%@ Page Title="SignUp" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="UploadImage.SignUp" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    body {
        background: linear-gradient(#141e30, #243b55);
    }
    .memorize{
        color: white;
    }
</style>

<div>
    <div class="login-box">
        <h2><strong>Sign Up</strong></h2><br />
        <asp:Panel id="form1" asp-action="login" method="post" runat="server">
            <div class="user-box">
                <input type="text" id="inputName" name="name" runat="server">
                <label>Name</label>
            </div>
            <div class="user-box">
                <input type="text" id="inputUserName" name="userName" runat="server">
                <label>UserName</label>
            </div>
            <div class="user-box box-password">
                <input type="password" id="inputPassWord" name="password" runat="server">
                <label>Password</label>
            </div>
            <div class="user-box">
                <input type="text" id="inputAddress" name="address" runat="server">
                <label>Address</label>
            </div>
            <div class="user-box">
                <input type="text" id="inputPhone" name="phoneN" runat="server">
                <label>Phone Number</label>
            </div>
                <asp:Button ID="signUp" runat="server" type="submit" Text="SignUp" OnClick="signUp_Click" class="btn btn-login btn-outline-success fw-bold" />
            <br />
        </asp:Panel>
    </div>
</div>

</asp:Content>

