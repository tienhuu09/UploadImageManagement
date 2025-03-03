<%@ Page Title="Image Page" Language="C#" MasterPageFile="~/MainProfile.Master" AutoEventWireup="true" CodeBehind="ImagePage.aspx.cs" Inherits="UploadImage.ImagePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent2" runat="server">
    <main>
        <div class="main-container-imagePage mt-3">
            <div>
                <div class="div-ImagePage" style="display: flex; flex-direction: row; margin-left: 20px;">
                    <h4>Tất cả các ảnh</h4>
                </div>
                <div style="display: flex; flex-direction: row;">
                    <div class="imagePage-boxImage">
                        <div class="imagePage-child" style="display: flex; flex-wrap: wrap; flex-direction: row;">

                            <%-- <asp:Panel ID="imagePanel" runat="server" CssClass="imagePage-child" Style="display: flex; flex-direction: row;">
                        </asp:Panel>--%>
                            <asp:Repeater ID="RepeaterImages" OnItemDataBound="RepeaterImages_ItemDataBound" runat="server">
                                <ItemTemplate>
                                    <div id="myDiv" runat="server" style="position: relative;">
                                        <button class="icon-button user-dropdown2">
                                            <i class="icon-pen-image fa-solid fa-pen"></i>
                                            <div class="dropdown-content2">
                                                <div style="display: flex; flex-direction: row; position: relative; align-items: center;">
                                                    <asp:LinkButton CssClass="btnLinkIcon" ID="ButtonRemove" OnClick="ButtonRemove_Click" runat="server">
                                                        Remove
                                                        <i class="icon-remove fa-xl fa-solid fa-trash-can"></i>
                                                    </asp:LinkButton>
                                                </div>

                                                <div style="display: flex; flex-direction: row; position: relative; align-items: center;">
                                                    <asp:LinkButton CssClass="btnLinkIcon" ID="SetAvtProfile" OnClick="SetAvtProfile_Click" runat="server">
                                                        Đặt làm ảnh đại diện
                                                        <i class="icon-remove fa-xl fa-solid fa-circle-user"></i>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </button>
                                        <asp:Image ID="myImg" 
                                            CssClass="imagePage-image js-myImg" 
                                            ImageUrl='<%# Eval("Url") %>' 
                                            alt='<%# Eval("Name") %>'
                                            runat="server" />
                                        
                                        <!-- The Modal -->
                                        <div id="myModal" class="modal">
                                            <span class="close">&times;</span>
                                            <img id="img01" src="/" class="modal-content"/>
                                            <div id="caption"></div> 
                                        </div>
                                    </div>
                                    </script>

                                </ItemTemplate>
                            </asp:Repeater>

                        </div>
                    </div>
                </div>
            </div>
            <script>
                var images = document.querySelectorAll(".js-myImg");

                images.forEach(function (img) {
                    img.onclick = function () {
                        var modal = document.getElementById("myModal");
                        var modalImg = document.getElementById("img01");
                        var captionText = document.getElementById("caption");
                        modalImg.style = "max-height: 750px; max-width: 650px";

                        modal.style.display = "block";
                        modalImg.src = img.src;
                        var width = modalImg.clientWidth;
                        if (width > 600)
                            modalImg.style = "max-width: 600px;";
                        var height = modalImg.clientHeight;
                        if (height < 600) {
                            modalImg.style = "height: 450px; max-width: 900px; width: 750px; margin-top: 50px;";
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

            </script>
        </div>
    </main>

</asp:Content>
