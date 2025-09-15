@echo off
echo =========================================
echo     UPDATE PRODUCT IMAGES
echo =========================================
echo.

echo This script will update the products table to include image URLs
echo Make sure MySQL server is running before proceeding
echo.

if not exist "update_product_images.sql" (
    echo ERROR: update_product_images.sql not found!
    echo Please make sure the file exists in the current directory
    pause
    exit /b 1
)

echo Checking MySQL client availability...
mysql --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: MySQL command line client not found in PATH
    echo Please install MySQL and add it to your PATH
    echo Alternatively, use MySQL Workbench to run the script manually
    pause
    exit /b 1
)

echo.
echo Updating product images...
echo Please enter your MySQL root password when prompted:
echo.

mysql -u root -p < update_product_images.sql

if %errorlevel% equ 0 (
    echo.
    echo SUCCESS: Product images updated successfully!
    echo.
    echo Next steps:
    echo 1. Add actual image files to src/main/webapp/images/ directory
    echo 2. Use these filenames:
    echo    - laptop.png, smartphone.png, headphones.png
    echo    - tshirt.png, jeans.png, shoes.png  
    echo    - mug.png, book.png, backpack.png, bottle.png
    echo.
    echo 3. Restart your web server to see the changes
    echo.
) else (
    echo.
    echo ERROR: Failed to update product images
    echo Please check:
    echo 1. MySQL server is running
    echo 2. Root password is correct
    echo 3. ecommerce_db database exists
)

echo.
pause