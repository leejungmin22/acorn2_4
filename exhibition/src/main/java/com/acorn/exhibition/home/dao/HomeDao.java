package com.acorn.exhibition.home.dao;

import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.exhibition.home.dto.FullCalendarDto;

public interface HomeDao {
	public List<FullCalendarDto> getEvent();
	public FullCalendarDto getData(int seq);
}
