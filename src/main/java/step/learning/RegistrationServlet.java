package step.learning;

import com.google.inject.Singleton;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

//@WebServlet( "/registration" )
@Singleton
public class RegistrationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("Registration.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // User input
        String login = req.getParameter("login");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String password2 = req.getParameter("password2");

        // Error message
        String passwordError = "Passwords do not match";
        String emptyError = "One of the lines is empty";

        // check for emptiness
        if( login.equals("") || email.equals("") )
        {
            req.setAttribute("Error",emptyError);
        }else{
            // password matching check
            if( password.equals(password2))
            {
                req.setAttribute("login",login);
                req.setAttribute("password",password);
                req.setAttribute("email",email);

            }else req.setAttribute("Error",passwordError);  // error password
        }


        req.getRequestDispatcher("Registration.jsp").forward(req,resp);
    }
}
