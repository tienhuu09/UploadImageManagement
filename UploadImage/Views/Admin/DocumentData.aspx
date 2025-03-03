    <%@ Page Title="Document" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DocumentData.aspx.cs" Inherits="UploadImage.DocumentData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .modalAdd {
            display: none;
            position: fixed;
            z-index: 1;
            padding-top: 100px;
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
            max-width: 900px;
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
                background-image: linear-gradient(to right, #00F5A0 0%, #00D9F5 100%);
                transition: .5s ease;
                display: block;
                z-index: -1;
            }

            #btnConfirm:hover::before {
                width: 9em;
            }

        /*---------Upload file Table---------*/
        .js-div-fileTable {
            display: none;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .inputBorder {
            min-width: 250px;
            width: 100%;
            font-size: 16px;
            border: 4px;
            font-weight: 400;
        }

        .green-dot {
            width: 20px;
            height: 20px;
            margin-top: 8px;
            margin-left: 15px;
            background-color: #6EC207;
            border-radius: 50%;
            display: inline-block;
        }

        .red-dot {
            width: 20px;
            height: 20px;
            margin-top: 8px;
            margin-left: 15px;
            background-color: red;
            border-radius: 50%;
            display: inline-block;
        }

        /*----- Button download -----*/
        .download-btn {
            display: flex;
            text-decoration: none;
            border: 2px solid rgb(168, 38, 255);
            background-color: white;
            width: 50px;
            height: 40px;
            border-radius: 10px;
            position: relative;
            z-index: 1;
            transition: all 0.2s ease;
            align-content: center;
            justify-content: center;
            cursor: pointer;
        }

            .download-btn span {
                padding-top: 7px;
                font-size: 20px;
                color: black;
                width: 25px;
                height: 25px;
                transition: all 0.3s ease;
            }

            .download-btn:hover span {
                color: white;
                fill: white;
            }

            .download-btn:hover {
                background-color: rgb(168, 38, 255);
            }

    </style>
    <from>
        <div style="display: flex; flex-direction: row; position: relative; margin: 10px;">
            <button id="btnAddDocument" class="btn-add-imageData " type="button">
                <span class="fa-plus fa-solid fa-xl"></span>
                Upload Files
            </button>
            <div style="position: absolute; right: 30px">
                <div class="container-input">
                    <input id="inputSearch" type="text" placeholder="Search by name" size="100" name="input" class="input" runat="server" />
                    <svg fill="#000000" width="20px" height="20px" viewBox="0 0 1920 1920" xmlns="http://www.w3.org/2000/svg">
                    </svg>
                    <button style="cursor: pointer" id="search" type="submit" onserverclick="search_ServerClick" class="btn" runat="server">
                        <span class="fa-solid fa-magnifying-glass" fill-rule="evenodd"></span>
                    </button>
                </div>
            </div>
        </div>

        <div>
            <div id="ModalAddDocument" class="modalAdd">
                <div class="modalAdd-content">
                    <span class="closeModal">&times;</span>
                    <h5>Upload files</h5>
                    <div>
                        <div class="custum-file-upload js-div-fileDocument" for="file">
                            <div class="icon">
                                <i class="fa-solid fa-cloud-arrow-up"></i>
                            </div>
                            <div class="text">
                                <span>Click to upload document</span>
                            </div>
                            <div id="Div1" runat="server" enctype="multipart/form-data">
                                <!-- Input để chọn file -->
                                <input id="fileDocument" type="file" name="fileDocument" runat="server" clientidmode="Static" accept="application/msword, application/pdf, text/plain, application/vnd.openxmlformats-officedocument.wordprocessingml.document" class="form-control" multiple onchange="handlefileDocument()" />
                            </div>
                        </div>
                    </div>
                    <div style="display: flex; flex-direction: column;">
                        <div id="fileDetails" class="js-div-fileTable">
                            <asp:HiddenField ID="hfTableData" runat="server" />
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>File Name</th>
                                        <th>File Size (Kb)</th>
                                        <th>Preview/URL</th>
                                        <th class="js-Summary">Summary</th>
                                    </tr>
                                </thead>
                                <tbody id="fileTableBody">
                                </tbody>
                            </table>
                            <div id="divConfirm" style="display: none;">
                                <button id="btnConfirm" class="js-btnConfirm" runat="server" clientidmode="Static" onserverclick="btnfileDocument_Click">Confirm upload</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="Document" class="tab-content">
                <asp:GridView ID="gridDocument" AutoGenerateColumns="false" CssClass="table table-striped" runat="server">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" />
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="Url" HeaderText="Url" />
                        <asp:BoundField DataField="Type" HeaderText="Type" />
                        <asp:BoundField DataField="Size" HeaderText="Size (Kb)" DataFormatString="{0:N0} (Kb)" />
                        <asp:TemplateField HeaderText="User upload">
                            <ItemTemplate>
                                <p>
                                    <%# UploadImage.AccountService.getName(Eval("IdAccount").ToString()) %>
                                </p>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="UploadDate" HeaderText="Upload Date" DataFormatString="{0:dd-MM-yyyy HH:mm tt}" />
                        <asp:BoundField DataField="Summary" HeaderText="Summary" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lbStatus" CssClass="js-status" runat="server" Text='<%# Eval("Status").ToString() %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>    
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <button id="removeDoc" 
                                    class="btn btn-outline-danger" 
                                    clientidmode="Static"
                                    runat="server"
                                    data-id='<%# Eval("Id") %>'
                                    onserverclick="removeDoc_ServerClick"><i class="fa fa-trash"></i>
                                </button>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <a href="<%# Eval("Url") %>" class="download-btn">
                                    <span class="fa-solid fa-cloud-arrow-down"></span>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </from>
    <script>
        var modalAdd = document.getElementById("ModalAddDocument");
        var btn = document.getElementById("btnAddDocument");
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

        // Handle file Document upload, .pdf .doc .docx .txt
        function handlefileDocument() {
            var fileDocument = document.getElementById("fileDocument").files;
            if (fileDocument === null)
                return;
            const tableBody = document.getElementById('fileTableBody');
            const divConfirm = document.getElementById('divConfirm');
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

                const summary = document.createElement('input');
                summary.type = 'text';
                summary.style = 'font-size: 16px';
                summary.className = 'inputBorder';
                summary.placeholder = '. . . . . . . . .';
                row.appendChild(summary);

                tableBody.appendChild(row);
            });

            var divfileDoc = document.querySelector(".js-div-fileDocument");
            if (divfileDoc.style.display === 'none') {
                divfileDoc.style.display = 'block';
            } else {
                divfileDoc.style.display = 'none';
            }

            var tablefileDoc = document.querySelector(".js-div-fileTable");
            tablefileDoc.style.display = 'flex';
            divConfirm.style.display = 'block';
        }

        const btnConfirm = document.getElementById("btnConfirm");
        btnConfirm.addEventListener("click", GetSummary);
        const tableData = [];

        function GetSummary() {
            const summaryElements = document.querySelectorAll('.inputBorder');
            summaryElements.forEach((summary, index) => {
                const str = summary.value;
                tableData.push(str);
            });

            const hiddenField = document.getElementById('<%= hfTableData.ClientID %>');
            if (hiddenField) {
                hiddenField.value = JSON.stringify(tableData);
            }
        }

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

        function AddedSuccess() {
            var fileDocument = document.getElementById("fileDocument").files;
            fileDocument.value = null;
            alert('Added successfully');
        }

        function NotificationUrlExisted() {
            alert('The URL already exists and cannot be initialized!!!');
        }
    </script>
</asp:Content>
