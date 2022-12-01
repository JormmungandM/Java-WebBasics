package step.learning.entities;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Post {

    private String id;
    private String user_id;
    private String name;
    private String preview;
    private String content;

    private String date;

    public Post() {

    }
    public Post( ResultSet res ) throws SQLException{
        id      = res.getString( "id"    ) ;
        user_id = res.getString( "user_id" ) ;
        preview = res.getString( "preview"  ) ;
        name    = res.getString( "name"  ) ;
        content = res.getString( "content"  ) ;
        date    = res.getString( "new_date"  );
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPreview() {
        return preview;
    }

    public void setPreview(String preview) {
        this.preview = preview;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }



}
