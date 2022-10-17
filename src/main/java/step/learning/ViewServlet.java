package step.learning;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet( "/servlet" )
public class ViewServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response ) throws ServletException, IOException {
        response.setCharacterEncoding( "UTF-8" );
        //response.getWriter().print( "<h1>Сервлет рарботает</h1>" );
        request.getRequestDispatcher("WEB-INF/servlets.jsp").forward(request,response);
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
