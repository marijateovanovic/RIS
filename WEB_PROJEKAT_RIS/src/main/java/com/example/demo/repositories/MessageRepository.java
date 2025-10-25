package com.example.demo.repositories;

import model.Message;
import model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {
    List<Message> findByIdUser1AndIdUser2OrIdUser2AndIdUser1OrderBySentAt(
        User user1, User user2, User user2_2, User user1_2);
    
    @Query("SELECT m FROM Message m WHERE (m.idUser1 = :user1 AND m.idUser2 = :user2) OR (m.idUser1 = :user2 AND m.idUser2 = :user1) ORDER BY m.sentAt ASC")
    List<Message> findConversationBetweenUsers(@Param("user1") User user1, @Param("user2") User user2);
    
    List<Message> findByIdUser1(User user);
    List<Message> findByIdUser2(User user);
    
    // Count unread messages for a user (where they are the receiver)
    @Query("SELECT COUNT(m) FROM Message m WHERE m.idUser2 = :user AND m.isRead = false")
    long countUnreadMessages(@Param("user") User user);
    
    // Find unread messages for a user
    @Query("SELECT m FROM Message m WHERE m.idUser2 = :user AND m.isRead = false ORDER BY m.sentAt DESC")
    List<Message> findUnreadMessages(@Param("user") User user);
}