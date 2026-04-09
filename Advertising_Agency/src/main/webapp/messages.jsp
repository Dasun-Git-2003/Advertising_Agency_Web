<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Message" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");
    if (userId == null || role == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Message> messages = (List<Message>) request.getAttribute("messages");
    int campaignId = (int) request.getAttribute("campaignId");
    long now = System.currentTimeMillis();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Campaign Messages</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            margin: 0;
            padding: 0;
        }
        header {
            background: linear-gradient(90deg,#0d6efd,#6610f2);
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 1.5rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .chat-container {
            max-width: 800px;
            margin: 30px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            padding: 25px;
        }
        h2, h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        .messages {
            max-height: 500px;
            overflow-y: auto;
            margin-bottom: 20px;
        }
        .message {
            padding: 12px 15px;
            margin-bottom: 10px;
            border-radius: 12px;
            position: relative;
            word-wrap: break-word;
        }
        .message.me {
            background-color: #d4edda;
            text-align: right;
            align-self: flex-end;
        }
        .message.other {
            background-color: #e9ecef;
            text-align: left;
            align-self: flex-start;
        }
        .message small {
            display: block;
            font-size: 0.75rem;
            color: #555;
            margin-top: 5px;
        }
        .message a {
            text-decoration: none;
            color: #0d6efd;
            font-weight: 500;
        }
        .message button {
            margin-top: 5px;
            background: #dc3545;
            border: none;
            color: white;
            padding: 5px 10px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.75rem;
        }
        .message button:hover {
            background: #b02a37;
        }
        form textarea, form input[type="file"] {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin-bottom: 10px;
            font-size: 1rem;
        }
        form button.send-btn {
            background-color: #0d6efd;
            color: white;
            padding: 12px;
            border-radius: 10px;
            border: none;
            width: 100%;
            font-weight: 600;
            cursor: pointer;
            font-size: 1rem;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        form button.send-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(13,110,253,0.4);
        }
        .back-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 18px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            transition: transform 0.2s;
        }
        .back-btn:hover {
            transform: translateY(-2px);
            background-color: #5a6268;
        }
    </style>
    <script>
        function deleteMessage(messageId, campaignId) {
            if (!confirm("Are you sure you want to delete this message?")) return;

            fetch('<%= request.getContextPath() %>/MessageServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=delete&messageId=' + messageId + '&campaignId=' + campaignId
            }).then(resp => {
                if (resp.ok) {
                    document.getElementById("msg-" + messageId).remove();
                } else {
                    alert("Failed to delete message (maybe 5 min limit exceeded).");
                }
            });
        }
    </script>
</head>
<body>

<header>📢 Campaign Chat</header>

<div class="chat-container">
    <div class="messages">
        <%
            if (messages != null && !messages.isEmpty()) {
                for (Message m : messages) {
                    boolean isMe = m.getSenderId() == userId;
                    boolean canDelete = isMe && (now - m.getCreatedAt().getTime() <= 5 * 60 * 1000);
        %>
        <div id="msg-<%= m.getMessageId() %>" class="message <%= isMe ? "me" : "other" %>">
            <strong><%= m.getSenderRole() %>:</strong>
            <div><%= m.getContent() %></div>
            <% if (m.getMediaPath() != null) { %>
            <div><a href="<%= m.getMediaPath() %>" target="_blank">📎 View File</a></div>
            <% } %>
            <small><%= m.getCreatedAt() %></small>
            <% if (canDelete) { %>
            <button onclick="deleteMessage(<%= m.getMessageId() %>, <%= campaignId %>)">Delete</button>
            <% } %>
        </div>
        <%
            }
        } else {
        %>
        <p>No messages yet.</p>
        <% } %>
    </div>

    <form action="<%= request.getContextPath() %>/MessageServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="send"/>
        <input type="hidden" name="campaignId" value="<%= campaignId %>"/>
        <textarea name="content" placeholder="Type your message..." required></textarea>
        <input type="file" name="media"/>
        <button type="submit" class="send-btn">Send</button>
    </form>

    <a href="<%= request.getContextPath() %>/<%= role.toLowerCase() %>/dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>
</div>

</body>
</html>
