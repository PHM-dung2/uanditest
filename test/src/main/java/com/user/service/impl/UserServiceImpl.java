package com.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.user.model.dto.UserDto;
import com.user.model.mapper.UserMapper;
import com.user.service.UserService;

import jakarta.servlet.http.HttpSession;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public boolean userJoin(UserDto userDto) {
		
		// 비크립트 암호화
		String hashedPassword = passwordEncoder.encode(userDto.getUser_password());
		
		userDto.setUser_password(hashedPassword);
		
		return userMapper.userJoin(userDto);
	}
	
	@Override
	public boolean userNameCheck(String name) {
		return userMapper.userNameCheck(name) > 0 ? false : true;
	}
	
	@Override
	public boolean userEmailCheck(String email) {
		return userMapper.userEmailCheck(email) > 0 ? false : true;
	}
	
	@Override
	public boolean userPhoneCheck(String phone) {
		return userMapper.userPhoneCheck(phone) > 0 ? false : true;
	}
	
	@Override
	public UserDto userLoginInformation( String email ) {
		
		UserDto userDto = new UserDto();
		
		// 이메일 확인
		int resultEmail = userMapper.userEmailCheck( email );
		
		if( resultEmail == 0 ) {
			throw new UsernameNotFoundException("email" + email + " not found");
		// 비크립트 암호 확인
		}else {
			userDto = userMapper.userLoginInformation( email );
		}
		
		return userDto;
	}
	
	// 로그인된 id가 작성자인지 확인
	public boolean isWriter( HttpSession session, int writerId ) {
		
		UserDto userDto = (UserDto)session.getAttribute("UserDto");
		System.out.println("UserDto : " + userDto);
		int loginUserId = userDto != null ? userDto.getUser_id() : -1;
		System.out.println("loginUserId : "+ loginUserId);
		System.out.println("writerId : "+ writerId);
		
		return loginUserId == writerId;
		
	}
	
}
