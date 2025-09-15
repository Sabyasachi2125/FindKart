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

        /* Products Grid Layout */
        .products-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
            margin-top: 30px;
            padding: 0 10px;
        }

        .product-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(45, 77, 104, 0.1);
            border: 1px solid #e2e8f0;
            overflow: hidden;
            transition: all 0.3s ease;
            position: relative;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(45, 77, 104, 0.15);
        }

        .product-image-container {
            position: relative;
            width: 100%;
            height: 220px;
            overflow: hidden;
            background: #f8fafc;
        }

        .product-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .product-card:hover .product-image {
            transform: scale(1.05);
        }

        .product-image-placeholder {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(45deg, #ff6b35, #ffa500);
            color: white;
            font-weight: bold;
            font-size: 18px;
        }

        .favorite-btn {
            position: absolute;
            top: 12px;
            right: 12px;
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.9);
            border: none;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .favorite-btn:hover {
            background: #ff6b35;
            color: white;
            transform: scale(1.1);
        }

        .product-info {
            padding: 20px;
        }

        .product-brand {
            color: #64748b;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }

        .product-name {
            color: #2d4d68;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-description {
            color: #64748b;
            font-size: 13px;
            margin-bottom: 12px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.3;
        }

        .price-section {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 16px;
        }

        .current-price {
            color: #2d4d68;
            font-size: 20px;
            font-weight: 700;
        }

        .stock-info {
            color: #059669;
            font-size: 12px;
            font-weight: 500;
            margin-bottom: 16px;
        }

        .stock-info.low-stock {
            color: #dc2626;
        }

        .quantity-section {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .quantity-label {
            color: #2d4d68;
            font-size: 14px;
            font-weight: 500;
        }

        .quantity-input {
            width: 60px;
            padding: 6px 8px;
            border: 2px solid #e2e8f0;
            border-radius: 6px;
            text-align: center;
            font-weight: 500;
        }

        .quantity-input:focus {
            outline: none;
            border-color: #ff6b35;
        }

        .add-to-cart-btn {
            width: 100%;
            background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
        }

        .add-to-cart-btn:hover {
            background: linear-gradient(135deg, #e55a2b 0%, #e67832 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
        }

        .add-to-cart-btn:disabled {
            background: #9ca3af;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
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
                font-size: 2rem;
            }
            
            .products-container {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 16px;
            }
            
            .product-info {
                padding: 16px;
            }
        }

        @media (max-width: 480px) {
            .products-container {
                grid-template-columns: 1fr;
                gap: 16px;
                padding: 0 5px;
            }
            
            .product-image-container {
                height: 200px;
            }
            
            .product-info {
                padding: 12px;
            }
            
            .add-to-cart-btn {
                padding: 10px 16px;
                font-size: 13px;
            }
        }
    </style>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Event delegation for favorite buttons
            document.addEventListener('click', function(e) {
                if (e.target.closest('.favorite-btn')) {
                    const btn = e.target.closest('.favorite-btn');
                    const productId = btn.getAttribute('data-product-id');
                    const heart = btn.querySelector('span');
                    
                    if (heart.textContent === '♡') {
                        heart.textContent = '♥';
                        heart.style.color = '#ff6b35';
                        console.log('Added product ' + productId + ' to favorites');
                    } else {
                        heart.textContent = '♡';
                        heart.style.color = '#cbd5e1';
                        console.log('Removed product ' + productId + ' from favorites');
                    }
                }
            });
        });
    </script>
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

        <div class="products-container">
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
                    
                    // Determine brand/category for display
                    String brand = "FindKart";
                    if (name.toLowerCase().contains("laptop")) brand = "Electronics";
                    else if (name.toLowerCase().contains("smartphone")) brand = "Mobile";
                    else if (name.toLowerCase().contains("headphone")) brand = "Audio";
                    else if (name.toLowerCase().contains("shirt")) brand = "Fashion";
                    else if (name.toLowerCase().contains("jeans")) brand = "Apparel";
                    else if (name.toLowerCase().contains("shoe")) brand = "Footwear";
                    else if (name.toLowerCase().contains("mug")) brand = "Kitchen";
                    else if (name.toLowerCase().contains("book")) brand = "Books";
                    else if (name.toLowerCase().contains("bag")) brand = "Accessories";
        %>
            <div class="product-card">
                <div class="product-image-container">
                    <%
                        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                            out.println("<img src='images/" + imageUrl + "' alt='" + name + "' class='product-image' onerror=\"this.style.display='none'; this.nextElementSibling.style.display='flex';\">" +
                                       "<div class='product-image-placeholder' style='display:none;'>No Image</div>");
                        } else {
                            out.println("<div class='product-image-placeholder'>No Image</div>");
                        }
                    %>
                    <button class="favorite-btn" data-product-id="<%=id%>">
                        <span style="font-size: 18px; color: #cbd5e1;">♡</span>
                    </button>
                </div>
                
                <div class="product-info">
                    <div class="product-brand"><%=brand%></div>
                    <h3 class="product-name"><%=name%></h3>
                    <p class="product-description"><%=desc%></p>
                    
                    <div class="price-section">
                        <span class="current-price">₹<%=String.format("%.0f", price)%></span>
                    </div>
                    
                    <%
                        if (stock > 10) {
                            out.println("<div class='stock-info'>In Stock (" + stock + " available)</div>");
                        } else if (stock > 0) {
                            out.println("<div class='stock-info low-stock'>Low Stock (" + stock + " left)</div>");
                        } else {
                            out.println("<div class='stock-info low-stock'>Out of Stock</div>");
                        }
                    %>
                    
                    <form action="addToCart.jsp" method="get" style="margin: 0;">
                        <div class="quantity-section">
                            <span class="quantity-label">Qty:</span>
                            <input type="number" name="quantity" value="1" min="1" max="<%=stock%>" 
                                   class="quantity-input" <%=stock == 0 ? "disabled" : ""%> required>
                        </div>
                        
                        <input type="hidden" name="productId" value="<%=id%>">
                        <button type="submit" class="add-to-cart-btn" <%=stock == 0 ? "disabled" : ""%>>
                            <%=stock == 0 ? "Out of Stock" : "Add to Cart"%>
                        </button>
                    </form>
                </div>
            </div>
        <%
                }
            } catch(Exception e){
                out.println("<div style='grid-column: 1/-1; text-align: center; color: #dc2626; padding: 40px;'>Error: "+e.getMessage()+"</div>");
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ex) {}
                try { if (st != null) st.close(); } catch (Exception ex) {}
                try { if (conn != null) conn.close(); } catch (Exception ex) {}
            }
        %>
        </div>
    </div>
</body>
</html>