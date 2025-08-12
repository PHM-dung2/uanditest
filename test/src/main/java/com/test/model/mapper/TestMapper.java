package com.test.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.test.model.dto.TestDto;

@Mapper
public interface TestMapper {

	public List<TestDto> getAll();
	
}
