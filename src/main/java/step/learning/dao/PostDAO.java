package step.learning.dao;

import step.learning.entities.Post;
import step.learning.entities.User;
import step.learning.services.DataService;
import step.learning.services.EmailService;
import step.learning.services.hash.HashService;

import javax.inject.Inject;
import javax.inject.Singleton;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Singleton
public class PostDAO {

    private final DataService dataService;

    @Inject
    public PostDAO(DataService dataService, HashService hashService, EmailService emailService ) {
        this.dataService = dataService ;
    }

    // Получаем все посты
    public List<Post> getAllPosts(){
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT *, DATE_FORMAT(`date`, '%d.%m.%Y %H:%i') as new_date FROM posts ";
        try(Statement stmt = dataService.getConnection().createStatement();
            ResultSet res = stmt.executeQuery(sql); ){
            while(res.next()){
                posts.add(new Post(res));
            }
        }
        catch( SQLException ex ) {
            System.out.println( "PostDAO::getAllPosts" + ex.getMessage() + "\n" + sql) ;
        }
        return posts;
    }

    // Получаем все посты конкетного пользователя
    public List<Post> getAllUserPosts(String userId){
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT *, DATE_FORMAT(`date`, '%d.%m.%Y %H:%i') as new_date FROM posts p WHERE p.user_id = ?";
        try(PreparedStatement prep = dataService.getConnection().prepareStatement( sql )  ){

            prep.setString(1,userId);
            ResultSet res = prep.executeQuery();
            while(res.next()){
                posts.add(new Post(res));
            }
        }
        catch( SQLException ex ) {
            System.out.println( "PostDAO::getAllUserPosts" + ex.getMessage() + "\n" + sql) ;
        }
        return posts;
    }

    public String Add(Post post)
    {
        String id = UUID.randomUUID().toString() ;

        Date dt = new Date();
        SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentTime = sdf.format(dt);
        System.out.println(currentTime);

        String sql = "INSERT INTO posts(`id`,`user_id`,`preview`,`name`,`content`,`date`) VALUES(?,?,?,?,?,?)" ;
        try( PreparedStatement prep = dataService.getConnection().prepareStatement( sql ) ) {
            prep.setString( 1, id ) ;
            prep.setString( 2, post.getUser_id()) ;
            prep.setString( 3, post.getPreview() ) ;
            prep.setString( 4, post.getName() ) ;
            prep.setString( 5, post.getContent() ) ;
            prep.setString( 6, currentTime ) ;
            prep.executeUpdate() ;
        }
        catch( SQLException ex ) {
            System.out.println( "PostDAO::addPosts" + ex.getMessage() + "\n" + sql) ;
            return null ;
        }
        return id ;
    }


}
