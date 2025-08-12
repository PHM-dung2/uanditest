package com.user.service;

import com.user.model.dto.UserDto;
import com.user.model.dto.UserLoginDto;

public interface UserService {

	/**
	* 회원가입
	* 
	* @author 박희만
	* @since 2025-07-30
	*/
	public int userJoin(UserDto userDto);
	
	/**
	* 회원가입 이름 중복 체크
	* 
	* @author 박희만
	* @since 2025-08-01
	*/
	public boolean userNameCheck(String name);
	
	/**
	* 회원가입 이메일 중복 체크
	* 
	* @author 박희만
	* @since 2025-08-01
	*/
	public boolean userEmailCheck(String email);
	
	/**
	* 회원가입 휴대폰번호 중복 체크
	* 
	* @author 박희만
	* @since 2025-08-01
	*/
	public boolean userPhoneCheck(String phone);
	
	/**
	* 회원가입
	* 
	* @author 박희만
	* @since 2025-08-02
	*/
	public UserDto userLogin(UserLoginDto userLoginDto);
	
}
