package com.board.model.dto;

public class BoardDeleteDto {

	// 게시판 번호(기본키)
	private int board_id;
	
	// 회원 번호(외래키)
	private int user_id;

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	@Override
	public String toString() {
		return "BoardDeleteDto [board_id=" + board_id + ", user_id=" + user_id + "]";
	}
	
}
