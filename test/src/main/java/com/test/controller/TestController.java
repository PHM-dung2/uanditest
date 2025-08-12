package com.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.test.model.dto.TestDto;
import com.test.service.TestService;

@Controller
public class TestController {
	@Autowired
	private TestService testService;

	@RequestMapping("/test")
	public String list(Model model) {
		List<TestDto> list = testService.getList();
		
		System.out.println("== 리스트 결과 ==");
		list.forEach(System.out::println);
		
		model.addAttribute("list", list);
		return "test/list";
	}
	
	@RequestMapping("/membership")
	public String membership(ModelAndView mv) {
		
		return "user/membership";	
	}
	
}
