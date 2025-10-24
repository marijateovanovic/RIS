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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.services.PostService;
import com.example.demo.services.UserService;

@Controller
public class PostController {
    
	//autowired se samo koristi da ne bih morao praviti konstruktor, već automatski instanciram Bean-ove
	
    @Autowired
    private PostService postService;
    
    @Autowired
    private UserService userService;
    
    //prikazuje stranicu koja izlistava sve postove na ekran
    @GetMapping("/posts")
    public String listPosts(Authentication authentication, Model model) {
        // Get current user from Spring Security
        User user = getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }
        
        //izlistava postove
        model.addAttribute("posts", postService.findAll());
        model.addAttribute("user", user);
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
        model.addAttribute("posts", postService.findByUser(user.getId()));
        model.addAttribute("user", user);
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
    public String savePost(@ModelAttribute Post post, Authentication authentication, RedirectAttributes redirectAttributes) {
        // Get current user from Spring Security
    	User user = getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }
        
        try {
            
            
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
    
    
    //pokreće se kad kliknemo na "delete post"
    @GetMapping("/posts/delete/{id}")
    public String deletePost(@PathVariable Long id, Authentication authentication) {
        // Get current user from Spring Security
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
    
    // Dobavalja informacije o trenutno ulogovanom korisniku (ime, id, poruke, prijatelje, postove, da li je USER ili ADMIN)    
    private User getCurrentUser(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }
        String username = authentication.getName();
        return userService.findByUsername(username);
    }
}