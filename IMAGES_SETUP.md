# Product Images Setup Guide

This guide explains how to add product images to your FindKart e-commerce application.

## 📁 Image Directory Structure

All product images should be placed in:
```
src/main/webapp/images/
```

## 🖼️ Required Image Files

The application expects the following image files:

### Electronics
- `laptop.png` - For Laptop product
- `smartphone.png` - For Smartphone product
- `headphones.png` - For Headphones product

### Clothing
- `tshirt.png` - For T-Shirt product
- `jeans.png` - For Jeans product

### Footwear
- `shoes.png` - For Running Shoes product

### Home & Kitchen
- `mug.png` - For Coffee Mug product

### Books
- `book.png` - For Book - Programming product

### Accessories
- `backpack.png` - For Backpack product
- `bottle.png` - For Water Bottle product

## 🚀 Setup Instructions

### Option 1: Update Existing Database
If you already have the database set up:

1. Run the update script:
   ```bash
   update_product_images.bat
   ```
   OR manually run:
   ```bash
   mysql -u root -p < update_product_images.sql
   ```

### Option 2: Fresh Database Setup
If setting up a new database:

1. The updated `create_database_schema.sql` already includes image URLs
2. Simply run:
   ```bash
   import_database.bat
   ```

## 📷 Image Specifications

### Recommended Image Properties:
- **Format**: JPG, PNG, SVG, or WebP
- **Size**: 300x300 pixels (square aspect ratio)
- **File Size**: Under 100KB for optimal loading
- **Quality**: High quality but web-optimized

## 🎨 Current Implementation

The application now properly displays:
- ✅ **Real images** when image files are present
- ✅ **"No Image" placeholders** when images are missing or fail to load
- ✅ **Proper error handling** with fallback to text placeholders

### Sample SVG Images Included
The `create_placeholder_images.bat` script now creates colorful SVG sample images for testing.

## 🔧 Adding Your Own Images

1. **Obtain Images**: 
   - Use product photos from manufacturers
   - Take your own photos
   - Use royalty-free stock images

2. **Process Images**:
   - Resize to 300x300 pixels
   - Optimize for web (save as JPG with 80-90% quality)
   - Name according to the list above

3. **Upload Images**:
   - Place files in `src/main/webapp/images/` directory
   - Ensure filenames match exactly (case-sensitive)

4. **Test**:
   - Restart your web server
   - Visit the products page to see images
   - Check cart and orders pages for image display

## 🐛 Troubleshooting

### Images Not Showing?
1. Check file paths and names are correct
2. Ensure images are in the correct directory
3. Verify file permissions
4. Check browser console for 404 errors
5. Restart web server after adding images

### Placeholder Showing Instead of Image?
1. Verify the image file exists
2. Check the filename matches database entry exactly
3. Ensure image file is not corrupted
4. Try accessing image directly: `http://localhost:8080/ecommerce-web/images/[filename]`

## 📝 Database Schema

The `products` table includes an `image_url` column:
```sql
image_url VARCHAR(255)
```

This stores just the filename (e.g., "laptop.jpg"), not the full path.

## 🎯 Features Enabled

With images properly set up, you'll see:
- ✅ Product images in the products listing page
- ✅ Product images in shopping cart
- ✅ Product images in checkout page  
- ✅ Product images in order history
- ✅ Smart emoji placeholders for missing images
- ✅ Responsive image sizing across all pages

---

**Note**: Images are optional. The application works perfectly with placeholders if you prefer not to add actual images immediately.