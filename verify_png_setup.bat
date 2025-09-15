@echo off
echo =========================================
echo     PNG IMAGES SETUP VERIFICATION
echo =========================================
echo.

set IMAGE_DIR=src\main\webapp\images

echo Checking for PNG image files in %IMAGE_DIR%...
echo.

if not exist "%IMAGE_DIR%" (
    echo ERROR: Images directory does not exist!
    echo Please create the directory: %IMAGE_DIR%
    echo.
    pause
    exit /b 1
)

echo ✓ Images directory exists: %IMAGE_DIR%
echo.

echo Checking for PNG files:
set /a found=0
if exist "%IMAGE_DIR%\laptop.png" (echo ✓ laptop.png found && set /a found+=1) else (echo ✗ laptop.png missing)
if exist "%IMAGE_DIR%\smartphone.png" (echo ✓ smartphone.png found && set /a found+=1) else (echo ✗ smartphone.png missing)
if exist "%IMAGE_DIR%\headphones.png" (echo ✓ headphones.png found && set /a found+=1) else (echo ✗ headphones.png missing)
if exist "%IMAGE_DIR%\tshirt.png" (echo ✓ tshirt.png found && set /a found+=1) else (echo ✗ tshirt.png missing)
if exist "%IMAGE_DIR%\jeans.png" (echo ✓ jeans.png found && set /a found+=1) else (echo ✗ jeans.png missing)
if exist "%IMAGE_DIR%\shoes.png" (echo ✓ shoes.png found && set /a found+=1) else (echo ✗ shoes.png missing)
if exist "%IMAGE_DIR%\mug.png" (echo ✓ mug.png found && set /a found+=1) else (echo ✗ mug.png missing)
if exist "%IMAGE_DIR%\book.png" (echo ✓ book.png found && set /a found+=1) else (echo ✗ book.png missing)
if exist "%IMAGE_DIR%\backpack.png" (echo ✓ backpack.png found && set /a found+=1) else (echo ✗ backpack.png missing)
if exist "%IMAGE_DIR%\bottle.png" (echo ✓ bottle.png found && set /a found+=1) else (echo ✗ bottle.png missing)

echo.
echo Found %found%/10 PNG image files.

if %found% equ 10 (
    echo ✓ All PNG images are present!
) else (
    echo ⚠ Some PNG images are missing. Please add the missing files.
)

echo.
echo =========================================
echo     NEXT STEPS
echo =========================================
echo.

if %found% gtr 0 (
    echo You have PNG images in place. Now:
    echo.
    echo 1. Update your database to use PNG files:
    echo    update_to_png_images.bat
    echo.
    echo 2. Start your web server:
    echo    start_server.bat
    echo.
    echo 3. Visit: http://localhost:8080/ecommerce-web/
    echo.
    echo 4. Check the products page to see your images
    echo.
) else (
    echo Please add your PNG image files to: %IMAGE_DIR%
    echo Required files: laptop.png, smartphone.png, headphones.png,
    echo                 tshirt.png, jeans.png, shoes.png,
    echo                 mug.png, book.png, backpack.png, bottle.png
    echo.
)

echo =========================================
echo     TROUBLESHOOTING
echo =========================================
echo.
echo If images don't show up:
echo 1. Make sure database is updated (run update_to_png_images.bat)
echo 2. Restart web server
echo 3. Check browser console for 404 errors
echo 4. Test direct access: http://localhost:8080/ecommerce-web/images/laptop.png
echo.

pause