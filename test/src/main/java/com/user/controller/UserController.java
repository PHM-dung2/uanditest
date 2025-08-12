package com.user.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.TestApplication;
import com.user.config.WebMvcConfig;
import com.user.model.dto.UserDto;
import com.user.model.dto.UserLoginDto;
import com.user.service.UserService;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController extends HttpServlet {

	@Autowired
    private WebMvcConfig webMvcConfig;

	@Autowired
    private TestApplication testApplication;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/login")
	public String login() throws Exception{
		return "user/login";
	}
	
	// 회원가입 페이지
	@RequestMapping("/join")
	public String join() throws Exception{
		return "user/membership";
	}
	
	// 회원가입
	// Ajax 로 처리
	@PostMapping("/createUser")
	@ResponseBody
	public Map<String, Object> joinPost(UserDto userDto) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<>();
		System.out.println("USER JOIN 진입");
		
		System.out.println("데이터확인 -> " + userDto.getUser_name());
		
		int result = userService.userJoin(userDto);
		// insert 성공시 1 이상 , 실패시 0 return
		
		if(result > 0 ){
			resultMap.put("result", true);
		} else {
			resultMap.put("result", false);
		}
		
		return resultMap;
	}
	
	// 회원가입 - 이름 중복 체크
	@PostMapping("/nameCheck")
	@ResponseBody
	public boolean userNameCheck(String name) throws Exception{
		System.out.println("/nameCheck 시작");
		
		boolean matchCount = userService.userNameCheck(name);
		System.out.println("matchCount : " + matchCount);
		
		System.out.println("/nameCheck 종료");
		
		return matchCount; 
	}
	
	// 회원가입 - 이메일 중복 체크
	@PostMapping("/emailCheck")
	@ResponseBody
	public boolean userEmailCheck(String email) throws Exception{
		
		System.out.println("/emailCheck 시작");
		
		boolean matchCount = userService.userEmailCheck(email);
		System.out.println("matchCount : " + matchCount);
		
		System.out.println("/emailCheck 종료");
		
		return matchCount; 
	}
	
	// 회원가입 - 휴대폰번호 중복
	@PostMapping("/phoneCheck")
	@ResponseBody
	public boolean userPhoneCheck(String phone) throws Exception{

		System.out.println("/phoneCheck 시작");
		
		boolean matchCount = userService.userPhoneCheck(phone);
		System.out.println("matchCount : " + matchCount);
		
		System.out.println("/phoneCheck 시작");
		
		return matchCount; 
	}
	
	// 로그인
	@PostMapping("/login")
	@ResponseBody
	public boolean userLogin(UserLoginDto userLoginDto, HttpSession session) throws Exception{
		
		System.out.println("USER LOGIN 진입");
		
		System.out.println("이메일 -> " + userLoginDto.getUser_email());
		System.out.println("비밀번호 -> " + userLoginDto.getUser_password());
		
		// 로그인 성공시 로그인 정보 가져오기, 실패시 null
		UserDto result = userService.userLogin(userLoginDto);
		
		if( result != null ) { 
			session.setAttribute("UserDto", result );
			session.setMaxInactiveInterval(60*5);
			
			System.out.println( "세션 : " + (UserDto)session.getAttribute("UserDto") );
			return true;
		}
		
		return false;
	}
	
	// 세션의 회원정보 가져오기
	@GetMapping("/imformation")
	@ResponseBody
	public UserDto getSessionUser(HttpSession session) {
		
		return (UserDto)session.getAttribute("UserDto");
		
	}
	
	// 로그아웃
	@GetMapping("/logout")
	@ResponseBody
	public void userLogout(HttpSession session) throws Exception{
		
		if( session.getAttribute("UserDto") != null ) {
			session.removeAttribute("UserDto");
			
			System.out.println( "세션 : " + (UserDto)session.getAttribute("UserDto") );
		}
		
	}
	
	
	
}
