package com.acorn.exhibition.home.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.exhibition.home.dto.CommentDto;
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
	
	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, @RequestParam int seq) {
		service.getData(request);
		return "detail";
	}
	
	//댓글 저장 요청 처리
	@RequestMapping(value = "/comment_insert", method = RequestMethod.POST)
	public ModelAndView authCommentInsert(HttpServletRequest request, @RequestParam int ref_group) {
		service.saveComment(request);
		return new ModelAndView("redirect:/detail.do?seq="+ref_group);
	}
	
	@ResponseBody
	@RequestMapping(value = "/comment_delete", method = RequestMethod.POST)
	public Map<String, Object> authCommentDelete(HttpServletRequest request, @RequestParam int num) {
		service.deleteComment(num);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isSuccess", true);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/comment_update", method = RequestMethod.POST)
	public Map<String, Object> authCommentUpdate(HttpServletRequest request, @ModelAttribute CommentDto dto) {
		service.updateComment(dto);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isSuccess", true);
		return map;
	}
	
	@RequestMapping(value = "/more_comment")
	public ModelAndView getComment(HttpServletRequest request, ModelAndView mView) {
		service.commentList(request);
		mView.addObject("id", request.getSession().getAttribute("id"));
		mView.setViewName("commentprint");
		return mView;
	}
	
	
}
