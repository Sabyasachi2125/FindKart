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
            color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* Success Container */
        .container {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(45, 77, 104, 0.15);
            border: 1px solid #e2e8f0;
            padding: 50px 40px;
            text-align: center;
            max-width: 800px;
            width: 100%;
            position: relative;
        }

        /* Logo at top of container */
        .container-logo {
            position: absolute;
            top: -30px;
            left: 50%;
            transform: translateX(-50%);
            background: linear-gradient(45deg, #ff6b35, #ffa500);
            border-radius: 50%;
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
        }

        /* Success Message */
        .container h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #059669;
            margin-top: 20px;
        }

        .order-id {
            font-size: 1.3rem;
            color: #2d4d68;
            font-weight: 600;
            margin-bottom: 35px;
            padding: 15px 25px;
            background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
            border-radius: 10px;
            border: 2px solid #bbf7d0;
            box-shadow: 0 2px 10px rgba(5, 150, 105, 0.1);
        }

        /* Order Summary Table */
        .order-summary {
            background: #f8fafc;
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 35px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 2px 10px rgba(45, 77, 104, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
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

        /* Action Buttons */
        .btn {
            display: inline-block;
            background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
            color: #ffffff;
            padding: 15px 30px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            text-decoration: none;
            margin: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
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

        /* Error Styling */
        .error {
            color: #dc2626;
            text-align: center;
            margin-top: 50px;
            padding: 16px;
            background-color: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 6px;
            max-width: 600px;
            margin: 50px auto;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }
            
            .container h1 {
                font-size: 1.5rem;
            }
            
            .order-id {
                font-size: 1rem;
            }
            
            th, td {
                padding: 8px 6px;
                font-size: 12px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 20px 15px;
            }
            
            .container h1 {
                font-size: 1.3rem;
            }
            
            .order-id {
                font-size: 0.9rem;
                padding: 10px 15px;
            }
            
            .btn {
                padding: 10px 16px;
                font-size: 13px;
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
        <div class="container-logo">🛒</div>
        <h1>Order Placed Successfully!</h1>
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

        <a href="products.jsp" class="btn">Continue Shopping</a>
        <a href="myOrders.jsp" class="btn secondary">View Orders</a>
    </div>

<%
    } catch(Exception e){
        out.println("<div class='error'>Error placing order: "+e.getMessage()+"</div>");
        e.printStackTrace();
    } finally {
        try { if (conn != null) conn.close(); } catch (Exception ex) {}
    }
%>
</body>
</html>