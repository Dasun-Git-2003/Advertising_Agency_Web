<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Marketing Strategy</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f4f8;
            margin: 0;
            padding: 0;
            color: #333;
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

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h2 {
            color: #0d6efd;
            margin-bottom: 30px;
            text-align: center;
        }

        .card {
            background: #fff;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }

        form label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            margin-top: 15px;
        }

        form input[type="text"],
        form textarea {
            width: 100%;
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 1rem;
            transition: border 0.2s, box-shadow 0.2s;
        }

        form input:focus,
        form textarea:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 6px rgba(13,110,253,0.3);
            outline: none;
        }

        form button {
            margin-top: 20px;
            background: #0d6efd;
            color: #fff;
            border: none;
            padding: 14px 20px;
            font-size: 1.1rem;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 600;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        form button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        a.btn-back {
            display: inline-block;
            margin-left: 12px;
            padding: 12px 20px;
            border-radius: 12px;
            text-decoration: none;
            background: #6c757d;
            color: #fff;
            font-weight: 500;
            transition: 0.2s;
        }

        a.btn-back:hover {
            background: #5a6268;
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

        @media (max-width: 600px) {
            .card {
                padding: 20px;
            }

            form button, a.btn-back {
                width: 100%;
                text-align: center;
                margin-top: 10px;
            }

            a.btn-back {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>

<header>
    Marketing Strategy
</header>

<div class="container">
    <h2>Create Marketing Strategy</h2>
    <div class="card">
        <form action="../ManagerServlet" method="post">
            <label>Strategy Title</label>
            <input type="text" name="title" required>

            <label>Details</label>
            <textarea name="details" rows="5"></textarea>

            <div style="display:flex; flex-wrap:wrap; gap:10px;">
                <button type="submit" name="action" value="saveStrategy">Save Strategy</button>
                <a href="dashboard.jsp" class="btn-back">Back</a>
            </div>
        </form>
    </div>
</div>

<footer>
    &copy; 2025 Advertising Agency System
</footer>

</body>
</html>
