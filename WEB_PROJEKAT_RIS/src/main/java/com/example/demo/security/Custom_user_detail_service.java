package com.example.demo.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.demo.repositories.UserRepository;

import model.User;

@Service
public class Custom_user_detail_service implements UserDetailsService {

	@Autowired
	private UserRepository user_repository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("=== Attempting login with: " + username);
		
		User user = user_repository.findByUsername(username);
		
		if (user == null) {
			user = user_repository.findByEmail(username);
		}
		
		if (user == null) {
			throw new UsernameNotFoundException("User not found with username or email: " + username);
		}
		
		return new Custom_user_details(user);
	}
}
