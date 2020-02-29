package com.acorn.exhibition.home.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.exhibition.home.dto.FullCalendarDto;

@Repository
public class HomeDaoImpl implements HomeDao{
	@Autowired
	private SqlSession session;
	
	public List<FullCalendarDto> getEvent() {
		List<FullCalendarDto> list=session.selectList("event.getevent");
		return list;
	}
}
