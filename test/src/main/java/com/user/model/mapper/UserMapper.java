package com.user.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.user.model.dto.UserDto;

@Mapper
public interface UserMapper {

	// 회원가입
	public boolean userJoin(UserDto userDto);
	
	// 이름 중복 체크
	public int userNameCheck(String name);
	
	// 이메일 중복 체크
	public int userEmailCheck(String email);

	// 휴대폰번호 중복 체크
	public int userPhoneCheck(String phone);
	
	// 비밀번호 확인
	public String userPassword(String password);
	
	// 로그인된 회원 정보
	public UserDto userLoginInformation(String email);
	
}
