package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String sessionRole = (session != null) ? (String) session.getAttribute("role") : null;

        // Get parameters from form
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String role;
        String status = "Active"; // default status

        if ("Admin".equalsIgnoreCase(sessionRole)) {
            // Admin registering any role
            role = request.getParameter("role");
        } else {
            // Self-registration (only client)
            role = "client";
        }

        // Create user object
        User user = new User();
        user.setName(fullname);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);
        user.setStatus(status);

        // Try to register
        boolean saved = userDAO.registerUser(user);

        if (saved) {
            if ("Admin".equalsIgnoreCase(sessionRole)) {
                // Admin → back to user management page
                response.sendRedirect("AdminServlet?action=manage_users");
            } else {
                // Client self-registration → login page
                response.sendRedirect("login.jsp");
            }
        } else {
            request.setAttribute("error", "Registration failed! Email may already exist.");
            if ("Admin".equalsIgnoreCase(sessionRole)) {
                request.getRequestDispatcher("admin/register_user.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }
}
