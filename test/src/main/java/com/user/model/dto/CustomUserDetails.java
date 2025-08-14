package com.user.model.dto;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomUserDetails implements UserDetails{

	private UserDto userDto;

    public CustomUserDetails( UserDto userDto ) {
    	this.userDto = userDto;
    }
	
    @Override
    public String getUsername() {
    	return userDto.getUser_email();
    }
    
    @Override
    public String getPassword() {
    	return userDto.getUser_password();
    }
    
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
    	return List.of( new SimpleGrantedAuthority("USER") );
    }

	public UserDto getUserDto() {
		return userDto;
	}

	
}
