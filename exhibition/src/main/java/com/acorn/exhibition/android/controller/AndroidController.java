package com.acorn.exhibition.android.controller;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.acorn.exhibition.android.service.AndroidService;

@Controller
public class AndroidController {
	
	@Autowired
	private AndroidService service;
	
	@ResponseBody
	@RequestMapping("/android/detail")
	public Map<String, Object> detail(@RequestParam int seq) {
		return service.getData(seq);
	}

}

