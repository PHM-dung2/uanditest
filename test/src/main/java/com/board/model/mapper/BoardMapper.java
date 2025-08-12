package com.board.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.model.dto.BoardDetailDto;
import com.board.model.dto.BoardListDto;
import com.board.model.dto.BoardUpdateDto;
import com.board.model.dto.BoardWriteDto;

@Mapper
public interface BoardMapper {

	// 게시판 목록 조회
	public List<BoardListDto> boardList();
	
	// 게시물 상세 조회
	public BoardDetailDto boardDetail( int board_id );
	
	// 게시물 수정
	public int boardUpdate( BoardUpdateDto boardUpdateDto );
	
	// 게시물 등록
	public int boardWrite( BoardWriteDto boardWriteDto );
	
	// 게시물 삭제
	public int boardDelete( int board_id );
	
}
