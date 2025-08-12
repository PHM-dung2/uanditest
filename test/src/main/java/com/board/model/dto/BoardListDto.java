package com.board.model.dto;

public class BoardListDto {

	// 게시판 번호(기본키)
	private int board_id;
	
	// 회원 이름(닉네임)
	private String user_name;
	
	// 게시판 제목
	private String board_title;
	
	// 게시판 표시날짜
	private String board_display_date;

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_display_date() {
		return board_display_date;
	}

	public void setBoard_display_date(String board_display_date) {
		this.board_display_date = board_display_date;
	}

	@Override
	public String toString() {
		return "BoardListDto [board_id=" + board_id + ", user_name=" + user_name + ", board_title=" + board_title
				+ ", board_display_date=" + board_display_date + "]";
	}
	
}
