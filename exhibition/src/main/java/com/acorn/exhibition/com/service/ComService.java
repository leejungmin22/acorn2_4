package com.acorn.exhibition.com.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.exhibition.com.dto.ComDto;

public interface ComService {
	public void getList(HttpServletRequest request);
	public void saveContent(ComDto dto);
	public void getDetail(HttpServletRequest request);
	public void deleteContent(int num, HttpServletRequest request);
	public void getUpdateData(ModelAndView mView, int num);
	public void updateContent(ComDto dto); //원글 수정하는 메소드
	public void saveComment(HttpServletRequest request); //댓글 저장하는 메소드
	public void deleteComment(int num); //댓글 삭제하는 메소드
}
