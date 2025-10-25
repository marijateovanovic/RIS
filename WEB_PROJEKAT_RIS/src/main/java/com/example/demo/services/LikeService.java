package com.example.demo.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.repositories.LikeRepository;
import com.example.demo.repositories.PostRepository;

import model.Like;
import model.Post;
import model.User;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class LikeService {
    
    @Autowired
    private LikeRepository likeRepository;
    
    @Autowired
    private PostRepository postRepository;
    
    // Toggle like: if user already liked, unlike; otherwise, like
    @Transactional
    public boolean toggleLike(User user, Long postId) {
        Post post = postRepository.findById(postId).orElse(null);
        if (post == null) {
            return false;
        }
        
        Optional<Like> existingLike = likeRepository.findByUserAndPost(user, post);
        
        if (existingLike.isPresent()) {
            // Unlike: remove the like
            likeRepository.delete(existingLike.get());
            return false; // Returns false indicating unliked
        } else {
            // Like: create new like
            Like like = new Like();
            like.setUser(user);
            like.setPost(post);
            like.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            likeRepository.save(like);
            return true; // Returns true indicating liked
        }
    }
    
    public long getLikeCount(Post post) {
        return likeRepository.countByPost(post);
    }
    
    public boolean hasUserLikedPost(User user, Post post) {
        return likeRepository.existsByUserAndPost(user, post);
    }
    
    public Map<Long, Long> getLikeCounts(List<Post> posts) {
        Map<Long, Long> likeCounts = new HashMap<>();
        for (Post post : posts) {
            likeCounts.put(post.getId(), likeRepository.countByPost(post));
        }
        return likeCounts;
    }
    
    public Map<Long, Boolean> getUserLikes(User user, List<Post> posts) {
        Map<Long, Boolean> userLikes = new HashMap<>();
        for (Post post : posts) {
            userLikes.put(post.getId(), likeRepository.existsByUserAndPost(user, post));
        }
        return userLikes;
    }
    
    public List<User> getUsersWhoLikedPost(Post post) {
        List<Like> likes = likeRepository.findByPost(post);
        List<User> users = new java.util.ArrayList<>();
        for (Like like : likes) {
            users.add(like.getUser());
        }
        return users;
    }
}

