<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Faculty</title>
        <link href="managefaculty.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!--<link rel="stylesheet" href="managefaculty.css" class="rel">-->
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #c850c0, #4158d0);
                margin: 0;
                padding: 0;
                height: 100vh; /* Full viewport height */
                display: flex;
            }

            .container {
                display: flex;
                width: 100%;
                height: 100vh;
            }

            /* Sidebar Styles */
            .sidebar {
                background: rgba(255, 255, 255, 0.15);
                backdrop-filter: blur(10px);
                color: white;
                width: 260px;
                padding: 20px;
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
                height: 100%;
                border-radius: 15px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            }

            .user-info {
                text-align: center;
            }

            .user-info img {
                border-radius: 50%;
                width: 80px;
                margin-bottom: 15px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .menu {
                margin-top: 40px;
            }

            .menu ul {
                list-style-type: none;
                padding: 0;
            }

            .menu ul li {
                margin: 20px 0;
            }

            .menu ul li a {
                text-decoration: none;
                color: white;
                font-size: 18px;
                display: flex;
                align-items: center;
                transition: all 0.3s ease;
            }

            .menu ul li a:hover {
                transform: translateX(10px);
                color: #f39c12;
            }

            .menu ul li a i {
                margin-right: 12px;
            }

            /* Content Styles */
            .content {
                flex-grow: 1;
                padding: 40px;
                color: white;
                display: flex;
                flex-direction: column;
                height: auto;
                overflow-y: auto;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .header h1 {
                font-size: 28px;
                font-weight: 600;
            }

            .logout-btn {
                background: #e74c3c;
                color: white;
                border: none;
                padding: 12px 25px;
                border-radius: 10px;
                font-size: 14px;
                cursor: pointer;
                box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
                transition: all 0.3s ease;
            }

            .logout-btn:hover {
                background: #c0392b;
                box-shadow: 0 6px 20px rgba(192, 57, 43, 0.3);
            }

            /* Table Styles */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 12px;
                text-align: left;
                border: 1px solid rgba(255, 255, 255, 0.3);
                color: white;
            }

            th {
                background: rgba(255, 255, 255, 0.1);
                font-weight: 600;
            }

            tr:nth-child(even) {
                background: rgba(255, 255, 255, 0.05);
            }

            tr:hover {
                background: rgba(255, 255, 255, 0.1);
            }

            /* Button Styles */
            .edit-btn, .remove-btn {
                background: green;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 10px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .edit-btn:hover {
                background: greenyellow;
            }

            .remove-btn {
                background: brown;
                margin-left: 10px;
            }

            .remove-btn:hover {
                background: red;
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 200px;
                }

                .content {
                    padding: 20px;
                }

                .header h1 {
                    font-size: 24px;
                }
            }
            /* Input Styles */
            input[type="text"],
            input[type="email"],
            select {
                padding: 10px;
                border: 1px solid rgba(255, 255, 255, 0.5);
                border-radius: 5px;
                margin: 5px 0;
                background: rgba(255, 255, 255, 0.1);
                color: white;
                transition: all 0.3s ease;
            }

            input[type="text"]:focus,
            input[type="email"]:focus,
            select:focus {
                border-color: #f39c12;
                outline: none;
                background: rgba(255, 255, 255, 0.2);
            }

            /* Button Styles for Save and Cancel */
            .save-btn,
            .cancel-btn {
                background: #2ecc71;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 10px;
                cursor: pointer;
                margin-left: 5px;
                transition: all 0.3s ease;
            }

            .save-btn:hover {
                background: #27ae60;
            }

            .cancel-btn {
                background: #e67e22;
            }

            .cancel-btn:hover {
                background: #d35400;
            }

            /* Action Buttons Adjustment */
            .edit-btn,
            .remove-btn {
                background: green;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 10px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .edit-btn:hover {
                background: greenyellow;
            }

            .remove-btn {
                background: brown;
                margin-left: 10px;
            }

            .remove-btn:hover {
                background: red;
            }

            .edit-form {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                z-index: 1000;
            }
            .edit-form input {
                display: block;
                margin: 10px 0;
                padding: 5px;
                width: 100%;
                color:black;
            }
            .edit-form button {
                margin-top: 10px;
                padding: 5px 10px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <aside class="sidebar">
                <div class="user-info">
                    <img src="admin.png" alt="Admin Image" class="user-image">
                    <h3>Admin Panel</h3>
                </div>
                <nav class="menu">
                      <ul>
                        <li><a href="admin.html"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                        <li><a href="addfaculty.html"><i class="fas fa-user-plus"></i> Add Faculty</a></li>
                        <li><a href="managefaculty.jsp"><i class="fas fa-users-cog"></i> Manage Faculty</a></li>
                        <li><a href="managestudents.html"><i class="fas fa-user-graduate"></i> Manage Students</a></li>
                        <li><a href="adminveiwFeedback.jsp"><i class="fas fa-comments"></i> View Feedbacks</a></li>
                        <li><a href="createquestions.jsp"><i class="fas fa-question-circle"></i> Create Feedback Questions</a></li>
                        <li><a href="questionslist.jsp"><i class="fas fa-edit"></i> Edit Question</a></li>
                        <li><a href="adminprofile.html"><i class="fas fa-user"></i> View/Edit Profile</a></li>
                        <li><a href="adminupdatepass.html"><i class="fas fa-key"></i> Update Password</a></li>
                        <li><a href="logoutstudent.html"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </nav>
            </aside>

            <div class="content">
                <div class="header">
                    <h1>Manage Faculty</h1>
                    <button class="logout-btn" onclick="window.location.href='logout.html';">Logout</button>
                </div>

                <table id="faculty-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Mobile Number</th>
                            <th>Program</th>
                            <th>Semester</th>
                            <th>Course Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_management", "root", "9920201752aA@");
                                stmt = conn.createStatement();

                                // Check if an update action is requested
                                String updateId = request.getParameter("updateId");
                                if (updateId != null && !updateId.isEmpty()) {
                                    String name = request.getParameter("name");
                                    String email = request.getParameter("email");
                                    String mobile = request.getParameter("mobile");
                                    String program = request.getParameter("program");
                                    String semester = request.getParameter("semester");
                                    String courseName = request.getParameter("courseName");

                                    String updateSql = "UPDATE faculty SET name=?, email=?, mobile=?, program=?, semester=?, courseName=? WHERE id=?";
                                    PreparedStatement pstmt = conn.prepareStatement(updateSql);
                                    pstmt.setString(1, name);
                                    pstmt.setString(2, email);
                                    pstmt.setString(3, mobile);
                                    pstmt.setString(4, program);
                                    pstmt.setString(5, semester);
                                    pstmt.setString(6, courseName);
                                    pstmt.setString(7, updateId);
                                    int rowsAffected = pstmt.executeUpdate();
                                    if (rowsAffected > 0) {
                                        out.println("<script>alert('Faculty member updated successfully.');</script>");
                                    } else {
                                        out.println("<script>alert('Failed to update faculty member.');</script>");
                                    }
                                    pstmt.close();
                                }

                                // Check if a delete action is requested
                                String deleteId = request.getParameter("deleteId");
                                if (deleteId != null && !deleteId.isEmpty()) {
                                    String deleteSql = "DELETE FROM faculty WHERE id = ?";
                                    PreparedStatement pstmt = conn.prepareStatement(deleteSql);
                                    pstmt.setString(1, deleteId);
                                    int rowsAffected = pstmt.executeUpdate();
                                    if (rowsAffected > 0) {
                                        out.println("<script>alert('Faculty member removed successfully.');</script>");
                                    } else {
                                        out.println("<script>alert('Failed to remove faculty member.');</script>");
                                    }
                                    pstmt.close();
                                }

                                // Fetch and display faculty data
                                String sql = "SELECT * FROM faculty";
                                rs = stmt.executeQuery(sql);

                                while (rs.next()) {
                        %>
                        <tr id="faculty-<%= rs.getInt("id")%>">
                            <td><%= rs.getString("name")%></td>
                            <td><%= rs.getString("email")%></td>
                            <td><%= rs.getString("mobile")%></td>
                            <td><%= rs.getString("program")%></td>
                            <td><%= rs.getString("semester")%></td>
                            <td><%= rs.getString("courseName")%></td>
                            <td>
                                <button class="edit-btn" onclick="editFaculty(<%= rs.getInt("id")%>, '<%= rs.getString("name")%>', '<%= rs.getString("email")%>', '<%= rs.getString("mobile")%>', '<%= rs.getString("program")%>', '<%= rs.getString("semester")%>', '<%= rs.getString("courseName")%>')">Edit</button>
                                <button class="remove-btn" onclick="removeFaculty(<%= rs.getInt("id")%>)">Remove</button>
                            </td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<script>alert('An error occurred while processing your request.');</script>");
                            } finally {
                                try {
                                    if (rs != null) {
                                        rs.close();
                                    }
                                    if (stmt != null) {
                                        stmt.close();
                                    }
                                    if (conn != null) {
                                        conn.close();
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="editForm" class="edit-form">
            <h2>Edit Faculty</h2>
            <form id="updateForm" method="post">
                <input type="hidden" id="updateId" name="updateId">
                <input type="text" id="name" name="name" placeholder="Name" required>
                <input type="email" id="email" name="email" placeholder="Email" required>
                <input type="tel" id="mobile" name="mobile" placeholder="Mobile Number" required>
                <input type="text" id="program" name="program" placeholder="Program" required>
                <input type="text" id="semester" name="semester" placeholder="Semester" required>
                <input type="text" id="courseName" name="courseName" placeholder="Course Name" required>
                <button type="submit">Update</button>
                <button type="button" onclick="closeEditForm()">Cancel</button>
            </form>
        </div>

        <script>
            function logout() {
                alert("Thank you for using the Faculty Management System. Have a great day!");
                window.location.href = "login.jsp"; // Redirect to login page
            }

            function editFaculty(id, name, email, mobile, program, semester, courseName) {
                document.getElementById('updateId').value = id;
                document.getElementById('name').value = name;
                document.getElementById('email').value = email;
                document.getElementById('mobile').value = mobile;
                document.getElementById('program').value = program;
                document.getElementById('semester').value = semester;
                document.getElementById('courseName').value = courseName;
                document.getElementById('editForm').style.display = 'block';
            }

            function closeEditForm() {
                document.getElementById('editForm').style.display = 'none';
            }

            function removeFaculty(id) {
                if (confirm("Are you sure you want to remove this faculty member?")) {
                    window.location.href = "managefaculty.jsp?deleteId=" + id;
                }
            }

            // Close the edit form if the user clicks outside of it
            window.onclick = function (event) {
                if (event.target == document.getElementById('editForm')) {
                    closeEditForm();
                }
            }
        </script>
    </body>
</html>

