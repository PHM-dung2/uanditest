package com.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.user.model.dto.UserDto;
import com.user.model.dto.UserLoginDto;
import com.user.model.mapper.UserMapper;
import com.user.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public int userJoin(UserDto userDto) {
		
		// 비크립트 암호화
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
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
	public UserDto userLogin(UserLoginDto userLoginDto) {
		
		// 이메일 확인(이메일 불일치)
		String email = userLoginDto.getUser_email();
		int resultEmail = userMapper.userEmailCheck( email );
		if( resultEmail == 0 ) {
			return null;
		// 비크립트 암호 확인(이메일 일치)
		}else {
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			// 가져온 이메일에 해당하는 비밀번호		
			String matchPassword = userMapper.userPassword( userLoginDto.getUser_email( ));
			// 비밀번호 비교
			boolean resultPassword = passwordEncoder.matches(userLoginDto.getUser_password(), matchPassword);
			System.out.println("resultPawword : " + resultPassword);
			
			if( resultPassword ) {  
				UserDto userLoginInformation = userMapper.userLoginInformation( email );
				
				return userLoginInformation;
			}
		}
		
		return null;
	}
	
}
