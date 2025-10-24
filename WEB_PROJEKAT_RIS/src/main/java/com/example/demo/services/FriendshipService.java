package com.example.demo.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repositories.FriendshipRepository;

import model.Friendship;
import model.User;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class FriendshipService {
    
    @Autowired
    private FriendshipRepository friendshipRepository;
    
    public void createFriendship(User user1, User user2) {
        if (!friendshipRepository.existsByIdUser1AndIdUser2(user1, user2) && 
            !friendshipRepository.existsByIdUser1AndIdUser2(user2, user1)) {
            Friendship friendship = new Friendship();
            friendship.setIdUser1(user1);
            friendship.setIdUser2(user2);
            friendshipRepository.save(friendship);
        }
    }
    
    public List<User> getFriends(User user) {
        List<Friendship> friendships = friendshipRepository.findByIdUser1OrIdUser2(user, user);
        return friendships.stream()
            .map(f -> f.getIdUser1().equals(user) ? f.getIdUser2() : f.getIdUser1())
            .collect(Collectors.toList());
    }
    
    public boolean areFriends(User user1, User user2) {
        return friendshipRepository.existsByIdUser1AndIdUser2(user1, user2) || 
               friendshipRepository.existsByIdUser1AndIdUser2(user2, user1);
    }
    
    public List<Friendship> getFriendshipsAsUser1(User user) {
        return friendshipRepository.findByIdUser1(user);
    }

    public List<Friendship> getFriendshipsAsUser2(User user) {
        return friendshipRepository.findByIdUser2(user);
    }

    public void deleteFriendship(Long friendshipId) {
        friendshipRepository.deleteById(friendshipId);
    }
}