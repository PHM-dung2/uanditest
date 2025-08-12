package com.test.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class TestDto {
	private int userNo;
	private String userName;
	
	public TestDto() {}
    public TestDto(int userNo, String userName) {
        this.userNo = userNo;
        this.userName = userName;
    }

    public int getUserNo() {
        return userNo;
    }
    public void setUserNo(int userNo) {
        this.userNo = userNo;
    }

    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "TestDto{userNo=" + userNo + ", userName='" + userName + "'}";
    }
}
