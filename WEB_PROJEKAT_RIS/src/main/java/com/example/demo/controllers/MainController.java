package com.example.demo.controllers;

import jakarta.servlet.http.HttpSession;
import model.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.security.Generate_password;
import com.example.demo.services.PostService;
import com.example.demo.services.UserService;

@Controller
public class MainController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private PostService postService;
    
    @Autowired
    private Generate_password generatePassword;
    
    //otvara početni stranicu nakon uspešnog ulogovanja
    @GetMapping("/index")
    public String home(HttpSession session, Model model) {
    	//ako smo se izlogovali, restartuj ovu stranicu
        if (session.getAttribute("user") != null) {
            return "redirect:/posts";
        }
        User user = (User) session.getAttribute("user");
        
        //dobavlja iz baze sve postove i korisnike, da bi ih izlistao na ekran
        model.addAttribute("posts", postService.findAll());
        model.addAttribute("user", user);
        return "posts";
    }
    
    //otvara login stranicu
    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error,
                           @RequestParam(value = "logout", required = false) String logout,
                           HttpSession session,
                           Model model) {
        // Check for error from custom handler (if using CustomAuthenticationFailureHandler)
        String sessionError = (String) session.getAttribute("loginError");
        if (sessionError != null) {
            model.addAttribute("error", sessionError);
            session.removeAttribute("loginError");  // Clear after displaying
        } else if (error != null) {
            // Fallback to default error message
            model.addAttribute("error", "Invalid username or password. Please try again.");
        }
        
        if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully.");
        }
        return "login/login";
    }
    
    //otvara stranicu kada korisnik bez ADMIN privilegije pokušava da uđe na admin stranicu
    @GetMapping("/access-denied")
    public String deniedPage(Authentication authentication, Model model) {
    	User currentUser = getCurrentUser(authentication);
    	model.addAttribute("user", currentUser);
        return "access-denied";
    }
    
    
    //vraća stranicu za registrovanje novog korisnika
    @GetMapping("/register")
    public String registerPage() {
        return "login/register";
    }
    
    //pokreće se kada kliknemo na dugme "Register"
    @PostMapping("/register")
    public String register(@RequestParam String username,
                          @RequestParam String email,
                          @RequestParam String password,
                          Model model) {
        if (userService.findByUsername(username) != null) {
            model.addAttribute("error", "Username already exists");
            return "login/register";
        }
        
        //setujemo podatke o novom korisniku u bazu
        User user = new User();
        user.setClearance("USER");
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(generatePassword.encode(password));
        userService.save(user);
        
        model.addAttribute("success", "Registration successful. Please login.");
        return "redirect:/login";
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