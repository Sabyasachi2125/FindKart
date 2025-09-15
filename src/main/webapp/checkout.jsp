<%@ page import="java.util.*,java.sql.*,com.ecommerce.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if(userEmail == null) { response.sendRedirect("login.jsp"); return; }

    Map<Integer,Integer> cart = (Map<Integer,Integer>) session.getAttribute("cart");
    if(cart == null || cart.isEmpty()) { response.sendRedirect("cart.jsp"); return; }

    double grandTotal = 0.0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - FindKart</title>
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
        max-width: 900px;
        margin: 0 auto;
        padding: 40px 20px;
    }

    h2 {
        font-size: 2.5rem;
        font-weight: 700;
        color: #2d4d68;
        margin-bottom: 40px;
        text-align: center;
    }

    /* Order Summary Table */
    .order-summary {
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(45, 77, 104, 0.1);
        border: 1px solid #e2e8f0;
        overflow: hidden;
        margin-bottom: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 16px 12px;
        text-align: center;
        border-bottom: 1px solid #e5e7eb;
    }

    th {
        background: linear-gradient(135deg, #2d4d68 0%, #1e3a52 100%);
        color: white;
        font-weight: 600;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    td {
        color: #2d4d68;
        font-weight: 500;
    }

    tr:last-child td {
        border-bottom: none;
    }

    .total-row {
        background-color: #f8fafc !important;
        font-weight: 600;
        font-size: 1.1em;
    }

    .total-row th {
        background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%) !important;
        color: white;
    }

    /* Checkout Form */
    .checkout-form {
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(45, 77, 104, 0.1);
        border: 1px solid #e2e8f0;
        padding: 30px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #2d4d68;
        font-size: 14px;
    }

    textarea, select {
        width: 100%;
        padding: 12px 16px;
        border: 1px solid #d1d5db;
        border-radius: 4px;
        font-size: 14px;
        transition: border-color 0.2s ease;
        font-family: inherit;
    }

    textarea:focus, select:focus {
        outline: none;
        border-color: #ff6b35;
        box-shadow: 0 0 0 2px rgba(255, 107, 53, 0.1);
    }

    select {
        cursor: pointer;
    }

    textarea {
        resize: vertical;
        min-height: 100px;
    }

    .btn {
        background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
        color: #ffffff;
        font-weight: 600;
        font-size: 16px;
        padding: 15px 30px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 20px;
        width: 100%;
        box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
    }

    .btn:hover {
        background: linear-gradient(135deg, #e55a2b 0%, #e67832 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
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
            font-size: 1.5rem;
        }
        
        .order-summary,
        .checkout-form {
            margin: 10px;
            border-radius: 6px;
            padding: 20px;
        }
        
        th, td {
            padding: 12px 8px;
            font-size: 13px;
        }
    }

    @media (max-width: 480px) {
        .container {
            padding: 10px;
        }
        
        th, td {
            padding: 10px 5px;
            font-size: 12px;
        }
        
        .checkout-form {
            padding: 15px;
        }
        
        .btn {
            padding: 10px 20px;
            font-size: 14px;
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
                <a href="myOrders.jsp">My Orders</a>
                <a href="logout.jsp">Logout (<%=userEmail%>)</a>
            </div>
        </div>
    </nav>
    <div class="container">
        <h2>Confirm Your Order</h2>

        <div class="order-summary">
            <table>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Price (₹)</th>
                    <th>Total (₹)</th>
                </tr>
        <%
            Connection conn = null;
            try {
                conn = DBConnection.getConnection();
                for(Map.Entry<Integer,Integer> entry : cart.entrySet()){
                    int pid = entry.getKey();
                    int qty = entry.getValue();

                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        ps = conn.prepareStatement("SELECT name, price, image_url FROM products WHERE id=?");
                        ps.setInt(1, pid);
                        rs = ps.executeQuery();
                        if(rs.next()){
                            String name = rs.getString("name");
                            String imageUrl = rs.getString("image_url");
                            double price = rs.getDouble("price");
                            double total = price * qty;
                            grandTotal += total;
        %>
                        <tr>
                            <td>
                                <div style="display: flex; align-items: center; gap: 10px; justify-content: flex-start;">
                                    <%
                                        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                                            out.println("<img src='images/" + imageUrl + "' alt='" + name + "' style='width: 40px; height: 40px; object-fit: cover; border-radius: 4px;' onerror=\"this.style.display='none'; this.nextElementSibling.style.display='flex';\">" +
                                                       "<div style='display:none; width: 40px; height: 40px; background: linear-gradient(45deg, #ff6b35, #ffa500); border-radius: 4px; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 10px;'>No Image</div>");
                                        } else {
                                            out.println("<div style='width: 40px; height: 40px; background: linear-gradient(45deg, #ff6b35, #ffa500); border-radius: 4px; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 10px;'>No Image</div>");
                                        }
                                    %>
                                    <span><%=name%></span>
                                </div>
                            </td>
                            <td><%=qty%></td>
                            <td>₹<%=price%></td>
                            <td>₹<%=total%></td>
                        </tr>
        <%
                        }
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception ex) {}
                        try { if (ps != null) ps.close(); } catch (Exception ex) {}
                    }
                }
            } catch(Exception e){ 
                out.println("<tr><td colspan='4' style='color:#dc2626;'>Error: "+e.getMessage()+"</td></tr>"); 
            } finally {
                try { if (conn != null) conn.close(); } catch (Exception ex) {}
            }
        %>
        <tr class="total-row">
            <th colspan="3">Grand Total</th>
            <th>₹<%=grandTotal%></th>
        </tr>
            </table>
        </div>

        <div class="checkout-form">
            <form action="placeOrders.jsp" method="post">
                <div class="form-group">
                    <label>Shipping Address:</label>
                    <textarea name="address" placeholder="Enter your complete shipping address..." required></textarea>
                </div>

                <div class="form-group">
                    <label>Payment Method:</label>
                    <select name="payment" required>
                        <option value="Cash on Delivery">Cash on Delivery</option>
                        <option value="Online Payment">Online Payment</option>
                    </select>
                </div>

                <button type="submit" class="btn">Confirm & Pay</button>
            </form>
        </div>
    </div>
</body>
</html>