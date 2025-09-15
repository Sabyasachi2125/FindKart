<%@ page import="java.sql.*, java.util.*, com.ecommerce.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products - FindKart</title>
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
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
        }

        /* Navigation Bar - FindKart Theme */
        .navbar {
            background: linear-gradient(135deg, #2d4d68 0%, #34567a 100%);
            padding: 12px 0;
            box-shadow: 0 2px 8px rgba(45, 77, 104, 0.2);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo {
            width: 35px;
            height: 35px;
            background: linear-gradient(135deg, #ff6b35, #ff8856);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 16px;
            font-weight: 700;
        }

        .brand-name {
            color: #ffffff;
            font-size: 20px;
            font-weight: 700;
            text-decoration: none;
        }

        .brand-name .find {
            color: #ffffff;
        }

        .brand-name .kart {
            color: #ff6b35;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .navbar a {
            color: #ffffff;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            padding: 8px 12px;
            border-radius: 4px;
            transition: all 0.2s ease;
            position: relative;
        }

        .navbar a:hover {
            background-color: rgba(255, 107, 53, 0.2);
            color: #ff6b35;
        }

        .cart-counter {
            position: absolute;
            top: -5px;
            right: -5px;
            background: linear-gradient(135deg, #ff6b35, #ff8856);
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 11px;
            font-weight: 600;
            min-width: 18px;
            text-align: center;
        }

        /* Page Content */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }

        h2 {
            font-size: 2rem;
            font-weight: 600;
            color: #2d4d68;
            margin-bottom: 30px;
        }

        /* Message Styling */
        .message {
            max-width: 800px;
            margin: 20px auto;
            padding: 12px 16px;
            border-radius: 4px;
            font-size: 14px;
            text-align: center;
        }

        .message.success {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* Products Table */
        .products-wrapper {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(45, 77, 104, 0.1);
            border: 1px solid #e5e7eb;
            overflow: hidden;
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
            background: linear-gradient(135deg, #2d4d68, #34567a);
            color: #ffffff;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td {
            color: #1f2937;
            font-weight: 500;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        /* Product Image */
        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
            border: 2px solid #e5e7eb;
        }

        .product-image-placeholder {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6b7280;
            font-size: 24px;
            border: 2px solid #e5e7eb;
        }

        /* Form Elements */
        input[type="number"] {
            width: 60px;
            padding: 6px 8px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            text-align: center;
            font-size: 14px;
        }

        input[type="number"]:focus {
            outline: none;
            border-color: #ff6b35;
            box-shadow: 0 0 0 2px rgba(255, 107, 53, 0.1);
        }

        .btn {
            padding: 8px 16px;
            background: linear-gradient(135deg, #ff6b35, #ff8856);
            color: #ffffff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .btn:hover {
            background: linear-gradient(135deg, #ff5722, #ff7043);
            transform: translateY(-1px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .nav-container {
                flex-wrap: wrap;
                gap: 15px;
            }
            
            .navbar a {
                font-size: 13px;
                padding: 6px 10px;
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
                <a href="cart.jsp" class="cart-link">Cart
                    <% if(cartSize > 0) { %>
                        <span class="cart-counter"><%=cartSize%></span>
                    <% } %>
                </a>
                <a href="myOrders.jsp">My Orders</a>
                <a href="logout.jsp">Logout</a>
            </div>
        </div>
    </div>

    <div class="container">
        <h2>Our Products</h2>
        
        <% if(cartMessage != null) { %>
            <div class="message <%=cartMessageType%>"><%=cartMessage%></div>
        <% } %>

        <div class="products-wrapper">
            <table>
                <tr>
                    <th>Image</th>
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
                rs = st.executeQuery("SELECT id, name, description, price, stock, image_url FROM products");
                while(rs.next()){
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String desc = rs.getString("description");
                    double price = rs.getDouble("price");
                    int stock = rs.getInt("stock");
                    String imageUrl = rs.getString("image_url");
        %>
                    <tr>
                        <td>
                            <%
                                if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                                    out.println("<img src='images/" + imageUrl + "' alt='" + name + "' class='product-image' onerror=\"this.style.display='none'; this.nextElementSibling.style.display='flex';\">" +
                                               "<div class='product-image-placeholder' style='display:none; background: linear-gradient(45deg, #ff6b35, #ffa500); width: 60px; height: 60px; border-radius: 6px; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 12px;'>No Image</div>");
                                } else {
                                    out.println("<div class='product-image-placeholder' style='background: linear-gradient(45deg, #ff6b35, #ffa500); display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 12px; width: 60px; height: 60px; border-radius: 6px;'>No Image</div>");
                                }
                            %>
                        </td>
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
                out.println("<tr><td colspan='7' style='color:#dc2626;'>Error: "+e.getMessage()+"</td></tr>");
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