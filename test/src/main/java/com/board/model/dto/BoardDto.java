package com.board.model.dto;

public class BoardDto {
	
	// 게시판 번호(기본키)
	private int board_id;
	
	// 회원 번호(외래키)
	private int user_id;
	
	// 게시판 제목
	private String board_title;
	
	// 게시판 내용
	private String board_content;
	
	// 게시판 생성날짜
	private String board_create_at;
	
	// 게시판 수정날짜
	private String board_update_at;
	
	// 게시판 삭제 여부
	private boolean board_delete;

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

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public String getBoard_create_at() {
		return board_create_at;
	}

	public void setBoard_create_at(String board_create_at) {
		this.board_create_at = board_create_at;
	}

	public String getBoard_update_at() {
		return board_update_at;
	}

	public void setBoard_update_at(String board_update_at) {
		this.board_update_at = board_update_at;
	}

	public boolean isBoard_delete() {
		return board_delete;
	}

	public void setBoard_delete(boolean board_delete) {
		this.board_delete = board_delete;
	}

	@Override
	public String toString() {
		return "BoardDto [board_id=" + board_id + ", user_id=" + user_id + ", board_title=" + board_title
				+ ", board_content=" + board_content + ", board_create_at=" + board_create_at + ", board_update_at="
				+ board_update_at + ", board_delete=" + board_delete + "]";
	}
	
}
