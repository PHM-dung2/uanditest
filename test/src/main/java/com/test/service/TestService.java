package com.test.service;

import java.util.List;

import com.test.model.dto.TestDto;

public interface TestService {
	
	/**
    * 테스트
    * 
    * @author 박희만
    * @since 2025-07-29
    */
	List<TestDto> getList();
	
}
