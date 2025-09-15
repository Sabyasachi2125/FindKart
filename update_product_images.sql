-- =========================================
-- UPDATE EXISTING PRODUCTS WITH IMAGE URLs
-- =========================================
-- This script updates existing products to include sample image filenames
-- You can replace these with actual image files in the images/ directory

USE ecommerce_db;

-- Update products with PNG image filenames
UPDATE products SET image_url = 'laptop.png' WHERE name = 'Laptop';
UPDATE products SET image_url = 'smartphone.png' WHERE name = 'Smartphone';
UPDATE products SET image_url = 'headphones.png' WHERE name = 'Headphones';
UPDATE products SET image_url = 'tshirt.png' WHERE name = 'T-Shirt';
UPDATE products SET image_url = 'jeans.png' WHERE name = 'Jeans';
UPDATE products SET image_url = 'shoes.png' WHERE name = 'Running Shoes';
UPDATE products SET image_url = 'mug.png' WHERE name = 'Coffee Mug';
UPDATE products SET image_url = 'book.png' WHERE name = 'Book - Programming';
UPDATE products SET image_url = 'backpack.png' WHERE name = 'Backpack';
UPDATE products SET image_url = 'bottle.png' WHERE name = 'Water Bottle';

-- Display updated products
SELECT id, name, price, image_url FROM products;

SELECT 'Product images updated successfully!' as Status;
SELECT 'Place actual image files in src/main/webapp/images/ directory' as Note;