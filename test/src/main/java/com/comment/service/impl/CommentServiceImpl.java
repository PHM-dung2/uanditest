package com.comment.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.comment.model.dto.CommentListDto;
import com.comment.model.dto.CommentUpdateDto;
import com.comment.model.dto.CommentWriteDto;
import com.comment.model.mapper.CommentMapper;
import com.comment.service.CommentService;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentMapper commentMapper;

	@Override
	public List<CommentListDto> commentList(int board_id) {

		List<CommentListDto> commentList = commentMapper.commentList( board_id );
		
		return commentList;
	}
	
	@Override
	public boolean commentWrite(CommentWriteDto commentWriteDto) {
		
		boolean result = commentMapper.commentWrite( commentWriteDto );
		
		return result;
	}
	
	@Override
	public boolean commentUpdate(CommentUpdateDto commentUpdateDto) {
		
		boolean result = commentMapper.commentUpdate( commentUpdateDto );
		
		return result;
	}
	
	@Override
	public boolean commentDelete(int comment_id) {
		
		boolean result = commentMapper.commentDelete( comment_id );
		
		return result;
	}

	
}
