package com.example.demo.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.LockedException;
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
		User user = user_repository.findByUsername(username);
		
		if (user == null) {
			user = user_repository.findByEmail(username);
		}
		
		if (user == null) {
			throw new UsernameNotFoundException("User not found with username or email: " + username);
		}
		
		// Check if user is blocked
		if (user.isBlocked()) {
			throw new LockedException("Your account has been blocked. Please contact the administrator.");
		}
		
		return new Custom_user_details(user);
	}
}
