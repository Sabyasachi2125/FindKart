<%@ page import="java.sql.*, com.ecommerce.DBConnection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // If user already logged in, redirect to index.jsp
    if (session.getAttribute("userEmail") != null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - FindKart</title>
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
        position: relative;
    }

    /* Logo Section at Top */
    .top-logo {
        position: absolute;
        top: 40px;
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
    }

    .logo {
        font-size: 2.5rem;
        background: linear-gradient(45deg, #ff6b35, #ffa500);
        border-radius: 15px;
        width: 60px;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
    }

    .brand-name {
        color: #2d4d68;
        font-size: 2.2rem;
        font-weight: 700;
        letter-spacing: -0.5px;
    }

    .find {
        color: #2d4d68;
    }

    .kart {
        color: #ff6b35;
    }

    .login-container {
        background: #ffffff;
        padding: 50px 40px;
        border-radius: 16px;
        box-shadow: 0 8px 32px rgba(45, 77, 104, 0.15);
        border: 1px solid #e2e8f0;
        width: 420px;
        text-align: center;
        position: relative;
        z-index: 10;
    }

    .login-container h2 {
        margin-bottom: 30px;
        color: #2d4d68;
        font-size: 2rem;
        font-weight: 700;
    }

    .input-group {
        margin-bottom: 20px;
        text-align: left;
    }

    .input-group input {
        width: 100%;
        padding: 15px 20px;
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        font-size: 15px;
        transition: all 0.3s ease;
        background-color: #f8fafc;
    }

    .input-group input:focus {
        outline: none;
        border-color: #ff6b35;
        box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.1);
        background-color: #ffffff;
    }

    .login-btn {
        width: 100%;
        padding: 15px;
        margin-top: 25px;
        background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
        color: #ffffff;
        font-weight: 600;
        font-size: 16px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
    }

    .login-btn:hover {
        background: linear-gradient(135deg, #e55a2b 0%, #e67832 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
    }

    .error {
        color: #dc2626;
        margin-top: 15px;
        font-size: 14px;
        padding: 10px;
        background-color: #fef2f2;
        border: 1px solid #fecaca;
        border-radius: 4px;
    }

    .register-link {
        display: inline-block;
        margin-top: 25px;
        color: #ff6b35;
        text-decoration: none;
        font-size: 15px;
        font-weight: 500;
        transition: color 0.3s ease;
    }

    .register-link:hover {
        color: #e55a2b;
        text-decoration: underline;
    }

    /* Responsive */
    @media(max-width: 480px) {
        .login-container {
            width: 90%;
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
    <div class="login-container">
        <h2>Sign in to FindKart</h2>
        <form method="post" action="login.jsp">
            <div class="input-group">
                <input type="text" name="email" placeholder="Email Address" required>
            </div>
            <div class="input-group">
                <input type="password" name="password" placeholder="Password" required>
            </div>
            <button type="submit" class="login-btn">Sign In</button>
        </form>
        <a href="register.jsp" class="register-link">New user? Create Account</a>

        <%
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email != null && password != null) {
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getConnection();
                    ps = conn.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
                    ps.setString(1, email);
                    ps.setString(2, password); // plain text for simplicity
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        session.setAttribute("userEmail", email); // store session
                        response.sendRedirect("index.jsp");
                    } else {
                        out.println("<p class='error'>Invalid email or password!</p>");
                    }
                } catch (Exception e) {
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception ex) {}
                    try { if (ps != null) ps.close(); } catch (Exception ex) {}
                    try { if (conn != null) conn.close(); } catch (Exception ex) {}
                }
            }
        %>
    </div>
</body>
</html>