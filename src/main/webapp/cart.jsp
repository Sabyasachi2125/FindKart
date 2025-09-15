<%@ page import="java.util.*, java.sql.*, com.ecommerce.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if(userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get cart from session
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    if(cart == null) cart = new HashMap<Integer, Integer>();

    // Handle remove item from cart
    String removeIdStr = request.getParameter("remove");
    if(removeIdStr != null) {
        int removeId = Integer.parseInt(removeIdStr);
        cart.remove(removeId);
        session.setAttribute("cart", cart);
        response.sendRedirect("cart.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart - FindKart</title>
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
        padding-top: 80px;
    }

    /* Fixed Navigation Bar */
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
    }

    .navbar a {
        color: #ffffff;
        text-decoration: none;
        font-weight: 500;
        font-size: 14px;
        padding: 8px 16px;
        border-radius: 25px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .navbar a:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateY(-2px);
    }

    /* Page Content */
    .container {
        max-width: 1000px;
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

    /* Cart Table Wrapper */
    .cart-wrapper {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(20px);
        border-radius: 25px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        margin-bottom: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 20px 15px;
        text-align: center;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    th {
        background: rgba(255, 255, 255, 0.1);
        color: #ffffff;
        font-weight: 600;
        font-size: 1.1em;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    td {
        color: rgba(255, 255, 255, 0.9);
        font-weight: 500;
    }

    tr:hover {
        background: rgba(255, 255, 255, 0.05);
    }

    .total-row {
        background: rgba(255, 255, 255, 0.15) !important;
        font-weight: 600;
        font-size: 1.2em;
    }

    .total-row th {
        color: #4ecdc4;
    }

    /* Buttons */
    .btn {
        padding: 10px 20px;
        background: linear-gradient(135deg, #ff6b6b, #ff8787);
        color: #ffffff;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-weight: 600;
        font-size: 0.9em;
        text-decoration: none;
        display: inline-block;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
    }

    .btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        transition: left 0.6s;
    }

    .btn:hover::before {
        left: 100%;
    }

    .btn:hover {
        transform: translateY(-2px) scale(1.05);
        box-shadow: 0 10px 25px rgba(255, 107, 107, 0.4);
    }

    .checkout-btn {
        background: linear-gradient(135deg, #4ecdc4, #44a08d);
        padding: 15px 35px;
        font-size: 1.1em;
        margin-top: 20px;
    }

    .checkout-btn:hover {
        box-shadow: 0 15px 35px rgba(78, 205, 196, 0.4);
    }

    /* Empty Cart Message */
    .empty-cart {
        text-align: center;
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(20px);
        border-radius: 25px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        padding: 60px 40px;
        margin: 40px auto;
        max-width: 500px;
    }

    .empty-cart p {
        font-size: 1.3em;
        margin-bottom: 20px;
        color: rgba(255, 255, 255, 0.8);
    }

    .empty-cart a {
        color: #4ecdc4;
        text-decoration: none;
        font-weight: 600;
        font-size: 1.1em;
        padding: 12px 25px;
        background: rgba(78, 205, 196, 0.2);
        border-radius: 12px;
        transition: all 0.3s ease;
        display: inline-block;
    }

    .empty-cart a:hover {
        background: rgba(78, 205, 196, 0.3);
        transform: translateY(-2px);
    }

    /* Checkout Section */
    .checkout-section {
        text-align: center;
        margin-top: 30px;
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
        
        body {
            padding-top: 100px;
        }
        
        h2 {
            font-size: 2em;
        }
        
        .cart-wrapper {
            margin: 10px;
            border-radius: 15px;
        }
        
        th, td {
            padding: 12px 8px;
            font-size: 0.9em;
        }
    }

    @media (max-width: 480px) {
        .container {
            padding: 10px;
        }
        
        th, td {
            padding: 10px 5px;
            font-size: 0.8em;
        }
        
        .btn {
            padding: 8px 12px;
            font-size: 0.8em;
        }
        
        .empty-cart {
            padding: 40px 20px;
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

    <div class="container">
        <h2>🛒 Your Shopping Cart</h2>

        <%
            double grandTotal = 0.0;

            if(cart.isEmpty()) {
        %>
            <div class="empty-cart">
                <p>😔 Your cart is empty</p>
                <a href="products.jsp">🛍️ Start Shopping</a>
            </div>
        <%
            } else {
        %>
        <div class="cart-wrapper">
            <table>
                <tr>
                    <th>Product</th>
                    <th>Price (₹)</th>
                    <th>Quantity</th>
                    <th>Total (₹)</th>
                    <th>Action</th>
                </tr>
        <%
            Connection conn = null;
            try {
                conn = DBConnection.getConnection();
                for(Map.Entry<Integer,Integer> entry : cart.entrySet()) {
                    int pid = entry.getKey();
                    int qty = entry.getValue();

                    String sql = "SELECT name, price FROM products WHERE id=?";
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        ps = conn.prepareStatement(sql);
                        ps.setInt(1, pid);
                        rs = ps.executeQuery();
                        if(rs.next()) {
                            String name = rs.getString("name");
                            double price = rs.getDouble("price");
                            double total = price * qty;
                            grandTotal += total;
        %>
        <tr>
            <td><%=name%></td>
            <td>₹<%=price%></td>
            <td><%=qty%></td>
            <td>₹<%=total%></td>
            <td>
                <a class="btn" href="cart.jsp?remove=<%=pid%>">🗑️ Remove</a>
            </td>
        </tr>
        <%
                        }
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception ex) {}
                        try { if (ps != null) ps.close(); } catch (Exception ex) {}
                    }
                }



            } catch(Exception e) {
                out.println("<tr><td colspan='5' style='color:#ff6b6b;'>Error: "+e.getMessage()+"</td></tr>");
            } finally {
                try { if (conn != null) conn.close(); } catch (Exception ex) {}
            }
        %>
        <tr class="total-row">
            <th colspan="3">Grand Total</th>
            <th colspan="2">₹ <%=grandTotal%></th>
        </tr>
            </table>
        </div>
        <div class="checkout-section">
            <a class="btn checkout-btn" href="checkout.jsp">🚀 Proceed to Checkout</a>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>