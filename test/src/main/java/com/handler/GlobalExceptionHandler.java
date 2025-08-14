package com.handler;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler({ RuntimeException.class
					  , NullPointerException.class
					  , UsernameNotFoundException.class
				     })
	public ResponseEntity< Map<String, String> > handleRuntimeException( Exception ex ){
		Map<String, String> error = new HashMap<>();
		error.put(ex.getClass().getSimpleName(), 
				ex.getMessage() != null ? ex.getMessage() : "서버 오류가 발생했습니다.");
		return ResponseEntity.status( HttpStatus.INTERNAL_SERVER_ERROR).body(error);
		
	}
	
	
}
