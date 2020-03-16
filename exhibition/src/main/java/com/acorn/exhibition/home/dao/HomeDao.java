package com.acorn.exhibition.home.dao;

import java.util.List;

import com.acorn.exhibition.home.dto.ApiDto;

import com.acorn.exhibition.home.dto.FullCalendarDto;

public interface HomeDao {
	public List<FullCalendarDto> getEvent();
	public FullCalendarDto getData(int seq);
	public void insert(ApiDto dto);
	public void deleteFromDate(String fromTime);
	//list
	public int getCount(FullCalendarDto dto);
	public List<FullCalendarDto> getList(FullCalendarDto dto);
}
