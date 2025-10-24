package com.example.demo.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repositories.FriendRequestRepository;

import model.FriendRequest;
import model.User;

import java.sql.Timestamp;
import java.util.List;

@Service
public class FriendRequestService {
    
    @Autowired
    private FriendRequestRepository friendRequestRepository;
    
    @Autowired
    private FriendshipService friendshipService;
    
    public List<FriendRequest> getPendingRequests(User receiver) {
        return friendRequestRepository.findByIdUser2AndStatus(receiver, "PENDING");
    }
    
    public FriendRequest sendRequest(User sender, User receiver) {
        FriendRequest existing = friendRequestRepository.findByIdUser1AndIdUser2(sender, receiver);
        if (existing != null) {
            return existing;
        }
        
        FriendRequest request = new FriendRequest();
        request.setIdUser1(sender);
        request.setIdUser2(receiver);
        request.setStatus("PENDING");
        request.setSentAt(new Timestamp(System.currentTimeMillis()));
        
        return friendRequestRepository.save(request);
    }
    
    public void acceptRequest(Long requestId) {
        FriendRequest request = friendRequestRepository.findById(requestId).orElse(null);
        if (request != null) {
            request.setStatus("ACCEPTED");
            friendRequestRepository.save(request);
            friendshipService.createFriendship(request.getIdUser1(), request.getIdUser2());
        }
    }
    
    public void rejectRequest(Long requestId) {
        FriendRequest request = friendRequestRepository.findById(requestId).orElse(null);
        if (request != null) {
            request.setStatus("REJECTED");
            friendRequestRepository.save(request);
        }
    }
    
    public FriendRequest findById(Long id) {
        return friendRequestRepository.findById(id).orElse(null);
    }
    
    public List<FriendRequest> getSentRequests(User user) {
        return friendRequestRepository.findByIdUser1(user);
    }

    public List<FriendRequest> getReceivedRequests(User user) {
        return friendRequestRepository.findByIdUser2(user);
    }

    public void deleteRequest(Long requestId) {
        friendRequestRepository.deleteById(requestId);
    }
}