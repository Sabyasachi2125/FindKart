<%@ page import="java.sql.*, java.util.*, com.ecommerce.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products - E-Commerce</title>
      <style>
        /* Reset */
        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #fef9f9; /* soft pastel background */
            padding: 20px;
            color: #333;
        }

        /* Navbar */
        .navbar {
            text-align: center;
            background: #a8edea; /* light aqua */
            padding: 15px 0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-radius: 10px;
            margin-bottom: 30px;
        }

        .navbar a {
            color: #333;
            margin: 0 20px;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            transition: 0.3s;
        }

        .navbar a:hover {
            color: #ff7e5f; /* soft coral on hover */
        }

        /* Page title */
        h2 {
            text-align: center;
            color: #ff7e5f; /* soft coral */
            margin-bottom: 20px;
            font-size: 2em;
        }

        /* Table styles */
        table {
            width: 85%;
            margin: auto;
            border-collapse: collapse;
            background: #ffffff; /* white table */
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border-radius: 12px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
        }

        th {
            background: #ffe1e0; /* soft pink header */
            color: #ff7e5f;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background: #f9f9f9;
        }

        tr:hover {
            background: #fff2f0; /* hover highlight */
        }

        input[type="number"] {
            width: 50px;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            text-align: center;
        }

        .btn {
            padding: 6px 12px;
            background: #ff7e5f;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn:hover {
            background: #ff4c3b;
        }

        /* Success/Error message styles */
        .message {
            max-width: 85%;
            margin: 20px auto;
            padding: 15px;
            border-radius: 8px;
            font-weight: 600;
            text-align: center;
            animation: fadeInOut 0.5s ease-in-out;
        }

        .message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        @keyframes fadeInOut {
            0% { opacity: 0; transform: translateY(-10px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        /* Cart counter in navbar */
        .cart-link {
            position: relative;
        }

        .cart-counter {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #ff4444;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
            font-weight: bold;
            min-width: 18px;
            text-align: center;
        }

        /* Responsive */
        @media(max-width:768px){
            table { width: 100%; }
            .navbar a { margin: 0 10px; font-size: 14px; }
        }
    </style>
</head>
<body>
    <%
        // Check for cart messages
        String cartMessage = (String) session.getAttribute("cartMessage");
        String cartMessageType = (String) session.getAttribute("cartMessageType");
        
        // Clear the message after displaying
        if(cartMessage != null) {
            session.removeAttribute("cartMessage");
            session.removeAttribute("cartMessageType");
        }
        
        // Get cart size for counter
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        int cartSize = 0;
        if(cart != null && !cart.isEmpty()) {
            for(Integer qty : cart.values()) {
                cartSize += qty;
            }
        }
    %>
    
    <div class="navbar">
        <a href="index.jsp">Home</a>
        <a href="products.jsp">Products</a>
        <a href="cart.jsp" class="cart-link">Cart
            <% if(cartSize > 0) { %>
                <span class="cart-counter"><%=cartSize%></span>
            <% } %>
        </a>
        <a href="myOrders.jsp">My Orders</a>
        <a href="logout.jsp">Logout</a>
    </div>

    <h2>Available Products</h2>
    
    <% if(cartMessage != null) { %>
        <div class="message <%=cartMessageType%>"><%=cartMessage%></div>
    <% } %>

    <table>
        <tr><th>Name</th><th>Description</th><th>Price (₹)</th><th>Stock</th><th>Quantity</th><th>Action</th></tr>
        <%
            Connection conn = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                conn = DBConnection.getConnection();
                st = conn.createStatement();
                rs = st.executeQuery("SELECT * FROM products");
                while(rs.next()){
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String desc = rs.getString("description");
                    double price = rs.getDouble("price");
                    int stock = rs.getInt("stock");
        %>
                    <tr>
                        <td><%=name%></td>
                        <td><%=desc%></td>
                        <td>₹<%=price%></td>
                        <td><%=stock%></td>
                        <form action="addToCart.jsp" method="get">
                        <td><input type="number" name="quantity" value="1" min="1" max="<%=stock%>" required></td>
                        <td>
                            <input type="hidden" name="productId" value="<%=id%>">
                            <button type="submit" class="btn">Add to Cart</button>
                        </td>
                        </form>
                    </tr>
        <%
                }
            } catch(Exception e){
                out.println("<tr><td colspan='6' style='color:red;'>Error: "+e.getMessage()+"</td></tr>");
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ex) {}
                try { if (st != null) st.close(); } catch (Exception ex) {}
                try { if (conn != null) conn.close(); } catch (Exception ex) {}
            }
        %>
    </table>
</body>
</html>