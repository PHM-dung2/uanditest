package com.handler;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(RuntimeException.class)
	public ResponseEntity< Map<String, String> > handleRuntimeException( RuntimeException ex ){
		Map<String, String> error = new HashMap<>();
		error.put("RuntimeException", 
				ex.getMessage() != null ? ex.getMessage() : "서버 오류가 발생했습니다.");
		return ResponseEntity.status( HttpStatus.INTERNAL_SERVER_ERROR).body(error);
		
	}
	
	@ExceptionHandler(NullPointerException.class)
	public ResponseEntity< Map<String, String> > handleNullPointerException( NullPointerException ex ){
		Map<String, String> error = new HashMap<>();
		error.put("NullPointerException", 
				ex.getMessage() != null ? ex.getMessage() : "서버 오류가 발생했습니다.");
		return ResponseEntity.status( HttpStatus.INTERNAL_SERVER_ERROR).body(error);
		
	}
	
}
