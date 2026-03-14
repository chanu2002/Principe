package util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {

    // Add a parameter to indicate HTML content
    public static void sendBill(String toEmail, String subject, String body, boolean isHtml) {

        final String fromEmail = "chandrabanuherath04@gmail.com";
        final String password = "fhgi ouke afva cjgu";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            if (isHtml) {
                // Tell JavaMail this is HTML content
                message.setContent(body, "text/html; charset=UTF-8");
            } else {
                message.setText(body);
            }

            Transport.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
