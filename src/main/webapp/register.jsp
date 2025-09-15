<%@ page import="java.sql.*, com.ecommerce.DBConnection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - FindKart</title>
    <style>
    /* Import Google Fonts */
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

    /* Reset */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        color: #333;
        padding: 20px;
        position: relative;
    }

    /* Logo Section at Top */
    .top-logo {
        position: absolute;
        top: 30px;
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
    }

    .logo {
        font-size: 2.2rem;
        background: linear-gradient(45deg, #ff6b35, #ffa500);
        border-radius: 12px;
        width: 55px;
        height: 55px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
    }

    .brand-name {
        color: #2d4d68;
        font-size: 2rem;
        font-weight: 700;
        letter-spacing: -0.5px;
    }

    .find {
        color: #2d4d68;
    }

    .kart {
        color: #ff6b35;
    }

    .form-container {
        background: #ffffff;
        padding: 50px 40px;
        border-radius: 16px;
        box-shadow: 0 8px 32px rgba(45, 77, 104, 0.15);
        border: 1px solid #e2e8f0;
        width: 100%;
        max-width: 480px;
        position: relative;
        z-index: 10;
    }

    .form-container h2 {
        text-align: center;
        color: #2d4d68;
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 30px;
    }

    .input-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #2d4d68;
        font-size: 14px;
    }

    input, textarea, select {
        width: 100%;
        padding: 15px 20px;
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        font-size: 15px;
        transition: all 0.3s ease;
        font-family: inherit;
        background-color: #f8fafc;
    }

    input:focus, textarea:focus, select:focus {
        outline: none;
        border-color: #ff6b35;
        box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.1);
        background-color: #ffffff;
    }

    select {
        cursor: pointer;
    }

    textarea {
        resize: vertical;
        min-height: 80px;
    }

    .register-btn {
        margin-top: 30px;
        padding: 15px;
        width: 100%;
        border: none;
        background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
        color: #ffffff;
        font-weight: 600;
        font-size: 16px;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
    }

    .register-btn:hover {
        background: linear-gradient(135deg, #e55a2b 0%, #e67832 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
    }

    .success {
        text-align: center;
        margin-top: 15px;
        font-size: 14px;
        color: #059669;
        padding: 12px;
        background-color: #f0fdf4;
        border: 1px solid #bbf7d0;
        border-radius: 4px;
    }

    .error {
        text-align: center;
        margin-top: 15px;
        font-size: 14px;
        color: #dc2626;
        padding: 12px;
        background-color: #fef2f2;
        border: 1px solid #fecaca;
        border-radius: 4px;
    }

    a {
        color: #ff6b35;
        text-decoration: none;
        font-weight: 500;
    }

    a:hover {
        color: #e55a2b;
        text-decoration: underline;
    }

    /* Responsive */
    @media(max-width: 480px) {
        .form-container {
            padding: 30px 20px;
        }
    }
</style>

</head>
<body>
    <!-- Top Logo -->
    <a href="index.jsp" class="top-logo">
        <div class="logo">🛒</div>
        <div class="brand-name">
            <span class="find">Find</span><span class="kart">Kart</span>
        </div>
    </a>
    <div class="form-container">
        <h2>Create Account</h2>
        <form method="post" action="register.jsp">
            <div class="input-group">
                <label>Full Name:</label>
                <input type="text" name="fullname" required>
            </div>

            <div class="input-group">
                <label>Email:</label>
                <input type="email" name="email" required>
            </div>

            <div class="input-group">
                <label>Password:</label>
                <input type="password" name="password" required>
            </div>

            <div class="input-group">
                <label>Gender:</label>
                <select name="gender" required>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                </select>
            </div>

            <div class="input-group">
                <label>Date of Birth:</label>
                <input type="date" name="dob" required>
            </div>

            <div class="input-group">
                <label>Phone:</label>
                <input type="text" name="phone" required>
            </div>

            <div class="input-group">
                <label>Address:</label>
                <textarea name="address" rows="3"></textarea>
            </div>

            <div class="input-group">
                <label>Role:</label>
                <select name="role" required>
                    <option value="User" selected>User</option>
                    <option value="Admin">Admin</option>
                    <option value="Guest">Guest</option>
                </select>
            </div>

            <button type="submit" class="register-btn">Create Account</button>
        </form>

        <%
            // Process registration only if form is submitted
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String gender = request.getParameter("gender");
            String dob = request.getParameter("dob");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String role = request.getParameter("role");

            if (fullname != null && email != null && password != null) {
                Connection conn = null;
                PreparedStatement ps = null;
                try {
                    conn = DBConnection.getConnection();

                    // Check if email already exists
                    ps = conn.prepareStatement("SELECT * FROM users WHERE email=?");
                    ps.setString(1, email);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        out.println("<p class='error'>Email already exists! Try another.</p>");
                    } else {
                        // Insert new user
                        ps = conn.prepareStatement(
                            "INSERT INTO users(fullname,email,password,gender,dob,phone,address,role) VALUES (?,?,?,?,?,?,?,?)"
                        );
                        ps.setString(1, fullname);
                        ps.setString(2, email);
                        ps.setString(3, password); // For simplicity, plain text (can use hashing later)
                        ps.setString(4, gender);
                        ps.setString(5, dob);
                        ps.setString(6, phone);
                        ps.setString(7, address);
                        ps.setString(8, role);

                        int rows = ps.executeUpdate();
                        if (rows > 0) {
                            out.println("<p class='success'>Registration successful! <a href='login.jsp'>Login here</a></p>");
                        }
                    }
                } catch (Exception e) {
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace(); // ✅ Logs to server console
                } finally {
                    try { if (ps != null) ps.close(); } catch (Exception ex) {}
                    try { if (conn != null) conn.close(); } catch (Exception ex) {}
                }
            }
        %>
    </div>
</body>
</html>