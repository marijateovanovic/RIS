package com.example.demo.controllers;

import model.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.services.UserService;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Controller
@RequestMapping("/profile")
public class ProfileController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    // View profile page
    @GetMapping
    public String viewProfile(Authentication authentication, Model model) {
        User user = getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("user", user);
        return "profile/profile";
    }
    
    // Update profile information
    @PostMapping("/update")
    public String updateProfile(
            @RequestParam(required = false) String email,
            @RequestParam(value = "profilePhoto", required = false) MultipartFile profilePhoto,
            @RequestParam(value = "removePhoto", required = false, defaultValue = "false") String removePhoto,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {
        
        User user = getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }
        
        try {
            // Update email if provided and different
            if (email != null && !email.trim().isEmpty() && !email.equals(user.getEmail())) {
                user.setEmail(email.trim());
            }
            
            // Handle profile photo upload
            if (profilePhoto != null && !profilePhoto.isEmpty()) {
                String photoPath = saveProfilePhoto(profilePhoto, user.getId());
                user.setProfilePhotoPath(photoPath);
            } else if ("true".equals(removePhoto)) {
                // Remove existing photo
                user.setProfilePhotoPath(null);
            }
            
            userService.save(user);
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error updating profile: " + e.getMessage());
        }
        
        return "redirect:/profile";
    }
    
    // Change password
    @PostMapping("/change-password")
    public String changePassword(
            @RequestParam String currentPassword,
            @RequestParam String newPassword,
            @RequestParam String confirmPassword,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {
        
        User user = getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }
        
        try {
            // Verify current password
            if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
                redirectAttributes.addFlashAttribute("error", "Current password is incorrect");
                return "redirect:/profile";
            }
            
            // Verify new passwords match
            if (!newPassword.equals(confirmPassword)) {
                redirectAttributes.addFlashAttribute("error", "New passwords do not match");
                return "redirect:/profile";
            }
            
            // Validate new password length
            if (newPassword.length() < 6) {
                redirectAttributes.addFlashAttribute("error", "Password must be at least 6 characters");
                return "redirect:/profile";
            }
            
            // Update password
            user.setPassword(passwordEncoder.encode(newPassword));
            userService.save(user);
            
            redirectAttributes.addFlashAttribute("success", "Password changed successfully!");
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error changing password: " + e.getMessage());
        }
        
        return "redirect:/profile";
    }
    
    // Save profile photo to local storage
    private String saveProfilePhoto(MultipartFile file, long userId) throws IOException {
        // Generate unique filename
        String originalFilename = file.getOriginalFilename();
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String filename = "profile_" + userId + "_" + UUID.randomUUID().toString() + extension;
        
        // Save to both src and target directories
        String uploadDir = "uploads/profiles/";
        
        // Save to src/main/resources/static
        Path srcPath = Paths.get("src/main/resources/static/" + uploadDir);
        Files.createDirectories(srcPath);
        Path srcFilePath = srcPath.resolve(filename);
        Files.copy(file.getInputStream(), srcFilePath, StandardCopyOption.REPLACE_EXISTING);
        
        // Save to target/classes/static
        Path targetPath = Paths.get("target/classes/static/" + uploadDir);
        Files.createDirectories(targetPath);
        Path targetFilePath = targetPath.resolve(filename);
        Files.copy(file.getInputStream(), targetFilePath, StandardCopyOption.REPLACE_EXISTING);
        
        return "/" + uploadDir + filename;
    }
    
    // Get current authenticated user
    private User getCurrentUser(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }
        String username = authentication.getName();
        return userService.findByUsername(username);
    }
}

