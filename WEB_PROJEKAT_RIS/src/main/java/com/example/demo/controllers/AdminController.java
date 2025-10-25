package com.example.demo.controllers;

import model.User;
import model.FriendRequest;
import model.Friendship;
import model.Message;
import model.Post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.services.UserService;
import com.example.demo.services.FriendRequestService;
import com.example.demo.services.FriendshipService;
import com.example.demo.services.MessageService;
import com.example.demo.services.PostService;

import java.util.List;


@Controller
@RequestMapping("/admin") //sve mape će imati prefiks "/admin"
public class AdminController {
    
	//autowired se samo koristi da ne bih morao praviti konstruktor, već automatski instanciram Bean-ove
    @Autowired
    private UserService userService;
    
    @Autowired
    private FriendRequestService friendRequestService;
    
    @Autowired
    private FriendshipService friendshipService;
    
    @Autowired
    private MessageService messageService;
    
    @Autowired
    private PostService postService;
    
  //metod vraća .jsp stranicu users.jsp iz foldera admin
    @GetMapping("/users")
    public String adminUsersPage(Authentication authentication, Model model) {
        User currentUser = getCurrentUser(authentication);
        
        
        //dobavlja sve usere iz baze i setuje ih u model atribute
        List<User> allUsers = userService.findAll();
        model.addAttribute("user", currentUser);
        model.addAttribute("users", allUsers);
        model.addAttribute("currentUser", currentUser);
        
        return "admin/users"; 
    }
    
    //kada kliknemo dugme obriši na admin stranici, pokrenuće se ovaj metod
    @PostMapping("/users/delete/{userId}")
    public String deleteUser(@PathVariable Long userId, 
                           Authentication authentication,
                           RedirectAttributes redirectAttributes) {
        User currentUser = getCurrentUser(authentication);
        
        
        
        // Sprečava admina da obriše samog sebe
        if (currentUser.getId() == userId) {
            redirectAttributes.addFlashAttribute("error", "You cannot delete your own account!");
            return "redirect:/admin/users";
        }
        
        try {
            User userToDelete = userService.findById(userId);
            if (userToDelete != null) {
                // Briše sve veze korisnika pre nego što obriše samog korisnika (metod definisan ispod ovog metoda)
                deleteUserRelationships(userToDelete);
                
                // Briše korisnika
                userService.deleteUser(userId);
                
                redirectAttributes.addFlashAttribute("success", 
                    "User '" + userToDelete.getUsername() + "' has been deleted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "User not found!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "Error deleting user: " + e.getMessage());
            e.printStackTrace(); // Log the error for debugging
        }
        
        return "redirect:/admin/users";
    }
    
    //kada kliknemo dugme "Make Admin", pokrenuće se ovaj metod
    @PostMapping("/users/make-admin/{userId}")
    public String makeUserAdmin(@PathVariable Long userId, 
                               Authentication authentication,
                               RedirectAttributes redirectAttributes) {
        User currentUser = getCurrentUser(authentication);
        
        try {
            User userToPromote = userService.findById(userId);
            if (userToPromote != null) {
                // Proverava da li je korisnik već admin
                if ("ADMIN".equals(userToPromote.getClearance())) {
                    redirectAttributes.addFlashAttribute("error", 
                        "User '" + userToPromote.getUsername() + "' is already an admin!");
                    return "redirect:/admin/users";
                }
                
                // Postavlja clearance na ADMIN
                userToPromote.setClearance("ADMIN");
                userService.save(userToPromote);
                
                redirectAttributes.addFlashAttribute("success", 
                    "User '" + userToPromote.getUsername() + "' has been promoted to admin!");
            } else {
                redirectAttributes.addFlashAttribute("error", "User not found!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "Error promoting user: " + e.getMessage());
            e.printStackTrace(); // Log the error for debugging
        }
        
        return "redirect:/admin/users";
    }
    
    //kada kliknemo dugme "Block", pokrenuće se ovaj metod
    @PostMapping("/users/block/{userId}")
    public String blockUser(@PathVariable Long userId, 
                           Authentication authentication,
                           RedirectAttributes redirectAttributes) {
        User currentUser = getCurrentUser(authentication);
        
        // Sprečava admina da blokira samog sebe
        if (currentUser.getId() == userId) {
            redirectAttributes.addFlashAttribute("error", "You cannot block yourself!");
            return "redirect:/admin/users";
        }
        
        try {
            User userToBlock = userService.findById(userId);
            if (userToBlock != null) {
                // Proverava da li je korisnik već blokiran
                if (userToBlock.isBlocked()) {
                    redirectAttributes.addFlashAttribute("error", 
                        "User '" + userToBlock.getUsername() + "' is already blocked!");
                    return "redirect:/admin/users";
                }
                
                // Blokira korisnika
                userToBlock.setBlocked(true);
                userService.save(userToBlock);
                
                redirectAttributes.addFlashAttribute("success", 
                    "User '" + userToBlock.getUsername() + "' has been blocked successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "User not found!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "Error blocking user: " + e.getMessage());
            e.printStackTrace(); // Log the error for debugging
        }
        
        return "redirect:/admin/users";
    }
    
    //kada kliknemo dugme "Unblock", pokrenuće se ovaj metod
    @PostMapping("/users/unblock/{userId}")
    public String unblockUser(@PathVariable Long userId, 
                             Authentication authentication,
                             RedirectAttributes redirectAttributes) {
        try {
            User userToUnblock = userService.findById(userId);
            if (userToUnblock != null) {
                // Proverava da li je korisnik blokiran
                if (!userToUnblock.isBlocked()) {
                    redirectAttributes.addFlashAttribute("error", 
                        "User '" + userToUnblock.getUsername() + "' is not blocked!");
                    return "redirect:/admin/users";
                }
                
                // Odblokira korisnika
                userToUnblock.setBlocked(false);
                userService.save(userToUnblock);
                
                redirectAttributes.addFlashAttribute("success", 
                    "User '" + userToUnblock.getUsername() + "' has been unblocked successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "User not found!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "Error unblocking user: " + e.getMessage());
            e.printStackTrace(); // Log the error for debugging
        }
        
        return "redirect:/admin/users";
    }
    
    /**
     * Briše sve veze korisnika pre nego što obriše samog korisnika
     */
    private void deleteUserRelationships(User user) {
        Long userId = user.getId();
        
        // 1. Delete friend requests where user is sender (idUser1)
        List<FriendRequest> sentRequests = friendRequestService.getSentRequests(user);
        for (FriendRequest request : sentRequests) {
            friendRequestService.deleteRequest(request.getId());
        }
        
        // 2. Delete friend requests where user is receiver (idUser2)
        List<FriendRequest> receivedRequests = friendRequestService.getReceivedRequests(user);
        for (FriendRequest request : receivedRequests) {
            friendRequestService.deleteRequest(request.getId());
        }
        
        // 3. Delete friendships where user is user1
        List<Friendship> friendshipsAsUser1 = friendshipService.getFriendshipsAsUser1(user);
        for (Friendship friendship : friendshipsAsUser1) {
            friendshipService.deleteFriendship(friendship.getId());
        }
        
        // 4. Delete friendships where user is user2
        List<Friendship> friendshipsAsUser2 = friendshipService.getFriendshipsAsUser2(user);
        for (Friendship friendship : friendshipsAsUser2) {
            friendshipService.deleteFriendship(friendship.getId());
        }
        
        // 5. Delete messages where user is sender (idUser1)
        List<Message> sentMessages = messageService.getMessagesBySender(user);
        for (Message message : sentMessages) {
            messageService.deleteMessage(message.getId());
        }
        
        // 6. Delete messages where user is receiver (idUser2)
        List<Message> receivedMessages = messageService.getMessagesByReceiver(user);
        for (Message message : receivedMessages) {
            messageService.deleteMessage(message.getId());
        }
        
        // 7. Delete user's posts
        List<Post> userPosts = postService.findByUser(user);
        for (Post post : userPosts) {
            postService.deletePost(post.getId());
        }
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