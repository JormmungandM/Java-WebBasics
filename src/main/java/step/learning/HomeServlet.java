package step.learning;

import com.google.inject.Singleton;
import step.learning.services.DataService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

//@WebServlet("/")
@Singleton
public class HomeServlet extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req,HttpServletResponse resp ) throws ServletException, IOException {

        DataService dataService = (DataService)req.getAttribute("DataService");
        String dbElement;

        try (Statement stat = dataService.getConnection().createStatement();
             ResultSet res = stat.executeQuery("SELECT COUNT(*) FROM randoms2");)
        {
            if(res.next()) {
                dbElement = "Amount of elements " + res.getInt(1);
            }
            else {
                dbElement = "No data";
            }
        }
        catch(SQLException ex) {
            dbElement = "Error " + ex.getMessage();
        }



        List<String> elements = new ArrayList<>();
        try (Statement stat = dataService.getConnection().createStatement();
             ResultSet res = stat.executeQuery("SELECT * FROM randoms2");)
        {
            while(res.next()){
                elements.add("Id: "+res.getString("id") + ".  "
                        + res.getString("numint") + " | "
                        + res.getString("numfloat")+ " | "
                        + res.getString("str") + " | "
                        + res.getString("datatime") + "."
                );
            }
        }
        catch(SQLException ex) {
            dbElement = "Error " + ex.getMessage();
        }


        req.setAttribute("count", dbElement);
        req.setAttribute("elements", elements.toArray(new String[0]));
        req.getRequestDispatcher("WEB-INF/index.jsp").forward(req,resp);
    }


}
