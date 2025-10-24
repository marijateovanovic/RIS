package com.example.demo.repositories;

import model.Friendship;
import model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface FriendshipRepository extends JpaRepository<Friendship, Long> {
    List<Friendship> findByIdUser1OrIdUser2(User user1, User user2);
    Friendship findByIdUser1AndIdUser2(User user1, User user2);
    boolean existsByIdUser1AndIdUser2(User user1, User user2);
    List<Friendship> findByIdUser1(User user);
    List<Friendship> findByIdUser2(User user);
}