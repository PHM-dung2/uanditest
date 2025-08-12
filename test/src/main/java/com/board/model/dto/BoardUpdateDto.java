package com.board.model.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class BoardUpdateDto {

	// 게시판 번호(기본키)
	private int board_id;
	
	// 게시판 제목
	private String board_title;
	
	// 게시판 내용
	private String board_content;
	
	// 수정 파일 리스트
	private List<MultipartFile> files;
	
	// 삭제할 파일 리스트
	private List<String> delete_files;
	
	// 파일 변경 여부
	private boolean file_state;

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
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

	public boolean isFile_state() {
		return file_state;
	}

	public void setFile_state(boolean file_state) {
		this.file_state = file_state;
	}

	public List<String> getDelete_files() {
		return delete_files;
	}

	public void setDelete_files(List<String> delete_files) {
		this.delete_files = delete_files;
	}

	@Override
	public String toString() {
		return "BoardUpdateDto [board_id=" + board_id + ", board_title=" + board_title + ", board_content="
				+ board_content + ", files=" + files + ", delete_files=" + delete_files + ", file_state=" + file_state
				+ "]";
	}

}
