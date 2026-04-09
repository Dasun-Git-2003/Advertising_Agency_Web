package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate user credentials
        User user = userDAO.validateUser(email, password); // keep it plain text

        if (user != null) {
            // Check if user is inactive
            if ("Inactive".equalsIgnoreCase(user.getStatus())) {
                request.setAttribute("error", "Your account is inactive. Contact admin.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Create session
            HttpSession session = request.getSession(true); // create session if none exists
            session.setAttribute("user", user);               // full user object
            session.setAttribute("role", user.getRole());    // role
            session.setAttribute("userId", user.getUserId());// user ID

            // Redirect based on role
            switch (user.getRole().toLowerCase()) {
                case "admin":
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
                    break;
                case "client":
                    response.sendRedirect(request.getContextPath() + "/client/dashboard.jsp");
                    break;
                case "professional":
                    response.sendRedirect(request.getContextPath() + "/professional/dashboard.jsp");
                    break;
                case "analyst":
                    response.sendRedirect(request.getContextPath() + "/analyst/dashboard.jsp");
                    break;
                case "manager":
                    response.sendRedirect(request.getContextPath() + "/manager/dashboard.jsp");
                    break;
                case "finance":
                    response.sendRedirect(request.getContextPath() + "/finance/dashboard.jsp");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                    break;
            }

        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
