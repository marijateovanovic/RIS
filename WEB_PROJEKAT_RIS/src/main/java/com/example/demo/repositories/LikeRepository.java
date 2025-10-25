package com.example.demo.repositories;

import model.Like;
import model.Post;
import model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface LikeRepository extends JpaRepository<Like, Long> {
    
    // Find all likes for a specific post
    List<Like> findByPost(Post post);
    
    // Count likes for a specific post
    long countByPost(Post post);
    
    // Check if a user already liked a post
    @Query("SELECT l FROM Like l WHERE l.user = :user AND l.post = :post")
    Optional<Like> findByUserAndPost(@Param("user") User user, @Param("post") Post post);
    
    // Check if user liked a post (boolean)
    boolean existsByUserAndPost(User user, Post post);
    
    // Find all likes by a user
    List<Like> findByUser(User user);
    
    void deleteByUserAndPost(User user, Post post);
}

