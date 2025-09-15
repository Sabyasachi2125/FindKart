# 🛒 FindKart - E-Commerce Web Application

![Java](https://img.shields.io/badge/Java-24-orange?style=flat-square&logo=java)
![Maven](https://img.shields.io/badge/Maven-3.x-blue?style=flat-square&logo=apache-maven)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square&logo=mysql)
![JSP](https://img.shields.io/badge/JSP-Servlet-green?style=flat-square)
![Tomcat](https://img.shields.io/badge/Tomcat-7-yellow?style=flat-square&logo=apache-tomcat)

A complete e-commerce web application built with Java, JSP/Servlets, and MySQL. Features include user management, product catalog, shopping cart, order processing, and a modern responsive UI with the FindKart brand theme.

## 🌟 Features

- **🔐 User Authentication**: Registration, login, and session management
- **📦 Product Catalog**: Browse products with images, details, and stock information
- **🛍️ Shopping Cart**: Add/remove items with persistent session storage
- **📋 Order Management**: Place orders and view detailed order history
- **🎨 Modern UI**: Responsive design with FindKart brand colors and logo
- **🖼️ Image Support**: Product images throughout the application
- **👤 Admin Functions**: User and product management capabilities
- **📱 Mobile Friendly**: Responsive design for all screen sizes

## 🚀 Quick Start

### Prerequisites
- ☕ JDK 24
- 📦 Maven 3.x
- 🗄️ MySQL Server 8.0

### 🛠️ Installation & Setup

#### 1. Clone the Repository
```bash
git clone https://github.com/Sabyasachi2125/FindKart.git
cd FindKart
```

#### 2. Database Setup

**Option A: Quick Setup**
```bash
# Run the quick start menu
quick_start.bat

# Then choose:
# [1] First Time Setup
# [2] Import Database Schema
```

**Option B: Manual Setup**
```bash
# Install dependencies and build
setup_project.bat

# Create database and import schema
mysql -u root -p < create_database_schema.sql

# Update to PNG images (if you have image files)
update_to_png_images.bat
```

#### 3. Start the Application
```bash
start_server.bat
```

#### 4. Access the Application
Open your browser and visit: `http://localhost:8080/ecommerce-web/`

## 🎨 Brand Theme

FindKart features a modern, professional design with:
- **Primary Colors**: Navy Blue (`#2d4d68`) and Orange (`#ff6b35`)
- **Logo**: Shopping cart emoji (🛒) with "FindKart" branding
- **Design**: Clean, responsive layout inspired by modern e-commerce platforms

## 📸 Product Images

The application supports product images:
- Place PNG/JPG images in `src/main/webapp/images/`
- Expected image files: `laptop.png`, `smartphone.png`, `headphones.png`, etc.
- Run `verify_png_setup.bat` to check your image setup

## 🗄️ Database Schema

The application uses MySQL with the following main tables:
- **users**: User accounts and authentication
- **products**: Product catalog with images
- **orders**: Order information
- **order_items**: Order line items

### Default Login Credentials
- **Admin**: `admin@ecommerce.com` / `admin123`
- **User**: `john@email.com` / `john123`

## 📁 Project Structure

```
FindKart/
├── src/main/
│   ├── java/com/ecommerce/
│   │   └── DBConnection.java          # Database connection
│   └── webapp/
│       ├── *.jsp                      # JSP pages
│       ├── images/                    # Product images
│       └── WEB-INF/web.xml           # Web configuration
├── target/                           # Build output
├── *.sql                            # Database scripts
├── *.bat                            # Setup scripts
├── pom.xml                          # Maven configuration
└── README.md                        # This file
```

## 🔧 Available Scripts

- `quick_start.bat` - Interactive setup menu
- `setup_project.bat` - Install dependencies and build
- `start_server.bat` - Start the web server
- `import_database.bat` - Import database schema
- `update_to_png_images.bat` - Update database for PNG images
- `verify_png_setup.bat` - Verify image setup

## 📱 Pages & Features

- **🏠 Home** (`index.jsp`) - Welcome page with FindKart branding
- **📦 Products** (`products.jsp`) - Product catalog with images
- **🛒 Cart** (`cart.jsp`) - Shopping cart with product images
- **💳 Checkout** (`checkout.jsp`) - Order placement
- **📋 My Orders** (`myOrders.jsp`) - Order history with images
- **🔐 Login/Register** (`login.jsp`, `register.jsp`) - User authentication

## 🛠️ Technical Stack

- **Frontend**: JSP, HTML5, CSS3 (responsive design)
- **Backend**: Java Servlets, JDBC
- **Database**: MySQL 8.0
- **Build Tool**: Maven 3.x
- **Server**: Apache Tomcat 7 (embedded)
- **Architecture**: MVC pattern with JSP/Servlet

## 🔒 Security Note

⚠️ **Development Application**: This is a learning/development project with basic security:
- Plain text password storage
- No input validation/sanitization
- No HTTPS encryption
- For educational purposes only

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🐛 Troubleshooting

### Common Issues

1. **Port 8080 already in use**
   - Stop other applications using port 8080
   - Or modify the port in the Tomcat configuration

2. **Database connection failed**
   - Ensure MySQL server is running
   - Check credentials in `DBConnection.java`
   - Run `check_database.bat` to test connection

3. **Images not showing**
   - Verify PNG files exist in `src/main/webapp/images/`
   - Run `update_to_png_images.bat`
   - Check browser console for 404 errors

4. **Build failed**
   - Ensure JDK 24 and Maven are properly installed
   - Run `mvn clean install` manually
   - Check internet connection for dependencies

## 📞 Support

If you encounter any issues:
1. Check the troubleshooting section above
2. Run the verification scripts (`verify_png_setup.bat`)
3. Open an issue on GitHub with error details

## 🎯 Future Enhancements

- [ ] Enhanced security (password hashing, input validation)
- [ ] Admin panel for product management
- [ ] Product categories and search functionality
- [ ] Payment gateway integration
- [ ] Email notifications
- [ ] Product reviews and ratings

---

**Happy Shopping with FindKart! 🛒**