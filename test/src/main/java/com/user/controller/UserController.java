package com.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.user.model.dto.UserDto;
import com.user.model.dto.UserLoginDto;
import com.user.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AuthenticationManager authenticationManager;
	
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
	@PostMapping("/api/createUser")
	@ResponseBody
	public boolean joinPost(UserDto userDto) throws Exception{
		
		System.out.println("USER JOIN 진입");
		
		System.out.println("데이터확인 -> " + userDto.getUser_name());
		
		boolean result = userService.userJoin(userDto);
		
		return result;
	}
	
	// 회원가입 - 이름 중복 체크
	@PostMapping("/api/nameCheck")
	@ResponseBody
	public boolean userNameCheck(String name) throws Exception{
		System.out.println("/nameCheck 시작");
		
		boolean matchCount = userService.userNameCheck(name);
		System.out.println("matchCount : " + matchCount);
		
		System.out.println("/nameCheck 종료");
		
		return matchCount; 
	}
	
	// 회원가입 - 이메일 중복 체크
	@PostMapping("/api/emailCheck")
	@ResponseBody
	public boolean userEmailCheck(String email) throws Exception{
		
		System.out.println("/emailCheck 시작");
		
		boolean matchCount = userService.userEmailCheck(email);
		System.out.println("matchCount : " + matchCount);
		
		System.out.println("/emailCheck 종료");
		
		return matchCount; 
	}
	
	// 회원가입 - 휴대폰번호 중복
	@PostMapping("/api/phoneCheck")
	@ResponseBody
	public boolean userPhoneCheck(String phone) throws Exception{

		System.out.println("/phoneCheck 시작");
		
		boolean matchCount = userService.userPhoneCheck(phone);
		System.out.println("matchCount : " + matchCount);
		
		System.out.println("/phoneCheck 시작");
		
		return matchCount; 
	}
	
	// 로그인
	@PostMapping("/api/login")
	@ResponseBody
	public boolean userLogin(UserLoginDto userLoginDto, HttpSession session) {
		
		System.out.println("/api/login 시작");
		
		System.out.println("이메일 -> " + userLoginDto.getUser_email());
		System.out.println("비밀번호 -> " + userLoginDto.getUser_password());
		
		String email = userLoginDto.getUser_email();
		
		// Spring Security 인증 처리
		try {
	        Authentication auth = authenticationManager.authenticate(
	            new UsernamePasswordAuthenticationToken(email, userLoginDto.getUser_password())
	        );
	        
	        // SecurityContext 생성 및 저장
	        SecurityContext context = SecurityContextHolder.createEmptyContext();
	        context.setAuthentication(auth);
	        SecurityContextHolder.setContext(context);

	        // 세션에 SecurityContext 저장 (이게 있어야 인증이 유지됨)
	        session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, context);

	    } catch ( Exception e ) {
	        throw new RuntimeException("이메일 또는 비밀번호가 일치하지 않습니다.");
	    }
		
		// 로그인 성공시 로그인 정보 가져오기, 실패시 null
		UserDto result = userService.userLoginInformation( email );
		
		if( result != null ) { 
			session.setAttribute("UserDto", result );
			session.setMaxInactiveInterval(60*1);
			
			System.out.println( "세션 : " + (UserDto)session.getAttribute("UserDto") );
		}else {
			throw new RuntimeException("세션에 정보가 없습니다.");
		}
		
		System.out.println("/api/login 종료");
		
		return true;
	}
	
	// 세션의 회원정보 가져오기
	@GetMapping("/api/imformation")
	@ResponseBody
	public UserDto getSessionUser(HttpSession session) {
		
		return (UserDto)session.getAttribute("UserDto");
		
	}
	
	// 로그아웃
	@GetMapping("/api/logout")
	@ResponseBody
	public void userLogout(HttpSession session) throws Exception{
		
		if( session.getAttribute("UserDto") != null ) {
			session.removeAttribute("UserDto");
			
			System.out.println( "세션 : " + (UserDto)session.getAttribute("UserDto") );
		}
		
	}
	
	
	
}
