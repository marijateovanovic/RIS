package com.example.demo.security;

import java.io.IOException;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, 
                                       HttpServletResponse response,
                                       AuthenticationException exception) 
                                       throws IOException, ServletException {
        
        String errorMessage = "Invalid username or password";
        
        // Customize error message based on exception type
        if (exception instanceof LockedException) {
            errorMessage = exception.getMessage();
        } else if (exception.getCause() instanceof LockedException) {
            errorMessage = exception.getCause().getMessage();
        } else if (exception instanceof UsernameNotFoundException) {
            errorMessage = "User not found. Please check your username or email.";
        } else if (exception instanceof BadCredentialsException) {
            errorMessage = "Incorrect password. Please try again.";
        } else if (exception instanceof DisabledException) {
            errorMessage = "Your account has been disabled. Contact support.";
        }
        
        request.getSession().setAttribute("loginError", errorMessage);
        response.sendRedirect(request.getContextPath() + "/login?error=true");
    }
}

