package com.comment.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.comment.model.dto.CommentListDto;
import com.comment.model.dto.CommentUpdateDto;
import com.comment.model.dto.CommentWriteDto;

@Mapper
public interface CommentMapper {

	// 댓글 조회
	public List<CommentListDto> commentList( int board_id );
	
	// 댓글 작성
	public boolean commentWrite( CommentWriteDto commentWriteDto );
	
	// 댓글 수정
	public boolean commentUpdate( CommentUpdateDto commentUpdateDto );
	
	// 댓글 삭제
	public boolean commentDelete( int board_id );
	
}
