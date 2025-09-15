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
        max-width: 1000px;
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

    /* Cart Table Wrapper */
    .cart-wrapper {
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

    tr:hover {
        background-color: #f8fafc;
    }

    .total-row {
        background-color: #f8fafc !important;
        font-weight: 600;
        font-size: 1.1em;
    }

    .total-row th {
        background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
        color: white;
    }

    /* Buttons */
    .btn {
        padding: 8px 16px;
        background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
        color: #ffffff;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 500;
        font-size: 14px;
        text-decoration: none;
        display: inline-block;
        transition: all 0.3s ease;
        box-shadow: 0 2px 8px rgba(220, 38, 38, 0.3);
    }

    .btn:hover {
        background: linear-gradient(135deg, #b91c1c 0%, #991b1b 100%);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(220, 38, 38, 0.4);
    }

    .checkout-btn {
        background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
        padding: 15px 30px;
        font-size: 16px;
        font-weight: 600;
        box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
        border-radius: 8px;
    }

    .checkout-btn:hover {
        background: linear-gradient(135deg, #e55a2b 0%, #e67832 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
    }

    /* Empty Cart Message */
    .empty-cart {
        text-align: center;
        background: #ffffff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        border: 1px solid #e5e7eb;
        padding: 60px 40px;
        margin: 40px auto;
        max-width: 500px;
    }

    .empty-cart p {
        font-size: 1.2em;
        margin-bottom: 20px;
        color: #6b7280;
    }

    .empty-cart a {
        color: #ffffff;
        background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        padding: 12px 24px;
        border-radius: 8px;
        transition: all 0.3s ease;
        display: inline-block;
        box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
    }

    .empty-cart a:hover {
        background: linear-gradient(135deg, #e55a2b 0%, #e67832 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
    }

    /* Checkout Section */
    .checkout-section {
        text-align: center;
        margin-top: 30px;
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
        
        .container {
            padding: 20px 10px;
        }
        
        h2 {
            font-size: 1.5rem;
        }
        
        th, td {
            padding: 12px 8px;
            font-size: 13px;
        }
    }

    @media (max-width: 480px) {
        th, td {
            padding: 10px 5px;
            font-size: 12px;
        }
        
        .btn {
            padding: 6px 12px;
            font-size: 12px;
        }
        
        .empty-cart {
            padding: 40px 20px;
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
                <a href="cart.jsp" class="active">Cart</a>
                <a href="myOrders.jsp">My Orders</a>
                <a href="logout.jsp">Logout (<%=userEmail%>)</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <h2>Your Shopping Cart</h2>

        <%
            double grandTotal = 0.0;

            if(cart.isEmpty()) {
        %>
            <div class="empty-cart">
                <p>Your cart is empty</p>
                <a href="products.jsp">Start Shopping</a>
            </div>
        <%
            } else {
        %>
        <div class="cart-wrapper">
            <table>
                <tr>
                    <th>Image</th>
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

                    String sql = "SELECT id, name, price, image_url FROM products WHERE id=?";
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        ps = conn.prepareStatement(sql);
                        ps.setInt(1, pid);
                        rs = ps.executeQuery();
                        if(rs.next()) {
                            String name = rs.getString("name");
                            String imageUrl = rs.getString("image_url");
                            double price = rs.getDouble("price");
                            double total = price * qty;
                            grandTotal += total;
        %>
        <tr>
            <td>
                <%
                    if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                        out.println("<img src='images/" + imageUrl + "' alt='" + name + "' class='product-image' style='width: 50px; height: 50px; object-fit: cover; border-radius: 6px;' onerror=\"this.style.display='none'; this.nextElementSibling.style.display='flex';\">" +
                                   "<div style='display:none; width: 50px; height: 50px; background: linear-gradient(45deg, #ff6b35, #ffa500); border-radius: 6px; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 12px;'>No Image</div>");
                    } else {
                        out.println("<div style='width: 50px; height: 50px; background: linear-gradient(45deg, #ff6b35, #ffa500); border-radius: 6px; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 12px;'>No Image</div>");
                    }
                %>
            </td>
            <td><%=name%></td>
            <td>₹<%=price%></td>
            <td><%=qty%></td>
            <td>₹<%=total%></td>
            <td>
                <a class="btn" href="cart.jsp?remove=<%=pid%>">Remove</a>
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
                out.println("<tr><td colspan='6' style='color:#dc2626;'>Error: "+e.getMessage()+"</td></tr>");
            } finally {
                try { if (conn != null) conn.close(); } catch (Exception ex) {}
            }
        %>
        <tr class="total-row">
            <th colspan="4">Grand Total</th>
            <th colspan="2">₹ <%=grandTotal%></th>
        </tr>
            </table>
        </div>
        <div class="checkout-section">
            <a class="btn checkout-btn" href="checkout.jsp">Proceed to Checkout</a>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>