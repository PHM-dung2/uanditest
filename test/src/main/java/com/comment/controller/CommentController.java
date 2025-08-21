package com.comment.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.comment.model.dto.CommentDeleteDto;
import com.comment.model.dto.CommentListDto;
import com.comment.model.dto.CommentUpdateDto;
import com.comment.model.dto.CommentWriteDto;
import com.comment.service.CommentService;
import com.user.model.dto.UserDto;

import jakarta.servlet.http.HttpSession;

@Controller
public class CommentController {

	@Autowired
	private CommentService commentService;
	
	// 댓글 작성
	@PostMapping("/api/comment/write")
	@ResponseBody
	public Map<String, Object> boardWrite( HttpSession session
			                 , CommentWriteDto commentWriteDto
			                 ) {
		
		System.out.println("/api/comment/write 시작");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		// 로그인 정보 불러오기
		UserDto userDto = (UserDto)session.getAttribute("UserDto");
		int user_id = userDto.getUser_id();
		
		// 로그인된 아이디 번호 넣기
		commentWriteDto.setUser_id( user_id );

		// 게시판 번호
		int board_id = commentWriteDto.getBoard_id();
		// 댓글 레벨
		int parent_level = commentWriteDto.getComment_parent_level();
		
		// 댓글 등록
		boolean result = commentService.commentWrite( commentWriteDto );
		
		// 댓글 전체 리스트
		List<CommentListDto> commentList = commentService.commentList( board_id );
		
		resultMap.put("commentList", commentList);
		resultMap.put("result", result);
		if( parent_level == 0 ) { resultMap.put("level", 0 ); }
		
		System.out.println("/api/comment/write 종료");
		
		return resultMap;
	}
	
	// 댓글 수정
	@PostMapping("/api/comment/update")
	@ResponseBody
	public Map<String, Object> commentUpdate( CommentUpdateDto commentUpdateDto ) {
		
		System.out.println("/api/comment/update 시작");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		boolean result = commentService.commentUpdate( commentUpdateDto );
		int board_id = commentUpdateDto.getBoard_id();
		
		resultMap = resultList( result, board_id );
		
		System.out.println("/api/comment/update 종료");

		return resultMap;
		
	}
	
	// 댓글 삭제
	@PostMapping("/api/comment/delete")
	@ResponseBody
	public Map<String, Object> commentDelete( CommentDeleteDto commentDeleteDto ) {
		
		System.out.println("/api/comment/delete 시작");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		boolean result = commentService.commentDelete( commentDeleteDto.getComment_id() );
		int board_id = commentDeleteDto.getBoard_id();
		
		resultMap = resultList( result, board_id );
		
		System.out.println("/api/comment/delete 종료");
		
		return resultMap;
		
	}
	
	// 렌더링할 리스트
	private Map<String, Object> resultList( boolean result, int board_id ) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		if( result ) {
			
			List<CommentListDto> commentList = commentService.commentList( board_id );
			
			resultMap.put("commentList", commentList);
			resultMap.put("result", result);
		}else {
			resultMap.put("result", result);
		}
		
		return resultMap;
		
	}
	
}
