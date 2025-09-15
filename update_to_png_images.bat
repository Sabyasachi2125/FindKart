@echo off
echo =========================================
echo     UPDATE DATABASE TO PNG IMAGES
echo =========================================
echo.

echo This script will update your existing database to use PNG image files
echo instead of SVG files for all products.
echo.
echo Make sure you have placed your PNG images in the images directory:
echo src\main\webapp\images\
echo.

if not exist "update_to_png_images.sql" (
    echo ERROR: update_to_png_images.sql not found!
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
echo Updating database to use PNG images...
echo Please enter your MySQL root password when prompted:
echo.

mysql -u root -p < update_to_png_images.sql

if %errorlevel% equ 0 (
    echo.
    echo SUCCESS: Database updated to use PNG images!
    echo.
    echo Your database now references these PNG files:
    echo - laptop.png, smartphone.png, headphones.png
    echo - tshirt.png, jeans.png, shoes.png
    echo - mug.png, book.png, backpack.png, bottle.png
    echo.
    echo Make sure these PNG files exist in:
    echo src\main\webapp\images\
    echo.
    echo Restart your web server to see the changes
    echo.
) else (
    echo.
    echo ERROR: Failed to update database
    echo Please check:
    echo 1. MySQL server is running
    echo 2. Root password is correct
    echo 3. ecommerce_db database exists
)

echo.
pause