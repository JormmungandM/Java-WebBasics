package step.learning.services;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/*
email: java.web.jormmungand@gmail.com
pass: avidqlrzilnbczhd
*/

public class GmailService implements EmailService{
    @Override
    public boolean send(String to, String subject, String text) {
        Properties gmailProperties = new Properties();
        gmailProperties.put( "mail.smtp.aut","true" );
        gmailProperties.put( "mail.smtp.starttls.enable","true" );
        gmailProperties.put( "mail.smtp.port","587" );
        gmailProperties.put( "mail.smtp.ssl.protocols","TLSv1.2" );
        gmailProperties.put( "mail.smtp.ssl.trust","smtp.gmail.com" );

        Session mailSession = Session.getInstance(gmailProperties);
        mailSession.setDebug( true ); // вывод в консоль данных обмена

        try{
            Transport mailTransport = mailSession.getTransport( "smtp" );
            mailTransport.connect(
                    "smtp.gmail.com",
                    "java.web.jormmungand@gmail.com",
                    "avidqlrzilnbczhd"
            );
            // Создаем сообщение
            MimeMessage message = new MimeMessage(mailSession);
            // от кого
            message.setFrom( new InternetAddress("java.web.jormmungand@gmail.com"));
            //message.addRecipients(Message.RecipientType.TO, InternetAddress.parse( to ));
            // тема
            message.setSubject( subject );
            // содржание (тело)
            message.setContent( text, "text/html; charset=utf-8");
            // отправляем
            mailTransport.sendMessage(message, InternetAddress.parse( to ));
            mailTransport.close();


        }catch (MessagingException ex){
            return false;
        }

        return true;
    }
}

