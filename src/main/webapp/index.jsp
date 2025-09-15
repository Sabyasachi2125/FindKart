<%-- 
    Document   : index
    Author     : Sabyasachi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>E-Commerce Home</title>
<style>
/* Import Google Fonts */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');

/* Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Modern Dark Theme */
body {
    font-family: 'Inter', 'Poppins', sans-serif;
    min-height: 100vh;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: #ffffff;
    overflow-x: hidden;
}

/* Glass Navigation Bar */
.navbar {
    position: fixed;
    top: 20px;
    left: 50%;
    transform: translateX(-50%);
    z-index: 1000;
    display: flex;
    gap: 20px;
    padding: 12px 30px;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(20px);
    border-radius: 50px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
}

.navbar:hover {
    background: rgba(255, 255, 255, 0.15);
    transform: translateX(-50%) translateY(-2px);
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
}

.navbar a {
    color: #ffffff;
    text-decoration: none;
    font-weight: 500;
    font-size: 14px;
    padding: 8px 16px;
    border-radius: 25px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
}

.navbar a::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
    transition: left 0.5s;
}

.navbar a:hover::before {
    left: 100%;
}

.navbar a:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: translateY(-2px);
    color: #f0f0f0;
}

/* Welcome Section */
.welcome-section {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
    padding: 100px 20px 20px;
}

.welcome-card {
    max-width: 600px;
    padding: 60px 40px;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(20px);
    border-radius: 30px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
    text-align: center;
    position: relative;
    overflow: hidden;
    animation: float 6s ease-in-out infinite;
}

.welcome-card::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: conic-gradient(from 0deg, transparent, rgba(255,255,255,0.1), transparent);
    animation: rotate 8s linear infinite;
}

.welcome-card > * {
    position: relative;
    z-index: 1;
}

@keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-20px); }
}

@keyframes rotate {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.welcome-card h1 {
    font-family: 'Poppins', sans-serif;
    font-size: 3.5rem;
    font-weight: 700;
    background: linear-gradient(135deg, #ff6b6b, #4ecdc4, #45b7d1, #f093fb);
    background-size: 300% 300%;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    margin-bottom: 24px;
    animation: gradientShift 4s ease-in-out infinite;
}

@keyframes gradientShift {
    0%, 100% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
}

.welcome-card p {
    font-size: 1.3rem;
    color: rgba(255, 255, 255, 0.9);
    line-height: 1.6;
    margin-bottom: 40px;
    font-weight: 400;
}

.cta-button {
    display: inline-block;
    padding: 16px 40px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: #ffffff;
    text-decoration: none;
    border-radius: 50px;
    font-weight: 600;
    font-size: 1.1rem;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
    position: relative;
    overflow: hidden;
}

.cta-button::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
    transition: left 0.6s;
}

.cta-button:hover::before {
    left: 100%;
}

.cta-button:hover {
    transform: translateY(-3px) scale(1.05);
    box-shadow: 0 20px 40px rgba(102, 126, 234, 0.4);
}

/* Responsive Design */
@media (max-width: 768px) {
    .navbar {
        flex-wrap: wrap;
        gap: 10px;
        padding: 10px 20px;
        top: 10px;
    }
    
    .navbar a {
        font-size: 13px;
        padding: 6px 12px;
    }
    
    .welcome-card {
        margin: 80px 10px 20px;
        padding: 40px 20px;
    }
    
    .welcome-card h1 {
        font-size: 2.5rem;
    }
    
    .welcome-card p {
        font-size: 1.1rem;
    }
}

@media (max-width: 480px) {
    .welcome-card h1 {
        font-size: 2rem;
    }
    
    .welcome-card p {
        font-size: 1rem;
    }
    
    .cta-button {
        padding: 12px 30px;
        font-size: 1rem;
    }
}
</style>


    
</head>
<body>
    <div class="navbar">
        <a href="index.jsp">🏠 Home</a>
        <a href="products.jsp">🛍️ Products</a>
        <a href="cart.jsp">🛒 Cart</a>
        <a href="myOrders.jsp">📦 My Orders</a>
        <a href="logout.jsp">🚪 Logout</a>
    </div>

    <div class="welcome-section">
        <div class="welcome-card">
            <h1>Welcome to FindKart ✨</h1>
            <p>Discover amazing products, enjoy seamless shopping, and experience the future of e-commerce!</p>
            <a href="products.jsp" class="cta-button">Start Shopping</a>
        </div>
    </div>
</body>
</html>