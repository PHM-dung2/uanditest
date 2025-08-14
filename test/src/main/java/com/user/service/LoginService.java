package com.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.user.model.mapper.UserMapper;

@Service
public class LoginService implements UserDetailsService {

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		
		String password;
		
		// 가져온 이메일에 해당하는 비밀번호		
		password = userMapper.userPassword( email );
		
		return User.builder()
				   .username( email )
				   .password( password )
				   .roles("USER")
				   .build();
	}
	
}
