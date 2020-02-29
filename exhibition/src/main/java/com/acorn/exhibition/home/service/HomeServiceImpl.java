package com.acorn.exhibition.home.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acorn.exhibition.home.dao.HomeDao;
import com.acorn.exhibition.home.dto.FullCalendarDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class HomeServiceImpl implements HomeService{
	@Autowired
	private HomeDao dao;
	
	@Override
	public String getEvent() {
		List<FullCalendarDto> list=dao.getEvent();
		String jsonStr=null;
		try {
			ObjectMapper mapper=new ObjectMapper();
			jsonStr=mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return jsonStr;
	}

	@Override
	public void getPopularEvents(HttpServletRequest request) {
		List<FullCalendarDto> list=dao.getEvent();
		request.setAttribute("list", list);
	}
}
