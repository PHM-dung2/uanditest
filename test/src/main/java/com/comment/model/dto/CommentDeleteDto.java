package com.comment.model.dto;

public class CommentDeleteDto {

	// 댓글 번호
	private int comment_id;
	
	// 게시물 번호
	private int board_id;

	public int getComment_id() {
		return comment_id;
	}

	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	@Override
	public String toString() {
		return "CommentDeleteDto [comment_id=" + comment_id + ", board_id=" + board_id + "]";
	}
	
}
