package com.example.demo.security;


import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class Generate_password {
	
	private BCryptPasswordEncoder bcryptEncoder = new BCryptPasswordEncoder();
	
	public String encode(String password) {
		return bcryptEncoder.encode(password);
	}
	
	public boolean matches(String plainPassword, String hashedPassword) {
        return bcryptEncoder.matches(plainPassword, hashedPassword);
    }
	
}