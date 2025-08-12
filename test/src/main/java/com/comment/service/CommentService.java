package com.comment.service;

import java.util.List;

import com.comment.model.dto.CommentListDto;
import com.comment.model.dto.CommentUpdateDto;
import com.comment.model.dto.CommentWriteDto;

public interface CommentService {

	/**
	* 댓글 조회
	* 
	* @author 박희만
	* @since 2025-08-09
	*/
	public List<CommentListDto> commentList(int board_id);
	
	/**
	* 댓글 작성
	* 
	* @author 박희만
	* @since 2025-08-10
	*/
	public boolean commentWrite(CommentWriteDto commentWriteDto);
	
	/**
	* 댓글 수정
	* 
	* @author 박희만
	* @since 2025-08-11
	*/
	public boolean commentUpdate(CommentUpdateDto commentUpdateDto);
	
	/**
	* 댓글 삭제
	* 
	* @author 박희만
	* @since 2025-08-11
	*/
	public boolean commentDelete(int comment_id);
	
}
