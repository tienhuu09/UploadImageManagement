<%@ Page Title="Post Data" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PostData.aspx.cs" Inherits="UploadImage.PostData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <style>
            .dropbtn {
                background-color: #3498DB;
                color: white;
                padding: 10px;
                width: max-content;
                border-radius: 8px;
                font-size: 16px;
                border: none;
                cursor: pointer;
            }

                .dropbtn:hover, .dropbtn:focus {
                    background-color: #2980B9;
                }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f1f1f1;
                min-width: 150px;
                overflow: auto;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

                .dropdown-content a {
                    color: black;
                    padding: 12px 16px;
                    text-decoration: none;
                    display: block;
                }

            .dropdown a:hover {
                background-color: #ddd;
            }

            .show {
                display: block;
            }
            /*Modal Image*/
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
                max-width: 800px;
                width: 70%;
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

            /*Status green red dot*/
            .green-dot {
                width: 20px;
                height: 20px;
                margin-top: 8px;
                margin-left: 15px;
                background-color: #6EC207 !important;
                border-radius: 50%;
                display: inline-block;
            }

            .red-dot {
                width: 20px;
                height: 20px;
                margin-top: 8px;
                margin-left: 15px;
                background-color: red !important;
                border-radius: 50%;
                display: inline-block;
            }

            /*------Button Confirm--------*/
            #btnConfirmUpdate {
                width: 9em;
                height: 3em;
                margin-right: 30px;
                margin-bottom: 10px;
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

                #btnConfirmUpdate::before {
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

                #btnConfirmUpdate:hover::before {
                    width: 9em;
                }

            .btnConfirmMuti {
                min-width: 70px;
                width: max-content;
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

                .btnConfirmMuti::before {
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

                .btnConfirmMuti:hover::before {
                    width: 9em;
                }

            .inputPostAdd {
                font-size: 16px;
                border: 4px;
            }
            /*Button selected style image*/
            .checkbox {
                width: 50px;
                height: 50px;
                opacity: 0;
                position: absolute;
                z-index: 2;
                cursor: pointer;
            }

            .button-menu {
                cursor: pointer;
                position: absolute;
                z-index: 1;
                background-color: #ffdd00;
                border: 2px solid #1e1e1e;
                color: #1e1e1e;
                font-size: 36px;
                font-weight: 700;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                text-align: center;
                box-shadow: 0px 3px 10px 0px rgba(16, 16, 16, 0.5);
                transition: all 0.3s ease;
            }

                .button-menu::before {
                    content: "+";
                }

            .checkbox:checked ~ .button-menu::before {
                content: "-";
            }

            .option {
                position: absolute;
                background-color: #1e1e1e;
                border: 2px solid #ffdd00;
                color: #ffdd00;
                z-index: -1;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                cursor: pointer;
                font-weight: 700;
                transform: translate(0, 0);
                transition: all 0.3s ease;
                opacity: 0;
                pointer-events: none;
            }

            .checkbox:checked ~ .option {
                opacity: 1;
                pointer-events: auto;
                z-index: 1;
            }

            .checkbox:checked ~ .option-a {
                transition-delay: 0.2s;
                transform: translateY(-55px) translateX(55px);
            }

            .checkbox:checked ~ .option-b {
                transition-delay: 0.3s;
                transform: translateX(80px);
            }

            .option:hover {
                box-shadow: none;
                transform: scale(0.95);
            }

            .divSelect {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: #474e5d;
                padding-top: 50px;
            }

            .divSelect {
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
        </style>
        <div>
            <div style="display: flex; flex-direction: row; position: relative; margin: 10px;">
                <button id="myBtn" class="btn-add-imageData " type="button">
                    <span class="fa-plus fa-solid fa-xl"></span>
                    Add Post
                </button>
                <div style="position: absolute; right: 30px">
                    <div class="container-input">
                        <input id="inputSearch" type="text" placeholder="Search by title" name="input" class="input" runat="server" />
                        <svg fill="#000000" width="20px" height="20px" viewBox="0 0 1920 1920" xmlns="http://www.w3.org/2000/svg">
                        </svg>
                        <button id="search"
                            style="cursor: pointer" type="submit"
                            onserverclick="search_ServerClick"
                            class="btn" runat="server">
                            <span class="fa-solid fa-magnifying-glass" fill-rule="evenodd"></span>
                        </button>
                    </div>
                </div>
            </div>
            <div>
                <div id="ModalAddImage" class="modalAdd">
                    <div class="modalAdd-content" style="max-width: 60%">
                        <span class="closeModal">&times;</span>
                        <h4>Add new Post</h4>
                        <div id="addPostBody">
                            <div>
                                <input id="inputTitle" class="inputPostAdd" size="300" runat="server" placeholder="Chi tiết hình ảnh . . . ." />
                            </div>
                            <div class="custum-file-upload js-div">
                                <div class="icon">
                                    <i class="fa-regular fa-images"></i>
                                </div>
                                <div class="text">
                                    <span>Click to upload image</span>
                                </div>
                                <div id="uploadContainer" runat="server" enctype="multipart/form-data">
                                    <!-- Input upload multiple file -->
                                    <input id="imageAdd"
                                        type="file"
                                        name="fileUpload"
                                        accept="image/*"
                                        class="form-control"
                                        multiple onchange="handleFileUpload()" />
                                </div>
                            </div>
                        </div>
                        <div class="js-divAdd" style="display: none;">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Name</th>
                                        <th>Url</th>
                                        <th>Size</th>
                                        <th>Style</th>
                                        <th>CreateDate</th>
                                    </tr>
                                </thead>
                                <tbody id="tableAddPost">
                                </tbody>
                            </table>
                            <div style="justify-content: center; justify-items: center;">
                                <button id="confirmCreate"
                                    class="js-btn btnConfirmMuti"
                                    clientidmode="Static"
                                    onserverclick="confirmCreate_ServerClick"
                                    style="display: none;"
                                    runat="server">
                                    Confirm create</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <input id="inputId" class="inputTes" runat="server" style="display: none;" />
            <a id="btnTest" onserverclick="btnConfirmUpdate_ServerClick" runat="server"></a>
            <input id="fileInput" class="js-fileInput"
                type="file" accept="image/*"
                multiple style="display: none;"
                clientidmode="Static"
                runat="server" />
            <script>
                function Notification() {
                    alert("The URL already exists and cannot be initialized!!!");
                }

                function getId(el) {
                    const input = document.querySelector(".inputTes");
                    input.value = el.getAttribute("data-id");
                    __doPostBack('<%= btnTest.UniqueID%>', '');
                }
            </script>
            <table id="pagination-table" class="table table-striped">
                <thead>
                    <tr>
                        <th><span class="flex items-center">ID</span></th>
                        <th><span class="flex items-center">Title</span></th>
                        <th><span class="flex items-center">User Upload</span></th>
                        <th><span class="flex items-center">Quantity Image</span></th>
                        <th><span class="flex items-center">Create Date</span></th>
                        <th><span class="flex items-center">Status</span></th>
                        <th><span class="flex items-center"></span></th>
                    </tr>
                </thead>
                <tbody>
                    <% foreach (var post in lstPost)
                        {
                            gridData.DataSource = post.lstPostDetail;
                            gridData.DataBind();%>
                    <tr>
                        <td><%= post.Id %></td>
                        <td><%= post.Title %></td>
                        <td><%= UploadImage.AccountService.getName(post.IdAccount) %></td>
                        <td><%= post.QuantityImage %></td>
                        <td><%= post.CreateDate.ToString(UploadImage.Ulti.date4) %></td>
                        <td>
                            <div class="js-status"><%=post.Status%></div>
                        </td>
                        <td>
                            <button class="btnEdit btn btn-outline btn-outline-primary" type="button">
                                <i class="fa fa-pen"></i>
                            </button>

                            <div id="ModalEdit-<%= post.Id %>" class="modalAdd modaledit">
                                <div id="divTest" class="modalAdd-content">
                                    <span class="closeModal">&times;</span>
                                    <h5>Form Edit</h5>
                                    <p class="text-p">ID: <%=post.Id %></p>
                                    <p class="text-p">Title: <%=post.Title %></p>
                                    <p class="text-p">ID Account: <%= post.IdAccount %></p>
                                    <p class="text-p">Username: <%= UploadImage.AccountService.getName(post.IdAccount) %></p>
                                    <p class="text-p">Create Date: <%= post.CreateDate %></p>
                                    <div style="display: flex; flex-direction: row">

                                        <button class="btnConfirmMuti"
                                            type="button"
                                            data-id="<%= post.Id %>"
                                            onclick="triggerFileInput(this)">
                                            <i class="fa-solid fa-plus" style="font-size: 25px;"></i>
                                        </button>

                                        <div id="divConfirm" style="margin-left: auto; margin-right: 20px; display: flex;">
                                            <button id="btnConfirmUpdate" data-id="<%= post.Id %>" onclick="getId(this)">Confirm update</button>
                                        </div>
                                    </div>

                                    <div runat="server">
                                        <asp:GridView ID="gridData" AutoGenerateColumns="false" CssClass="table table-striped" runat="server">
                                            <Columns>
                                                <asp:BoundField DataField="Id" HeaderText="Id" />
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <img id="imgtest"
                                                            class="js-myImg"
                                                            data-id='<%# Eval("Id") %>'
                                                            src="<%# UploadImage.ImageService.getUrl(Eval("IdImage").ToString())%>"
                                                            style="width: 40px; height: 40px; border-radius: 50%; cursor: pointer" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <%--<asp:BoundField DataField="" HeaderText="Url" />--%>
                                                <asp:TemplateField HeaderText="Url">
                                                    <ItemTemplate>
                                                        <p class="text-p"><%# UploadImage.ImageService.getUrl(Eval("IdImage").ToString()) %></p>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <%--<asp:BoundField DataField="Size" HeaderText="Size" DataFormatString="{0:N0} (Kb)" />--%>
                                                <asp:TemplateField HeaderText="Size">
                                                    <ItemTemplate>
                                                        <p class="text-p"><%# string.Format("{0} (Kb)", Math.Round(Convert.ToDouble(UploadImage.ImageService.getSize(Eval("IdImage").ToString())), 2)) %> </p>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:BoundField DataField="Position" HeaderText="Position" />

                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <div class="js-status"><%# Eval("Status") %></div>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
<%--                                                <asp:TemplateField HeaderText="Actions">
                                                    <ItemTemplate>
                                                        <input id="fileChange" type="file" name="fileChange" runat="server" clientidmode="Static" accept="image/*" style="display: none" />
                                                        <button class="btn btn-outline-primary" type="button" onclick="triggerFileChange()">
                                                            <i class="fa-solid fa-pen-to-square"></i>
                                                        </button>
                                                        <button id="btnStatus"
                                                            class="btnlock btn"
                                                            onserverclick="btnStatus_ServerClick"
                                                            clientidmode="Static"
                                                            runat="server">
                                                            <i class="fa-solid fa-lock"></i>True</button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>
                                            </Columns>
                                        </asp:GridView>
                                    </div>

                                    <div class="js-divEditAdd" style="display: none;">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>Name</th>
                                                    <th>Url</th>
                                                    <th>Size</th>
                                                </tr>
                                            </thead>
                                            <tbody class="tbodyDemo">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <button class="btnDetail btn btn-outline-success" type="button">
                                <i class="fa fa-xl fa-circle-info"></i>
                            </button>
                            <div id="ModalDetail" class="modalAdd modaldetail">
                                <div class="modalAdd-content" style="max-width: 600px">
                                    <span class="closeModal">&times;</span>
                                    <h5>Form Detail</h5>
                                    <p class="text-p">ID: <%=post.Id %></p>
                                    <p class="text-p">Title: <%=post.Title %></p>
                                    <p class="text-p">ID Account: <%= post.IdAccount %></p>
                                    <p class="text-p">Username: <%= UploadImage.AccountService.getName(post.IdAccount) %></p>
                                    <p class="text-p">Create Date: <%= post.CreateDate %></p>
                                    <div>
                                        <div class="js-div-post">
                                            <%foreach (var img in post.lstImage)
                                                {
                                                    if (img.Status)
                                                    {   %>
                                            <div class="mySlidesPost js-test">
                                                <div id="number" class="numbertext">0 / 1</div>
                                                <img id="imgSlide"
                                                    src='<%= img.Url %>'
                                                    class="js-myImg"
                                                    style="width: 100%; cursor: pointer;" />
                                                <a class="prevPost" onclick="plusSlidesPost(-1, this)">&#10094;</a>
                                                <a class="nextPost" onclick="plusSlidesPost(1, this)">&#10095;</a>
                                                <p class="text-p">ID: <%=img.Id %></p>
                                            </div>
                                            <%}
                                                } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
<%--                            <button class="btn btn-outline-danger">
                                <i class="fa fa-trash"></i>
                            </button>--%>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <div id="myModal" class="modal">
            <span class="closeModal">&times;</span>
            <img id="img01" src="/" class="modal-content" />
            <div id="caption"></div>
        </div>
<%--        <div id="SelectTypeImage" class="modalAdd">
            <div class="modalAdd-content">
                <div style="display: flex; flex-direction: row">
                <h5>Selected Image</h5>
                    <span class="closeModal">&times;</span>
                </div>
                <div style="display:block; margin-top: 25px;">
                    <asp:GridView ID="divlistImage" AutoGenerateColumns="false" CssClass="table table-striped" runat="server">
                        <Columns>
                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <img src="<%# Eval("Url") %>" class="js-myImg" style="width: 40px; height: 40px; border-radius: 50%; cursor: pointer" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Name" HeaderText="Name" />
                            <asp:BoundField DataField="Url" HeaderText="Url" />
                            <asp:BoundField DataField="Size" HeaderText="Size (Kb)" DataFormatString="{0:N0} (Kb)" />
                            <asp:BoundField DataField="Style" HeaderText="Style" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lbStatus" CssClass="js-status" runat="server" Text='<%# Eval("Status").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>--%>
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
        var item = document.getElementById("myModal");
        var spanImg = item.querySelector('.closeModal');
        spanImg.onclick = function () {
            var modal = document.getElementById("myModal");
            modal.style.display = "none";
        }

    </script>

    <script>
        //Modal Add
        var modalAdd = document.getElementById("ModalAddImage");
        var btn = document.getElementById("myBtn");
        var span = document.getElementsByClassName("closeModal")[0];

        btn.onclick = function () {
            modalAdd.style.display = "block";
        }

        span.onclick = function () {
            modalAdd.style.display = "none";
        }

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape" && modalAdd.style.display === "block") {
                modalAdd.style.display = "none";
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
                var fileInput = document.getElementById("fileInput");
                fileInput.value = null;
            }

            document.addEventListener("keydown", function (event) {
                if (event.key === "Escape" && modalEdit[index].style.display === "block") {
                    modalEdit[index].style.display = "none";
                    var fileInput = document.getElementById("fileInput");
                    fileInput.value = null;
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

        const selectDivPost = document.querySelectorAll('.js-div-post');
        let slideIndexs = Array.from(selectDivPost).map(() => 1);
        let slideIndexPost = 1;
        for (var i = 0; i < selectDivPost.length; i++) {
            showSlidesPost(slideIndexPost, i);
            if (i == 21)
                continue;
        }

        function showSlidesPost(n, i) {

            const slidesPost = selectDivPost[i].getElementsByClassName("mySlidesPost");
            const dotsPost = selectDivPost[i].getElementsByClassName("dotPost");
            const number = selectDivPost[i].getElementsByClassName("numbertext");
            for (var i = 0; i < number.length; i++) {
                number[i].innerHTML = `${i + 1} / ${slidesPost.length}`;
            }

            if (n > slidesPost.length)
                slideIndexPost = 1;
            if (n < 1)
                slideIndexPost = slidesPost.length;

            for (let i = 0; i < slidesPost.length; i++) {
                slidesPost[i].style.display = "none";
            }

            for (let i = 0; i < dotsPost.length; i++) {
                dotsPost[i].className = dotsPost[i].className.replace("activeBk-color", "");
            }

            slidesPost[slideIndexPost - 1].style.display = "block";

            if (dotsPost.length > 0) dotsPost[slideIndexPost - 1].className += "activeBk-color";

        }

        function plusSlidesPost(n, btn) {
            const perentDiv = btn.closest('.js-div-post');

            const index = Array.from(selectDivPost).indexOf(perentDiv);

            if (index !== -1) {
                showSlidesPost(slideIndexPost += n, index);
            }
        }

        function currentSlidePost(n, btn) {
            const perentDiv = btn.closest('.js-div-post');

            const index = Array.from(selectDivPost).indexOf(perentDiv);

            if (index !== -1) {
                showSlidesPost(slideIndexPost = n, index);
            }
        }

        // change dot Status
        const aspStt = document.querySelectorAll('.js-status');
        aspStt.forEach((stt, index) => {
            const status = stt.lastChild.textContent;
            stt.lastChild.textContent = '';
            if (status === "True") {
                stt.className = 'green-dot';
            } else {
                stt.className = 'red-dot';
            }
        });

        const listbtn = document.querySelectorAll('.btnlock');
        listbtn.forEach((btn, index) => {
            const str = btn.textContent;
            btn.lastChild.textContent = '';
            if (str === "True") {
                btn.className = 'btn btn-outline-danger';
            } else {
                btn.className = 'btn btn-outline-success';
            }
        })

        // trigger event click change file by edit

        //function triggerFileChange() {
        //    document.getElementById('fileChange').click();
        //}
        //var fileChange = document.getElementById('fileChange');
        //fileChange.addEventListener('change', function (event) {
        //    const file = event.target.files[0];

        //    if (file && file.type.startsWith('image/')) {
        //        const name = file.name;
        //        const fileSizeKb = (file.size / 1024).toFixed(2);
        //        const date = new Date();
        //        const day = String(date.getDate()).padStart(2, '0');
        //        const month = String(date.getMonth() + 1).padStart(2, '0');
        //        const year = date.getFullYear();
        //        const formatDate = `${day}/${month}/${year}`;

        //        const row = document.createElement('tr');
        //        const nameCell = document.createElement('td');
        //        nameCell.textContent = file.name;
        //        row.appendChild(nameCell);

        //        const urlCell = document.createElement('td');
        //        urlCell.textContent = "/images/" + name;
        //        row.appendChild(urlCell);

        //        const sizeCell = document.createElement('td');
        //        sizeCell.textContent = fileSizeKb;
        //        row.appendChild(sizeCell);

        //        const img = document.createElement('img');
        //        img.src = file.src;

        //        const imgCell = document.createElement('td');
        //        imgCell.appendChild(img);

        //    }
        //});

    </script>

    <script>
        // Handle file image upload and create table
        function handleFileUpload() {
            const files = document.getElementById('imageAdd').files;
            const tableAddPost = document.getElementById('tableAddPost');
            // file is empty return
            if (files.length === 0) return;

            Array.from(files).forEach((file, index) => {

                const row = document.createElement('tr');

                const imgCell = document.createElement('td');

                const img = document.createElement('img');
                const reader = new FileReader();
                reader.onload = function (e) {
                    img.src = e.target.result;
                    img.style = "width: 40px; height: 40px; border-radius: 50%;";
                };
                reader.readAsDataURL(file);
                imgCell.appendChild(img);
                row.appendChild(imgCell);

                const nameCell = document.createElement('td');
                nameCell.textContent = file.name;
                row.appendChild(nameCell);

                const urlCell = document.createElement('td');
                urlCell.textContent = "/images/" + file.name;
                row.appendChild(urlCell);

                const sizeCell = document.createElement('td');
                const fileSizeKB = (file.size / 1024).toFixed(2);
                sizeCell.textContent = fileSizeKB + "(Kb)";
                row.appendChild(sizeCell);

                const styleCell = document.createElement('td');
                styleCell.textContent = "Post";
                row.appendChild(styleCell);

                const date = new Date();
                const day = String(date.getDate()).padStart(2, '0');
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const year = date.getFullYear();
                const formatDate = `${day}/${month}/${year}`;
                const dateStr = document.createElement('td');
                dateStr.textContent = formatDate;
                row.appendChild(dateStr);

                tableAddPost.appendChild(row);
            });

            // open close div
            var dig = document.querySelector(".js-div");
            if (dig.style.display === 'none') {
                dig.style.display = 'block';
            } else {
                dig.style.display = 'none';
            }

            var btn = document.querySelector(".js-btn");
            if (btn.style.display === 'none') {
                btn.style.display = 'block';
            } else {
                btn.style.display = 'none';
            }

            var divAdd = document.querySelector(".js-divAdd");
            if (divAdd.style.display === 'none') {
                divAdd.style.display = 'block';
            }
            else {
                divAdd.style.display = 'none';
            }
        }

    </script>

    <script>
        function triggerFileInput(btn) {
            const postId = btn.getAttribute('data-id');

            var parentDiv = btn.closest(`#ModalEdit-${postId}`);
            const input = document.querySelector('#fileInput');
            input.value = '';                           // reset input value
            input.click();

            const tbody = parentDiv.querySelector('.tbodyDemo');
            const divAdd = parentDiv.querySelector('.js-divEditAdd');

            tbody.innerHTML = '';                           // clear tbody
            divAdd.style.display = 'none';                  // Hide divAdd by default

            if (input) {
                input.addEventListener('change', function (event) {
                    const files = input.files;
                    if (files.length === 0) return;

                    Array.from(files).forEach((file, index) => {
                        if (file && file.type.startsWith('image/')) {
                            const fileSizeKb = (file.size / 1024).toFixed(2);

                            const row = document.createElement('tr');

                            const imgCell = document.createElement('td');
                            const img = document.createElement('img');
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                img.src = e.target.result;
                                img.style = "width: 40px; height: 40px; border-radius: 50%;";
                            };

                            reader.readAsDataURL(file);
                            imgCell.appendChild(img);
                            row.appendChild(imgCell);

                            const nameCell = document.createElement('td');
                            nameCell.textContent = file.name;
                            row.appendChild(nameCell);

                            const urlCell = document.createElement('td');
                            urlCell.textContent = "/images/" + file.name;
                            row.appendChild(urlCell);

                            const sizeCell = document.createElement('td');
                            sizeCell.textContent = fileSizeKb;
                            row.appendChild(sizeCell);

                            tbody.appendChild(row);
                        }
                    });
                    divAdd.style.display = 'block';                     // show divAdd

                }, { once: true });

            }
        }
    </script>

    <script>
        const divSelect = document.getElementById("SelectTypeImage");

        function clickShowDivSelect(btn) {
                divSelect.style.display = 'block';
        }

        var closeBtn = divSelect.querySelector('.closeModal');
        closeBtn.onclick = function () {
            divSelect.style.display = "none";
        }
    </script>
</asp:Content>
