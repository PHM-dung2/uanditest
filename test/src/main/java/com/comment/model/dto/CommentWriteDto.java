package com.comment.model.dto;

public class CommentWriteDto {

	// 댓글 번호
	private int comment_id;
	
	// 게시물 번호
	private int board_id;
	
	// 작성자 번호
	private int user_id;
	
	// 댓글 내용
	private String comment_content;
	
	// 최상위 댓글 번호
	private int comment_root_id;
	
	// 부모 댓글 번호
	private int comment_parent_id;
	
	// 댓글 레벨
	private int comment_parent_level;

	// 태그 이름
	private String tag_name;
	
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

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public int getComment_root_id() {
		return comment_root_id;
	}

	public void setComment_root_id(int comment_root_id) {
		this.comment_root_id = comment_root_id;
	}

	public int getComment_parent_id() {
		return comment_parent_id;
	}

	public void setComment_parent_id(int comment_parent_id) {
		this.comment_parent_id = comment_parent_id;
	}

	public int getComment_parent_level() {
		return comment_parent_level;
	}

	public void setComment_parent_level(int comment_parent_level) {
		this.comment_parent_level = comment_parent_level;
	}

	public String getTag_name() {
		return tag_name;
	}

	public void setTag_name(String tag_name) {
		this.tag_name = tag_name;
	}

	@Override
	public String toString() {
		return "CommentWriteDto [comment_id=" + comment_id + ", board_id=" + board_id + ", user_id=" + user_id
				+ ", comment_content=" + comment_content + ", comment_root_id=" + comment_root_id
				+ ", comment_parent_id=" + comment_parent_id + ", comment_parent_level=" + comment_parent_level
				+ ", tag_name=" + tag_name + "]";
	}

}
