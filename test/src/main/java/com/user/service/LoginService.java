package com.user.service;

import org.springframework.stereotype.Component;

import com.user.model.dto.UserDto;

import jakarta.servlet.http.HttpSession;

@Component
public class LoginService {

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
