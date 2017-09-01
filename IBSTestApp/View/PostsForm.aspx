<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PostsForm.aspx.cs" Inherits="IBSTestApp.PostsForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-3.1.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="../Content/bootstrap.min.css"/>
    <script type="text/javascript">

        //GET ALL
        function getAllPosts() {
            resetTabla();
            $.ajax({
                type: "GET",
                url: "http://localhost:5197/BloggingService.svc/Posts/",
                contentType: "json",
                dataType: "json",
                cache: false,
                success: function (data) {
                    $.each(data, function (key, value) {
                        var jsonData = JSON.stringify(value);
                        var objData = $.parseJSON(jsonData);
                        var postId = objData.PostId;
                        var title = objData.Title;
                        var content = objData.Content;
                        var time = formatDate(objData.PublicationDate);
                        var blogId = objData.BlogId;
                        $('<tr><td>' + postId + '</td><td>' + title + '</td><td>' + content + '</td><td>' + time + '</td><td>' + blogId + '</td> <td><a id="editItem" data-item="' + postId + '" onclick="EditItem(this);" >Edit</a></td>' +
                        '<td><a id="delItem" data-item="' + postId + '" onclick="DeleteItem(this);" >Delete</a></td> </tr>"').appendTo('#tableBody');
                    });
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        }

        function formatDate(timestamp) {
            var date = timestamp.replace(/\+0500/, "").replace(/[^0-9]/g, "");
            var x = new Date(+date);
            var dd = x.getDate();
            var mm = x.getMonth() + 1;
            var yy = x.getFullYear();
            var hh = x.getHours();
            var mn = x.getMinutes();
            return dd + "/" + mm + "/" + yy + " " + hh + ":" + mn;
        }

        // обработчик удаления
        function DeleteItem(el) {
            // получаем id удаляемого объекта
            var id = $(el).attr('data-item');
            deletePost(id);
        }
        // обработчик редактирования
        function EditItem(el) {
            // получаем id редактируемого объекта
            var id = $(el).attr('data-item');
            GetPost(id);
        }

        function GetPost(id) {
            $.ajax({
                url: "http://localhost:5197/BloggingService.svc/Posts/" + id,
                type: 'GET',
                contentType: "json",
                dataType: 'json',
                success: function (data) {
                    ShowPost(data);
                },
                error: function (x, y, z) {
                    alert(x + '\n' + y + '\n' + z);
                }
            });
        }

        function ShowPost(post) {
            if (post != null) {
                $("#TextId").val(post.PostId);
                $("#TextTitle").val(post.Title);
                $('#TextContent').val(post.Content);
            }
            else {
                alert("No Post");
            }
        }

        //GET ID
        function getPostById() {
            resetTabla();
            var id = document.getElementById("TextId").value;
            $.ajax({
                type: "GET",
                url: "http://localhost:5197/BloggingService.svc/Posts/" + id,
                contentType: "json",
                dataType: "json",
                cache: false,
                success: function (data) {
                    var jsonData = JSON.stringify(data);
                    var objData = $.parseJSON(jsonData);
                    var postId = objData.PostId;
                    var title = objData.Title;
                    var content = objData.Content;
                    var time = formatDate(objData.PublicationDate);
                    var blogId = objData.BlogId;
                    $('<tr><td>' + postId + '</td><td>' + title + '</td><td>' + content + '</td><td>' + time + '</td><td>' + blogId + '</td> <td><a id="editItem" data-item="' + postId + '" onclick="EditItem(this);" >Edit</a></td>' +
                        '<td><a id="delItem" data-item="' + postId + '" onclick="DeleteItem(this);" >Delete</a></td> </tr>"').appendTo('#tableBody');
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        }

        //CREATE
        function addNewPost() {
            var title = document.getElementById("TextTitle").value;
            var content = document.getElementById("TextContent").value;
            var blogId = document.getElementById("TextBlogId").value;
            var postData = {
                "Title": title,
                "Content": content,
                "BlogId": blogId
            };
            $.ajax({
                type: "PUT",
                url: "http://localhost:5197/BloggingService.svc/AddPost/",
                data: JSON.stringify(postData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: true,
                cache: false,
                success: function (data) {
                    alert("success..." + data);
                    getAllPosts();
                },
                error: function (xhr) {
                    alert(xhr.ResponseText);
                }
            });
        }

        //UPDATE
        function updatePost() {
            var id = document.getElementById("TextId").value;
            var title = document.getElementById("TextTitle").value;
            var content = document.getElementById("TextContent").value;
            //var blogId = document.getElementById("TextBlogId").value;
            var postData = {
                "PostId": id,
                "Title": title,
                "Content": content
                //"BlogId": blogId
            };
            $.ajax({
                type: "PUT",
                url: "http://localhost:5197/BloggingService.svc/UpdatePost/" + id,
                data: JSON.stringify(postData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: true,
                cache: false,
                success: function (data) {
                    getAllPosts();
                    alert("" + data);
                },
                error: function (xhr) {
                    alert(xhr.ResponseText);
                }
            });
        }

        //DELETE
        function deletePost(id) {
            $.ajax({
                type: "DELETE",
                url: "http://localhost:5197/BloggingService.svc/DeletePost/" + id,
                contentType: "json",
                dataType: "json",
                cache: false,
                success: function (data) {
                    alert("success..." + data);
                    getAllPosts();
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
            <table class="table table-bordered" id="posts">
                <thead>
                    <tr>
                        <th>Post ID</th>
                        <th>Title</th>
                        <th>Content</th>
                        <th>Publication Date</th>
                        <th>Blog</th>
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
                    <input type="text" id="TextTitle" placeholder="TITLE"/>
                    <textarea id="TextContent" rows="3" placeholder="CONTENT"></textarea>
                    <input type="number" id="TextBlogId" placeholder="BLOG ID"/>
                    <input id="GetAllPost" type="button" class="btn btn-default" value="Get All Posts" onclick="getAllPosts()" />
                    <input id="GetPostById" type="button" class="btn btn-default" value="Get Post by Id" onclick="getPostById()" />
                    <input id="AddNewPost" type="button" class="btn btn-default" value="Add New Post" onclick="addNewPost()" />
                    <input id="UpdatePost" type="button" class="btn btn-default" value="Update Post" onclick="updatePost()" />
                </div>
            </form>
        </div>
    </div>
</body>
</html>
