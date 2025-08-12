package com.file.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.file.service.FileService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class FileController {

	@Autowired
	private FileService fileService;
	
	// 파일 다운로드
	@RequestMapping("/api/file/download")
	public void fileDownload( @RequestParam String file_name
							, HttpServletResponse resp ) {
		
		fileService.fileDownload(file_name, resp);
		
	}
	
}
