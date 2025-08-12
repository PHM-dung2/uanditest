package com.board.service;

import com.board.model.dto.BoardDetailDto;
import com.board.model.dto.BoardListDto;
import com.board.model.dto.BoardUpdateDto;
import com.board.model.dto.BoardWriteDto;
import com.github.pagehelper.PageInfo;

public interface BoardService {

	/**
	* 게시판 목록 조회
	* 
	* @author 박희만
	* @since 2025-08-04
	*/
	public PageInfo<BoardListDto> boardList(int page, int pageSize);
	
	/**
	 * 게시물 상세 조회
	 * 
	 * @author 박희만
	 * @since 2025-08-04
	 */
	public BoardDetailDto boardDetail(int board_id);
	
	/**
	 * 게시물 작성
	 * 
	 * @author 박희만
	 * @since 2025-08-04
	 */
	public boolean boardWrite(BoardWriteDto boardWriteDto);
	
	/**
	 * 게시물 수정
	 * 
	 * @author 박희만
	 * @since 2025-08-08
	 */
	public boolean boardUpdate(BoardUpdateDto boardUpdateDto);
	
	/**
	 * 게시물 삭제
	 * 
	 * @author 박희만
	 * @since 2025-08-04
	 */
	public int boardDelete(int board_id);
	
}
