# FindKart Deployment Guide

This guide explains how to deploy and run the FindKart e-commerce application.

## 🚀 Quick Deployment

### Method 1: Using Quick Start Script
```bash
# Run the interactive menu
quick_start.bat

# Follow the menu options:
# [1] First Time Setup
# [2] Import Database Schema
# [5] Start Web Server
```

### Method 2: Manual Deployment
```bash
# 1. Setup and build
setup_project.bat

# 2. Import database
import_database.bat

# 3. Start server
start_server.bat

# 4. Access application
# http://localhost:8080/ecommerce-web/
```

## 🗄️ Database Setup

### Prerequisites
- MySQL Server 8.0 installed and running
- Default credentials: `root` with password `Sabya@123`
- Or update credentials in `src/main/java/com/ecommerce/DBConnection.java`

### Database Configuration
```sql
-- Default database: ecommerce_db
-- Default port: 3306
-- URL: jdbc:mysql://localhost:3306/ecommerce_db
```

### Import Schema
```bash
mysql -u root -p < create_database_schema.sql
```

## 🖼️ Image Setup

### Add Product Images
1. Place PNG/JPG files in `src/main/webapp/images/`
2. Expected filenames:
   - `laptop.png`, `smartphone.png`, `headphones.png`
   - `tshirt.png`, `jeans.png`, `shoes.png`
   - `mug.png`, `book.png`, `backpack.png`, `bottle.png`

### Update Database for Images
```bash
update_to_png_images.bat
```

### Verify Image Setup
```bash
verify_png_setup.bat
```

## 🌐 Web Server Configuration

### Default Configuration
- **Server**: Apache Tomcat 7 (embedded)
- **Port**: 8080
- **Context Path**: `/ecommerce-web`
- **URL**: `http://localhost:8080/ecommerce-web/`

### Build and Deploy
```bash
# Clean build
mvn clean package

# Start server
mvn tomcat7:run

# Or use the provided script
start_server.bat
```

## 🔐 Default User Accounts

### Admin Account
- **Email**: `admin@ecommerce.com`
- **Password**: `admin123`
- **Role**: Admin

### Test User Account
- **Email**: `john@email.com`
- **Password**: `john123`
- **Role**: User

## 📁 Directory Structure

```
FindKart/
├── src/main/
│   ├── java/com/ecommerce/
│   │   └── DBConnection.java
│   └── webapp/
│       ├── *.jsp                    # Application pages
│       ├── images/                  # Product images
│       └── WEB-INF/
│           └── web.xml             # Web configuration
├── target/                         # Build output
├── *.sql                          # Database scripts
├── *.bat                          # Setup scripts
└── pom.xml                        # Maven configuration
```

## 🔧 Troubleshooting

### Common Issues

#### 1. Port 8080 Already in Use
```bash
# Find process using port 8080
netstat -ano | findstr :8080

# Kill the process (replace PID)
taskkill /PID <PID> /F

# Or change port in pom.xml
```

#### 2. Database Connection Failed
```bash
# Check if MySQL is running
net start mysql80

# Test connection
check_database.bat

# Update credentials in DBConnection.java if needed
```

#### 3. Maven Build Failed
```bash
# Clean and rebuild
mvn clean install

# Check Java version
java -version

# Should be JDK 24
```

#### 4. Images Not Loading
```bash
# Verify image files exist
verify_png_setup.bat

# Update database
update_to_png_images.bat

# Check browser console for 404 errors
```

## 🌍 Production Deployment

### For Production Environment

1. **Update Database Credentials**
   - Modify `src/main/java/com/ecommerce/DBConnection.java`
   - Use environment variables or external configuration

2. **Security Enhancements**
   - Enable HTTPS
   - Implement password hashing
   - Add input validation
   - Configure proper firewall rules

3. **Server Configuration**
   - Use external Tomcat server
   - Configure proper logging
   - Set up monitoring
   - Enable session clustering for load balancing

4. **Database Setup**
   - Use production MySQL instance
   - Configure proper backup strategy
   - Set up read replicas if needed
   - Implement proper indexing

### Environment Variables
```bash
# Database configuration
DB_HOST=localhost
DB_PORT=3306
DB_NAME=ecommerce_db
DB_USER=root
DB_PASSWORD=your_password

# Server configuration
SERVER_PORT=8080
CONTEXT_PATH=/ecommerce-web
```

## 📊 Performance Optimization

### For Better Performance

1. **Database Optimization**
   - Add proper indexes
   - Optimize queries
   - Use connection pooling

2. **Web Application**
   - Enable compression
   - Optimize images
   - Use CDN for static assets
   - Implement caching

3. **Server Configuration**
   - Tune JVM parameters
   - Configure thread pools
   - Set up load balancing

## 📝 Monitoring

### Health Checks
- Database connectivity: `check_database.bat`
- Web server status: `http://localhost:8080/ecommerce-web/`
- Image access: `http://localhost:8080/ecommerce-web/images/laptop.png`

### Logs Location
- Application logs: Console output
- Tomcat logs: `target/` directory
- MySQL logs: MySQL data directory

## 🔄 Updates and Maintenance

### Applying Updates
```bash
# Pull latest changes
git pull origin main

# Rebuild application
mvn clean package

# Restart server
start_server.bat
```

### Database Updates
```bash
# Run migration scripts if any
mysql -u root -p < migration_script.sql

# Update image references if needed
update_to_png_images.bat
```

---

For more details, see the main [README.md](README.md) file.