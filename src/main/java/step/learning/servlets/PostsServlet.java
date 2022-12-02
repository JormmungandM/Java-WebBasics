package step.learning.servlets;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import step.learning.dao.PostDAO;
import step.learning.entities.Post;
import step.learning.entities.User;
import step.learning.services.MimeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet( "/user-posts/" )   // servlet-api
@MultipartConfig     // прием multipart - данных
@Singleton
public class PostsServlet extends HttpServlet {

    @Inject private  PostDAO postDAO ;
    @Inject private  MimeService mimeService ;

    @Override
    protected void doGet(HttpServletRequest req,HttpServletResponse resp ) throws ServletException, IOException {

        User authUser = (User) req.getAttribute( "AuthUser" ) ;
        if( authUser == null ) {
            req.setAttribute( "pageBody", "auth/authfragment.jsp" ) ;
        }
        else {
            req.setAttribute("posts", postDAO.getAllUserPosts(authUser.getId()).toArray(new Post[0]));
            req.setAttribute( "pageBody", "content/user-posts.jsp" ) ;
        }
        req.getRequestDispatcher( "/WEB-INF/_layout.jsp" ).forward( req, resp ) ;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        User authUser = (User) req.getAttribute( "AuthUser" ) ;

        String postName = req.getParameter( "addName" ) ;
        String postContent = req.getParameter( "addContent" ) ;
        Part postPreview = req.getPart( "addPreview" ) ;

        String errorMessage = null ;
        try {
            // Name
            if( postName == null || postName.isEmpty() ) {
                throw new Exception( "Name could not be empty" ) ;
            }
            // Content
            if( postContent == null || postContent.isEmpty() ) {
                throw new Exception( "Email could not be empty" ) ;
            }

            if( postPreview == null ) {  // такое возможно если на форме нет <input type="file" name="userAvatar"
                throw new Exception( "Form integrity violation" ) ;
            }

            long size = postPreview.getSize() ;
            String savedName = null ;
            if( size > 0 ) {  // если на форме есть input, то узнать приложен ли файл можно по его размеру
                // файл приложен - обрабатываем его
                String userFilename = postPreview.getSubmittedFileName() ;  // имя приложенного файла
                // отделяем расширение, проверяем на разрешенные, имя заменяем на UUID
                int dotPosition = userFilename.lastIndexOf( '.' ) ;
                if( dotPosition == -1 ) {
                    throw new Exception( "File extension required" ) ;
                }
                String extension = userFilename.substring( dotPosition ) ;
                if( ! mimeService.isImage( extension ) ) {
                    throw new Exception( "File type unsupported" ) ;
                }
                savedName = UUID.randomUUID() + extension ;
                // сохраняем
                // String path = new File( "./" ).getAbsolutePath() ;  // запрос текущей директории - C:\xampp\tomcat\bin\.
                String path = req.getServletContext().getRealPath("/");
                //String path = "C:\\Users\\JormmungandPC\\IdeaProjects\\Java-WebBasics\\src\\main\\webapp\\img\\";
                File file = new File(path + "img\\" + savedName);
                Files.copy( postPreview.getInputStream(), file.toPath() ) ;
                System.out.println(postPreview.getInputStream());
                System.out.println(file.toPath());
            }

            Post post = new Post() ;
            post.setUser_id(authUser.getId());
            post.setName(postName);
            post.setContent(postContent);
            post.setPreview(savedName);
            System.out.println(postName);
            System.out.println(postContent);
            System.out.println(postPreview);
            if( postDAO.Add( post ) == null ) {
                throw new Exception( "Server error, try later" ) ;
            }
        }
        catch( Exception ex ) {
            errorMessage = ex.getMessage() ;
        }

        // Проверяем успешность валидации
        if( errorMessage != null ) {  // Есть ошибки
            // Возвращаем данные если он не прошли валидацию
            session.setAttribute( "SaveName", req.getParameter( "Name" ) ) ;    // Имя
            session.setAttribute( "SaveContent", req.getParameter( "Content" ) ) ;  // Контент
            System.out.println(errorMessage);
            session.setAttribute( "regError", errorMessage ) ;
        }
        else {  // Успешно - нет ошибок
            session.setAttribute( "regOk", "Add successful" ) ;
        }

        req.setAttribute("posts", postDAO.getAllUserPosts(authUser.getId()).toArray(new Post[0]));
        resp.sendRedirect( req.getRequestURI() ) ;
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String postContent = req.getParameter("id");
        String reply = postDAO.Delete( postContent )
                        ? "Delete successful"
                        : "Delete error" ;
        resp.getWriter().print( reply ) ;
    }
}


