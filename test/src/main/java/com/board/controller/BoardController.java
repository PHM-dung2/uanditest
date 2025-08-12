package com.board.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.model.dto.BoardDetailDto;
import com.board.model.dto.BoardListDto;
import com.board.model.dto.BoardUpdateDto;
import com.board.model.dto.BoardWriteDto;
import com.board.service.BoardService;
import com.comment.model.dto.CommentListDto;
import com.comment.service.CommentService;
import com.file.service.FileService;
import com.github.pagehelper.PageInfo;
import com.user.model.dto.UserDto;
import com.user.service.LoginService;

import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController{
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private FileService fileService;

	@Autowired
	private CommentService commentService;
	
	// 초기화면
	@RequestMapping("/")
	public String root(	Model model,
						@RequestParam(defaultValue = "1") int page,
						@RequestParam(defaultValue = "10") int pageSize
					   ) throws Exception{
		
		// 페이지네이션
		PageInfo<BoardListDto> pageInfo = boardService.boardList(page, pageSize);
		model.addAttribute("pageInfo", pageInfo);
		
		return "board/tables";
	}
	
	// 게시물 작성 페이지 이동
	@RequestMapping("/board/write")
	public String boardWritePage() {
		
		return "board/write";

	}
	
	// 게시물 수정 페이지 이동
	@RequestMapping("/board/modify")
	public String boardUpdatePage( Model model
								 , @RequestParam int board_id
								 ) throws Exception {
		
		System.out.println("/board/modify 시작");
		
		// 게시물 정보
		BoardDetailDto board = boardService.boardDetail(board_id);
		
		// 해당 게시물 파일
		List<String> fileList = fileService.findById( board_id );
		
		model.addAttribute("board", board);
		model.addAttribute("fileList", fileList);
		
		System.out.println("/board/modify 종료");
		
		return "board/modify";
		
	}
	
	// 게시물 작성 api
	@PostMapping("/api/board/write")
	@ResponseBody
	public boolean boardWrite( HttpSession session
			                 , BoardWriteDto boardWriteDto
			                 ) throws Exception{
		
		System.out.println("api/board/write 시작");
		UserDto userDto = (UserDto)session.getAttribute("UserDto");
		if( userDto == null ) { throw new NullPointerException("로그인해 주세요."); }
		
		int userId = userDto.getUser_id();
		boardWriteDto.setUser_id( userId );
		
		boolean result = boardService.boardWrite( boardWriteDto );
		
		System.out.println("api/board/write 종료");
		
		return result;
	}
	
	// 게시물 상세 조회
	@RequestMapping("/board/detail")
	public String boardDetail( HttpSession session
							 , Model model
							 , @RequestParam(defaultValue = "1") int page
							 , @RequestParam(defaultValue = "10") int pageSize
							 , @RequestParam int board_id
							 ) throws Exception{
		
		System.out.println("/board/detail 시작");
		
		// 게시물 정보
		BoardDetailDto board = boardService.boardDetail(board_id);
		
		// 작성자 일치 여부
		boolean isWriter = loginService.isWriter(session, board.getUser_id());
		
		// 해당 게시물 파일
		List<String> fileList = fileService.findById(board_id);
		
		// 해당 게시물 댓글 목록
		List<CommentListDto> commentList = commentService.commentList(board_id);
		
		model.addAttribute("isWriter", isWriter);
		model.addAttribute("board", board);
		model.addAttribute("fileList", fileList);
		model.addAttribute("commentList", commentList);
		model.addAttribute("board_id", board_id);
		
		System.out.println("/board/detail 종료");

		return "/board/detail";
	}
	
	// 게시물 수정
	@PutMapping("/api/board/update")
	@ResponseBody
	public boolean boardUpdate( BoardUpdateDto boardUpdateDto ) throws Exception {
		
		System.out.println("/api/board/update 시작");
		
		boolean result = boardService.boardUpdate(boardUpdateDto);
		
		System.out.println("/api/board/update 종료");
		
		return result;
	}
	
	// 게시물 삭제
	@PutMapping("/api/board/delete")
	@ResponseBody
	public Map<String, Object> boardDelete( HttpSession session
						                  , int board_id
						                  ) throws Exception{
		
		System.out.println("/api/board/delete 시작");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		boolean loginState = session.getAttribute("UserDto") != null;
		if( !loginState ) { 
			resultMap.put("result", false );
			resultMap.put("message", "notSession");
		}else {
			int result = boardService.boardDelete( board_id );
			if( result > 0 ) {
				resultMap.put("message", "deleteSuccess");
			}else {
				resultMap.put("message", "deleteFail");
			}
			
			resultMap.put("result", result );
			
		}
		
		System.out.println("resultMap : " + resultMap);
		System.out.println("/api/board/delete 종료");
		
		return resultMap;
		
	}
	
}
