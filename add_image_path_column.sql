ALTER TABLE id_posts 
ADD COLUMN image_path VARCHAR(255) NULL
COMMENT 'Stores the relative path to uploaded post images (e.g., /uploads/posts/filename.jpg)';

DESCRIBE id_posts;

