package com.example.demo.repositories;

import model.FriendRequest;
import model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface FriendRequestRepository extends JpaRepository<FriendRequest, Long> {
    List<FriendRequest> findByIdUser2AndStatus(User receiver, String status);
    FriendRequest findByIdUser1AndIdUser2(User sender, User receiver);
    List<FriendRequest> findByIdUser1OrIdUser2(User user1, User user2);
    List<FriendRequest> findByIdUser1(User user);
    List<FriendRequest> findByIdUser2(User user);
}