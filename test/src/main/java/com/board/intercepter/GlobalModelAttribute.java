package com.board.intercepter;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.user.model.dto.UserDto;

import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalModelAttribute {

//	@ModelAttribute
//    public void addLoginUserToModel(HttpSession session, Model model) {
//        UserDto userDto = (UserDto)session.getAttribute("UserDto");
//        if (userDto != null) {
//            model.addAttribute("loginUser", userDto);
//        }
//    }
	
}
