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
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

/* Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* FindKart Theme - Based on Logo Colors */
body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background-color: #f8f9fa;
    color: #333;
    line-height: 1.6;
}

/* Navigation Bar - Logo Colors */
.navbar {
    background: linear-gradient(135deg, #2d4d68 0%, #34567a 100%);
    padding: 12px 0;
    box-shadow: 0 2px 8px rgba(45, 77, 104, 0.2);
    position: sticky;
    top: 0;
    z-index: 100;
}

.nav-container {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 20px;
}

.logo-section {
    display: flex;
    align-items: center;
    gap: 12px;
}

.logo {
    width: 40px;
    height: 40px;
    background: linear-gradient(135deg, #ff6b35, #ff8856);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 18px;
    font-weight: 700;
}

.brand-name {
    color: #ffffff;
    font-size: 24px;
    font-weight: 700;
    text-decoration: none;
}

.brand-name .find {
    color: #ffffff;
}

.brand-name .kart {
    color: #ff6b35;
}

.nav-links {
    display: flex;
    align-items: center;
    gap: 30px;
}

.navbar a {
    color: #ffffff;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    padding: 8px 12px;
    border-radius: 4px;
    transition: all 0.2s ease;
}

.navbar a:hover {
    background-color: rgba(255, 107, 53, 0.2);
    color: #ff6b35;
}

/* Main Content */
.main-section {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
}

.welcome-card {
    background: #ffffff;
    border-radius: 8px;
    padding: 40px;
    text-align: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    border: 1px solid #e5e7eb;
}

.welcome-card h1 {
    font-size: 2.5rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 16px;
}

.welcome-card p {
    font-size: 1.1rem;
    color: #6b7280;
    margin-bottom: 32px;
    max-width: 600px;
    margin-left: auto;
    margin-right: auto;
}

.cta-button {
    display: inline-block;
    background: linear-gradient(135deg, #ff6b35, #ff8856);
    color: #ffffff;
    padding: 12px 24px;
    border-radius: 4px;
    text-decoration: none;
    font-weight: 600;
    font-size: 14px;
    transition: all 0.2s ease;
    box-shadow: 0 2px 8px rgba(255, 107, 53, 0.3);
}

.cta-button:hover {
    background: linear-gradient(135deg, #ff5722, #ff7043);
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(255, 107, 53, 0.4);
}

/* Responsive Design */
@media (max-width: 768px) {
    .nav-container {
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .navbar a {
        font-size: 13px;
        padding: 6px 10px;
    }
    
    .welcome-card {
        padding: 30px 20px;
    }
    
    .welcome-card h1 {
        font-size: 2rem;
    }
    
    .welcome-card p {
        font-size: 1rem;
    }
}
</style>


    
</head>
<body>
    <div class="navbar">
        <div class="nav-container">
            <div class="logo-section">
                <div class="logo">🛒</div>
                <a href="index.jsp" class="brand-name">
                    <span class="find">Find</span><span class="kart">Kart</span>
                </a>
            </div>
            <div class="nav-links">
                <a href="index.jsp">Home</a>
                <a href="products.jsp">Products</a>
                <a href="cart.jsp">Cart</a>
                <a href="myOrders.jsp">My Orders</a>
                <a href="logout.jsp">Logout</a>
            </div>
        </div>
    </div>

    <div class="main-section">
        <div class="welcome-card">
            <h1>Welcome to FindKart</h1>
            <p>Shop. Locate. Discover. Your ultimate destination for quality products and seamless shopping experience!</p>
            <a href="products.jsp" class="cta-button">Start Shopping</a>
        </div>
    </div>
</body>
</html>