package step.learning.dao;

import step.learning.entities.User;
import step.learning.services.DataService;
import step.learning.services.EmailService;
import step.learning.services.hash.HashService;

import javax.inject.Inject;
import javax.inject.Singleton;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;


@Singleton
public class UserDAO {
    private final Connection connection ;
    private final HashService hashService;
    private final DataService dataService;

    private final EmailService emailService;

    @Inject
    public UserDAO(  DataService dataService,HashService hashService, EmailService emailService ) {

        this.dataService = dataService ;
        this.hashService = hashService;
        this.emailService = emailService;

        this.connection = dataService.getConnection() ;
    }

    /**
     * Updates data for given user: set email to confirm
     * @param user with Id set
     * @return success status
     */
    public boolean confirmEmail (User user){
        if(user.getId() == null ) return false;
        String sql = "UPDATE users SET email_code = NULL WHERE id = ?";
        try( PreparedStatement prep = dataService.getConnection().prepareStatement( sql ) ) {
            prep.setString(1, user.getId());
            prep.executeUpdate() ;
        }
        catch( SQLException ex ) {
            System.out.println( "UserDAO::confirmEmail" + ex.getMessage() + "\nsql: " + sql) ;
            return false ;
        }
        return true;
    }

    public boolean incEmailCodeAttempts( User user ) {
        if( user == null || user.getId() == null ) return false ;
        String sql = "UPDATE users u SET u.`email_code_attempts` = u.`email_code_attempts` + 1 WHERE u.`id` = ?" ;
        try( PreparedStatement statement = dataService.getConnection().prepareStatement( sql ) ) {
            statement.setString( 1, user.getId() ) ;
            statement.executeUpdate() ;
        }
        catch( SQLException ex ) {
            System.out.println( "UserDAO::incEmailCodeAttempts " + ex.getMessage() ) ;
            System.out.println( sql ) ;
            return false ;
        }
        user.setEmailCodeAttempts( user.getEmailCodeAttempts() + 1 ) ;
        return true ;
    }

    /**
     * Updates data for user given. Only non-null fields are considered
     * @param user entity 'User' with non-null 'id'
     * @return true if success
     */
    public boolean updateUser( User user ) {
        if( user == null || user.getId() == null ) return false ;

        // ??????????????: ???????????????????????? ????????????, ???????????????? ???????????? ???? ????????????, ?????????????? ???? null (?? user)
        Map<String, String> data = new HashMap<>() ;
        Map<String, Integer> dataNumeric = new HashMap<>();

        if( user.getName() != null ) data.put( "name", user.getName() ) ;
        if( user.getLogin() != null ) data.put( "login", user.getLogin() ) ;
        if( user.getAvatar() != null ) data.put( "avatar", user.getAvatar() ) ;

        if( user.getEmail() != null ){
            user.setEmailCode(UUID.randomUUID().toString().substring(0,6));
            data.put( "email", user.getEmail());
            data.put( "email_code", user.getEmailCode());

            dataNumeric.put("email_code_attempts",0);
        }

        if(user.getPass() != null){
            // ???????????????????? ????????
            String salt = hashService.hash( UUID.randomUUID().toString() ) ;
            // ???????????????????? ?????? ????????????
            String passHash = this.hashPassword( user.getPass(), salt ) ;
            data.put( "pass", passHash ) ;
            data.put( "salt", salt ) ;
        }


        String sql = "UPDATE users u SET " ;
        boolean needComma = false ;
        for( String fieldName : data.keySet() ) {
            sql += String.format( "%c u.`%s` = ?", ( needComma ? ',' : ' ' ), fieldName ) ;
            needComma = true ;
        }

        for( String fieldName : dataNumeric.keySet() ) {   // ???????????????? ???????? ???? ?????????? ??????????????????, ??????????????
            sql += String.format( "%c u.`%s` = %d",        // ?????????????????????? ???? ???????????????? ?? ?????? ????????????
                    ( needComma ? ',' : ' ' ), fieldName, dataNumeric.get( fieldName ) ) ;
            needComma = true ;
        }

        sql += " WHERE u.`id` = ? " ;
        if( ! needComma ) {  // ???? ???????? ???? ???????????? ??????????????????
            return false ;
        }
        try( PreparedStatement prep = dataService.getConnection().prepareStatement( sql ) ) {
            int n = 1;
            for( String fieldName : data.keySet() ) {
                prep.setString( n, data.get( fieldName ) ) ;
                ++n ;
            }
            prep.setString( n, user.getId() ) ;
            prep.executeUpdate() ;
        }
        catch( SQLException ex ) {
            System.out.println( "UserDAO::updateUser" + ex.getMessage() ) ;
            return false ;
        }

        if(user.getEmailCode() != null){
            String text = String.format(
                    "Hello, %s! Your code is <b>%s</b>",
                    user.getName(),
                    user.getEmailCode()
            );

            emailService.send(user.getEmail(), "Email confirmation", text);
        }
        return true ;
    }

    public User getUserById (String userId){
        String sql = "SELECT * FROM users u WHERE u.id = ?";
        try(PreparedStatement prep = dataService.getConnection().prepareStatement( sql ) ){
            prep.setString(1,userId);
            ResultSet res = prep.executeQuery();
            if( res.next() ) {
                return new User( res );
            }
        }
        catch( SQLException ex ) {
            System.out.println( "UserDAO::getUserByID" + ex.getMessage() + "\n" + sql + "--" + userId) ;
        }
        return null ;
    }


    /**
     * Inserts user in DB `Users` table
     * @param user data to insert
     * @return `id` of new record or null if fails
     */
    public String add( User user ) {


        // ???????????????????? id ?????? ?????????? ????????????
        String id = UUID.randomUUID().toString() ;
        // ???????????????????? ????????
        String salt = hashService.hash( UUID.randomUUID().toString() ) ;
        // ???????????????????? ?????? ????????????
        String passHash = this.hashPassword( user.getPass(), salt ) ;
        // ???????????????????? ?????? ?????????????????????????? ??????????
        String emailCode = UUID.randomUUID().toString().substring(0,6);
        // ?????????????? ???????????? (?????????????????????? ?????????????????? ????????????!!)
        String sql = "INSERT INTO users(`id`,`login`,`pass`,`name`,`salt`,`avatar`,`email`,`email_code`) VALUES(?,?,?,?,?,?,?,?)" ;
        try( PreparedStatement prep = connection.prepareStatement( sql ) ) {
            prep.setString( 1, id ) ;
            prep.setString( 2, user.getLogin() ) ;
            prep.setString( 3, passHash ) ;
            prep.setString( 4, user.getName() ) ;
            prep.setString( 5, salt ) ;
            prep.setString( 6, user.getAvatar() ) ;
            prep.setString( 7, user.getEmail() ) ;
            prep.setString( 8, user.getEmailCode() ) ;
            prep.executeUpdate() ;
        }
        catch( SQLException ex ) {
            System.out.println( ex.getMessage() + " " + sql ) ;
            return null ;
        }

        // ?????????? ?????????????????????? ?????????????????? ??????
        if( user.getEmail() != null ){
            user.setEmailCode( emailCode ); // ?????????????????? ??????
            String text = String.format(
                   "<h2>Hello!</h2><p>Your code is <b>%s</b></p>" +
                    "<p>Follow " +
                    "<a href='http://localhost:8080/Java_WebBasics_war_exploded/checkmail/?userid=%s&confirm=%s'>link</a>" +
                    " to confirm email</p>",
                    user.getEmailCode(),
                    user.getId(),
                    user.getEmailCode() ) ;
           emailService.send(user.getEmail(), "Email confirmation", text); // ???????????????? ??????????????????
        }

        return id ;
    }

    /**
     * Checks User table for login given
     * @param login value to look for
     * @return  true if login is in table
     */
    public boolean isLoginUsed(String login){
        String sql = "SELECT COUNT(u.id) FROM users u WHERE u.login=?";

        try ( PreparedStatement prep = connection.prepareStatement(sql))
        {
            prep.setString(1, login );
            ResultSet res = prep.executeQuery();
            res.next();
            return  res.getInt(1) > 0;

        } catch (SQLException ex) {
            System.out.println("DB connection error! "+ ex.getMessage());
            System.out.println(sql);
            return true;
        }
    }

    /**
     * Calculates hash (optionally salted) from password
     * @param password Open password string
     * @return  hash for DB table
     */
    public String hashPassword(String password, String salt){
        return hashService.hash( salt + password + salt  );
    }

    public User getUserByCredentials(String login, String password) {
        String sql = "SELECT u.* FROM users u WHERE u.login=?";                 // creating request

        try ( PreparedStatement prep = connection.prepareStatement( sql ) ) {

            prep.setString(1, login );
            ResultSet res = prep.executeQuery();

            if(res.next()) {
                User user = new User(res);
                // password - open password, user.pass - hash(password,user.salt)
                String expectedHash = this.hashPassword( password,user.getSalt());
                if( expectedHash.equals(user.getPass())){   // checking if password is created with salt
                    return user;
                }

                String simpleHash = hashService.hash(password);
                if(simpleHash.equals(user.getPass())){  // checking if password is created without salt
                    return user;
                }
            }

        }
        catch (SQLException ex) {
            System.out.println("DB connection error! " + ex.getMessage());
            System.out.println(sql);
        }
        return null;
    }

    public User getUserByCredentialsOld(String login, String password) {
        String sql = "SELECT u.* FROM users u WHERE u.login=? AND u.pass=?";

        try ( PreparedStatement prep = connection.prepareStatement( sql ) ) {
            prep.setString(1, login );
            prep.setString(2,  password );
            ResultSet res = prep.executeQuery();
            if(res.next()) return new User(res);

        }
        catch (SQLException ex) {
            System.out.println("DB connection error! " + ex.getMessage());
            System.out.println(sql);
        }
        return null;
    }
}

