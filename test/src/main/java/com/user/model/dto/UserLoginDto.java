package com.user.model.dto;

public class UserLoginDto {

	// 회원 이메일
	private String user_email;
	
	// 회원 비밀번호
	private String user_password;

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	@Override
	public String toString() {
		return "UsetLoginDto [user_email=" + user_email + ", user_password=" + user_password + "]";
	}
	
}
