<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="UploadImage.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    body {
        background: linear-gradient(#141e30, #243b55);
    }
    .memorize{
        color: white;
    }
</style>

<div onkeydown="submitEnter(event)">
    <div class="login-box">
        <h2><strong>Login</strong></h2><br />
        <asp:Panel id="form1" asp-action="login" method="post" runat="server">
            <div class="user-box">
                <input type="text" id="userName" required name="userName" runat="server">
                <label>UserName</label>
            </div>
            <div class="user-box box-password">
                <input type="password" id="passWord" required name="password" runat="server">
                <label>Password</label>
            </div>
            <p class="memorize">
                <input type="checkbox" name="ghinho" /> Remember account
            </p> 
            <br />
            <asp:button ID="login" OnClick="login_Click" runat="server" type="submit" Text="Sign In" class="btn-login btn btn-outline-primary" />
        </asp:Panel>
        <p class="mb-0 text-white">Don't have an account? <a href="SignUp" class="text-white-50 fw-bold">Sign Up</a></p>
    </div>
</div>


<script>
    function submitEnter(event) {
        if (event.key === "Enter") {
            event.preventDefault();
            document.getElementById("<%= login.ClientID %>").click();
        }
    }
</script>

</asp:Content>
