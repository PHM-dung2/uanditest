package com.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.board.model.dto.BoardDetailDto;
import com.board.model.dto.BoardListDto;
import com.board.model.dto.BoardUpdateDto;
import com.board.model.dto.BoardWriteDto;
import com.board.model.mapper.BoardMapper;
import com.board.service.BoardService;
import com.file.service.FileService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.user.service.LoginService;


@Service
@Transactional
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private LoginService loginService;

	@Override
	public PageInfo<BoardListDto> boardList(int page, int pageSize) {
		
		PageHelper.startPage( page, pageSize );
		List<BoardListDto> boardList = boardMapper.boardList();
		
		PageInfo<BoardListDto> pageResult = new PageInfo<>(boardList);
			
		return pageResult;
	}
	
	@Override
	public BoardDetailDto boardDetail( int board_id ) {

		BoardDetailDto result = boardMapper.boardDetail( board_id );
		
		return result;
		
	}
	
	@Override
	public boolean boardWrite(BoardWriteDto boardWriteDto) {
		
		boolean result = boardMapper.boardWrite( boardWriteDto );
		
		// insert 실패시 return
		if( !result ) { return false; }
		System.out.println("insert success : board_id : " + boardWriteDto.getBoard_id());
		
		// 파일 업로드
		try {
			List<MultipartFile> files = boardWriteDto.getFiles();
			
			if( files == null || files.isEmpty() ) { return result; }
			int board_id = boardWriteDto.getBoard_id();
			
			boolean uploadResult = fileService.multiFileUpload(files, board_id);
			
			return uploadResult;
			
		}catch( Exception e ) {
			System.err.println( e );
			throw e;
		}
		
	}
	
	@Override
	public boolean boardUpdate(BoardUpdateDto boardUpdateDto) {
		
		boolean result = boardMapper.boardUpdate( boardUpdateDto );
		
		// update 실패시 return
		if( !result ) { return false; }
		
		// 파일 업로드
		try {
			List<MultipartFile> files = boardUpdateDto.getFiles();
			
			// 변경할 파일 없으면 생략			
			if( !boardUpdateDto.isFile_state() ) { return result; }
			
			int board_id = boardUpdateDto.getBoard_id();
			
			// 기존 파일 제거
			List<String> deleteFiles = boardUpdateDto.getDelete_files();
			deleteFiles.forEach( fileName -> fileService.fileDelete(fileName) );
			
			// DB 파일 목록 제거
			fileService.fileListDelete(board_id);
			
			if( files == null || files.isEmpty() ) { 
				return true;
			}
			
			boolean uploadResult = fileService.multiFileUpload(files, board_id);
			
			return uploadResult;

		}catch( Exception e ) {
			System.err.println( e );
			throw e;
		}
		
	}
	
	@Override
	public boolean boardDelete(int board_id) {
		
		boolean result = boardMapper.boardDelete( board_id );
		
		return result;
		
	}
	
	
}
