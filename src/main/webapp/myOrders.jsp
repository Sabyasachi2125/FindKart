<%@ page import="java.sql.*" %>
<%@ page import="com.ecommerce.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders - FindKart</title>
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
        background-color: #f8fafc;
        color: #333;
        line-height: 1.6;
        margin: 0;
    }

    /* Navigation Bar */
    .navbar {
        background: linear-gradient(135deg, #2d4d68 0%, #1e3a52 100%);
        color: white;
        padding: 1rem 0;
        box-shadow: 0 2px 10px rgba(45, 77, 104, 0.3);
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .nav-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 20px;
    }

    .logo-section {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .logo {
        font-size: 2rem;
        background: linear-gradient(45deg, #ff6b35, #ffa500);
        border-radius: 12px;
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
    }

    .brand-name {
        text-decoration: none;
        color: white;
        font-size: 1.8rem;
        font-weight: 700;
        letter-spacing: -0.5px;
    }

    .find {
        color: #ffffff;
    }

    .kart {
        color: #ff6b35;
    }

    .nav-links {
        display: flex;
        gap: 2rem;
        align-items: center;
    }

    .nav-links a {
        color: white;
        text-decoration: none;
        font-weight: 500;
        padding: 8px 16px;
        border-radius: 6px;
        transition: all 0.3s ease;
    }

    .nav-links a:hover {
        background-color: rgba(255, 255, 255, 0.1);
        transform: translateY(-1px);
    }

    .nav-links a.active {
        background-color: #ff6b35;
        color: white;
    }

    /* Page Content */
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 40px 20px;
    }

    h2 {
        font-size: 2.5rem;
        font-weight: 700;
        color: #2d4d68;
        margin-bottom: 30px;
        text-align: center;
    }

    /* Order Cards */
    .order-block {
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(45, 77, 104, 0.1);
        border: 1px solid #e2e8f0;
        padding: 30px;
        margin-bottom: 30px;
        transition: all 0.3s ease;
    }

    .order-block:hover {
        box-shadow: 0 8px 25px rgba(45, 77, 104, 0.15);
        transform: translateY(-2px);
    }

    .order-block h3 {
        color: #2d4d68;
        margin-bottom: 20px;
        font-size: 1.4em;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .order-block p {
        margin: 8px 0;
        font-size: 15px;
        color: #64748b;
        font-weight: 500;
    }

    .order-block p b {
        color: #2d4d68;
        font-weight: 600;
    }

    /* Order Items Table */
    .order-items {
        background: #f8fafc;
        border-radius: 8px;
        overflow: hidden;
        margin-top: 20px;
        border: 1px solid #e2e8f0;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 15px 12px;
        text-align: center;
        border-bottom: 1px solid #e2e8f0;
    }

    th {
        background: linear-gradient(135deg, #2d4d68 0%, #1e3a52 100%);
        color: white;
        font-weight: 600;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .item-row td {
        color: #2d4d68;
        font-weight: 500;
        font-size: 14px;
    }

    tr:last-child td {
        border-bottom: none;
    }

    /* Product Image */
    .product-image {
        width: 60px;
        height: 60px;
        object-fit: cover;
        border-radius: 8px;
        border: 2px solid #e2e8f0;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .product-name {
        display: flex;
        align-items: center;
        gap: 12px;
        justify-content: flex-start;
        text-align: left;
        padding-left: 20px;
    }

    /* Messages */
    .no-orders, .login-prompt, .error-message {
        text-align: center;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(45, 77, 104, 0.1);
        border: 1px solid #e2e8f0;
        padding: 50px 40px;
        margin: 40px auto;
        max-width: 500px;
    }

    .no-orders p, .login-prompt p {
        font-size: 1.2em;
        margin-bottom: 20px;
        color: #64748b;
    }

    .error-message {
        border-color: #fecaca;
        background-color: #fef2f2;
    }

    .login-prompt {
        border-color: #bfdbfe;
        background-color: #eff6ff;
    }

    /* Buttons */
    .btn {
        display: inline-block;
        background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
        color: #ffffff;
        padding: 12px 30px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 14px;
        text-decoration: none;
        margin: 10px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
        border: none;
        cursor: pointer;
    }

    .btn:hover {
        background: linear-gradient(135deg, #e55a2b 0%, #e67832 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
    }

    .btn.secondary {
        background: linear-gradient(135deg, #64748b 0%, #475569 100%);
        box-shadow: 0 4px 15px rgba(100, 116, 139, 0.3);
    }

    .btn.secondary:hover {
        background: linear-gradient(135deg, #475569 0%, #334155 100%);
        box-shadow: 0 6px 20px rgba(100, 116, 139, 0.4);
    }

    /* Links */
    a {
        color: #ff6b35;
        text-decoration: none;
        font-weight: 600;
    }

    a:hover {
        color: #e55a2b;
        text-decoration: underline;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .nav-container {
            flex-direction: column;
            gap: 1rem;
            padding: 0 15px;
        }

        .logo-section {
            order: 1;
        }

        .nav-links {
            order: 2;
            gap: 1rem;
        }

        h2 {
            font-size: 2rem;
        }
        
        .order-block {
            margin: 15px;
            padding: 20px;
        }
        
        th, td {
            padding: 10px 8px;
            font-size: 12px;
        }
        
        .container {
            padding: 20px 15px;
        }

        .product-image {
            width: 50px;
            height: 50px;
        }
    }

    @media (max-width: 480px) {
        .container {
            padding: 15px 10px;
        }
        
        .order-block {
            padding: 15px;
        }
        
        h2 {
            font-size: 1.8rem;
        }
        
        .no-orders, .login-prompt {
            padding: 30px 20px;
        }

        .nav-links {
            flex-wrap: wrap;
            justify-content: center;
        }
    }
</style>

</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
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
                <a href="myOrders.jsp" class="active">My Orders</a>
                <%
                    String userEmail = (String) session.getAttribute("userEmail");
                    if (userEmail != null) {
                        out.println("<a href='logout.jsp'>Logout (" + userEmail + ")</a>");
                    } else {
                        out.println("<a href='login.jsp'>Login</a>");
                        out.println("<a href='register.jsp'>Register</a>");
                    }
                %>
            </div>
        </div>
    </nav>

    <div class="container">
        <h2>My Orders</h2>
        

        <%
            String email = (String) session.getAttribute("userEmail"); // user email stored at login
            if (email == null) {
                out.println("<div class='login-prompt'><p>Please <a href='login.jsp'>login</a> to view your orders.</p></div>");
            } else {
                Connection conn = null;
                try {
                    conn = DBConnection.getConnection();
                    String sql = "SELECT * FROM orders WHERE user_email=? ORDER BY order_date DESC";
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, email);
                        rs = ps.executeQuery();
                        boolean hasOrders = false;
                        while (rs.next()) {
                            hasOrders = true;
                            int orderId = rs.getInt("id");
                            String addr = rs.getString("address");
                            String payment = rs.getString("payment_method");
                            double total = rs.getDouble("total");
                            Timestamp date = rs.getTimestamp("order_date");
        %>
                                <div class="order-block">
                                    <h3>🛒 Order ID: <%= orderId %></h3>
                                    <p><b>📅 Date:</b> <%= date %></p>
                                    <p><b>🏠 Address:</b> <%= addr %></p>
                                    <p><b>💳 Payment:</b> <%= payment %></p>
                                    <p><b>💰 Total:</b> ₹ <%= total %></p>

                                    <div class="order-items">
                                        <table>
                                            <tr>
                                                <th>Product</th>
                                                <th>Price (₹)</th>
                                                <th>Quantity</th>
                                                <th>Subtotal (₹)</th>
                                            </tr>
                                            <%
                                                String itemSql = "SELECT oi.*, p.name, p.image_url FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id=?";
                                                PreparedStatement ps2 = null;
                                                ResultSet rs2 = null;
                                                try {
                                                    ps2 = conn.prepareStatement(itemSql);
                                                    ps2.setInt(1, orderId);
                                                    rs2 = ps2.executeQuery();
                                                    while (rs2.next()) {
                                                        String pname = rs2.getString("name");
                                                        String pimage = rs2.getString("image_url");
                                                        double price = rs2.getDouble("price");
                                                        int qty = rs2.getInt("quantity");
                                                        double subtotal = price * qty;
                                            %>
                                                        <tr class="item-row">
                                                            <td>
                                                                <div class="product-name">
                                                                    <%
                                                                        if (pimage != null && !pimage.trim().isEmpty()) {
                                                                            out.println("<img src='images/" + pimage + "' alt='" + pname + "' class='product-image' onerror=\"this.style.display='none'; this.nextElementSibling.style.display='flex';\">" +
                                                                                       "<div class='product-image' style='display:none; background: linear-gradient(45deg, #ff6b35, #ffa500); align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 12px;'>No Image</div>");
                                                                        } else {
                                                                            out.println("<div class='product-image' style='background: linear-gradient(45deg, #ff6b35, #ffa500); display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 12px;'>No Image</div>");
                                                                        }
                                                                    %>
                                                                    <span><%= pname %></span>
                                                                </div>
                                                            </td>
                                                            <td><%= price %></td>
                                                            <td><%= qty %></td>
                                                            <td><%= subtotal %></td>
                                                        </tr>
                                            <%
                                                    }
                                                } finally {
                                                    try { if (rs2 != null) rs2.close(); } catch (Exception ex) {}
                                                    try { if (ps2 != null) ps2.close(); } catch (Exception ex) {}
                                                }
                                            %>
                                        </table>
                                        
                                    </div>
                                </div>
        <%
                        }
                        if (!hasOrders) {
                            out.println("<div class='no-orders'><p>You have no orders yet.</p><a href='products.jsp' class='btn'>Start Shopping</a></div>");
                        }
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception ex) {}
                        try { if (ps != null) ps.close(); } catch (Exception ex) {}
                    }
                } catch (Exception e) {
                    out.println("<div class='error-message'>Error: " + e.getMessage() + "</div>");
                } finally {
                    try { if (conn != null) conn.close(); } catch (Exception ex) {}
                }
            }
        %>
        <a href="products.jsp" class="btn">Continue Shopping</a>
    </div>
    
</body>
</html>