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
        max-width: 900px;
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

    /* Order Summary Table */
    .order-summary {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(20px);
        border-radius: 25px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        margin-bottom: 40px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 18px 15px;
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

    .total-row {
        background: rgba(255, 255, 255, 0.15) !important;
        font-weight: 600;
        font-size: 1.2em;
    }

    .total-row th {
        color: #4ecdc4;
    }

    /* Checkout Form */
    .checkout-form {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(20px);
        border-radius: 25px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
        padding: 40px;
        text-align: center;
    }

    .form-group {
        margin-bottom: 25px;
        text-align: left;
    }

    label {
        display: block;
        margin-bottom: 10px;
        font-weight: 600;
        color: rgba(255, 255, 255, 0.9);
        font-size: 1.1em;
    }

    textarea, select {
        width: 100%;
        padding: 15px 20px;
        border: 2px solid rgba(255, 255, 255, 0.2);
        border-radius: 15px;
        background: rgba(255, 255, 255, 0.1);
        color: #ffffff;
        font-size: 1em;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        backdrop-filter: blur(10px);
        font-family: inherit;
    }

    textarea::placeholder {
        color: rgba(255, 255, 255, 0.6);
    }

    textarea:focus, select:focus {
        outline: none;
        border-color: rgba(255, 255, 255, 0.5);
        background: rgba(255, 255, 255, 0.15);
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    select {
        cursor: pointer;
    }

    select option {
        background: #333;
        color: #fff;
    }

    textarea {
        resize: vertical;
        min-height: 100px;
    }

    .btn {
        background: linear-gradient(135deg, #4ecdc4, #44a08d);
        color: #ffffff;
        font-weight: 600;
        font-size: 1.2em;
        padding: 18px 40px;
        border: none;
        border-radius: 15px;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
        margin-top: 20px;
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
        box-shadow: 0 15px 35px rgba(78, 205, 196, 0.4);
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        h2 {
            font-size: 2em;
        }
        
        .order-summary,
        .checkout-form {
            margin: 10px;
            border-radius: 15px;
            padding: 25px;
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
        
        .checkout-form {
            padding: 20px;
        }
        
        .btn {
            padding: 15px 30px;
            font-size: 1em;
        }
    }
</style>

</head>
<body>
    <div class="container">
        <h2>📦 Confirm Your Order</h2>

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
                        ps = conn.prepareStatement("SELECT name, price FROM products WHERE id=?");
                        ps.setInt(1, pid);
                        rs = ps.executeQuery();
                        if(rs.next()){
                            String name = rs.getString("name");
                            double price = rs.getDouble("price");
                            double total = price * qty;
                            grandTotal += total;
        %>
                        <tr>
                            <td><%=name%></td>
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
                out.println("<tr><td colspan='4' style='color:#ff6b6b;'>Error: "+e.getMessage()+"</td></tr>"); 
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
                    <label>🏠 Shipping Address:</label>
                    <textarea name="address" placeholder="Enter your complete shipping address..." required></textarea>
                </div>

                <div class="form-group">
                    <label>💳 Payment Method:</label>
                    <select name="payment" required>
                        <option value="Cash on Delivery">💵 Cash on Delivery</option>
                        <option value="Online Payment">💳 Online Payment</option>
                    </select>
                </div>

                <button type="submit" class="btn">🚀 Confirm & Pay</button>
            </form>
        </div>
    </div>
</body>
</html>