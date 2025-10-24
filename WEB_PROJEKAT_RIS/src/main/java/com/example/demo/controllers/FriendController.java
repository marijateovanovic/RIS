package com.example.demo.controllers;

import model.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.services.FriendRequestService;
import com.example.demo.services.FriendshipService;
import com.example.demo.services.UserService;

@Controller
@RequestMapping("/friends") //sve mape će imati prefiks "/friends"
public class FriendController {
    
	//autowired se samo koristi da ne bih morao praviti konstruktor, već automatski instanciram Bean-ove
    @Autowired
    private FriendRequestService friendRequestService;
    
    @Autowired
    private FriendshipService friendshipService;
    
    @Autowired
    private UserService userService;
    
    //metod otvara stranicu friends iz foldera "friends"
    @GetMapping
    public String friendsPage(Authentication authentication, Model model) {
    	//proverava da li je korisnik USER ili ADMIN
    	User user = getCurrentUser(authentication);
        
    	//dobavlja sve userove (koji je definisan u redu iznad) podatke iz baze i setuje 
    	//ih u model atribute (zahteve, prijateljstva, ostale korisnike)
    	model.addAttribute("user", user);
        model.addAttribute("pendingRequests", friendRequestService.getPendingRequests(user));
        model.addAttribute("sentRequests", friendRequestService.getSentRequests(user));
        model.addAttribute("friends", friendshipService.getFriends(user));
        model.addAttribute("allUsers", userService.findAll().stream()
            .filter(u -> u.getId() != user.getId())
            .toList());
        
        return "friends/friends";
    }
    
    //metod se izvrši kada kliknemo na dugme "Send friend request" na friends stranici
    @PostMapping("/request/send")
    public String sendFriendRequest(@RequestParam Long receiverId, Authentication authentication,
            RedirectAttributes redirectAttributes) {
    	User sender = getCurrentUser(authentication);
        
    	//šalje poziv za prijateljstvo
        User receiver = userService.findById(receiverId);
        if (receiver != null) {
            friendRequestService.sendRequest(sender, receiver);
        }
        
        //ako korisnik kom je poslato više ne postoji, refrešaj stranicu i baci grešku
        if (receiver == null) {
            redirectAttributes.addFlashAttribute("error", "User not found");
            return "redirect:/friends"; //redirect:/ vraća mapu, a ne .jsp stranicu
        }
        
        friendRequestService.sendRequest(sender, receiver);
        redirectAttributes.addFlashAttribute("success", "Friend request sent successfully");
                
        return "redirect:/friends"; //redirect:/ vraća mapu, a ne .jsp stranicu
    }
    
    //metod se pokreće kada prihvatimo nečiji poziv za prijateljstvo
    @PostMapping("/request/accept/{id}")
    public String acceptFriendRequest(@PathVariable Long id, Authentication authentication) {
    	User user = getCurrentUser(authentication);
        
        friendRequestService.acceptRequest(id);
        return "redirect:/friends";
    }
    
  //metod se pokreće kada odbijemo nečiji poziv za prijateljstvo
    @PostMapping("/request/reject/{id}")
    public String rejectFriendRequest(@PathVariable Long id, Authentication authentication) {
    	User user = getCurrentUser(authentication);
        
        friendRequestService.rejectRequest(id);
        return "redirect:/friends";
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