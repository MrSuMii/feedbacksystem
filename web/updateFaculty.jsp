<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String column = request.getParameter("column");
    String value = request.getParameter("value");

    if (id != null && column != null && value != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_management", "root", "9920201752aA@");
            String sql = "UPDATE faculty SET " + column + " = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, value);
            pstmt.setString(2, id);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                out.print("Success");
            } else {
                out.print("Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("Error");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>
