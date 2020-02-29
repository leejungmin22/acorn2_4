package com.acorn.exhibition.home.dao;

import java.util.List;

import com.acorn.exhibition.home.dto.FullCalendarDto;

public interface HomeDao {
	public List<FullCalendarDto> getEvent();
}
