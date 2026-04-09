<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String role = user.getRole();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= role %> Profile</title>
    <style>
        body {
            background: #f0f4f8;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0; padding: 0;
        }
        header {
            background: linear-gradient(90deg, #0d6efd, #6610f2);
            color: #fff;
            text-align: center;
            padding: 25px 0;
            font-size: 1.8rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        main {
            max-width: 700px;
            margin: 50px auto;
        }
        .profile-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            padding-top: 170px; /* enough space for avatar */
            padding-bottom: 40px;
            position: relative;
        }
        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .profile-avatar {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            border: 4px solid #fff;
            position: absolute;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: url('<%= request.getContextPath() %>/assets/images/default-user.png') center center / cover no-repeat;
        }
        .profile-header {
            text-align: center;
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 25px;
            color: #333;
        }
        .card-body {
            padding: 0 30px 30px 30px;
        }
        label {
            font-weight: 500;
            margin-bottom: 5px;
            display: block;
            color: #333;
        }
        .form-control {
            width: 100%;
            padding: 8px 12px; /* slightly smaller text boxes */
            margin-bottom: 15px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 1rem;
            transition: border 0.2s, box-shadow 0.2s;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 6px rgba(13,110,253,0.3);
            outline: none;
        }
        .btn {
            padding: 12px 20px;
            font-size: 1rem;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .btn-primary {
            background: #0d6efd;
            color: #fff;
        }
        .btn-primary:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(13,110,253,0.4);
        }
        .btn-danger {
            background: #dc3545;
            color: #fff;
        }
        .btn-danger:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(220,53,69,0.4);
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }
        @media (max-width: 600px) {
            .button-group { flex-direction: column; }
            .button-group .btn { width: 100%; margin-bottom: 10px; }
        }
        .back-btn {
            background: linear-gradient(90deg, #0d6efd, #6610f2);
            color: #fff;
            font-weight: 600;
            padding: 10px 25px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .back-btn:hover {
            background: linear-gradient(90deg, #6610f2, #0d6efd);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.25);
            color: #fff;
        }
    </style>
</head>
<body>

<header>👤 <%= role %> Profile</header>

<main>
    <div class="profile-card">
        <div class="profile-avatar"></div>
        <div class="card-body">
            <div class="profile-header">Update Your Profile</div>
            <form action="<%= request.getContextPath() %>/ProfileServlet" method="post">
                <input type="hidden" name="action" value="updateProfile">
                <input type="hidden" name="userId" value="<%= user.getUserId() %>">

                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" class="form-control" value="<%= user.getName() %>" required>

                <label for="email">Email</label>
                <input type="email" id="email" name="email" class="form-control" value="<%= user.getEmail() %>" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" value="<%= user.getPassword() %>" required>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary">Update Profile</button>

                    <a href="<%= request.getContextPath() %>/ProfileServlet?action=deleteProfile&userId=<%= user.getUserId() %>"
                       class="btn btn-danger"
                       onclick="return confirm('Are you sure you want to delete your profile?');">
                        Delete Profile
                    </a>
                </div>
            </form>
        </div>
    </div>

    <div style="text-align: center; margin-top: 20px;">
        <a href="<%= request.getContextPath() + "/" + role.toLowerCase() + "/dashboard.jsp" %>" class="btn back-btn">
            ⬅ Back to Dashboard
        </a>
    </div>
</main>

</body>
</html>
