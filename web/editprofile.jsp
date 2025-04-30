<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>

    <!-- Google Font: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <link rel="stylesheet" href="editprofile.css">
    
</head>
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

.user-info {
  text-align: center;
  margin-bottom: 80px;
  animation: fadeIn 0.8s ease-in-out;
}

.user-image {
  width: 80px;
  height: 100%;
  border-radius: 50%;
  margin-bottom: 10px;
  border: 3px solid white;
  transition: transform 0.3s ease-in-out;
}

.user-image:hover {
  transform: scale(1.1);
}

.user-info h3 {
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

</style>
<body>
    <div class="container">
        <aside class="sidebar">
            <div class="profile-info">
                <img src="account.png" alt="Profile Image" class="profile-pic">
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

        <main class="main-content">
            <header class="dashboard-header">
                <h1>Edit Profile</h1>
                <button class="logout-btn" onclick="window.location.href='logoutstudent.html';">Logout</button>
            </header>
            <section class="profile-edit-form">
                <div class="profile-picture-upload">
                    <img src="account.png" alt="profile photo" class="profile-pic-preview">
                    <label for="profile-image">Change Profile Image:</label>
                    <input type="file" id="profile-image" name="profile-image">
                </div>
                <form action="updateProfile.jsp" method="POST">
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" value="">
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address:</label>
                        <input type="email" id="email" name="email" value="">
                    </div>
                    <div class="form-group">
                        <label for="phone">Mobile Number:</label>
                        <input type="text" id="phone" name="phone" value="">
                    </div>
                    <div class="form-group">
                        <label for="program">Program:</label>
                        <select id="program" name="program">
                            <option value="btech" selected>B.Tech</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="semester">Semester:</label>
                        <select id="semester" name="semester">
                            <option value="1" selected>I</option>
                            <option value="2">II</option>
                            <option value="3">III</option>
                            <option value="4">IV</option>
                            <option value="5">V</option>
                            <option value="6">VI</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="gender">Gender:</label>
                        <select id="gender" name="gender">
                            <option value="male" selected>Male</option>
                            <option value="female">Female</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="form-actions">
                        <button type="submit">Save Changes</button>
                        <button type="reset">Reset</button>
                    </div>
                </form>
            </section>
        </main>
    </div>

    <script>
        function logout() {
            // Implement your logout logic here
            alert('You have been logged out.');
        }
    </script>
</body>

</html>
