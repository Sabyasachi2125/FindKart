@echo off
echo =========================================
echo    IMAGE VERIFICATION SCRIPT
echo =========================================
echo.

set IMAGE_DIR=src\main\webapp\images

echo Checking image directory and files...
echo.

if not exist "%IMAGE_DIR%" (
    echo ERROR: Images directory does not exist!
    echo Please run create_placeholder_images.bat first
    echo.
    pause
    exit /b 1
)

echo ✓ Images directory exists: %IMAGE_DIR%
echo.

echo Checking for image files:
if exist "%IMAGE_DIR%\laptop.png" (echo ✓ laptop.png found) else (echo ✗ laptop.png missing)
if exist "%IMAGE_DIR%\smartphone.png" (echo ✓ smartphone.png found) else (echo ✗ smartphone.png missing)
if exist "%IMAGE_DIR%\headphones.png" (echo ✓ headphones.png found) else (echo ✗ headphones.png missing)
if exist "%IMAGE_DIR%\tshirt.png" (echo ✓ tshirt.png found) else (echo ✗ tshirt.png missing)
if exist "%IMAGE_DIR%\jeans.png" (echo ✓ jeans.png found) else (echo ✗ jeans.png missing)
if exist "%IMAGE_DIR%\shoes.png" (echo ✓ shoes.png found) else (echo ✗ shoes.png missing)
if exist "%IMAGE_DIR%\mug.png" (echo ✓ mug.png found) else (echo ✗ mug.png missing)
if exist "%IMAGE_DIR%\book.png" (echo ✓ book.png found) else (echo ✗ book.png missing)
if exist "%IMAGE_DIR%\backpack.png" (echo ✓ backpack.png found) else (echo ✗ backpack.png missing)
if exist "%IMAGE_DIR%\bottle.png" (echo ✓ bottle.png found) else (echo ✗ bottle.png missing)

echo.
echo =========================================
echo    TESTING IMAGE ACCESS
echo =========================================
echo.

echo Testing if server can access images...
echo Note: This requires your web server to be running on port 8080
echo.

curl -I http://localhost:8080/ecommerce-web/images/laptop.png >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Web server can access laptop.png
) else (
    echo ✗ Cannot access images via web server
    echo   Make sure your web server is running
    echo   URL should be: http://localhost:8080/ecommerce-web/images/laptop.png
)

echo.
echo =========================================
echo    TROUBLESHOOTING GUIDE
echo =========================================
echo.
echo If images are not showing in the application:
echo.
echo 1. Verify files exist in the images directory
echo 2. Check database has correct image_url values
echo 3. Ensure web server is running
echo 4. Test direct image access in browser:
echo    http://localhost:8080/ecommerce-web/images/laptop.png
echo.
echo 5. Check browser console for 404 errors
echo 6. Verify image file permissions
echo.
pause