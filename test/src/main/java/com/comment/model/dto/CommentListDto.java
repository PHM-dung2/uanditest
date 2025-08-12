package com.comment.model.dto;

public class CommentListDto {

	// 댓글 번호
	private int comment_id;
	
	// 게시물 번호
	private int board_id;
	
	// 사용자 번호
	private int user_id;
	
	// 사용자 이름
	private String writer_name;
	
	// 태그 이름
	private String tag_name;
	
	// 게시물 내용
	private String comment_content;
	
	// 댓글 작성/수정 날짜
	private String comment_display_date;
	
	// 댓글 삭제 여부
	private boolean comment_delete_state;
	
	// 최상위 부모 댓글 번호
	private int comment_root_id;
	
	// 상위 부모 댓글 번호
	private int comment_parent_id;
	
	// 부모 댓글 레벨
	private int comment_parent_level;

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

	public String getWriter_name() {
		return writer_name;
	}

	public void setWriter_name(String writer_name) {
		this.writer_name = writer_name;
	}

	public String getTag_name() {
		return tag_name;
	}

	public void setTag_name(String tag_name) {
		this.tag_name = tag_name;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public String getComment_display_date() {
		return comment_display_date;
	}

	public void setComment_display_date(String comment_display_date) {
		this.comment_display_date = comment_display_date;
	}

	public boolean isComment_delete_state() {
		return comment_delete_state;
	}

	public void setComment_delete_state(boolean comment_delete_state) {
		this.comment_delete_state = comment_delete_state;
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

	@Override
	public String toString() {
		return "CommentListDto [comment_id=" + comment_id + ", board_id=" + board_id + ", user_id=" + user_id
				+ ", writer_name=" + writer_name + ", tag_name=" + tag_name + ", comment_content=" + comment_content
				+ ", comment_display_date=" + comment_display_date + ", comment_delete_state=" + comment_delete_state
				+ ", comment_root_id=" + comment_root_id + ", comment_parent_id=" + comment_parent_id
				+ ", comment_parent_level=" + comment_parent_level + "]";
	}

}
