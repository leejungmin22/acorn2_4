package com.acorn.exhibition.home.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.acorn.exhibition.home.dto.ApiDto;
import com.acorn.exhibition.home.dto.CommentDto;


public interface HomeService {
	public String getEvent();
	public void getPopularEvents(HttpServletRequest request);
	public void getData(HttpServletRequest request);
	public void addExhibition(ApiDto dto);

	//전체 공연 list
	public void list(HttpServletRequest request);
	public void listfavor(HttpServletRequest request);
	public Map<String, Object> updateLikeCount(HttpServletRequest request);

}
