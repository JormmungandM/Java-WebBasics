package step.learning.servlets;

import com.google.inject.Singleton;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


//@WebServlet( "/servlet" )
@Singleton
public class ViewServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response ) throws ServletException, IOException {
        response.setCharacterEncoding( "UTF-8" );
        //response.getWriter().print( "<h1>Сервлет рарботает</h1>" );
        HttpSession session = request.getSession() ;
        String userInput = (String) session.getAttribute( "userInput" ) ;
        request.setAttribute( "userInput", userInput ) ;
        if( userInput != null ) {
            session.removeAttribute( "userInput" ) ;
        }
        request.getRequestDispatcher( "WEB-INF/servlets.jsp" )
                .forward( request, response ) ;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // При наличие параметров, передаваемых формой, они становятся доступными
        // через req.s
        req.setCharacterEncoding("UTF-8");
        String userInput = req.getParameter("userInput");
        req.setAttribute("userInput",userInput);
        req.getRequestDispatcher("WEB-INF/servlets.jsp").forward(req,resp);
    }

}
