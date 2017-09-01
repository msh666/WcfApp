<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BlogsForm.aspx.cs" Inherits="IBSTestApp.BlogsForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-3.1.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="../Content/bootstrap.min.css"/>
    <script type="text/javascript">

        //GET ALL
        function getAllBlogs() {
            resetTabla();
            $.ajax({
                type: "GET",
                url: "http://localhost:5197/BloggingService.svc/Blogs/",
                contentType: "json",
                dataType: "json",
                cache: false,
                success: function (data) {
                    $.each(data, function (key, value) {
                        var jsonData = JSON.stringify(value);
                        var objData = $.parseJSON(jsonData);
                        var blogId = objData.BlogId;
                        var name = objData.Name;
                        var url = objData.Url;
                        var userId = objData.UserId;
                        $('<tr><td>' + blogId + '</td><td>' + name + '</td><td>' + url +'</td><td>' + userId + '</td> <td><a id="editItem" data-item="' + blogId + '" onclick="EditItem(this);" >Edit</a></td>' +
                        '<td><a id="delItem" data-item="' + blogId + '" onclick="DeleteItem(this);" >Delete</a></td> </tr>"').appendTo('#tableBody');
                    });
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        }

        // обработчик удаления
        function DeleteItem(el) {
            // получаем id удаляемого объекта
            var id = $(el).attr('data-item');
            deleteBlog(id);
        }
        // обработчик редактирования
        function EditItem(el) {
            // получаем id редактируемого объекта
            var id = $(el).attr('data-item');
            GetBlog(id);
        }

        function GetBlog(id) {
            $.ajax({
                url: "http://localhost:5197/BloggingService.svc/Blogs/" + id,
                type: 'GET',
                contentType: "json",
                dataType: 'json',
                success: function (data) {
                    ShowBlog(data);
                },
                error: function (x, y, z) {
                    alert(x + '\n' + y + '\n' + z);
                }
            });
        }

        function ShowBlog(blog) {
            if (blog != null) {
                $("#TextId").val(blog.BlogId);
                $("#TextName").val(blog.Name);
                $('#TextUrl').val(blog.Url);
            }
            else {
                alert("No Blog");
            }
        }

        //GET ID
        function getBlogById() {
            resetTabla();
            var id = document.getElementById("TextId").value;
            $.ajax({
                type: "GET",
                url: "http://localhost:5197/BloggingService.svc/Blogs/" + id,
                contentType: "json",
                dataType: "json",
                cache: false,
                success: function (data) {
                    var jsonData = JSON.stringify(data);
                    //Parse JSON
                    var objData = $.parseJSON(jsonData);
                    var blogId = objData.BlogId;
                    var name = objData.Name;
                    var url = objData.Url;
                    var userId = objData.UserId;
                    $('<tr><td>' + blogId + '</td><td>' + name + '</td><td>' + url + '</td><td>' + userId + '</td> <td><a id="editItem" data-item="' + blogId + '" onclick="EditItem(this);" >Edit</a></td>' +
                        '<td><a id="delItem" data-item="' + blogId + '" onclick="DeleteItem(this);" >Delete</a></td></tr>"').appendTo('#tableBody');
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        }

        //CREATE
        function addNewBlog() {
            var name = document.getElementById("TextName").value;
            var url = document.getElementById("TextUrl").value;
            var userId = document.getElementById("TextUserId").value;
            var blogData = {
                "Name": name,
                "Url": url,
                "UserId": userId
            };
            $.ajax({
                type: "PUT",
                url: "http://localhost:5197/BloggingService.svc/AddBlog/",
                data: JSON.stringify(blogData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: true,
                cache: false,
                success: function (data) {
                    alert("success..." + data);
                    getAllBlogs();
                },
                error: function (xhr) {
                    alert(xhr.ResponseText);
                }
            });
        }

        //UPDATE
        function updateBlog() {
            var id = document.getElementById("TextId").value;
            var name = document.getElementById("TextName").value;
            var url = document.getElementById("TextUrl").value;
            var blogData = {
                "BlogId": id,
                "Name": name,
                "Url": url
            };
            $.ajax({
                type: "PUT",
                url: "http://localhost:5197/BloggingService.svc/UpdateBlog/" + id,
                data: JSON.stringify(blogData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: true,
                cache: false,
                success: function (data) {
                    getAllBlogs();
                    alert("" + data);
                },
                error: function (xhr) {
                    alert(xhr.ResponseText);
                }
            });
        }

        //DELETE
        function deleteBlog(id) {
            $.ajax({
                type: "DELETE",
                url: "http://localhost:5197/BloggingService.svc/DeleteBlog/" + id,
                contentType: "json",
                dataType: "json",
                cache: false,
                success: function (data) {
                    alert("success..." + data);
                    getAllBlogs();
                },
                error: function () {
                    alert(xhr.ResponseText);
                }
            });
        }

        //RESET tabla
        function resetTabla() {
            $("tr:gt(0)").remove();
        }

    </script>
    <style type="text/css">
        input {
            width: 150px;
        }

        table {
            width: 300px;
        }

        body {
            margin-top: 20px;
        }
        .Links {
            margin-bottom: 30px;
            text-align: center;
        }
        .userLink {
            margin-right: 10px;
        }
    </style>
</head>
<body>
<div class="Links"><a href="UserForm.aspx" class="userLink">USERS</a><a href="BlogsForm.aspx" class="userLink">BLOGS</a><a href="PostsForm.aspx" class="userLink">POSTS</a></div>
    <div class="container">
        <div class="col-md-6">
            <table class="table table-bordered" id="blogs">
                <thead>
                    <tr>
                        <th>Blog ID</th>
                        <th>Name</th>
                        <th>URL</th>
                        <th>Owner</th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                
                </tbody>
            </table>
        </div>
        <div class="col-md-4">
            <form>
                <div class="form-group">
                    <input type="number" id="TextId" placeholder="ID"/>
                    <input type="text" id="TextName" placeholder="NAME"/>
                    <input type="text" id="TextUrl" placeholder="URL"/>
                    <input type="number" id="TextUserId" placeholder="USER ID"/>
                    <input id="GetAllBlog" type="button" class="btn btn-default" value="Get All Blogs" onclick="getAllBlogs()" />
                    <input id="GetBlogById" type="button" class="btn btn-default" value="Get Blog by Id" onclick="getBlogById()" />
                    <input id="AddNewBlog" type="button" class="btn btn-default" value="Add New Blog" onclick="addNewBlog()" />
                    <input id="UpdateBlog" type="button" class="btn btn-default" value="Update Blog" onclick="updateBlog()" />
                </div>
            </form>
        </div>
    </div>
</body>
</html>

