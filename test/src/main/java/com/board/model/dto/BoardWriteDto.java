package com.board.model.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class BoardWriteDto {

	// 게시판 번호(기본키)
	private int board_id;
	
	// 회원 번호(외래키)
	private int user_id;
	
	// 게시판 제목
	private String board_title;
	
	// 게시판 내용
	private String board_content;
	
	// 파일 리스트
	private List<MultipartFile> files;

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

	public List<MultipartFile> getFiles() {
		return files;
	}

	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}

	@Override
	public String toString() {
		return "BoardWriteDto [board_id=" + board_id + ", user_id=" + user_id + ", board_title=" + board_title
				+ ", board_content=" + board_content + ", files=" + files + "]";
	}
	
}
