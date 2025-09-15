@echo off
echo =========================================
echo    CREATE SAMPLE PRODUCT IMAGES
echo =========================================
echo.

echo This script will create sample product image files.
echo These are basic HTML-based images that you can replace with actual photos.
echo.

set IMAGE_DIR=src\main\webapp\images

if not exist "%IMAGE_DIR%" (
    echo Creating images directory...
    mkdir "%IMAGE_DIR%"
)

echo Creating sample product images...
echo.

:: Create HTML-based image files that will display as proper images
echo Creating laptop.jpg...
echo ^<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" viewBox="0 0 300 300"^>^<rect width="300" height="300" fill="#1e40af"/^>^<text x="150" y="140" text-anchor="middle" fill="white" font-size="24" font-family="Arial"^>LAPTOP^</text^>^<text x="150" y="170" text-anchor="middle" fill="white" font-size="36"^>💻^</text^>^</svg^> > "%IMAGE_DIR%\laptop.svg"

echo Creating smartphone.jpg...
echo ^<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" viewBox="0 0 300 300"^>^<rect width="300" height="300" fill="#059669"/^>^<text x="150" y="140" text-anchor="middle" fill="white" font-size="20" font-family="Arial"^>SMARTPHONE^</text^>^<text x="150" y="170" text-anchor="middle" fill="white" font-size="36"^>📱^</text^>^</svg^> > "%IMAGE_DIR%\smartphone.svg"

echo Creating headphones.jpg...
echo ^<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" viewBox="0 0 300 300"^>^<rect width="300" height="300" fill="#7c3aed"/^>^<text x="150" y="140" text-anchor="middle" fill="white" font-size="18" font-family="Arial"^>HEADPHONES^</text^>^<text x="150" y="170" text-anchor="middle" fill="white" font-size="36"^>🎧^</text^>^</svg^> > "%IMAGE_DIR%\headphones.svg"

echo Creating tshirt.jpg...
echo ^<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" viewBox="0 0 300 300"^>^<rect width="300" height="300" fill="#dc2626"/^>^<text x="150" y="140" text-anchor="middle" fill="white" font-size="24" font-family="Arial"^>T-SHIRT^</text^>^<text x="150" y="170" text-anchor="middle" fill="white" font-size="36"^>👕^</text^>^</svg^> > "%IMAGE_DIR%\tshirt.svg"

echo Creating jeans.jpg...
echo ^<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" viewBox="0 0 300 300"^>^<rect width="300" height="300" fill="#1f2937"/^>^<text x="150" y="140" text-anchor="middle" fill="white" font-size="24" font-family="Arial"^>JEANS^</text^>^<text x="150" y="170" text-anchor="middle" fill="white" font-size="36"^>👖^</text^>^</svg^> > "%IMAGE_DIR%\jeans.svg"

echo Creating shoes.jpg...
echo ^<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" viewBox="0 0 300 300"^>^<rect width="300" height="300" fill="#ea580c"/^>^<text x="150" y="140" text-anchor="middle" fill="white" font-size="20" font-family="Arial"^>RUNNING SHOES^</text^>^<text x="150" y="170" text-anchor="middle" fill="white" font-size="36"^>👟^</text^>^</svg^> > "%IMAGE_DIR%\shoes.svg"

echo Creating mug.jpg...
echo ^<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" viewBox="0 0 300 300"^>^<rect width="300" height="300" fill="#92400e"/^>^<text x="150" y="140" text-anchor="middle" fill="white" font-size="20" font-family="Arial"^>COFFEE MUG^</text^>^<text x="150" y="170" text-anchor="middle" fill="white" font-size="36"^>☕^</text^>^</svg^> > "%IMAGE_DIR%\mug.svg"

echo Creating book.jpg...
echo ^<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" viewBox="0 0 300 300"^>^<rect width="300" height="300" fill="#065f46"/^>^<text x="150" y="140" text-anchor="middle" fill="white" font-size="24" font-family="Arial"^>BOOK^</text^>^<text x="150" y="170" text-anchor="middle" fill="white" font-size="36"^>📚^</text^>^</svg^> > "%IMAGE_DIR%\book.svg"

echo Creating backpack.jpg...
echo ^<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" viewBox="0 0 300 300"^>^<rect width="300" height="300" fill="#7e22ce"/^>^<text x="150" y="140" text-anchor="middle" fill="white" font-size="20" font-family="Arial"^>BACKPACK^</text^>^<text x="150" y="170" text-anchor="middle" fill="white" font-size="36"^>🎒^</text^>^</svg^> > "%IMAGE_DIR%\backpack.svg"

echo Creating bottle.jpg...
echo ^<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" viewBox="0 0 300 300"^>^<rect width="300" height="300" fill="#0369a1"/^>^<text x="150" y="140" text-anchor="middle" fill="white" font-size="18" font-family="Arial"^>WATER BOTTLE^</text^>^<text x="150" y="170" text-anchor="middle" fill="white" font-size="36"^>🍾^</text^>^</svg^> > "%IMAGE_DIR%\bottle.svg"

echo.
echo =========================================
echo    SAMPLE SVG IMAGES CREATED!
echo =========================================
echo.
echo Location: %IMAGE_DIR%
echo.
echo CREATED FILES:
echo - laptop.svg, smartphone.svg, headphones.svg
echo - tshirt.svg, jeans.svg, shoes.svg
echo - mug.svg, book.svg, backpack.svg, bottle.svg
echo.
echo FEATURES:
echo 1. Colorful SVG images with product names and icons
echo 2. Each image is 300x300 pixels
echo 3. Browser-compatible and lightweight
echo 4. Can be replaced with actual product photos
echo.
echo NEXT STEPS:
echo 1. Run update_product_images.bat to update database
echo 2. Start your web server
echo 3. Visit the products page to see the images
echo 4. Replace SVG files with actual photos if desired
echo.
pause