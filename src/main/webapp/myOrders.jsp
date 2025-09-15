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
        color: #ffffff;
        padding: 20px;
    }

    /* Page Content */
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    h2 {
        text-align: center;
        font-family: 'Poppins', sans-serif;
        font-size: 2.5em;
        font-weight: 600;
        margin-bottom: 40px;
        background: linear-gradient(135deg, #ff6b6b, #4ecdc4);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    /* Order Cards */
    .order-block {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(20px);
        border-radius: 25px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
        padding: 30px;
        margin-bottom: 30px;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
    }

    .order-block::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0.05));
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .order-block:hover::before {
        opacity: 1;
    }

    .order-block:hover {
        transform: translateY(-8px) scale(1.02);
        box-shadow: 0 35px 70px rgba(0, 0, 0, 0.15);
    }

    .order-block > * {
        position: relative;
        z-index: 1;
    }

    .order-block h3 {
        color: #4ecdc4;
        margin-bottom: 20px;
        font-size: 1.4em;
        font-weight: 600;
    }

    .order-block p {
        margin: 8px 0;
        font-size: 1.05em;
        color: rgba(255, 255, 255, 0.9);
        font-weight: 500;
    }

    .order-block p b {
        color: #ffffff;
        font-weight: 600;
    }

    /* Order Items Table */
    .order-items {
        background: rgba(255, 255, 255, 0.05);
        border-radius: 15px;
        overflow: hidden;
        margin-top: 20px;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 15px 12px;
        text-align: center;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    th {
        background: rgba(255, 255, 255, 0.1);
        color: #ffffff;
        font-weight: 600;
        font-size: 1em;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .item-row td {
        color: rgba(255, 255, 255, 0.85);
        font-weight: 500;
    }

    /* Messages */
    .no-orders {
        text-align: center;
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(20px);
        border-radius: 25px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        padding: 60px 40px;
        margin: 40px auto;
        max-width: 500px;
    }

    .no-orders p {
        font-size: 1.3em;
        margin-bottom: 20px;
        color: rgba(255, 255, 255, 0.8);
    }

    .error-message {
        color: #ff6b6b;
        text-align: center;
        background: rgba(255, 107, 107, 0.1);
        border: 1px solid rgba(255, 107, 107, 0.3);
        border-radius: 15px;
        padding: 20px;
        margin: 20px auto;
        max-width: 600px;
    }

    .login-prompt {
        color: #4ecdc4;
        text-align: center;
        background: rgba(78, 205, 196, 0.1);
        border: 1px solid rgba(78, 205, 196, 0.3);
        border-radius: 15px;
        padding: 20px;
        margin: 20px auto;
        max-width: 600px;
    }

    /* Links */
    a {
        color: #4ecdc4;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        padding: 8px 16px;
        border-radius: 8px;
        display: inline-block;
    }

    a:hover {
        color: #45b7d1;
        background: rgba(78, 205, 196, 0.2);
        transform: translateY(-2px);
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        h2 {
            font-size: 2em;
        }
        
        .order-block {
            margin: 10px;
            padding: 20px;
            border-radius: 15px;
        }
        
        th, td {
            padding: 10px 8px;
            font-size: 0.9em;
        }
        
        .container {
            padding: 15px;
        }
    }

    @media (max-width: 480px) {
        .container {
            padding: 10px;
        }
        
        .order-block {
            padding: 15px;
        }
        
        h2 {
            font-size: 1.8em;
        }
        
        th, td {
            padding: 8px 5px;
            font-size: 0.8em;
        }
        
        .no-orders {
            padding: 40px 20px;
        }
    }
</style>

</head>
<body>
    <div class="container">
        <h2>📦 My Orders</h2>

        <%
            String email = (String) session.getAttribute("userEmail"); // user email stored at login
            if (email == null) {
                out.println("<div class='login-prompt'><p>⚠️ Please <a href='login.jsp'>login</a> to view your orders.</p></div>");
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
                                                String itemSql = "SELECT oi.*, p.name FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id=?";
                                                PreparedStatement ps2 = null;
                                                ResultSet rs2 = null;
                                                try {
                                                    ps2 = conn.prepareStatement(itemSql);
                                                    ps2.setInt(1, orderId);
                                                    rs2 = ps2.executeQuery();
                                                    while (rs2.next()) {
                                                        String pname = rs2.getString("name");
                                                        double price = rs2.getDouble("price");
                                                        int qty = rs2.getInt("quantity");
                                                        double subtotal = price * qty;
                                            %>
                                                        <tr class="item-row">
                                                            <td><%= pname %></td>
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
                            out.println("<div class='no-orders'><p>ℹ️ You have no orders yet.</p><a href='products.jsp'>🛍️ Start Shopping</a></div>");
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
    </div>
</body>
</html>