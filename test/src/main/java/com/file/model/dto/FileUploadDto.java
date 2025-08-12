package com.file.model.dto;

public class FileUploadDto {

	// 게시물 번호
	private int board_id;
	
	// 파일 이름
	private String file_name;

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	@Override
	public String toString() {
		return "FileUploadDto [board_id=" + board_id + ", file_name=" + file_name + "]";
	}
	
}
