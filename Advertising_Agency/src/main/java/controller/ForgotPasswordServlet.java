package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.EmailUtil;
import java.io.IOException;
import java.util.UUID;   // for generating reset tokens

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        // generate token
        String token = UUID.randomUUID().toString();
        boolean saved = userDAO.saveResetToken(email, token);

        if (saved) {
            String resetLink = request.getRequestURL().toString().replace("ForgotPasswordServlet", "reset_password.jsp?token=" + token);

            // send email (using JavaMail API)
            try {
                EmailUtil.sendEmail(email, "Password Reset",
                        "Click the link to reset your password: " + resetLink);
                request.setAttribute("msg", "Reset link sent to your email!");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Failed to send email. Try again.");
            }
        } else {
            request.setAttribute("error", "Email not found!");
        }
        request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
    }
}

