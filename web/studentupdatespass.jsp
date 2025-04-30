<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
    // Ensure session exists and fetch username safely
    String username = (session.getAttribute("username") != null) ? (String) session.getAttribute("username") : "User";
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Password</title>
    <link rel="stylesheet" href="updatepass.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        /* Sidebar */
        .sidebar {
            width: 280px;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: all 0.3s ease-in-out;
            position: fixed;
            left: 0;
            height: 100%;
            transform: translateX(0);
        }

        .sidebar.hidden {
            transform: translateX(-100%);
        }

        .sidebar-toggle {
            position: absolute;
            top: 20px;
            right: -40px;
            background-color: #1e3c72;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .sidebar-toggle:hover {
            background-color: #2a5298;
        }

        .sidebar:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .profile-section {
            text-align: center;
            
            animation: fadeIn 0.8s ease-in-out;
        }

        .profile-section img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-bottom: 10px;
            border: 3px solid white;
            transition: transform 0.3s ease-in-out;
        }

        .profile-section img:hover {
            transform: scale(1.1);
        }

        .profile-section h3 {
            color: #ecf0f1;
            font-size: 20px;
        }

        .menu ul {
            list-style-type: none;
            width: 100%;
        }

        .menu li {
            margin: 15px 0;
        }

        .menu li a {
            color: #ecf0f1;
            text-decoration: none;
            font-size: 18px;
            padding: 12px 20px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            transition: all 0.3s ease-in-out;
            position: relative;
        }

        .menu li a:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateX(5px);
        }

        .menu li a i {
            margin-right: 15px;
            transition: transform 0.3s ease-in-out;
        }

        .menu li a:hover i {
            transform: rotate(15deg);
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Adjustments */
        @media (max-width: 900px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .content {
                margin-left: 0;
            }
        }

        /* Prevent scrolling when sidebar is open */
        .no-scroll {
            overflow: hidden;
        }

        .form-container {
            margin-left: 300px;
            padding: 20px;
        }

        .form-container h2 {
            text-align: center;
            color: #2a5298;
        }

        .form-container label {
            display: block;
            margin: 10px 0 5px;
            font-size: 16px;
        }

        .form-container input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .buttons {
            margin-top: 20px;
            text-align: center;
        }

        .buttons button {
            padding: 10px 15px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .buttons button[type="submit"] {
            background-color: #2a5298;
            color: white;
        }

        .buttons button[type="reset"] {
            background-color: #ccc;
        }

        .buttons button:hover {
            opacity: 0.8;
        }
    </style>
</head>

<body>
    <div class="container">
        <aside class="sidebar">
            <div class="profile-section">
                <img src="account.png" alt="Profile Picture">
                <h3>HELLO <%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %></h3>
            </div>
            <nav class="menu">
                <ul>
                    <li><a href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="feedback.jsp"><i class="fas fa-comment-dots"></i> Feedback</a></li>
                    <li><a href="editprofile.jsp"><i class="fas fa-user-edit"></i> View/Edit Profile</a></li>
                    <li><a href="studentupdatespass.jsp"><i class="fas fa-key"></i> Update Password</a></li>
                    <li><a href="logoutstudent.html"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
            </nav>
        </aside>

        <div class="main-content">
            <div class="header">
                <div class="title">UPDATE PASSWORD</div>
                <div class="logout"><a href="logoutstudent.html">Logout</a></div>
            </div>
            <div class="form-container">
                <h2>Update Password</h2>
                <form action="UpdatePasswordServlet" method="post">
                    <label for="old-password">Enter your old password</label>
                    <input type="password" id="old-password" name="old-password" required>

                    <label for="new-password">Enter your new password</label>
                    <input type="password" id="new-password" name="new-password" required>

                    <label for="confirm-password">Enter your confirm password</label>
                    <input type="password" id="confirm-password" name="confirm-password" required>

                    <div class="buttons">
                        <button type="submit">Update My Password</button>
                        <button type="reset">Reset</button>
                    </div>
                </form>

                <%-- Display success or error message --%>
                <% if (request.getAttribute("message") != null) { %>
                    <p style="color: <%= request.getAttribute("messageType") != null && request.getAttribute("messageType").equals("success") ? "green" : "red" %>;">
                        <%= request.getAttribute("message") %>
                    </p>
                <% } %>
            </div>
        </div>
    </div>
</body>

</html>
