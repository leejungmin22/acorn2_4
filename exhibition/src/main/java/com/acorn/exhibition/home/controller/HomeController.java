package com.acorn.exhibition.home.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.exhibition.home.service.HomeServiceImpl;

@Controller
public class HomeController {
	@Autowired
	private HomeServiceImpl sevice;
	
	@RequestMapping(value = "/home")
	public String home() {
		
		return "home";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getEvents")
	public String getEvents() {
		String jsonStr=sevice.getEvent();
		return jsonStr;
	}
	
}
