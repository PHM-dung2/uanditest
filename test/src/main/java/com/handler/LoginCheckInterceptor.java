package com.handler;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Configuration
public class LoginCheckInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle( HttpServletRequest request
			                , HttpServletResponse response
			                , Object handler ) throws Exception {
		
		HttpSession session = request.getSession( false );
		if( session == null || session.getAttribute("UserDto") == null ) {
			// AJAX 요청인지 확인
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setStatus( HttpStatus.UNAUTHORIZED.value() ); // 401
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("로그인 후 다시 시도해주세요.");
            } else {
                response.sendRedirect("/login");
            }
            return false;
			
		}
		return true;
	}
	
}
