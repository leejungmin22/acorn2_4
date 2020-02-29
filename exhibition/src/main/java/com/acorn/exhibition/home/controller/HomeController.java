package com.acorn.exhibition.home.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.exhibition.home.service.HomeService;
import com.acorn.exhibition.home.service.HomeServiceImpl;

@Controller
public class HomeController {
	@Autowired
	private HomeService sevice;
	
	@RequestMapping(value = "/home")
	public String home(HttpServletRequest request) {
		sevice.getPopularEvents(request);
		return "home";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getEvents")
	public String getEvents() {
		String jsonStr=sevice.getEvent();
		return jsonStr;
	}
	
}
