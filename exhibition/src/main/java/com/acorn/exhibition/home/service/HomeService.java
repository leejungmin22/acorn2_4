package com.acorn.exhibition.home.service;

import javax.servlet.http.HttpServletRequest;

import com.acorn.exhibition.home.dto.ApiDto;
import com.acorn.exhibition.home.dto.CommentDto;


public interface HomeService {
	public String getEvent();
	public void getPopularEvents(HttpServletRequest request);
	public void getData(HttpServletRequest request);
	public void addExhibition(ApiDto dto);
	//댓글 저장하는 메소드
	public void saveComment(HttpServletRequest request);
	public void deleteComment(int num);
	public void updateComment(CommentDto dto);
	public void commentList(HttpServletRequest request);
	//전체 공연 list
	public void list(HttpServletRequest request);
}
