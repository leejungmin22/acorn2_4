package com.acorn.exhibition.com.controller;

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

import com.acorn.exhibition.com.dto.ComCommentDto;
import com.acorn.exhibition.com.dto.ComDto;
import com.acorn.exhibition.com.service.ComService;

@Controller
public class ComController {
	@Autowired
	private ComService service;
	
	//글목록 요청처리
	@RequestMapping("/community/comList")
	public ModelAndView list(HttpServletRequest request) {
		service.getList(request);
		
		return new ModelAndView("community/comList");
	}
	@RequestMapping("/community/insertform")
	public ModelAndView authInsertform(HttpServletRequest request) {
		return new ModelAndView("community/insertform");
	}
	@RequestMapping(value="/community/insert", method=RequestMethod.POST)
	public ModelAndView authInsert(HttpServletRequest request,
			@ModelAttribute ComDto dto){
		//세션에 있는 글작성자의 아이디
		String writer=(String)
				request.getSession().getAttribute("id");
		//CafeDto 객체에 담고 
		dto.setWriter(writer);
		//서비스를 이용해서 DB 에 저장
		service.saveContent(dto);
		//글 목록 보기로 리다일렉트 이동 
		return new ModelAndView("redirect:/community/comList.do");
	}
	@RequestMapping("/community/comDetail")
	public String detail(HttpServletRequest request, @RequestParam int num) {
		service.getDetail(request);
		return "community/comDetail";
	}
	@RequestMapping("/community/delete")
	public ModelAndView authDelete(HttpServletRequest request, @RequestParam int num) {
		service.deleteContent(num, request);
		return new ModelAndView("redirect:/community/comDtail.do");
	}
	@RequestMapping("/community/updateform")
	public ModelAndView 
			authUpdateform(HttpServletRequest request, 
					@RequestParam int num, ModelAndView mView) {
		service.getUpdateData(mView, num);
		mView.setViewName("community/updateform");
		return mView;
	}
	//원글 수정반영 요청 처리
	@RequestMapping(value = "/community/update", 
					method = RequestMethod.POST)
	public ModelAndView 
			authUpdate(HttpServletRequest request, 
					@ModelAttribute ComDto dto) {
		service.updateContent(dto);
		return new ModelAndView("redirect:/community/comDetail.do?num="+dto.getNum());
	}
	//댓글 저장 요청 처리
	@RequestMapping(value = "/community/comment_insert",
					method = RequestMethod.POST)
	public ModelAndView authCommentInsert(HttpServletRequest request,
					@RequestParam int ref_group) {
		service.saveComment(request);
		return new ModelAndView("redirect:/community/comDetail.do?num="+ref_group);
	}
	//댓글 삭제 요청 처리
	@ResponseBody
	@RequestMapping(value = "/community/comment_delete",
					method = RequestMethod.POST)
	public Map<String, Object>
			authCommentDelete(HttpServletRequest request,
					@RequestParam int num){
		service.deleteComment(num);
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isSuccess", true);
		return map; // {"isSuccess":true} 형식의 JSON 문자열이 응답된다.
	}
	//댓글 수정 요청 처리(ajax)
	@ResponseBody
	@RequestMapping("/community/comment_update")
	public Map<String, Object>
			authCommentUpdate(HttpServletRequest request,
								@ModelAttribute ComCommentDto dto){
		service.updateComment(dto);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isSuccess", true);
		return map;
	}
}
