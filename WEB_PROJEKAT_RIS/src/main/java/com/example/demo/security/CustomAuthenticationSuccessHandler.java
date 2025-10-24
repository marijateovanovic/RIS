package com.example.demo.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, 
                                       HttpServletResponse response,
                                       Authentication authentication) 
                                       throws IOException, ServletException {
        
        request.getSession().setAttribute("loginSuccess", "Welcome back, " + authentication.getName() + "!");
        
        if (authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"))) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } else {
            response.sendRedirect(request.getContextPath() + "/posts");
        }
    }
}
