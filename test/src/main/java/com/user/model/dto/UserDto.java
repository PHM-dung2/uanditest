package com.user.model.dto;

public class UserDto {
	
	// 회원 번호(기본키)
	private int user_id;
	
	// 회원 이름(닉네임) 
	private String user_name;
	
	// 회원 이메일
	private String user_email;
	
	// 회원 비밀번호
	private String user_password;
	
	// 회원 핸드폰번호
	private String user_phone_num;
	
	// 회원 우편번호
	private String user_zonecode;
	
	// 회원 도로명 주소
	private String user_road_address;
	
	// 회원 상세 주소
	private String user_detail_address;
	
	// 회원 주소 참고
	private String user_refer_address;
	
	
	
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
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
	public String getUser_phone_num() {
		return user_phone_num;
	}
	public void setUser_phone_num(String user_phone_num) {
		this.user_phone_num = user_phone_num;
	}
	public String getUser_zonecode() {
		return user_zonecode;
	}
	public void setUser_zonecode(String user_zonecode) {
		this.user_zonecode = user_zonecode;
	}
	public String getUser_road_address() {
		return user_road_address;
	}
	public void setUser_road_address(String user_road_address) {
		this.user_road_address = user_road_address;
	}
	public String getUser_detail_address() {
		return user_detail_address;
	}
	public void setUser_detail_address(String user_detail_address) {
		this.user_detail_address = user_detail_address;
	}
	public String getUser_refer_address() {
		return user_refer_address;
	}
	public void setUser_refer_address(String user_refer_address) {
		this.user_refer_address = user_refer_address;
	}
	
	@Override
	public String toString() {
		return "UserDto [user_id=" + user_id + ", user_name=" + user_name + ", user_email=" + user_email
				+ ", user_password=" + user_password + ", user_phone_num=" + user_phone_num + ", user_zonecode="
				+ user_zonecode + ", user_road_address=" + user_road_address + ", user_detail_address="
				+ user_detail_address + ", user_refer_address=" + user_refer_address + "]";
	}
	

}
