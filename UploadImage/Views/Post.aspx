<%@ Page Title="" Language="C#" MasterPageFile="~/MainProfile.Master" AutoEventWireup="true" CodeBehind="Post.aspx.cs" Inherits="UploadImage.Post1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent2" runat="server">
    <main>
        <style>
            .mySlides {
                display: none;
            }

            img {
                vertical-align: middle;
            }

            .slideshow-container {
                max-width: 1000px;
                position: absolute;
                top: 50%;
                margin: auto;
            }

            .prev, .next {
                cursor: pointer;
                position: absolute;
                top: 50%;
                padding: 16px;
                color: white;
                font-weight: bold;
                font-size: 18px;
                transition: 0.6s ease;
                border-radius: 0 3px 3px 0;
                user-select: none;
                z-index: 10;
            }

            .next {
                right: 0;
                border-radius: 3px 0 0 3px;
            }

            .prev {
                left: 0;
                border-radius: 3px 0 0 3px;
            }

                .prev:hover, .next:hover {
                    background-color: rgba(0,0,0,0.8);
                }

            .dot {
                cursor: pointer;
                height: 15px;
                width: 15px;
                background-color: #bbb;
                border-radius: 50%;
                display: inline-block;
                transition: background-color 0.6s ease;
            }

            .activeBk-color {
                background-color: #b8b8b8;
            }

            /*--Dots Post --*/
            .dots-containerPost {
                text-align: center;
                margin-top: 20px;
            }

            .dotPost {
                cursor: pointer;
                height: 15px;
                width: 15px;
                margin: 0 2px;
                background-color: #bbb;
                border-radius: 50%;
                display: inline-block;
                transition: background-color 0.6s ease;
            }

                .dotPost .activeBk-color {
                    background-color: #b8b8b8;
                }

            .p-title {
                font-size: 17px;
                margin-left: 12px;
                margin-bottom: 4px;
            }

            .divInput {
                position: relative;
                align-self: flex-start;
                text-align: left;
                margin-left: 10px;
                margin-bottom: 3px;
            }

            .inputTitle {
                border: none;
                outline: none !important;
                color: aliceblue;
                font-size: 18px;
                background-color: transparent;
            }

            /*---------Upload file Table---------*/
            .js-div-fileTable {
                display: none;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }

        </style>
        <div class="main-container-profileGrid">
            <div style="height: 100%; width: 36%;">
                <div style="height: 230px;" class="item-container-profileLeft">
                    <div class="p-2 w-100">
                        <h4>Introduce</h4>
                    </div>

                    <div class="item-introduce" style="display: flex; flex-direction: row;">
                        <i class="icon-address fas fa-regular fa-location-dot"></i>
                        <p class="m-2 p-address">
                            <%= account.AccountInfo.Address %>
                        </p>
                    </div>
                    <div class="item-introduce" style="display: flex; flex-direction: row;">
                        <i class="icon-address fas fa-solid fa-phone"></i>
                        <p class="m-2 p-address">
                            <%= account.AccountInfo.PhoneNumber %>
                        </p>
                    </div>
                    <div class="item-introduce" style="display: flex; flex-direction: row;">
                        <i class="icon-address fas fa-solid fa-calendar-days"></i>
                        <p class="m-2 p-address">
                            <%= account.AccountInfo.CreateDate.ToString(UploadImage.Ulti.date3) %>
                        </p>
                    </div>
                    <div class="item-introduce" style="display: flex; flex-direction: row">
                        <i class="icon-address fas fa-regular fa-image"></i>
                        <asp:LinkButton ID="UpdateAvatar" CssClass="updateAvt p-profile" runat="server" OnClick="UpdateAvatar_Click">
                            Cập nhật ảnh đại diện
                        </asp:LinkButton>
                    </div>
                </div>

                <div class="containerBox-profile mt-2">
                    <div class="p-2 w-100 h-25" style="display: flex; flex-direction: row">
                        <h4>Ảnh</h4>
                        <a class="post-a" href="ImagePage.aspx">Tất cả các ảnh</a>
                    </div>

                    <div class="box-image">
                        <div class="child">
                            <asp:Repeater ID="RepeaterImages" runat="server">
                                <ItemTemplate> 
                                    <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("Url") %>' CssClass="list-image-profile" />
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>

                <div id="CreateAvt" class="item-container-updateAvatar mt-2">
                    <asp:Panel ID="panelInput" runat="server" CssClass="p-profile" Style="visibility: hidden">
                        <div class="input-group mb-3 mt-2">
                            <span class="input-group-text" id="basic-addon1">File Name</span>
                            <input id="inputfileName" type="text" class="form-control" placeholder="fileName" aria-label="fileName" aria-describedby="basic-addon1" runat="server">
                        </div>

                        <div class="input-group mb-3">
                            <span class="input-group-text" id="basic-addon2">Name</span>
                            <input id="inputName" type="text" placeholder="Name" class="form-control" aria-label="Name" aria-describedby="basic-addon1" runat="server">
                        </div>

                        <div class="input-group mb-3">
                            <span class="input-group-text" id="basic-addon3">Style</span>
                            <input id="inputStyle" readonly type="text" value="Avatar" class="form-control" aria-describedby="basic-addon1" runat="server">
                        </div>

                        <div class="input-group mb-3">
                            <span class="input-group-text" id="basic-addon4">Summary</span>
                            <input id="inputSummary" type="text" class="form-control" placeholder="summary" aria-describedby="basic-addon1" runat="server">
                        </div>

                        <asp:FileUpload ID="fileUploadControl" accept="image/png, image/jpeg" runat="server" CssClass="form-control" />

                        <asp:Button ID="btnUpload" runat="server" Text="Confirm Upload" OnClick="btnUpload_Click" CssClass="btn btn-primary mt-2" />
                    </asp:Panel>
                </div>
            </div>

            <%-- Column Right --%>
            <div style="height: 100%; width: 63%;">
                <div class="item-container-profileRight">
                    <div class="createPost">
                        <div id="form1" runat="server" style="display:flex; flex-direction: row;" enctype="multipart/form-data">
                            <div style="display: flex; flex-direction: row">
                                <%--<asp:Image ID="imagePostAvatarIcon2" runat="server" CssClass="imagePost-Avatar" />--%>
                            </div>
                            <div style="display: flex; flex-direction: row" class="m-4">
                                <button class="btn-create" type="button" onclick="toggleDiv()" style="display: flex; flex-direction: row">
                                    <i class="fas-image-icon fa-solid fa-regular fa-image"></i>
                                    <p class="m-1">Create Post</p>
                                </button>
                            </div>
                            <div class="mt-4">
                                <button class="btn-create" type="button" onclick="toggleDivUpload()" style="display: flex; flex-direction: row">
                                    <span class="fas-file-icon fa-solid fa-file fa-regular"></span>
                                    <p class="m-1">Upload File</p>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div id="divCreatePost" class="postCreate" style="display: none">
                        <div class="div-post-upload-container">
                            <div style="position: relative; width: 100%;">
                                <div style="display: flex; flex-direction: row;">
                                    <img src="<%= urlAvatar %>" class="imagePost-Avatar"/>
                                    <p class="p-name-post">
                                        <a>
                                            <%= account.Name %>
                                        </a>
                                        <span class="p-post-status">đã tạo bài viết mới
                                        </span>
                                    </p>
                                </div>
                                <asp:LinkButton ID="closePost" CssClass="js-close-createPost" runat="server" type="button">
                                    <i class="fa-solid fa-x fa-xl icon-close"></i>
                                </asp:LinkButton>
                            </div>
                            <div class="divInput">
                                <input id="title" type="text" size="300" class="inputTitle" placeholder="Bạn muốn chia sẽ thêm về những tắm ảnh này không ?" />
                            </div>
                            <div class="custum-file-upload js-div" for="file">
                                <div class="icon">
                                    <i class="fa-regular fa-images"></i>
                                </div>
                                <div class="text">  
                                    <span>Click to upload image</span>
                                </div>
                                <div id="uploadContainer" runat="server" enctype="multipart/form-data">
                                    <!-- Input upload multiple file -->
                                    <input id="fileUpload" type="file" name="fileUpload" accept="image/png, image/jpeg" class="form-control" multiple onchange="handleFileUpload()" />
                                </div>
                            </div>
                        </div>
                        <div id="previewContainer" style="display: flex; flex-direction: column">

                            <!-- Slideshow -->
                            <div class="slideShow-container js-plusSlide" style="display: none" id="slideshowContainer">
                                <a class="prev" onclick="plusSlides(-1)">❮</a>
                                <a class="next" onclick="plusSlides(1)">❯</a>
                            </div>

                            <!-- Dots -->
                            <div class="m-2" style="text-align: center" id="dotsContainer"></div>

                        </div>
                        <div style="display: flex; justify-content: center; align-items: center">
                            <asp:Button ID="btnUploadMultiple"
                                runat="server" Text="Upload"
                                Style="display: none;"
                                CssClass="btn btn-primary js-btn mb-3"
                                OnClick="btnUploadMultiple_Click" />
                        </div>
                    </div>

                    <div id="divUploadFile" class="postCreate" style="display: none">
                        <div class="div-post-upload-container">
                            <div style="position: relative; width: 100%;">
                                <div style="display: flex; flex-direction: row;">
                                    <img src="<%= urlAvatar %>" class="imagePost-Avatar"/>
                                    <p class="p-name-post">
                                        <a>
                                            <%= account.Name %>
                                        </a>
                                        <span class="p-post-status">đã đăng tải một tài liệu
                                        </span>
                                    </p>
                                </div>
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="js-btn-close" type="button">
                                    <i class="fa-solid fa-x fa-xl icon-close"></i>
                                </asp:LinkButton>
                            </div>
                            <div class="divInput">
                                <input id="summary" type="text" class="inputTitle" placeholder="Nhập thông tin thêm..." />
                            </div>
                            <div class="custum-file-upload js-div-fileDocument" for="file">
                                <div class="icon">
                                    <i class="fa-solid fa-cloud-arrow-up"></i>
                                </div>
                                <div class="text">
                                    <span>Click to upload document</span>
                                </div>
                                <div id="Div1" runat="server" enctype="multipart/form-data">
                                    <!-- Input để chọn file -->
                                    <input id="fileDocument"
                                        type="file" name="fileDocument"
                                        accept="application/msword, application/pdf, text/plain, application/vnd.openxmlformats-officedocument.wordprocessingml.document" 
                                        class="form-control" 
                                        multiple onchange="handlefileDocument()" />
                                </div>
                            </div>
                        </div>
                        <div style="display: flex; flex-direction: column;">
                             <div id="fileDetails" class="js-div-fileTable">
                                 <h2>Uploaded Files</h2>
                                 <table class="table table-dark">
                                     <thead>
                                         <tr>
                                             <th>File Name</th>
                                             <th>File Size (Kb)</th>
                                             <th>Preview/URL</th>
                                         </tr>
                                     </thead>
                                     <tbody id="fileTableBody">
                                     </tbody>
                                 </table>
                                 <asp:Button ID="btnfileDocument"
                                     runat="server" Text="Upload"
                                     Style="display: none;"
                                     CssClass="btn btn-primary js-btn-fileDocument mb-3"
                                     OnClick="btnfileDocument_Click" />
                             </div>
                        </div>
                    </div>

                    <% if (account.lstPost != null)
                        {
                            foreach (var post in account.lstPost)
                            {
                                bool flag = false;
                                if (String.Compare(post.IdAccount, account.Id, true) == 0)
                                {
                                    List<UploadImage.Images> lstImgRepeater = new List<UploadImage.Images>();
                                    foreach (var image in post.lstImage)
                                    {
                    %>

                    <%-- Post Avatar --%>
                    <% if (string.Compare(image.Style, "Avatar", true) == 0)
                        {
                            flag = false;
                            imagePost.ImageUrl = image.Url;
                    %>
                    <div class="postAvatar">
                        <div style="display: flex; flex-direction: row; position: relative;">
                            <asp:Image ID="imagePostAvatarIcon" runat="server" CssClass="imagePost-Avatar" />

                            <div style="display: flex; flex-direction: column;">
                                <p class="p-name-post">
                                    <a>
                                        <%= account.Name %>
                                    </a>
                                    <span class="p-post-status">đã cập nhật ảnh đại diện
                                    </span>
                                </p>
                                <p class="p-createDate-post">
                                    <%= post.CreateDate %>
                                </p>
                                <div class="user-dropdown2">
                                    <i class="icon-ellipsis fa-solid fa-ellipsis fa-xl"></i>
                                    <div class="dropdown-content2" style="width: 200px; top: 35px; right: 30px;">
                                        <div style="display: flex; flex-direction: row; position: relative; align-items: center;">
                                            <asp:LinkButton CssClass="btnLinkIcon" ID="ButtonRemove" runat="server">
                                          Remove
                                          <i class="icon-remove fa-xl fa-solid fa-trash-can"></i>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="post-image">
                            <asp:Image ID="imagePost"
                                CssClass="imagePost js-myImg"
                                Style="cursor: pointer"
                                runat="server" />
                            <div id="myModal" class="modal">
                                <span class="close">&times;</span>
                                <img id="img01" src="/" class="modal-content" />
                                <div id="caption"></div>
                            </div>
                        </div>
                    </div>
                    <% }
                        else
                        {
                            flag = true;
                            lstImgRepeater.Add(image);
                    %>
                    <% }

                        } %>
                    <% 
                        Repeater1.DataSource = lstImgRepeater;
                        Repeater1.DataBind();
                        if (flag == true)
                        { %>

                    <div id="divPost" class="postCreate js-div-post">
                        <div class="div-post-upload-container">
                            <div style="position: relative; width: 100%;">
                                <div style="display: flex; flex-direction: row;">
                                    <asp:Image ID="imagePostAvatarIcon2" runat="server" CssClass="imagePost-Avatar" />
                                    <div style="display: flex; flex-direction: column;">
                                        <p class="p-name-post">
                                            <a>
                                                <%= account.Name %>
                                            </a>
                                            <span class="p-post-status">đã tạo bài viết mới
                                            </span>
                                        </p>
                                        <p class="p-createDate-post">
                                            <%= post.CreateDate %>
                                        </p>
                                    </div>
                                    <div style="position: absolute; bottom: 0;">
                                        <p class="p-title"><%= post.Title %></p>
                                    </div>
                                </div>
                                <div class="user-dropdown2">
                                    <i class="icon-ellipsis fa-solid fa-ellipsis fa-xl"></i>
                                    <div class="dropdown-content2" style="width: 200px; top: 35px; right: 30px;">
                                        <div style="display: flex; flex-direction: row; position: relative; align-items: center;">
                                            <asp:LinkButton CssClass="btnLinkIcon" ID="removePost" OnClick="removePost_Click" runat="server">
                                          Remove
                                          <i class="icon-remove fa-xl fa-solid fa-trash-can"></i>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <asp:Repeater ID="Repeater1" runat="server">
                                    <ItemTemplate>
                                        <div class="mySlidesPost js-test">
                                            <div id="number" class="numbertext">0 / 1</div>
                                            <img id="imgSlide"
                                                src='<%# Eval("Url") %>'
                                                alt='<%# Eval("Name") %>'
                                                class="js-myImg"
                                                style="width: 100%; cursor: pointer;" />
                                            <a class="prevPost" onclick="plusSlidesPost(-1, this)">&#10094;</a>
                                            <a class="nextPost" onclick="plusSlidesPost(1, this)">&#10095;</a>
                                        </div>

                                        <div id="myModal" class="modal">
                                            <span class="close">&times;</span>
                                            <img id="img01" src="/" class="modal-content" />
                                            <div id="caption"></div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                    <% }%>
                    <%}
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </main>

    <!-- JavaScript -->
    <script>
        let slideIndex = 1;

        // Handle file image and create slideshow div
        function handleFileUpload() {
            const files = document.getElementById('fileUpload').files;
            const slideshowContainer = document.getElementById('slideshowContainer');
            const dotsContainer = document.getElementById('dotsContainer');

            const slides = slideshowContainer.querySelectorAll('.mySlides');
            slides.forEach(slide => slide.remove());
            dotsContainer.innerHTML = '';

            // file is empty return
            if (files.length === 0) return;

            Array.from(files).forEach((file, index) => {
                const reader = new FileReader();

                reader.onload = function (e) {
                    const slideDiv = document.createElement('div');
                    slideDiv.className = 'mySlides';
                    slideDiv.innerHTML = `
                         <img src="${e.target.result}" style="width:100%">
                    `;
                    slideshowContainer.appendChild(slideDiv);

                    const dot = document.createElement('span');
                    dot.className = 'dot';
                    dot.setAttribute('onclick', `currentSlide(${index + 1})`);

                    if (index === 0) {
                        slideDiv.style.display = "block";
                        dot.style = "background-color: #717171";
                    }
                    dotsContainer.appendChild(dot);
                };

                reader.readAsDataURL(file);
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

            var jsplus = document.querySelector(".js-plusSlide");
            jsplus.style.display = 'block';

        }

        // Create event click close file upload image and reset value
        document.querySelector('.js-close-createPost').addEventListener('click', function () {
            document.getElementById('fileUpload').value = '';
        });

        function removeSlide(index) {
            const slides = document.querySelectorAll('.mySlides');
            const dots = document.querySelectorAll('.dot');
            const slideshowContainer = document.getElementById('slideshowContainer');
            const dotsContainer = document.getElementById('dotsContainer');

            slides[index].remove();
            dots[index].remove();

            if (slideIndex > slides.length) {
                slideIndex = slides.length;
            }
            if (slideIndex === index + 1) {
                showSlides(slideIndex);
            } else {
                showSlides(slideIndex);
            }
        }

        // button next
        function plusSlides(n) {
            showSlides(slideIndex += n);
        }

        // button prev
        function currentSlide(n) {
            showSlides(slideIndex = n);
        }

        // handle event click button prev and next
        function showSlides(n) {
            const slides = document.getElementsByClassName("mySlides");
            const dots = document.getElementsByClassName("dot");

            if (n > slides.length) slideIndex = 1;
            if (n < 1) slideIndex = slides.length;

            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            for (let i = 0; i < dots.length; i++) {
                dots[i].style = "background-color: #b8b8b8";
            }

            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].style = "background-color: #717171;";
        }

        // Handle file Document upload, .pdf .doc .docx .txt
        function handlefileDocument() {

            var fileDocument = document.getElementById("fileDocument").files;
            const tableBody = document.getElementById('fileTableBody');
            tableBody.innerHTML = '';

            Array.from(fileDocument).forEach(file => {
                const fileSizeKB = (file.size / 1024).toFixed(2);
                const fileURL = URL.createObjectURL(file);

                const row = document.createElement('tr');            // Create table row
                const nameCell = document.createElement('td');       // File name
                nameCell.textContent = file.name;
                row.appendChild(nameCell);

                const sizeCell = document.createElement('td');       // File size
                sizeCell.textContent = fileSizeKB;
                row.appendChild(sizeCell);

                const urlCell = document.createElement('td');        // File Url
                const link = document.createElement('a');
                link.href = fileURL;
                link.textContent = 'View';
                link.target = '_blank';
                urlCell.appendChild(link);
                row.appendChild(urlCell);

                tableBody.appendChild(row);
            });

            var divfileDoc = document.querySelector(".js-div-fileDocument");
            if (divfileDoc.style.display === 'none') {
                divfileDoc.style.display = 'block';
            } else {
                divfileDoc.style.display = 'none';
            }

            var btnfileDoc = document.querySelector(".js-btn-fileDocument");
            if (btnfileDoc.style.display === 'none') {
                btnfileDoc.style.display = 'block';
            } else {
                btnfileDoc.style.display = 'none';
            }

            var tablefileDoc = document.querySelector(".js-div-fileTable");
            tablefileDoc.style.display = 'flex';
        }

        // Create event click to button close file Document
        document.querySelector('.js-btn-close').addEventListener('click', function () {
            document.getElementById('fileDocument').value = '';
        });


        // Open close div
        function toggleDiv() {
            const divUpload = document.getElementById('divUploadFile');
            if (divUpload.style.display === 'flex') {
                divUpload.style.display = 'none';
            }
            const div = document.getElementById('divCreatePost');
            if (div.style.display === 'none') {
                div.style.display = 'flex';
            } else {
                div.style.display = 'none';
            }
        }

        // open close div upload file document
        function toggleDivUpload() {
            const divPost = document.getElementById('divCreatePost');
            if (divPost.style.display === 'flex') {
                divPost.style.display = 'none';
            }
            const div = document.getElementById('divUploadFile');
            if (div.style.display === 'none') {
                div.style.display = 'flex';
            } else {
                div.style.display = 'none';
            }
        }

        //Zoom Image modal
        var images = document.querySelectorAll(".js-myImg");
        images.forEach(function (img) {
            img.onclick = function () {
                var modal = document.getElementById("myModal");
                var modalImg = document.getElementById("img01");
                var captionText = document.getElementById("caption");

                var heightOriginal = img.clientHeight;
                modal.style.display = "block";
                modalImg.src = img.src;
                var width = modalImg.clientWidth;
                var height = modalImg.clientHeight;

                if (height > 600 && heightOriginal > 300) {
                    modalImg.style = "max-height: 800px; max-width: 650px; margin-top: 70px;";
                }
                else if (height < 600 && heightOriginal > 300) {
                    modalImg.style = "height: 450px; max-width: 800px; margin-top: 70px;";
                }
                else {
                    modalImg.style = "margin-top: 150px; max-width: 800px; width: 750px; height: 250px;";
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

        // handle image in post to slideshow
        const selectDivPost = document.querySelectorAll('.js-div-post');
        let slideIndexs = Array.from(selectDivPost).map(() => 1);
        let slideIndexPost = 1;
        for (var i = 0; i < selectDivPost.length; i++) {
            showSlidesPost(slideIndexPost, i);
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
            //var height = slidesPost[slideIndexPost - 1].clientHeight;
            //if (height > 800) {
            //    slidesPost[slideIndexPost - 1].style = "max-height: 580px; max-width: 500px";
            //    slidesPost[slideIndexPost - 1].style.display = "block";
            //}
            if (dotsPost.length > 0) dotsPost[slideIndexPost - 1].className += "activeBk-color";

        }

        // button click next slide image in Post
        function plusSlidesPost(n, btn) {
            const perentDiv = btn.closest('.js-div-post');

            const index = Array.from(selectDivPost).indexOf(perentDiv);

            if (index !== -1) {
                showSlidesPost(slideIndexPost += n, index);
            }
        }

        // button click prev slide image in Post
        function currentSlidePost(n, btn) {
            const perentDiv = btn.closest('.js-div-post');

            const index = Array.from(selectDivPost).indexOf(perentDiv);

            if (index !== -1) {
                showSlidesPost(slideIndexPost = n, index);
            }
        }

        function createDotsPost(i) {

            const slidesPost = selectDivPost[i].getElementsByClassName("mySlidesPost");
            const dotsContainerPost = selectDivPost[i].querySelector('.previewContainer2');

            for (let i = 0; i < slidesPost.length; i++) {
                const dotPost = document.createElement("span");
                dotPost.className = "dotPost";
                dotPost.onclick = function () {
                    currentSlidePost(i + 1);
                };
                dotsContainerPost.appendChild(dotPost);
            }
        }

    </script>
</asp:Content>
