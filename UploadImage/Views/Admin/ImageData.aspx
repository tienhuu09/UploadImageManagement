<%@ Page Title="Image Data" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImageData.aspx.cs" Inherits="UploadImage.ImageData" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <style>
            .tab {
                overflow: hidden;
                border: 1px solid #ccc;
                background-color: #f1f1f1;
            }

                .tab button {
                    background-color: inherit;
                    float: left;
                    border: none;
                    outline: none;
                    cursor: pointer;
                    padding: 14px 16px;
                    transition: 0.3s;
                    font-size: 17px;
                }

                    .tab button:hover {
                        background-color: #ddd;
                    }

                    .tab button.active {
                        background-color: #ccc;
                    }

            .tab-content {
                display: none;
                padding: 6px 12px;
                border: 1px solid #ccc;
                border-top: none;
            }

            /*-------Model add----------*/
            .modalAdd {
                display: none;
                position: fixed;
                z-index: 1;
                padding-top: 50px;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgb(0,0,0);
                background-color: rgba(0,0,0,0.4);
            }

            .modalAdd-content {
                background-color: #fefefe;
                border-radius: 10px;
                margin: auto;
                display: block;
                padding: 20px;
                border: 1px solid #888;
                max-width: 700px;
                width: 60%;
            }

            .modalAdd-content {
                animation-name: zoom;
                animation-duration: 0.6s;
            }

            .closeModal {
                color: #aaaaaa;
                float: right;
                line-height: 0 !important;
                font-size: 40px;
                font-weight: bold;
                transition: 0.3s;
            }

                .closeModal:hover,
                .closeModal:focus {
                    color: #000;
                    text-decoration: none;
                    cursor: pointer;
                }

            .text-p {
                font-size: 16px;
                margin-bottom: 5px !important;
            }

            .inputBorder {
                margin-left: 10px;
                font-size: 16px;
                border: 4px;
            }

            #preview {
                margin-top: 20px;
                max-width: 100%;
                max-height: 300px;
                border: 1px solid #ddd;
            }

            #previewContainer {
                margin-top: 14px;
            }

            /*------Button Confirm--------*/
            #btnConfirm {
                width: 9em;
                height: 3em;
                margin-right: 30px;
                border-radius: 30em;
                font-size: 15px;
                font-family: inherit;
                border: none;
                background-color: aliceblue;
                position: relative;
                overflow: hidden;
                z-index: 1;
                box-shadow: 6px 6px 12px #c5c5c5, -6px -6px 12px #ffffff;
            }

                #btnConfirm::before {
                    content: '';
                    width: 0;
                    height: 3em;
                    border-radius: 30em;
                    position: absolute;
                    top: 0;
                    left: 0;
                    background-image: linear-gradient(to right, #0fd850 0%, #00CDAC 100%);
                    transition: .5s ease;
                    display: block;
                    z-index: -1;
                }

                #btnConfirm:hover::before {
                    width: 9em;
                }
        </style>
        <div class="tab">
            <button class="tablinks" type="button" onclick="openCity(event, 'Avatar')" runat="server">Avatar</button>
            <button class="tablinks" type="button" onclick="openCity(event, 'Post')" runat="server">Post</button>
        </div>
        <div style="padding: 6px 12px;">
            <div style="display: flex; flex-direction: row; position: relative; margin-bottom: 10px;">
                <button id="myBtn" class="btn-add-imageData " type="button">
                    <span class="fa-plus fa-solid fa-xl"></span>
                    Add Photo
                </button>
                <div style="position: absolute; right: 30px">
                    <div class="container-input">
                        <input id="inputSearch" type="text" placeholder="Search by name" name="text" class="input" runat="server" />
                        <svg fill="#000000" width="20px" height="20px" viewBox="0 0 1920 1920" xmlns="http://www.w3.org/2000/svg">
                        </svg>
                        <button style="cursor: pointer" id="search" type="submit" onserverclick="search_ServerClick" class="btn" runat="server">
                            <span class="fa-solid fa-magnifying-glass" fill-rule="evenodd"></span>
                        </button>
                    </div>
                </div>
            </div>
            <div id="ModalAddImage" class="modalAdd">
                <div class="modalAdd-content">
                    <span class="closeModal js-close">&times;</span>
                    <h4>Add new photo</h4>
                    <div style="display: flex; flex-direction: column">
                        <div style="display: flex; flex-direction: row">
                            <h8>Name: </h8>
                            <input id="inputName" type="text" size="100" runat="server"  ClientIDMode="Static" class="inputBorder" placeholder=". . . . . . ." />
                        </div>
                        <div style="display: flex; flex-direction: row">
                            <h8>Url: </h8>
                            <input id="inputUrl" type="text" size="60" runat="server" ClientIDMode="Static" class="inputBorder" disabled placeholder="/images/. . . ." />
                        </div>
                        <div style="display: flex; flex-direction: row">
                            <h8>Size: </h8>
                            <input id="inputSize" type="text" class="inputBorder" ClientIDMode="Static" runat="server" disabled placeholder=". . .(Kb)" />
                        </div>
                        <div style="display: flex; flex-direction: row">
                            <h8>Style: </h8>
                            <input id="inputStyle" type="text" class="inputBorder" ClientIDMode="Static" runat="server" disabled placeholder="Post" />
                        </div>
                        <div style="display: flex; flex-direction: row">
                            <h8>Create Date:</h8>
                            <input id="inputDate" type="text" class="inputBorder" ClientIDMode="Static" runat="server" disabled placeholder="00/00/2024" />
                        </div>
                        <div style="display: flex; flex-direction: row">
                            <h8>Summary:</h8>
                            <input id="inputSummary" type="text" size="100" ClientIDMode="Static" runat="server" class="inputBorder" placeholder=". . . . . . ." />
                        </div>
                        <div style="display:flex; flex-direction: row; align-items: center">
                            <input id="fileImage" type="file" name="fileUpload" runat="server" ClientIDMode="Static" accept="image/*" class="form-control" />

                            <div id="divConfirm" style="margin-left: auto; margin-right: 20px; display: none;">
                                <button id="btnConfirm" runat="server" ClientIDMode="Static" onserverclick="btnConfirm_ServerClick">Confirm upload</button>
                            </div>
                        </div>
                        <div id="previewContainer" style="display: flex; flex-direction: row;">
                            <img id="previewImg" src="#" alt="Image Preview" style="display: none; max-width: 100%; height: auto;">
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div id="Avatar" class="tab-content">
            <asp:GridView ID="avatarTable" runat="server" AutoGenerateColumns="false" CssClass="table table-striped">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <img src="<%# Eval("Url") %>" class="js-myImg" style="width: 40px; height: 40px; border-radius: 50%; cursor: pointer" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Url" HeaderText="Url" />
                    <asp:BoundField DataField="Size" HeaderText="Size (Kb)" DataFormatString="{0:N0} (Kb)" />
                    <asp:BoundField DataField="Style" HeaderText="Style" />
                    <asp:BoundField DataField="CreateDate" HeaderText="Create Date" DataFormatString="{0:dd-MM-yyyy HH:mm tt}" />
                    <asp:BoundField DataField="Summary" HeaderText="Summary" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lbStatus" CssClass="js-status" runat="server" Text='<%# Eval("Status").ToString() %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <button id="" class="btnEdit btn btn-outline btn-outline-primary" type="button">
                                <i class="fa fa-pen"></i>
                            </button>
                            <div id="ModalEdit" class="modalAdd modaledit">
                                <div class="modalAdd-content">
                                    <span class="closeModal">&times;</span>
                                    <h5>Form Edit</h5>
                                    <p class="fa-sm">ID: <%# Eval("Id") %></p>
                                </div>
                            </div>
                            <button class="btnDetail btn btn-outline-success" type="button">
                                <i class="fa fa-xl fa-circle-info"></i>
                            </button>
                            <div id="ModalDetail" class="modalAdd modaldetail">
                                <div class="modalAdd-content" style="max-width: 600px;">
                                    <span class="closeModal">&times;</span>
                                    <h5>Form Detail</h5>
                                    <p class="text-p">ID: <%# Eval("Id") %></p>
                                    <p class="text-p">Id Reference: <%# Eval("IdReference") %></p>
                                    <p class="text-p">Name: <%# Eval("Name")  %></p>
                                    <p class="text-p">Url: <%# Eval("Url")  %></p>
                                    <p class="text-p">Size: <%# Eval("Size")  %> Kb</p>
                                    <p class="text-p">Create Date: <%# Eval("CreateDate")  %></p>
                                    <p class="text-p">Summary: <%# Eval("Summary")  %></p>
                                    <img src="<%# Eval("Url") %>" style="width: 100%;" />
                                </div>
                            </div>
                              <button id="btnDelete" type="button" 
                                class="btnDelete btn btn-outline-danger"><i class="fa-solid fa-lock"></i><%# Eval("Status") %></button>

                            <div id="ModalDelete" class="modalAdd modaldelete">
                                <div class="modalAdd-content">
                                    <span class="closeModal">&times;</span>
                                    <h1>Delete Image</h1>
                                    <p>Are you sure you want to delete your image?</p>
                                    <div style="display: flex; flex-direction: row">
                                        <button class="btn w-50 btn-outline-danger">
                                            Cancel
                                        </button>
                                        <asp:Button ID="ConfirmDelete"
                                            CssClass="btn w-50 btn-outline-success"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnCommand="ConfirmDelete_Command"
                                            Text="Confirm"
                                            runat="server" />
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div id="Post" class="tab-content">
            <asp:GridView ID="postTable" AutoGenerateColumns="false" CssClass="table table-striped" runat="server">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <img src="<%# Eval("Url") %>" class="js-myImg" style="width: 40px; height: 40px; border-radius: 50%; cursor: pointer" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Url" HeaderText="Url" />
                    <asp:BoundField DataField="Size" HeaderText="Size (Kb)" DataFormatString="{0:N0} (Kb)" />
                    <asp:BoundField DataField="Style" HeaderText="Style" />   
                    <asp:BoundField DataField="CreateDate" HeaderText="Create Date" DataFormatString="{0:dd-MM-yyyy HH:mm tt}" />
                    <asp:BoundField DataField="Summary" HeaderText="Summary" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lbStatus" CssClass="js-status" runat="server" Text='<%# Eval("Status").ToString() %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <button class="btnDetail btn btn-outline-success" type="button">
                                <i class="fa fa-xl fa-circle-info"></i>
                            </button>
                            <div id="ModalDetail" class="modalAdd modaldetail">
                                <div class="modalAdd-content" style="max-width: 600px;">
                                    <span class="closeModal">&times;</span>
                                    <h5>Form Detail</h5>
                                    <p class="text-p">ID: <%# Eval("Id") %></p>
                                    <p class="text-p">Id Reference: <%# Eval("IdReference") %></p>
                                    <p class="text-p">Name: <%# Eval("Name")  %></p>
                                    <p class="text-p">Url: <%# Eval("Url")  %></p>
                                    <p class="text-p">Size: <%# Eval("Size")  %> Kb</p>
                                    <p class="text-p">Create Date: <%# Eval("CreateDate")  %></p>
                                    <p class="text-p">Summary: <%# Eval("Summary")  %></p>
                                    <img src="<%# Eval("Url") %>" style="width: 100%;" />
                                </div>
                            </div>
                            <button id="btnDelete" type="button" 
                                class="btnDelete btn"><i class="fa-solid fa-lock"></i><%# Eval("Status") %></button>

                            <div id="ModalDelete" class="modalAdd modaldelete">
                                <div class="modalAdd-content">
                                    <span class="closeModal">&times;</span>
                                    <h1>Delete Image</h1>
                                    <p>Are you sure you want to delete your image?</p>
                                    <div style="display: flex; flex-direction: row">
                                        <button class="btn w-50 btn-outline-danger">
                                            Cancel
                                        </button>
                                        <asp:Button ID="ConfirmDelete"
                                            CssClass="btn w-50 btn-outline-success" 
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnCommand="ConfirmDelete_Command"
                                            Text="Confirm"
                                            runat="server"/>
                                    </div>

                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div id="myModal" class="modal">
            <span class="close">&times;</span>
            <img id="img01" src="/" class="modal-content" />
            <div id="caption"></div>
        </div>
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

        function openCity(evt, cityName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tab-content");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += "  active";
        }

    </script>
    <script>
        var modalAdd = document.getElementById("ModalAddImage");
        var btn = document.getElementById("myBtn");
        var span = document.getElementsByClassName("closeModal")[0];

        btn.onclick = function () {
            modalAdd.style.display = "block";
        }

        const inputName = document.getElementById('inputName');
        const inputSummary = document.getElementById('inputSummary');

        span.onclick = function () {
            fileImage.value = '';
            preview.src = '';
            preview.style.display = 'none';
            inputUrl.value = '/images/. . .';
            inputSize.value = '. . .(kb)';
            inputDate.value = '. . .';
            modalAdd.style.display = "none";
            inputName.value = '';
            inputSummary.value = '';
            divConfirm.style.display = 'none';
        }

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape" && modalAdd.style.display === "block") {
                fileImage.value = '';
                preview.src = '';
                preview.style.display = 'none';
                inputUrl.value = '/images/. . .';
                inputSize.value = '. . .(kb)';
                inputDate.value = '. . .';
                modalAdd.style.display = "none";
                inputName.value = '';
                inputSummary.value = '';
                divConfirm.style.display = 'none';
            }
        });

        // Modal Edit
        var btnEdit = document.querySelectorAll(".btnEdit");
        var modalEdit = document.querySelectorAll(".modaledit");

        btnEdit.forEach(function (btn, index) {
            var modalContent = modalEdit[index].querySelector(".modalAdd-content");
            var closeBtn = modalContent.querySelector(".closeModal");

            btn.onclick = function () {
                modalEdit[index].style.display = "block";
            }

            closeBtn.onclick = function () {
                modalEdit[index].style.display = "none";
            }

            document.addEventListener("keydown", function (event) {
                if (event.key === "Escape" && modalEdit[index].style.display === "block") {
                    modalEdit[index].style.display = "none";
                }
            });
        });

        // Modal Detail
        var btnDetail = document.querySelectorAll(".btnDetail");
        var modalDetail = document.querySelectorAll(".modaldetail");

        btnDetail.forEach(function (btn, index) {
            var modalContent = modalDetail[index].querySelector(".modalAdd-content");
            var closeBtn = modalContent.querySelector(".closeModal");

            btn.onclick = function () {
                modalDetail[index].style.display = "block";
            }

            closeBtn.onclick = function () {
                modalDetail[index].style.display = "none";
            }

            document.addEventListener("keydown", function (event) {
                if (event.key === "Escape" && modalDetail[index].style.display === "block") {
                    modalDetail[index].style.display = "none";
                }
            });
        });

        // Modal delete
        var btnDelete = document.querySelectorAll(".btnDelete");
        var modalDelete = document.querySelectorAll(".modaldelete");

        btnDelete.forEach(function (btn, index) {
            var modalContent = modalDelete[index].querySelector(".modalAdd-content");
            var closeBtn = modalContent.querySelector(".closeModal");

            btn.onclick = function () {
                modalDelete[index].style.display = "block";
            }

            closeBtn.onclick = function () {
                modalDelete[index].style.display = "none";
            }

            document.addEventListener("keydown", function (event) {
                if (event.key === "Escape" && modalDelete[index].style.display === "block") {
                    modalDelete[index].style.display = "none";
                }
            });
        });

        var modalDelete = document.querySelectorAll(".modaldelete");
        btnDelete.forEach((btn, index) => {
            const status = btn.lastChild.textContent;
            btn.lastChild.textContent = '';
            if (status === "True") {
                btn.className = "btn btn-outline-danger";
                btn.innerHTML = `<i class="fa-solid fa-lock"></i>`;
            } else {
                btn.innerHTML = `<i class="fa-solid fa-lock-open"></i>`;
                btn.className = "btn btn-outline-success";
            }
        });

        // Handle file upload image
        var fileImage = document.getElementById("fileImage");
        const preview = document.getElementById('previewImg');
        const previewContainer = document.getElementById('previewContainer');
        const inputUrl = document.getElementById('inputUrl');
        const inputSize = document.getElementById('inputSize');
        const inputDate = document.getElementById('inputDate');
        const divConfirm = document.getElementById('divConfirm');

        fileImage.addEventListener('change', function (event) {
            const file = event.target.files[0];

            if (file && file.type.startsWith('image/')) {
                const reader = new FileReader();

                reader.onload = function (e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };
                const name = file.name;
                const fileSizeKB = (file.size / 1024).toFixed(2);
                const date = new Date();
                const day = String(date.getDate()).padStart(2, '0');
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const year = date.getFullYear();
                const formatDate = `${day}/${month}/${year}`;

                inputUrl.value = "/images/" + name;
                inputSize.value = fileSizeKB + " (Kb)";
                inputDate.value = formatDate;
                divConfirm.style.display = 'block';

                reader.readAsDataURL(file);
            } else {
                event.target.value = '';
                preview.src = '#';
                preview.style.display = 'none';
                fileImage.value = '';
                preview.src = '';
                preview.style.display = 'none';
                inputUrl.value = '/images/. . .';
                inputSize.value = '. . .(kb)';
                inputDate.value = '. . .';
                divConfirm.style.display = 'none';
                alert('Please upload a valid image file!');
            }
        });

        divConfirm.onclick = function () {
            setTimeout(alert('Added successfully'), 3000);
        }

        // change dot Status
        const aspStt = document.querySelectorAll('.js-status');
        aspStt.forEach((stt, index) => {
            const status = stt.lastChild.textContent;
            if (status === "True") {
                stt.className = 'green-dot';
            } else {
                stt.className = 'red-dot';
            }
            stt.lastChild.textContent = '';
        });

    </script>
</asp:Content>
