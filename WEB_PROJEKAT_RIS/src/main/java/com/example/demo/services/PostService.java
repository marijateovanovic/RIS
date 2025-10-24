package com.example.demo.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repositories.PostRepository;

import model.Post;
import model.User;

import java.sql.Timestamp;
import java.util.List;

@Service
public class PostService {
    
    @Autowired
    private PostRepository postRepository;
    
    public List<Post> findAll() {
        return postRepository.findAllByOrderByCreatedAtDesc();
    }
    
    public List<Post> findByUser(Long userId) {
        return postRepository.findByIdUser_IdOrderByCreatedAtDesc(userId);
    }
    
    public Post findById(Long id) {
        return postRepository.findById(id).orElse(null);
    }
    
    public Post save(Post post) {
        if (post.getCreatedAt() == null) {
            post.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        }
        return postRepository.save(post);
    }
    
    public void delete(Long id) {
        postRepository.deleteById(id);
    }
    
    public List<Post> findByUser(User user) {
        return postRepository.findByIdUser(user);
    }

    public void deletePost(Long postId) {
        postRepository.deleteById(postId);
    }
}