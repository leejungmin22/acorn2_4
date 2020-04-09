package com.acorn.exhibition.home.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.exhibition.home.dto.ApiDto;
import com.acorn.exhibition.home.dto.CommentDto;
import com.acorn.exhibition.home.dto.FullCalendarDto;
import com.acorn.exhibition.home.dto.mapDto;


public interface HomeService {
	public List<FullCalendarDto> getEvent();
	public void getPopularEvents(ModelAndView mView);
	public void getData(HttpServletRequest request);
	public void addExhibition(ApiDto dto);
	public List<mapDto> maplistplace(HttpServletRequest request);
	public void maplist(HttpServletRequest request);
	//전체 공연 list
	public void list(HttpServletRequest request);
	public void listfavor(HttpServletRequest request);
	public Map<String, Object> updateLikeCount(HttpServletRequest request);

}
