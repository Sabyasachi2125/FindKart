<%@ page import="java.sql.*, java.util.*, com.ecommerce.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products - FindKart</title>
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
            position: relative;
        }

        .navbar a:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .cart-link {
            position: relative;
        }

        .cart-counter {
            position: absolute;
            top: -8px;
            right: -8px;
            background: linear-gradient(135deg, #ff6b6b, #ff8787);
            color: white;
            border-radius: 50%;
            padding: 4px 8px;
            font-size: 11px;
            font-weight: 600;
            min-width: 20px;
            text-align: center;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
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

        /* Message Styling */
        .message {
            max-width: 600px;
            margin: 20px auto;
            padding: 16px 20px;
            border-radius: 15px;
            font-weight: 500;
            text-align: center;
            animation: slideDown 0.5s ease-out;
            backdrop-filter: blur(10px);
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .message.success {
            background: rgba(78, 205, 196, 0.2);
            color: #4ecdc4;
            border: 1px solid rgba(78, 205, 196, 0.3);
        }

        .message.error {
            background: rgba(255, 107, 107, 0.2);
            color: #ff6b6b;
            border: 1px solid rgba(255, 107, 107, 0.3);
        }

        /* Products Table */
        .products-wrapper {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin: 20px auto;
            max-width: 1000px;
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

        tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        /* Form Elements */
        input[type="number"] {
            width: 60px;
            padding: 8px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            text-align: center;
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            font-weight: 500;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        input[type="number"]:focus {
            outline: none;
            border-color: rgba(255, 255, 255, 0.4);
            background: rgba(255, 255, 255, 0.15);
        }

        input[type="number"]::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: #ffffff;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.9em;
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
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
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
            
            .products-wrapper {
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
        <a href="index.jsp">🏠 Home</a>
        <a href="products.jsp">🛍️ Products</a>
        <a href="cart.jsp" class="cart-link">🛒 Cart
            <% if(cartSize > 0) { %>
                <span class="cart-counter"><%=cartSize%></span>
            <% } %>
        </a>
        <a href="myOrders.jsp">📦 My Orders</a>
        <a href="logout.jsp">🚪 Logout</a>
    </div>

    <div class="container">
        <h2>🛍️ Our Products</h2>
        
        <% if(cartMessage != null) { %>
            <div class="message <%=cartMessageType%>"><%=cartMessage%></div>
        <% } %>

        <div class="products-wrapper">
            <table>
                <tr>
                    <th>Product Name</th>
                    <th>Description</th>
                    <th>Price (₹)</th>
                    <th>Stock</th>
                    <th>Quantity</th>
                    <th>Action</th>
                </tr>
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
                            <button type="submit" class="btn">🛒 Add to Cart</button>
                        </td>
                        </form>
                    </tr>
        <%
                }
            } catch(Exception e){
                out.println("<tr><td colspan='6' style='color:#ff6b6b;'>Error: "+e.getMessage()+"</td></tr>");
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ex) {}
                try { if (st != null) st.close(); } catch (Exception ex) {}
                try { if (conn != null) conn.close(); } catch (Exception ex) {}
            }
        %>
            </table>
        </div>
    </div>
</body>
</html>