package com.file.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.file.model.dto.FileUploadDto;

@Mapper
public interface FileMapper {
	
	// 업로드된 파일 DB 등록
	public int fileListPost( FileUploadDto fileUploadDto );

	// 해당 게시물의 파일 목록 가져오기
	public List<String> findById( int board_id );
	
	// 해당 게시물의 파일 목록 삭제
	public int fileListDelete( int board_id );
	
}
