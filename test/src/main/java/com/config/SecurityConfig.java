package com.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private static final String[] PERMIT_URL_ARRAY = {
		/* static */
		"/static/**", 
		"/css/**", 
		"/scss/**", 
		"/js/**", 
		"/img/**",
		"/vendor/**",
		"/resources/**",
		"/api/**",
		/* 게시판 */
        "/",
        "/board/detail/**",
        /* 회원가입 */
        "/join",
        "/login",
        "/logout"
    };
	
	@Bean
	public SecurityFilterChain securityFilterChain( HttpSecurity httpSecurity ) throws Exception { 
		httpSecurity
			.csrf(csrf -> csrf.disable())
			.authorizeHttpRequests( auth -> auth
					.requestMatchers(PERMIT_URL_ARRAY).permitAll()
					.anyRequest().authenticated()
			)
			.formLogin( formLogin -> formLogin
									 .loginPage("/")
									 .permitAll()
			);
		
		return httpSecurity.build();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		
		return new BCryptPasswordEncoder();
		
	}
	
}
