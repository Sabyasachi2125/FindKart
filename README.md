# 🛒 E-Commerce Web Application

![Java](https://img.shields.io/badge/Java-24-orange?style=flat-square&logo=java)
![Maven](https://img.shields.io/badge/Maven-3.x-blue?style=flat-square&logo=apache-maven)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square&logo=mysql)
![JSP](https://img.shields.io/badge/JSP-Servlet-green?style=flat-square)
![Tomcat](https://img.shields.io/badge/Tomcat-7-yellow?style=flat-square&logo=apache-tomcat)

A complete e-commerce web application built with Java, JSP/Servlets, and MySQL. Features include user management, product catalog, shopping cart, and order processing.

## 🌟 Features

- **User Authentication**: Registration, login, and session management
- **Product Catalog**: Browse products with details and stock information
- **Shopping Cart**: Add/remove items with persistent session storage
- **Order Management**: Place orders and view order history
- **Responsive Design**: Mobile-friendly interface with modern styling
- **Admin Functions**: User and product management capabilities

## 🚀 Quick Start

### Prerequisites
- JDK 24 (installed ✓)
- Maven (installed ✓) 
- MySQL Server (installed ✓)

## 🛠️ Installation & Setup

### 1. 💾 DATABASE SETUP

#### Step 1a: Create Database Schema
1. Start MySQL server
2. Open MySQL command line or MySQL Workbench
3. Run the SQL script: `create_database_schema.sql`

```bash
mysql -u root -p < create_database_schema.sql
```

#### Step 1b: Update Database Credentials (if needed)
- Open `src/main/java/com/ecommerce/DBConnection.java`
- Update the following if your MySQL credentials are different:
  - `USER = "root"`
  - `PASS = "Sabya@123"` 
  - `URL = "jdbc:mysql://localhost:3306/ecommerce_db"`

### 2. 📺 ONE-TIME SETUP

#### Step 2a: Install Dependencies & Build Project
```bash
setup_project.bat
```
This will:
- Check Java and Maven installation
- Download and install all dependencies
- Compile and package the application
- Create WAR file in `target/` directory

#### Step 2b: Test Database Connection
```bash
check_database.bat
```
This will:
- Test database connectivity
- Verify if schema is properly created
- Check if sample data is loaded

### 3. 🌐 RUNNING THE APPLICATION

#### Step 3a: Start Web Server
```bash
start_server.bat
```
This will:
- Start embedded Tomcat server on port 8080
- Deploy the application at: http://localhost:8080/ecommerce-web/
- Keep running until you press Ctrl+C

#### Step 3b: Open Frontend (Optional)
```bash
open_frontend.bat
```
This will:
- Check if server is running
- Open the application in your default browser
- Show available page URLs

## 🌍 Application URLs

After starting the server, access these pages:

- **Home Page**: http://localhost:8080/ecommerce-web/
- **Login**: http://localhost:8080/ecommerce-web/login.jsp
- **Register**: http://localhost:8080/ecommerce-web/register.jsp
- **Products**: http://localhost:8080/ecommerce-web/products.jsp

## 👥 Default User Accounts

The database comes with sample users:

1. **Admin Account**
   - Email: admin@ecommerce.com
   - Password: admin123

2. **Regular User**
   - Email: john@email.com
   - Password: john123

## 🚀 Features Available

1. **User Management**
   - User registration
   - User login/logout
   - Role-based access (Admin/User/Guest)

2. **Product Management**
   - Browse products
   - View product details
   - Stock management

3. **Shopping Cart**
   - Add/remove items
   - Quantity management
   - Cart persistence in session

4. **Order Management**
   - Place orders
   - Order history
   - Order tracking

## 🔧 Troubleshooting

### Database Connection Issues
- Ensure MySQL service is running
- Check database credentials in `DBConnection.java`
- Verify database `ecommerce_db` exists
- Run `check_database.bat` to test connection

### Build Issues
- Ensure JDK 24 is properly installed
- Check Maven installation: `mvn -version`
- Clear Maven cache: `mvn clean`
- Re-run `setup_project.bat`

### Server Issues
- Check if port 8080 is available
- Ensure WAR file exists in `target/` directory
- Check server logs for errors
- Try restarting the server

## 📚 Project Structure

```
Ecommerce1/
├── src/main/
│   ├── java/com/ecommerce/
│   │   └── DBConnection.java          # Database connection
│   └── webapp/
│       ├── WEB-INF/web.xml           # Web configuration
│       ├── *.jsp                     # JSP pages
│       └── index.html                # Welcome page
├── target/                           # Build output
├── pom.xml                          # Maven configuration
├── create_database_schema.sql       # Database schema
├── setup_project.bat               # One-time setup
├── check_database.bat              # Database test
├── start_server.bat                # Start web server
└── open_frontend.bat               # Open browser
```

## 📝 Development Notes

- Application uses JSP/Servlet architecture
- Direct JDBC for database operations
- Session-based cart management
- Basic authentication (no encryption)
- Responsive UI with inline CSS

## ⚠️ Security Considerations

⚠️ **Important**: This is a development/learning application:
- Passwords are stored in plain text
- No input validation/sanitization
- Vulnerable to SQL injection
- No HTTPS/encryption
- For learning purposes only, not production-ready

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Built with Java and JSP/Servlet technology
- Uses MySQL for data persistence
- Maven for project management and build automation
- Apache Tomcat for web server functionality

## 📧 Contact

If you have any questions or suggestions, feel free to reach out!

---

⭐ **If you found this project helpful, please give it a star!** ⭐
