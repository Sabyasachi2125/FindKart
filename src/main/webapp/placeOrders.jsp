<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ecommerce.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    if(userEmail == null){
        response.sendRedirect("login.jsp");
        return;
    }

    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    if(cart == null || cart.isEmpty()){
        response.sendRedirect("cart.jsp");
        return;
    }

    String address = request.getParameter("address");
    String payment = request.getParameter("payment");

    int orderId = 0;
    double grandTotal = 0.0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation - FindKart</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated background particles */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 20% 80%, rgba(120, 130, 200, 0.3) 0%, transparent 50%),
                        radial-gradient(circle at 80% 20%, rgba(255, 107, 107, 0.3) 0%, transparent 50%),
                        radial-gradient(circle at 40% 40%, rgba(78, 205, 196, 0.3) 0%, transparent 50%);
            animation: float 8s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-30px) rotate(120deg); }
            66% { transform: translateY(30px) rotate(240deg); }
        }

        /* Success Container */
        .container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 30px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.15);
            padding: 50px 40px;
            text-align: center;
            position: relative;
            z-index: 1;
            max-width: 800px;
            width: 100%;
            animation: successAnimation 1s ease-out;
        }

        @keyframes successAnimation {
            0% {
                opacity: 0;
                transform: translateY(50px) scale(0.8);
            }
            50% {
                transform: translateY(-10px) scale(1.05);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #4ecdc4, #44a08d, #667eea, #764ba2);
            border-radius: 30px;
            z-index: -1;
            background-size: 300% 300%;
            animation: borderGlow 4s ease-in-out infinite;
        }

        @keyframes borderGlow {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        /* Success Message */
        .container h1 {
            font-family: 'Poppins', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .order-id {
            font-size: 1.4rem;
            color: #4ecdc4;
            font-weight: 600;
            margin-bottom: 40px;
            padding: 15px 25px;
            background: rgba(78, 205, 196, 0.1);
            border-radius: 15px;
            border: 1px solid rgba(78, 205, 196, 0.3);
        }

        /* Order Summary Table */
        .order-summary {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 20px;
            overflow: hidden;
            margin-bottom: 40px;
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

        td {
            color: rgba(255, 255, 255, 0.9);
            font-weight: 500;
        }

        .total-row {
            background: rgba(78, 205, 196, 0.2) !important;
            font-weight: 600;
            font-size: 1.1em;
        }

        .total-row th {
            color: #4ecdc4;
        }

        /* Action Buttons */
        .btn {
            display: inline-block;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: #ffffff;
            padding: 15px 30px;
            border-radius: 15px;
            font-weight: 600;
            font-size: 1.1em;
            text-decoration: none;
            margin: 10px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
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
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
        }

        .btn.secondary {
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
        }

        .btn.secondary:hover {
            box-shadow: 0 15px 35px rgba(78, 205, 196, 0.4);
        }

        /* Error Styling */
        .error {
            color: #ff6b6b;
            text-align: center;
            margin-top: 50px;
            padding: 20px;
            background: rgba(255, 107, 107, 0.1);
            border: 1px solid rgba(255, 107, 107, 0.3);
            border-radius: 15px;
            max-width: 600px;
            margin: 50px auto;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 40px 30px;
            }
            
            .container h1 {
                font-size: 2rem;
            }
            
            .order-id {
                font-size: 1.2rem;
            }
            
            th, td {
                padding: 10px 8px;
                font-size: 0.9em;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
            }
            
            .container h1 {
                font-size: 1.8rem;
            }
            
            .order-id {
                font-size: 1rem;
                padding: 12px 20px;
            }
            
            th, td {
                padding: 8px 5px;
                font-size: 0.8em;
            }
            
            .btn {
                padding: 12px 20px;
                font-size: 1rem;
                margin: 5px;
            }
        }
    </style>
</head>
<body>
<%
    Connection conn = null;
    try {
        conn = DBConnection.getConnection();
        conn.setAutoCommit(false);

        // Calculate grand total
        for(Map.Entry<Integer,Integer> entry : cart.entrySet()){
            int pid = entry.getKey();
            int qty = entry.getValue();
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                ps = conn.prepareStatement("SELECT price FROM products WHERE id=?");
                ps.setInt(1, pid);
                rs = ps.executeQuery();
                if(rs.next()) grandTotal += rs.getDouble("price") * qty;
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ex) {}
                try { if (ps != null) ps.close(); } catch (Exception ex) {}
            }
        }

        // Insert order
        PreparedStatement psOrder = null;
        ResultSet rsOrder = null;
        try {
            psOrder = conn.prepareStatement(
                "INSERT INTO orders(user_email,address,payment_method,total) VALUES(?,?,?,?)",
                Statement.RETURN_GENERATED_KEYS
            );
            psOrder.setString(1, userEmail);
            psOrder.setString(2, address);
            psOrder.setString(3, payment);
            psOrder.setDouble(4, grandTotal);
            psOrder.executeUpdate();

            rsOrder = psOrder.getGeneratedKeys();
            if(rsOrder.next()) orderId = rsOrder.getInt(1);
        } finally {
            try { if (rsOrder != null) rsOrder.close(); } catch (Exception ex) {}
            try { if (psOrder != null) psOrder.close(); } catch (Exception ex) {}
        }

        // Insert order_items
        for(Map.Entry<Integer,Integer> entry : cart.entrySet()){
            int pid = entry.getKey();
            int qty = entry.getValue();
            double price = 0;
            PreparedStatement psPrice = null;
            ResultSet rsPrice = null;
            try {
                psPrice = conn.prepareStatement("SELECT price FROM products WHERE id=?");
                psPrice.setInt(1, pid);
                rsPrice = psPrice.executeQuery();
                if(rsPrice.next()) price = rsPrice.getDouble("price");
            } finally {
                try { if (rsPrice != null) rsPrice.close(); } catch (Exception ex) {}
                try { if (psPrice != null) psPrice.close(); } catch (Exception ex) {}
            }

            PreparedStatement psItem = null;
            try {
                psItem = conn.prepareStatement(
                    "INSERT INTO order_items(order_id,product_id,quantity,price) VALUES(?,?,?,?)"
                );
                psItem.setInt(1, orderId);
                psItem.setInt(2, pid);
                psItem.setInt(3, qty);
                psItem.setDouble(4, price);
                psItem.executeUpdate();
            } finally {
                try { if (psItem != null) psItem.close(); } catch (Exception ex) {}
            }
        }

        conn.commit();
        session.removeAttribute("cart");
%>

    <div class="container">
        <h1>🎉 Order Placed Successfully!</h1>
        <div class="order-id">Your Order ID: <strong><%=orderId%></strong></div>

        <div class="order-summary">
            <table>
                <tr>
                    <th>Product ID</th>
                    <th>Quantity</th>
                    <th>Price (₹)</th>
                    <th>Total (₹)</th>
                </tr>
            <%
                for(Map.Entry<Integer,Integer> entry : cart.entrySet()){
                    int pid = entry.getKey();
                    int qty = entry.getValue();
                    double price = 0;
                    PreparedStatement psPrice = null;
                    ResultSet rsPrice = null;
                    try {
                        psPrice = conn.prepareStatement("SELECT price FROM products WHERE id=?");
                        psPrice.setInt(1, pid);
                        rsPrice = psPrice.executeQuery();
                        if(rsPrice.next()) price = rsPrice.getDouble("price");
                    } finally {
                        try { if (rsPrice != null) rsPrice.close(); } catch (Exception ex) {}
                        try { if (psPrice != null) psPrice.close(); } catch (Exception ex) {}
                    }
                    double total = price * qty;
            %>
            <tr>
                <td><%=pid%></td>
                <td><%=qty%></td>
                <td>₹<%=price%></td>
                <td>₹<%=total%></td>
            </tr>
            <% } %>
            <tr class="total-row">
                <th colspan="3">Grand Total</th>
                <th>₹<%=grandTotal%></th>
            </tr>
            </table>
        </div>

        <a href="products.jsp" class="btn">🛍️ Continue Shopping</a>
        <a href="myOrders.jsp" class="btn secondary">📦 View Orders</a>
    </div>

<%
    } catch(Exception e){
        out.println("<div class='error'>⚠️ Error placing order: "+e.getMessage()+"</div>");
        e.printStackTrace();
    } finally {
        try { if (conn != null) conn.close(); } catch (Exception ex) {}
    }
%>
</body>
</html>