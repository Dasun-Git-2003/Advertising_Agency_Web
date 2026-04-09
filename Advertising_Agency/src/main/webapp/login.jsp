<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - AdAgency</title>
    <!-- Google Fonts & Bootstrap Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        /* Reset & body */
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0d6efd 0%, #6610f2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Card container */
        .login-card {
            background: #fff;
            border-radius: 20px;
            padding: 40px 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            width: 380px;
            max-width: 90%;
            text-align: center;
            position: relative;
        }

        .login-card h2 {
            font-weight: 700;
            margin-bottom: 25px;
            color: #6610f2;
        }

        .login-card input {
            width: calc(100% - 1.5cm); /* smaller width from right */
            padding: 12px 15px;
            margin: 12px 0;
            border-radius: 12px;
            border: 1px solid #ccc;
            font-size: 1rem;
        }

        .login-card button {
            width: 100%;
            padding: 15px;
            margin-top: 15px;
            border-radius: 50px;
            border: none;
            font-weight: 600;
            font-size: 1rem;
            background: linear-gradient(90deg, #6610f2, #0d6efd);
            color: #fff;
            cursor: pointer;
            transition: 0.3s;
        }

        .login-card button:hover {
            background: linear-gradient(90deg, #0d6efd, #6610f2);
        }

        .login-card a {
            text-decoration: none;
            color: #6610f2;
            font-weight: 500;
        }

        .login-card a:hover {
            text-decoration: underline;
        }

        .alert {
            background: #ffdddd;
            color: #d8000c;
            padding: 10px;
            margin: 10px 0;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h2>Login</h2>

    <!-- Display error from servlet -->
    <% String error = (String) request.getAttribute("error");
        if(error != null){ %>
    <div class="alert"><%= error %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>

    <p style="margin-top:15px;">
        <a href="forgot_password.jsp">Forgot Password?</a>
    </p>
    <p style="margin-top:10px;">
        Don't have an account? <a href="register.jsp">Register</a>
    </p>
</div>

</body>
</html>
