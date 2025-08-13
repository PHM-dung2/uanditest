package com.user.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.user.intercepter.LoginInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{

//	@Override
//	public void addInterceptors(InterceptorRegistry reg) {
//		reg.addInterceptor(new LoginInterceptor())
//			.addPathPatterns("/**")
//			.excludePathPatterns(
//				"/css/**", 
//				"/js/**", 
//				"/img/**", 
//				"/vendor/**",
//				"/resources/**",
//				
//				// 페이지
//				"/login", 
//				"/join"
//			);
//	}
	
}
