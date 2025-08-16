package com.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private static final String[] PERMIT_URL_ARRAY = {
		/* static */
		"/resources/**",
		"/board/**",
		"/css/**",
		"/img/**",
		"/js/**",
		"/scss/**",
		"/vendor/**",
		/* api */
		"/api/**",
		/* 게시판 */
        "/",
        "/board/detail",
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
					.dispatcherTypeMatchers(
							DispatcherType.FORWARD,
							DispatcherType.INCLUDE,
							DispatcherType.ASYNC
					).permitAll()
					.requestMatchers(PERMIT_URL_ARRAY).permitAll()
					.anyRequest().authenticated()
			)
			.formLogin( formLogin -> formLogin
									 .loginPage("/login")
									 .permitAll()
			);
		
		return httpSecurity.build();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		
		return new BCryptPasswordEncoder();
		
	}
	
	@Bean
	public AuthenticationManager authenticationManager( AuthenticationConfiguration authenticationConfig ) throws Exception {
		
		return authenticationConfig.getAuthenticationManager();
		
	}
	
	@Bean
	public HttpFirewall allowUrlWithDoubleSlash() {
	    StrictHttpFirewall firewall = new StrictHttpFirewall();
	    firewall.setAllowUrlEncodedDoubleSlash(true); // // 허용
	    return firewall;
	}
	
}
