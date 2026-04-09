<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) response.sendRedirect(request.getContextPath() + "/login.jsp");
%>

<header class="app-header">
    <div class="header-left">
        <a href="<%= request.getContextPath() %>/dashboard.jsp" class="logo">
            <img src="<%= request.getContextPath() %>/assets/images/logo.png" alt="AdAgency Logo">
            <span>AdAgency</span>
        </a>
    </div>

    <div class="header-right">
        <span class="welcome-text">👋 Welcome, <b><%= username %></b></span>
        <a href="<%= request.getContextPath() %>/profile.jsp" class="btn profile-btn">Profile</a>
        <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn logout-btn">Logout</a>
    </div>
</header>

<style>
    .app-header {
        width: 100%;
        height: 70px;
        background: linear-gradient(90deg,#0d6efd,#6610f2);
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 25px;
        color: #fff;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        position: fixed;
        top:0;
        z-index: 1000;
    }
    .logo img { height:40px; margin-right:10px; vertical-align:middle; }
    .logo span { font-size:1.5rem; font-weight:700; vertical-align:middle; }
    .header-right { display:flex; align-items:center; gap:15px; }
    .profile-btn, .logout-btn {
        padding:6px 15px;
        border-radius:8px;
        color:#fff;
        text-decoration:none;
        font-weight:500;
        transition:0.3s;
    }
    .profile-btn { background: rgba(255,255,255,0.2); }
    .logout-btn { background: #ff4c60; }
    .profile-btn:hover { background: rgba(255,255,255,0.4); }
    .logout-btn:hover { background: #ff3b4a; }
</style>
