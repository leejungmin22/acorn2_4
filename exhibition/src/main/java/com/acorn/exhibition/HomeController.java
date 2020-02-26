package com.acorn.exhibition;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	@Autowired
	private HomeService sevice;
	
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
