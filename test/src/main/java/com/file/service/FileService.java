package com.file.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.file.model.dto.FileUploadDto;

import jakarta.servlet.http.HttpServletResponse;

public interface FileService {

	/**
	* 파일 업로드
	* 
	* @author 박희만
	* @since 2025-08-06
	*/
	public String fileUpload(MultipartFile multipartFile);
	
	/**
	* 다중 파일 업로드
	* 
	* @author 박희만
	* @since 2025-08-08
	*/
	public boolean multiFileUpload(List<MultipartFile> files, int board_id);
	
	/**
	* 파일 다운로드
	* 
	* @author 박희만
	* @since 2025-08-06
	*/
	public void fileDownload(String fileName, HttpServletResponse resp);
	
	/**
	* 파일 삭제
	* 
	* @author 박희만
	* @since 2025-08-08
	*/
	public void fileDelete(String fileNmae);
	
	// DB
	
	/**
	* 해당 게시물의 파일 목록 가져오기
	* 
	* @author 박희만
	* @since 2025-08-07
	*/
	public List<String> findById(int board_id);
	
	/**
	* 업로드된 파일명 DB 저장
	* 
	* @author 박희만
	* @since 2025-08-07
	*/
	public int fileListPost(FileUploadDto fileUploadDto);
	

	/**
	* 해당 게시물의 파일 목록 삭제
	* 
	* @author 박희만
	* @since 2025-08-08
	*/
	public int fileListDelete(int board_id);
	
}
