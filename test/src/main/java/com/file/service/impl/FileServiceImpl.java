package com.file.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.board.service.impl.BoardServiceImpl;
import com.file.model.dto.FileUploadDto;
import com.file.model.mapper.FileMapper;
import com.file.service.FileService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;

@Service
@Transactional
public class FileServiceImpl implements FileService {

	@Autowired
	private FileMapper fileMapper;
	
    // 파일을 저장할 폴더 경로 지정
    @Autowired
    private ServletContext context;

    // 업로드할 경로 지정
    String uploadPath;

    @PostConstruct
    public void init() {
        uploadPath = context.getRealPath("/resources/board/file/");
    }
    
    // 파일 업로드
    @Override
    public String fileUpload(MultipartFile multipartFile) {
    	
        // 현재 날짜
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        System.out.println( today );
        // 실제 업로드할 디렉토리 설정
        String uuid = UUID.randomUUID().toString();
        String fileName = today + "_" + uuid + "_" + multipartFile.getOriginalFilename();
        System.out.println( fileName );
        String filePath = uploadPath + fileName;

        File directory = new File(uploadPath);

        // 디렉토리가 없으면 생성
        if (!directory.exists()) {
            directory.mkdirs();  // 디렉토리 생성
        }

        File directory2 = new File(filePath);

        try {
            multipartFile.transferTo(directory2);
        } catch (IOException e) {
            System.out.println(e);

            return null;
        }

        return fileName;

    }
    
    // 다중 파일 업로드
    @Override
    public boolean multiFileUpload(List<MultipartFile> files, int board_id) {
    	
    	for( int i = 0; i < files.size(); i++ ) {
    		
			FileUploadDto fileUploadDto = new FileUploadDto();
			fileUploadDto.setBoard_id( board_id );
			
			if( files.get(i) != null ) {
				System.out.println("file" + (i+1) + " Upload 시작");
				MultipartFile file = files.get(i);
				
				// 파일 업로드
				String fileName = fileUpload( file );
				
				if( fileName == null || fileName.isEmpty() ) {
					throw new RuntimeException("파일 업로드 실패: 파일명이 없습니다.");
				}
				
				// 업로드한 파일명 DB 저장
				fileUploadDto.setFile_name( fileName );
				int uploadResult = fileListPost( fileUploadDto );
				
				if( uploadResult == 0 ) { return false; }
				
			} // if end
		} // for end
		
		return true;
    	
    }

    // 업로드된 파일 다운로드
    @Override
    public void fileDownload(String fileName, HttpServletResponse resp) {
        String downloadPath = uploadPath + fileName;

        File file = new File(downloadPath);
        if( !file.exists() ){
            return;
        }

        try{
            FileInputStream fin = new FileInputStream(downloadPath);

            long fileSize = file.length();
            byte[] bytes = new byte[(int)fileSize];

            fin.read(bytes);

            fin.close();

            String oldFilename = URLEncoder.encode(fileName.split("_")[2], "UTF-8");
            resp.setHeader("Content-Disposition", "attachment;filename=" + oldFilename);

            ServletOutputStream fout = resp.getOutputStream();

            fout.write(bytes);

            fout.close();


        }catch (Exception e){
            System.out.println(e);
        }
    }
    
    // 파일 삭제
    @Override
    public void fileDelete(String fileName) {
    	
    	// 업로드 경로 + 파일명
        File file = new File(uploadPath, fileName);
    	
    	if( file.exists() ) { file.delete(); }
    	else { return; }

    }
    
    // DB
    // 업로드된 파일명 저장
    @Override
    public int fileListPost(FileUploadDto fileUploadDto) {
    	
    	int result = fileMapper.fileListPost(fileUploadDto);
    	
    	return result;
    }
    
    // 해당 게시물의 파일 목록 가져오기
    @Override
    public List<String> findById(int board_id) {
    	
    	List<String> result = fileMapper.findById( board_id );
    	
    	return result;
    }
    
    // 해당 게시물의 파일 목록 삭제
    @Override
    public int fileListDelete(int board_id) {

    	int result = fileMapper.fileListDelete(board_id);
    	
    	return result;
    }
    
}
