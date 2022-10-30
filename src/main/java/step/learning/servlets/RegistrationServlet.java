package step.learning.servlets;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import step.learning.dao.UserDAO;
import step.learning.entities.User;
import step.learning.services.MimeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.UUID;

@WebServlet( "/register/" )   // servlet-api
@MultipartConfig              // прием multipart - данных
@Singleton
public class RegistrationServlet extends HttpServlet {
    @Inject private UserDAO userDAO ;
    @Inject private MimeService mimeService ;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Проверяем, есть ли сохраненные в сессии данные от предыдущей обработки
        HttpSession session = req.getSession() ;
        String regError = (String) session.getAttribute( "regError" ) ;
        String regOk = (String) session.getAttribute( "regOk" ) ;
        if( regError != null ) {  // Есть сообщение об ошибке
            req.setAttribute( "regError", regError ) ;
            session.removeAttribute( "regError" ) ;  // удаляем сообщение из сессии
        }
        if( regOk != null ) {  // Есть сообщение об успешной регистрации
            req.setAttribute( "regOk", regOk ) ;
            session.removeAttribute( "regOk" ) ;  // удаляем сообщение из сессии
        }


        req.setAttribute( "pageBody", "auth/registration.jsp" ) ;
        req.getRequestDispatcher( "/WEB-INF/_layout.jsp" ).forward( req, resp ) ;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession() ;

        // Прием данных от формы регистрации
        String userLogin = req.getParameter( "Login" ) ;
        String userPassword = req.getParameter( "Password" ) ;
        String confirmPassword = req.getParameter( "confirmPassword" ) ;
        String userName = req.getParameter( "Name" ) ;
        Part userAvatar = req.getPart( "Avatar" ) ;  // часть, отвечающая за файл (имя - как у input)

        // Валидация данных
        String errorMessage = null ;
        try {
            if( userLogin == null || userLogin.isEmpty() ) {
                System.out.println(req.getParameter( "Login" ));
                throw new Exception( "Login could not be empty" ) ;
            }
            if( ! userLogin.equals( userLogin.trim() ) ) {
                throw new Exception( "Login could not contain trailing spaces" ) ;
            }
            if( userDAO.isLoginUsed( userLogin ) ) {
                throw new Exception( "Login is already in use" ) ;
            }
            if( userPassword == null || userPassword.isEmpty() ) {
                throw new Exception( "Password could not be empty" ) ;
            }
            if( ! userPassword.equals( confirmPassword ) ) {
                throw new Exception( "Passwords mismatch" ) ;
            }
            if( userName == null || userName.isEmpty() ) {
                throw new Exception( "Name could not be empty" ) ;
            }
            if( ! userName.equals( userName.trim() ) ) {
                throw new Exception( "Name could not contain trailing spaces" ) ;
            }

            // region Avatar
            if( userAvatar == null ) {  // такое возможно если на форме нет <input type="file" name="userAvatar"
                throw new Exception( "Form integrity violation" ) ;
            }

            long size = userAvatar.getSize() ;
            String savedName = null ;
            if( size > 0 ) {  // если на форме есть input, то узнать приложен ли файл можно по его размеру
                // файл приложен - обрабатываем его
                String userFilename = userAvatar.getSubmittedFileName() ;  // имя приложенного файла
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
                String path = req.getServletContext().getRealPath( "/" ) ;  // ....\target\WebBasics\
                File file = new File( path + "../upload/" + savedName ) ;
                Files.copy( userAvatar.getInputStream(), file.toPath() ) ;
            }
            // endregion

            User user = new User() ;
            user.setName( userName ) ;
            user.setLogin( userLogin ) ;
            user.setPass( userPassword ) ;
            user.setAvatar( savedName ) ;
            if( userDAO.add( user ) == null ) {
                throw new Exception( "Server error, try later" ) ;
            }
        }
        catch( Exception ex ) {
            errorMessage = ex.getMessage() ;
        }
        // Проверяем успешность валидации
        if( errorMessage != null ) {  // Есть ошибки
            session.setAttribute( "SaveLog", req.getParameter( "Login" ) ) ;
            session.setAttribute( "SaveName", req.getParameter( "Name" ) ) ;
            session.setAttribute( "regError", errorMessage ) ;
        }
        else {  // Успешно - нет ошибок
            session.setAttribute( "regOk", "Registration successful" ) ;
        }
        resp.sendRedirect( req.getRequestURI() ) ;
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User changes = new User() ;
        User authUser = (User) req.getAttribute( "AuthUser" ) ;
        Part userAvatar = null ;
        try {
            userAvatar = req.getPart( "userAvatar" ) ;
        } catch( Exception ignored ) { }

        if( userAvatar != null ) {
            resp.getWriter().print( "File '" + userAvatar.getSubmittedFileName() + "' in use" ) ;
            return ;
        }
        String reply ;
        String login = req.getParameter( "login" ) ;
        if( login != null ) {
            if( userDAO.isLoginUsed( login ) ) {
                resp.getWriter().print( "Login '" + login + "' in use" ) ;
                return ;
            }
            changes.setLogin( login ) ;
        }
        changes.setId( authUser.getId() ) ;
        changes.setName( req.getParameter( "name" ) ) ;
        reply =
                userDAO.updateUser( changes )
                        ? "OK"
                        : "Update error" ;
        resp.getWriter().print( reply ) ;
    }

}
