<%@ Page Title="Account Data" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AccountData.aspx.cs" Inherits="UploadImage.AccountData" %>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <table id="pagination-table" class="table table-striped">
            <thead>
                <tr>
                    <th>
                        <span class="flex items-center">ID
                        </span>
                    </th>
                    <th>
                        <span class="flex items-center"> </span>
                    </th>
                    <th>
                        <span class="flex items-center">Name
                        </span>
                    </th>
                    <th>
                        <span class="flex items-center">Username
                        </span>
                    </th>
                    <th>
                        <span class="flex items-center">Password
                        </span>
                    </th>
                    <th>
                        <span class="flex items-center">Address
                        </span>
                    </th>
                    <th>
                        <span class="flex items-center">Phone
                        </span>
                    </th>
                    <th>
                        <span class="flex items-center">RoleAccount
                        </span>
                    </th>
                </tr>
            </thead>
            <tbody>
                <%foreach (var acc in accountService.Gets())
                    {   %>
                <tr>
                    <td><%= acc.Id %></td>
                    <td>
                        <%if (string.Compare(acc.AccountInfo.IdImage, "empty", true) != 0)
                            { %> 
                            <img src="<%= acc.AccountInfo.Image.Url %>" class="js-myImg" style="width: 40px; height: 40px; border-radius: 50%; cursor: pointer" />
                            <% }%>
                        <%else
                            { %>
                            <img src="/images/user.png" class="js-myImg" style="width: 40px; height: 40px; border-radius: 50%; cursor: pointer" />
                        <%} %>
                        <div id="myModal" class="modal">
                            <span class="close">&times;</span>
                            <img id="img01" src="/" class="modal-content" />
                            <div id="caption"></div>
                        </div>
                    </td>
                    <td><%= acc.Name %></td>
                    <td><%= acc.Username %></td>
                    <td><%= acc.Password %></td>
                    <td><%= acc.AccountInfo.Address %></td>
                    <td><%= acc.AccountInfo.PhoneNumber %></td>
                    <td><%= acc.RoleAccount %></td>
<%--                    <td>
                        <button class="btn btn-outline btn-outline-primary">
                            <i class="fa fa-pen"></i>
                        </button>
                        <button class="btn btn-outline-success">
                            <i class="fa fa-xl fa-circle-info"></i>
                        </button>
                        <button class="btn btn-outline-danger">
                            <i class="fa fa-trash"></i>
                        </button>
                    </td>--%>
                </tr>
            <% } %>
            </tbody>
        </table>
    </main>
    <script>
        // Zoom Image modal
        var images = document.querySelectorAll(".js-myImg");

        images.forEach(function (img) {
            img.onclick = function () {
                var modal = document.getElementById("myModal");
                var modalImg = document.getElementById("img01");
                var captionText = document.getElementById("caption");
                modalImg.style = "max-height: 650px; max-width: 700px";

                modal.style.display = "block";
                modalImg.src = img.src;
                var width = modalImg.clientWidth;
                if (width > 600)
                    modalImg.style = "max-width: 600px;";
                var height = modalImg.clientHeight;
                if (height < 600) {
                    modalImg.style = "height: 400px; max-width: 800px; width: 700px; margin-top: 50px;";
                }

                captionText.innerHTML = img.alt;

            };
        });

        // close modal
        var span = document.getElementsByClassName("close")[0];
        span.onclick = function () {
            var modal = document.getElementById("myModal");
            modal.style.display = "none";
        };

        if (document.querySelectorAll("table") && typeof simpleDatatables.DataTable !== 'undefined') {
            const dataTable = new simpleDatatables.DataTable("#pagination-table", {
                paging: true,
                perPage: 5,
                perPageSelect: [5, 10, 15, 20, 25],
                sortable: false
            });
        }
    </script>
</asp:Content>
