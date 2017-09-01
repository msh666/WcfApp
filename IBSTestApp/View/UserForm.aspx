<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserForm.aspx.cs" Inherits="IBSTestApp.Caller" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-3.1.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="../Content/bootstrap.min.css"/>
    <script type="text/javascript">

        //GET ALL
        function getAllUsers() {
            resetTabla();
            $.ajax({
                type: "GET",
                url: "http://localhost:5197/BloggingService.svc/Users/",
                contentType: "json",
                dataType: "json",
                cache: false,
                success: function (data) {
                    $.each(data, function (key, value) {
                        var jsonData = JSON.stringify(value);
                        var objData = $.parseJSON(jsonData);
                        var userId = objData.UserId;
                        var name = objData.Name;
                        $('<tr><td>' + userId + '</td><td>' + name + '</td> <td><a id="editItem" data-item="' + userId + '" onclick="EditItem(this);" >Edit</a></td>' +
                        '<td><a id="delItem" data-item="' + userId + '" onclick="DeleteItem(this);" >Delete</a></td> </tr>"').appendTo('#tableBody');
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
            deleteUser(id);
        }
        // обработчик редактирования
        function EditItem(el) {
            // получаем id редактируемого объекта
            var id = $(el).attr('data-item');
            GetUser(id);
        }

        function GetUser(id) {
            $.ajax({
                url: "http://localhost:5197/BloggingService.svc/Users/" + id,
                type: 'GET',
                contentType: "json",
                dataType: 'json',
                success: function (data) {
                    ShowUser(data);
                },
                error: function (x, y, z) {
                    alert(x + '\n' + y + '\n' + z);
                }
            });
        }

        function ShowUser(user) {
            if (user != null) {
                $("#TextId").val(user.UserId);
                $("#TextName").val(user.Name);
            }
            else {
                alert("No User");
            }
        }

        //GET ID
        function getUserById() {
            resetTabla();
            var id = document.getElementById("TextId").value;
            $.ajax({
                type: "GET",
                url: "http://localhost:5197/BloggingService.svc/Users/" + id,
                contentType: "json",
                dataType: "json",
                cache: false,
                success: function (data) {
                    var jsonData = JSON.stringify(data);
                    //Parse JSON
                    var objData = $.parseJSON(jsonData);
                    var userId = objData.UserId;
                    var name = objData.Name;
                    $('<tr><td>' + userId + '</td><td>' + name + '</td> <td><a id="editItem" data-item="' + userId + '" onclick="EditItem(this);" >Edit</a></td>' +
                        '<td><a id="delItem" data-item="' + userId + '" onclick="DeleteItem(this);" >Delete</a></td></tr>"').appendTo('#tableBody');
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        }

        //CREATE
        function addNewUser() {
            var name = document.getElementById("TextName").value;
            var userData = {
                "Name": name
            };
            $.ajax({
                type: "PUT",
                url: "http://localhost:5197/BloggingService.svc/AddUser/",
                data: JSON.stringify(userData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: true,
                cache: false,
                success: function (data) {
                    alert("success..." + data);
                    getAllUsers();
                },
                error: function (xhr) {
                    alert(xhr.ResponseText);
                }
            });
        }

        //UPDATE
        function updateUser() {
            var id = document.getElementById("TextId").value;
            var name = document.getElementById("TextName").value;

            var userData = {
                "UserId": id,
                "Name": name
            };

            $.ajax({
                type: "PUT",
                url: "http://localhost:5197/BloggingService.svc/UpdateUser/" + id,
                data: JSON.stringify(userData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                processData: true,
                cache: false,
                success: function (data) {
                    getAllUsers();
                    alert("success..." + data);
                },
                error: function (xhr) {
                    alert(xhr.ResponseText);
                }
            });
        }

        //DELETE
        function deleteUser(id) {
            $.ajax({
                type: "DELETE",
                url: "http://localhost:5197/BloggingService.svc/DeleteUser/" + id,
                contentType: "json",
                dataType: "json",
                cache: false,
                success: function (data) {
                    alert("success..." + data);
                    getAllUsers();
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
        <div class="col-md-4">
            <table class="table table-bordered" id="users">
                <thead>
                    <tr>
                        <th scope="row">User ID</th>
                        <th>Name</th>
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
                    <input id="GetAllUser" type="button" class="btn btn-default" value="Get All Users" onclick="getAllUsers()" />
                    <input id="GetUserById" type="button" class="btn btn-default" value="Get User by Id" onclick="getUserById()" />
                    <input id="AddNewUser" type="button" class="btn btn-default" value="Add New User" onclick="addNewUser()" />
                    <input id="UpdateUser" type="button" class="btn btn-default" value="Update User" onclick="updateUser()" />
                </div>
            </form>
        </div>
    </div>
</body>
</html>
