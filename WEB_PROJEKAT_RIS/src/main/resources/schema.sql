-- Database Initialization Script
-- This file is automatically executed by Spring Boot on startup

CREATE TABLE IF NOT EXISTS id_users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    clearance VARCHAR(50) DEFAULT 'USER',
    profile_photo_path VARCHAR(255),
    blocked BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS id_posts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT NOT NULL,
    author_id BIGINT NOT NULL,
    image_path VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES id_users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS id_messages (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    sender_id BIGINT NOT NULL,
    receiver_id BIGINT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES id_users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES id_users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS id_friendships (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user1_id BIGINT NOT NULL,
    user2_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user1_id) REFERENCES id_users(id) ON DELETE CASCADE,
    FOREIGN KEY (user2_id) REFERENCES id_users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_friendship (user1_id, user2_id)
);

CREATE TABLE IF NOT EXISTS id_friend_requests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sender_id BIGINT NOT NULL,
    receiver_id BIGINT NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES id_users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES id_users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_request (sender_id, receiver_id)
);

CREATE TABLE IF NOT EXISTS id_likes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES id_users(id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES id_posts(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_post_like (user_id, post_id)
);

CREATE INDEX idx_posts_author ON id_posts(author_id);
CREATE INDEX idx_messages_sender ON id_messages(sender_id);
CREATE INDEX idx_messages_receiver ON id_messages(receiver_id);
CREATE INDEX idx_messages_read ON id_messages(is_read);
CREATE INDEX idx_friendships_user1 ON id_friendships(user1_id);
CREATE INDEX idx_friendships_user2 ON id_friendships(user2_id);
CREATE INDEX idx_friend_requests_sender ON id_friend_requests(sender_id);
CREATE INDEX idx_friend_requests_receiver ON id_friend_requests(receiver_id);
CREATE INDEX idx_likes_post ON id_likes(post_id);
CREATE INDEX idx_likes_user ON id_likes(user_id);

