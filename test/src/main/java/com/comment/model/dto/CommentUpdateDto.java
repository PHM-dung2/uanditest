package com.comment.model.dto;

public class CommentUpdateDto {

	// 댓글 번호
	private int comment_id;
	
	// 댓글 내용
	private String comment_content;
	
	// 게시물 번호
	private int board_id;

	public int getComment_id() {
		return comment_id;
	}

	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	@Override
	public String toString() {
		return "CommentUpdateDto [comment_id=" + comment_id + ", comment_content=" + comment_content + ", board_id="
				+ board_id + "]";
	}
	
}
