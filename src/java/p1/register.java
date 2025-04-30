/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package p1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ajmat khan
 */
@WebServlet(urlPatterns = {"/register"})
public class register extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String uname = request.getParameter("username");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
        String phone = request.getParameter("contact");
        String password = request.getParameter("password");

        String role = "student"; // Default role

        String sql = "INSERT INTO users (username, email, course, phone, password, role) VALUES (?, ?, ?, ?, ?, ?)";

        HttpSession session = request.getSession();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_db", "root", "9920201752aA@");
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, uname);
            ps.setString(2, email);
            ps.setString(3, course);
            ps.setString(4, phone);
            ps.setString(5, password);
            ps.setString(6, role);

            int rowaffected = ps.executeUpdate();
            if (rowaffected > 0) {
                session.setAttribute("username", uname);
                session.setAttribute("course", course);
                response.sendRedirect("index.html");
            } else {
                out.println("<center>Try again</center>");
            }

            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("Database connection error: " + e);
        }
    }
}
