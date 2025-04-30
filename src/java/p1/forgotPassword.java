package p1;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class ForgotPassword
 */
@WebServlet("/forgotPassword")
public class forgotPassword extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String email = request.getParameter("email");
        RequestDispatcher dispatcher = null;
        int otpvalue = 0;
        HttpSession mySession = request.getSession();

        String sql = "SELECT * FROM users WHERE email=?";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_db", "root", "9920201752aA@");
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                out.println("<script>alert(`invalid email`)</script>");
            } else if (email != null || !email.equals("")) {
                // sending otp
                Random rand = new Random();
                otpvalue = rand.nextInt(1255650);

                String to = email;// change accordingly
                // Get the session object
                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.socketFactory.port", "465");
                props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.port", "465");
                Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("khanajmat4245@gmail.com", "qpqvdjjruaqbjwiz");// Put your email
                        // id and
                        // password here
                    }
                });
                // compose message
                try {
                    MimeMessage message = new MimeMessage(session);
                    message.setFrom(new InternetAddress(email));// change accordingly
                    message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                    message.setSubject("Hello");
                    message.setText("Your OTP (One-Time Password) for authentication is:"+otpvalue
                            + "\n"
                            + "Please do not share this code with anyone.\n"
                            + "\n"
                            + "If you did not request this, please ignore this email.\n"
                            + "\n"
                            + "Thank you,\n"
                            + "[THAKUR COLLEGE OF SCIENCE AND COMMERCE]");
                    // send message
                    Transport.send(message);
                    System.out.println("message sent successfully");
                } catch (MessagingException e) {
                    throw new RuntimeException(e);
                }
                dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
                request.setAttribute("message", "OTP is sent to your email id");
                //request.setAttribute("connection", con);
                mySession.setAttribute("otp", otpvalue);
                mySession.setAttribute("email", email);
                dispatcher.forward(request, response);
                //request.setAttribute("status", "success");
            } else {
                out.println("please enter a email");
            }
        } catch (Exception e) {
            out.println(e);
        }

    }

}
