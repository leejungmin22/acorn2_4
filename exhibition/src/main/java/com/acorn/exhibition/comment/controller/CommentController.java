package com.acorn.exhibition.comment.controller;

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

import com.acorn.exhibition.comment.service.CommentService;
import com.acorn.exhibition.home.dto.CommentDto;
import com.acorn.exhibition.home.dto.FullCalendarDto;
import com.acorn.exhibition.home.service.HomeService;

@Controller
public class CommentController {
	@Autowired
	private CommentService commentservice;
	@Autowired
	private HomeService service;
	
	// 댓글 저장 요청 처리
		@RequestMapping(value = "/comment_insert")
		public ModelAndView authCommentInsert(HttpServletRequest request, @RequestParam int ref_group) {
			commentservice.saveComment(request);
			return new ModelAndView("redirect:/detail.do?seq=" + ref_group);
		}

		@ResponseBody
		@RequestMapping(value = "/comment_delete", method = RequestMethod.POST)
		public Map<String, Object> authCommentDelete(HttpServletRequest request, @RequestParam int num) {
			commentservice.deleteComment(num);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("isSuccess", true);
			return map;
		}

		@ResponseBody
		@RequestMapping(value = "/comment_update", method = RequestMethod.POST)
		public Map<String, Object> authCommentUpdate(HttpServletRequest request, @ModelAttribute CommentDto dto) {
			commentservice.updateComment(dto);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("isSuccess", true);
			return map;
		}

		@RequestMapping(value = "/more_comment")
		public ModelAndView getComment(HttpServletRequest request, ModelAndView mView) {
			commentservice.commentList(request);
			mView.addObject("id", request.getSession().getAttribute("id"));
			mView.setViewName("commentprint");
			return mView;
		}
		
		@ResponseBody
		@RequestMapping("/com_updateLikeCount")
		public Map<String, Object> com_updateLikeCount(HttpServletRequest request, @RequestParam int num) {
			System.out.println("댓글 번호"+num);
			Map<String, Object> result=commentservice.com_updateLikeCount(request,num);
			return result;
		}
}
