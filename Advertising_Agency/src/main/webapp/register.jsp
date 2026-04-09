<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - AdAgency</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #6610f2 0%, #0d6efd 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-card {
            background: #fff;
            border-radius: 20px;
            padding: 40px 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            width: 450px;
            max-width: 90%;
            text-align: center;
        }

        .register-card h2 {
            font-weight: 700;
            margin-bottom: 25px;
            color: #0d6efd;
        }

        .register-card input {
            width: calc(100% - 1.5cm); /* reduces width from right by 1.5cm */
            padding: 12px 15px;
            margin: 12px 0;
            border-radius: 12px;
            border: 1px solid #ccc;
            font-size: 1rem;
        }

        .register-card button {
            width: 100%;
            padding: 15px;
            margin-top: 15px;
            border-radius: 50px;
            border: none;
            font-weight: 600;
            font-size: 1rem;
            background: linear-gradient(90deg, #0d6efd, #6610f2);
            color: #fff;
            cursor: pointer;
            transition: 0.3s;
        }

        .register-card button:hover {
            background: linear-gradient(90deg, #6610f2, #0d6efd);
        }

        .register-card a {
            text-decoration: none;
            color: #0d6efd;
            font-weight: 500;
        }

        .register-card a:hover {
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

<div class="register-card">
    <h2>Register</h2>

    <% String error = (String) request.getAttribute("error");
        if(error != null){ %>
    <div class="alert"><%= error %></div>
    <% } %>

    <form action="RegisterServlet" method="post">
        <input type="text" name="fullname" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>

        <button type="submit">Register</button>

        <p style="margin-top:10px;">Already have an account? <a href="login.jsp">Login</a></p>
    </form>
</div>

</body>
</html>
