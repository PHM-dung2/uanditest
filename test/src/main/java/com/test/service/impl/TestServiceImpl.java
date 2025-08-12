package com.test.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.model.dto.TestDto;
import com.test.model.mapper.TestMapper;
import com.test.service.TestService;

@Service
public class TestServiceImpl implements TestService {
	
	@Autowired
	private TestMapper testMapper;
	
	@Override
	public List<TestDto> getList(){
		return testMapper.getAll();
	}
	
	
	
}
