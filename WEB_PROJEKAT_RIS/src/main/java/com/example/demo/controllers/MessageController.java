package com.example.demo.controllers;

import jakarta.servlet.http.HttpSession;
import model.Message;
import model.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.demo.services.FriendshipService;
import com.example.demo.services.MessageService;
import com.example.demo.services.UserService;

import java.util.List;

@Controller
@RequestMapping("/messages") //sve mape će imati prefiks "/messages"
public class MessageController {
    
	//autowired se samo koristi da ne bih morao praviti konstruktor, već automatski instanciram Bean-ove
	
    @Autowired
    private MessageService messageService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private FriendshipService friendshipService;
    
    //prikazuje .jsp stranicu sa porukama
    @GetMapping
    public String messagesPage(Authentication authentication, Model model) {
    	User user = getCurrentUser(authentication);
        
    	model.addAttribute("user", user);
        model.addAttribute("friends", friendshipService.getFriends(user));
        return "friends/messages";
    }
    
    //prikazuje stranicu četa sa korisnikom čiji je id {friendId}
    @GetMapping("/conversation/{friendId}")
    public String conversation(@PathVariable Long friendId, Authentication authentication, Model model) {
    	User user = getCurrentUser(authentication);
        
    	//ako prijatelj više ne postoji ili više nije prijatelj sa trenutnim korisnikom, refrešaj stranicu
        User friend = userService.findById(friendId);
        if (friend == null || !friendshipService.areFriends(user, friend)) {
            return "redirect:/messages";
        }
        
        //izlistava sve poruke na ekran
        List<Message> conversation = messageService.getConversation(user, friend);
        
        // Mark all messages in this conversation as read
        messageService.markConversationAsRead(user, friend);
        
        model.addAttribute("user", user);
        model.addAttribute("conversation", conversation);
        model.addAttribute("friend", friend);
        model.addAttribute("friends", friendshipService.getFriends(user));
        
        return "friends/conversation";
    }
    
    //šalje poruku prijatelju kada kliknemo na dugme send
    @PostMapping("/send")
    public String sendMessage(@RequestParam Long receiverId, 
                             @RequestParam String content, 
                             Authentication authentication) {
    	User sender = getCurrentUser(authentication);
        
    	//provera da li prijatelj i da li poruka nije prazna
        User receiver = userService.findById(receiverId);
        if (receiver != null && !content.trim().isEmpty()) {
            messageService.sendMessage(sender, receiver, content.trim());
        }
        
        return "redirect:/messages/conversation/" + receiverId;
    }
    
    // API endpoint to get unread message count (for AJAX polling)
    @GetMapping("/unread-count")
    @ResponseBody
    public long getUnreadCount(Authentication authentication) {
        User user = getCurrentUser(authentication);
        if (user == null) {
            return 0;
        }
        return messageService.getUnreadMessageCount(user);
    }
    
    // Dobavalja informacije o trenutno ulogovanom korisniku (ime, id, poruke, prijatelje, postove, da li je USER ili ADMIN)
    private User getCurrentUser(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }
        String username = authentication.getName();
        return userService.findByUsername(username);
    }
}