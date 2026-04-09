<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>New Campaign</title>
    <style>
        /* General Reset */
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f4f8;
            color: #333;
        }

        header {
            background: linear-gradient(90deg, #0d6efd, #6610f2);
            color: #fff;
            padding: 25px 0;
            text-align: center;
            font-size: 1.8rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .card {
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }

        .card form label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            margin-top: 15px;
        }

        .card form input[type="text"],
        .card form input[type="email"],
        .card form input[type="number"],
        .card form input[type="file"],
        .card form textarea {
            width: 100%;
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin-bottom: 10px;
            font-size: 1rem;
            transition: border 0.2s, box-shadow 0.2s;
        }

        .card form input:focus,
        .card form textarea:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 6px rgba(13,110,253,0.3);
            outline: none;
        }

        .card form button {
            margin-top: 20px;
            background: #0d6efd;
            color: #fff;
            border: none;
            padding: 14px;
            font-size: 1.1rem;
            border-radius: 12px;
            width: 100%;
            cursor: pointer;
            font-weight: 600;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .card form button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        footer {
            text-align: center;
            padding: 20px;
            color: #777;
            font-size: 0.9rem;
            background: #f5f7fa;
            border-top: 1px solid #ddd;
            margin-top: 40px;
        }

        @media (max-width: 500px) {
            .card { padding: 20px; }
        }
    </style>
</head>
<body>

<header>
    📢 Create New Campaign
</header>

<div class="container">

    <div class="card">
        <form action="<%= request.getContextPath() %>/CampaignServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="userId" value="<%= userId %>">
            <input type="hidden" name="action" value="create">

            <label>Title</label>
            <input type="text" name="title" required>

            <label>Objective</label>
            <textarea name="objective" rows="3" required></textarea>

            <label>Budget ($)</label>
            <input type="number" name="budget" required>

            <label>Target Audience</label>
            <input type="text" name="audience" required>

            <label>Contact Email</label>
            <input type="email" name="email" required>

            <label>Contact Number</label>
            <input type="text" name="contact" required>

            <label>Upload Media</label>
            <input type="file" name="mediaFile" accept=".jpg,.jpeg,.png,.mp4,.pdf">

            <button type="submit">Create Campaign</button>
        </form>
    </div>
</div>
<a href="<%= request.getContextPath() %>/client/dashboard.jsp" class="btn btn-secondary mb-3">
    ⬅ Back to Dashboard
</a>

<footer>
    &copy; 2025 Advertising Agency System
</footer>

</body>
</html>
