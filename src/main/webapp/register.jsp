<%@ page import="java.sql.*, com.ecommerce.DBConnection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - FindKart</title>
    <style>
    /* Import Google Fonts */
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');

    /* Reset */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Inter', 'Poppins', sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        color: #ffffff;
        padding: 20px;
        position: relative;
        overflow-x: hidden;
    }

    /* Animated background */
    body::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: radial-gradient(circle at 25% 25%, rgba(120, 130, 200, 0.3) 0%, transparent 50%),
                    radial-gradient(circle at 75% 75%, rgba(255, 107, 107, 0.3) 0%, transparent 50%);
        animation: float 10s ease-in-out infinite;
    }

    @keyframes float {
        0%, 100% { transform: translateX(0px) translateY(0px); }
        33% { transform: translateX(30px) translateY(-30px); }
        66% { transform: translateX(-20px) translateY(20px); }
    }

    .form-container {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(20px);
        padding: 45px 35px;
        border-radius: 25px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
        width: 100%;
        max-width: 450px;
        position: relative;
        z-index: 1;
        animation: slideUp 0.8s ease-out;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(50px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .form-container::before {
        content: '';
        position: absolute;
        top: -2px;
        left: -2px;
        right: -2px;
        bottom: -2px;
        background: linear-gradient(45deg, #667eea, #764ba2, #667eea);
        border-radius: 25px;
        z-index: -1;
        background-size: 200% 200%;
        animation: borderGlow 3s ease-in-out infinite;
    }

    @keyframes borderGlow {
        0%, 100% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
    }

    .form-container h2 {
        text-align: center;
        font-family: 'Poppins', sans-serif;
        color: #ffffff;
        font-size: 2.2em;
        font-weight: 600;
        margin-bottom: 30px;
        background: linear-gradient(135deg, #ff6b6b, #4ecdc4);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .input-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: rgba(255, 255, 255, 0.9);
        font-size: 0.95em;
    }

    input, textarea, select {
        width: 100%;
        padding: 12px 16px;
        border: 2px solid rgba(255, 255, 255, 0.2);
        border-radius: 12px;
        background: rgba(255, 255, 255, 0.1);
        color: #ffffff;
        font-size: 0.95em;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        backdrop-filter: blur(10px);
    }

    input::placeholder, textarea::placeholder {
        color: rgba(255, 255, 255, 0.6);
    }

    input:focus, textarea:focus, select:focus {
        outline: none;
        border-color: rgba(255, 255, 255, 0.5);
        background: rgba(255, 255, 255, 0.15);
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    }

    select {
        cursor: pointer;
    }

    select option {
        background: #333;
        color: #fff;
    }

    textarea {
        resize: vertical;
        min-height: 80px;
    }

    .register-btn {
        margin-top: 25px;
        padding: 15px;
        width: 100%;
        border: none;
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: #ffffff;
        font-weight: 600;
        font-size: 1.1em;
        border-radius: 15px;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
    }

    .register-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        transition: left 0.6s;
    }

    .register-btn:hover::before {
        left: 100%;
    }

    .register-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
    }

    .success {
        text-align: center;
        margin-top: 15px;
        font-weight: 500;
        color: #4ecdc4;
        padding: 12px;
        background: rgba(78, 205, 196, 0.1);
        border-radius: 10px;
        border: 1px solid rgba(78, 205, 196, 0.3);
    }

    .error {
        text-align: center;
        margin-top: 15px;
        font-weight: 500;
        color: #ff6b6b;
        padding: 12px;
        background: rgba(255, 107, 107, 0.1);
        border-radius: 10px;
        border: 1px solid rgba(255, 107, 107, 0.3);
    }

    a {
        color: #4ecdc4;
        text-decoration: none;
        transition: all 0.3s ease;
        font-weight: 500;
    }

    a:hover {
        color: #45b7d1;
        text-decoration: underline;
    }

    /* Responsive */
    @media(max-width: 480px) {
        .form-container {
            padding: 35px 25px;
        }
        
        .form-container h2 {
            font-size: 1.8em;
        }
        
        input, textarea, select {
            padding: 10px 14px;
        }
    }
</style>

</head>
<body>
    <div class="form-container">
        <h2>🆕 Join FindKart</h2>
        <form method="post" action="register.jsp">
            <div class="input-group">
                <label>👤 Full Name:</label>
                <input type="text" name="fullname" required>
            </div>

            <div class="input-group">
                <label>📧 Email:</label>
                <input type="email" name="email" required>
            </div>

            <div class="input-group">
                <label>🔒 Password:</label>
                <input type="password" name="password" required>
            </div>

            <div class="input-group">
                <label>♂️ Gender:</label>
                <select name="gender" required>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                </select>
            </div>

            <div class="input-group">
                <label>📅 Date of Birth:</label>
                <input type="date" name="dob" required>
            </div>

            <div class="input-group">
                <label>📞 Phone:</label>
                <input type="text" name="phone" required>
            </div>

            <div class="input-group">
                <label>🏠 Address:</label>
                <textarea name="address" rows="3"></textarea>
            </div>

            <div class="input-group">
                <label>🔑 Role:</label>
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