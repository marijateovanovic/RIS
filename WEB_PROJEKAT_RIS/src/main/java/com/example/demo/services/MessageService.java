package com.example.demo.services;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repositories.MessageRepository;

import model.Message;
import model.User;

import java.sql.Timestamp;
import java.util.List;

@Service
public class MessageService {
    
    @Autowired
    private MessageRepository messageRepository;
    
    @Autowired
    private FriendshipService friendshipService;
    
    public List<Message> getConversation(User user1, User user2) {
    	return messageRepository.findConversationBetweenUsers(user1, user2);
    }
    
    public Message sendMessage(User sender, User receiver, String content) {
        if (!friendshipService.areFriends(sender, receiver)) {
            throw new RuntimeException("Can only message friends");
        }
        
        Message message = new Message();
        message.setIdUser1(sender);
        message.setIdUser2(receiver);
        message.setContent(content);
        message.setSentAt(new Timestamp(System.currentTimeMillis()));
        message.setRead(false); 
        
        return messageRepository.save(message);
    }
    
    public List<Message> getMessagesBySender(User user) {
        return messageRepository.findByIdUser1(user);
    }

    public List<Message> getMessagesByReceiver(User user) {
        return messageRepository.findByIdUser2(user);
    }

    public void deleteMessage(Long messageId) {
        messageRepository.deleteById(messageId);
    }
    
    public long getUnreadMessageCount(User user) {
        return messageRepository.countUnreadMessages(user);
    }
    
    public List<Message> getUnreadMessages(User user) {
        return messageRepository.findUnreadMessages(user);
    }
    
    public void markConversationAsRead(User currentUser, User otherUser) {
        List<Message> conversation = messageRepository.findConversationBetweenUsers(currentUser, otherUser);
        for (Message message : conversation) {
            // Only mark as read if current user is the receiver
            if (message.getIdUser2().getId() == currentUser.getId() && !message.isRead()) {
                message.setRead(true);
                messageRepository.save(message);
            }
        }
    }
    
    public void markMessageAsRead(Long messageId) {
        Message message = messageRepository.findById(messageId).orElse(null);
        if (message != null && !message.isRead()) {
            message.setRead(true);
            messageRepository.save(message);
        }
    }
}