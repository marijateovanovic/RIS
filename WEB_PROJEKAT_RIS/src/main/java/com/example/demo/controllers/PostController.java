package com.example.demo.controllers;

import model.Post;
import model.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.services.PostService;
import com.example.demo.services.UserService;
import com.example.demo.services.LikeService;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
public class PostController {
    
	//autowired se samo koristi da ne bih morao praviti konstruktor, već automatski instanciram Bean-ove
	
    @Autowired
    private PostService postService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private LikeService likeService;
    
    //prikazuje stranicu koja izlistava sve postove na ekran
    @GetMapping("/posts")
    public String listPosts(Authentication authentication, Model model) {
        // Get current user from Spring Security
        User user = getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }
        
        //izlistava postove
        List<Post> posts = postService.findAll();
        model.addAttribute("posts", posts);
        model.addAttribute("user", user);
        
        model.addAttribute("likeCounts", likeService.getLikeCounts(posts));
        model.addAttribute("userLikes", likeService.getUserLikes(user, posts));
        
        return "posts";
    }
    
    //izlistava samo postove trenutno ulogovanog korisnika na stranici my-posts iz foldera posts
    @GetMapping("/posts/my")
    public String myPosts(Authentication authentication, Model model) {
        // Get current user from Spring Security
        User user = getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }
        
      //izlistava postove
        List<Post> posts = postService.findByUser(user.getId());
        model.addAttribute("posts", posts);
        model.addAttribute("user", user);
        
        // Add like counts and user likes to model
        model.addAttribute("likeCounts", likeService.getLikeCounts(posts));
        model.addAttribute("userLikes", likeService.getUserLikes(user, posts));
        
        return "posts/my-posts";
    }
    
    //otvara stranicu za kreiranje novog posta
    @GetMapping("/posts/new")
    public String newPostForm(Authentication authentication, Model model) {
        // Get current user from Spring Security
        User user = getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("post", new Post());
        model.addAttribute("user", user);
        return "posts/post-form";
    }
    
    //pokreće se kad kliknemo na dugme "Kreiraj" na stranici za pravljenje novog posta
    @PostMapping("/posts/save")
    public String savePost(@ModelAttribute Post post, 
                          @RequestParam(value = "image", required = false) MultipartFile image,
                          @RequestParam(value = "removeImage", required = false, defaultValue = "false") String removeImage,
                          Authentication authentication, 
                          RedirectAttributes redirectAttributes) {
        // Get current user from Spring Security
    	User user = getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }
        
        try {
            if (image != null && !image.isEmpty()) {
                try {
                    String imagePath = saveImageLocally(image);
                    post.setImagePath(imagePath);
                } catch (IOException e) {
                    System.err.println("Error saving image: " + e.getMessage());
                    redirectAttributes.addFlashAttribute("error", "Failed to save image. Post saved without image.");
                }
            } else if ("true".equals(removeImage)) {
                post.setImagePath(null);
            } else if (post.getId() != 0) {
                Post existingPost = postService.findById(post.getId());
                if (existingPost != null && existingPost.getImagePath() != null) {
                    post.setImagePath(existingPost.getImagePath());
                    System.out.println("Preserving existing image: " + existingPost.getImagePath());
                }
            }
            
            post.setIdUser(user);
            Post savedPost = postService.save(post);
            
            
            if (post.getId() == 0) { // Use == for primitive long comparison
                redirectAttributes.addFlashAttribute("success", "Post created successfully!");
            } else {
                redirectAttributes.addFlashAttribute("success", "Post updated successfully!");
            }
            
            return "redirect:/posts/my";
        } catch (Exception e) {
            System.out.println("ERROR saving post: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error saving post: " + e.getMessage());
            return "redirect:/posts/my";
        }
    }
    
    private String saveImageLocally(MultipartFile image) throws IOException {
        String originalFilename = image.getOriginalFilename();
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String uniqueFilename = UUID.randomUUID().toString() + extension;
        
         String sourceUploadDir = "src/main/resources/static/uploads/posts/";
        File sourceDirectory = new File(sourceUploadDir);
        if (!sourceDirectory.exists()) {
            sourceDirectory.mkdirs();
        }
        Path sourceFilePath = Paths.get(sourceUploadDir + uniqueFilename);
        Files.copy(image.getInputStream(), sourceFilePath, StandardCopyOption.REPLACE_EXISTING);
        
        String targetUploadDir = "target/classes/static/uploads/posts/";
        File targetDirectory = new File(targetUploadDir);
        if (!targetDirectory.exists()) {
            targetDirectory.mkdirs();
        }
        Path targetFilePath = Paths.get(targetUploadDir + uniqueFilename);
        Files.copy(Files.newInputStream(sourceFilePath), targetFilePath, StandardCopyOption.REPLACE_EXISTING);
        
        return "/uploads/posts/" + uniqueFilename;
    }
    
    //isto funkcioniše kao i newPostForm metod koji je gore definisan, samo se ovaj poziva kad kliknemo na edit post
    @GetMapping("/posts/edit/{id}")
    public String editPostForm(@PathVariable Long id, Authentication authentication, Model model) {
    	User user = getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }
        
        Post post = postService.findById(id);
        if (post == null || post.getIdUser().getId() != user.getId()) { // Use != for primitive long
            return "redirect:/posts/my";
        }
        
        model.addAttribute("post", post);
        model.addAttribute("user", user);
        return "posts/post-form";
    }
    

    @GetMapping("/posts/delete/{id}")
    public String deletePost(@PathVariable Long id, Authentication authentication) {
        User user = getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }
        
        //pronalazi u bazi post koji hoćemo da obrišemo
        Post post = postService.findById(id);
        if (post != null && post.getIdUser().getId() == user.getId()) { // ako postoji obriši ga
            postService.delete(id);
        }
        
        return "redirect:/posts/my"; //refrešaj stranicu na kojoj se trenutno nalazimo
    }
    
    // Toggle like/unlike on a post (AJAX endpoint)
    @PostMapping("/posts/like/{postId}")
    @org.springframework.web.bind.annotation.ResponseBody
    public Map<String, Object> toggleLike(@PathVariable Long postId, Authentication authentication) {
        Map<String, Object> response = new HashMap<>();
        
        User user = getCurrentUser(authentication);
        if (user == null) {
            response.put("success", false);
            response.put("message", "Not authenticated");
            return response;
        }
        
        try {
            boolean liked = likeService.toggleLike(user, postId);
            Post post = postService.findById(postId);
            long likeCount = likeService.getLikeCount(post);
            
            response.put("success", true);
            response.put("liked", liked);
            response.put("likeCount", likeCount);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error toggling like: " + e.getMessage());
        }
        
        return response;
    }
    
    // Get list of users who liked a post (AJAX endpoint for modal)
    @GetMapping("/posts/likes/{postId}")
    @org.springframework.web.bind.annotation.ResponseBody
    public Map<String, Object> getUsersWhoLiked(@PathVariable Long postId, Authentication authentication) {
        Map<String, Object> response = new HashMap<>();
        
        User user = getCurrentUser(authentication);
        if (user == null) {
            response.put("success", false);
            response.put("message", "Not authenticated");
            return response;
        }
        
        try {
            Post post = postService.findById(postId);
            if (post == null) {
                response.put("success", false);
                response.put("message", "Post not found");
                return response;
            }
            
            List<User> usersWhoLiked = likeService.getUsersWhoLikedPost(post);
            List<String> usernames = new java.util.ArrayList<>();
            for (User u : usersWhoLiked) {
                usernames.add(u.getUsername());
            }
            
            response.put("success", true);
            response.put("users", usernames);
            response.put("count", usernames.size());
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error fetching users: " + e.getMessage());
        }
        
        return response;
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