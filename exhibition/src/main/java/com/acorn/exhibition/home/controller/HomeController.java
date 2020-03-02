package com.acorn.exhibition.home.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.exhibition.home.service.HomeService;

@Controller
public class HomeController {
	@Autowired
	private HomeService service;
	
	@RequestMapping(value = "/home")
	public String home(HttpServletRequest request) {
		service.getPopularEvents(request);
		return "home";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getEvents")
	public String getEvents() {
		String jsonStr=service.getEvent();
		return jsonStr;
	}
	
	@RequestMapping(value = "/exhibition/detail")
	public ModelAndView detail(ModelAndView mView, @RequestParam int seq) {
		service.getData(mView, seq);
		mView.setViewName("exhibition/detail");
		return mView;
	}
	
	
}
