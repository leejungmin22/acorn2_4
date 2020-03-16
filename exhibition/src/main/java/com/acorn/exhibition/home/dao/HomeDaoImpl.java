package com.acorn.exhibition.home.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.acorn.exhibition.home.dto.ApiDto;

import com.acorn.exhibition.home.dto.FullCalendarDto;

@Repository
public class HomeDaoImpl implements HomeDao{
	@Autowired
	private SqlSession session;
	
	@Override
	public List<FullCalendarDto> getEvent() {
		List<FullCalendarDto> list=session.selectList("event.getevent");
		return list;
	}

	@Override
	public FullCalendarDto getData(int seq) {
		FullCalendarDto dto=session.selectOne("event.getdata", seq);
		return dto;
	}

	@Override
	public void insert(ApiDto dto) {
		session.insert("event.insert", dto);
	}

	@Override
	public int getCount(FullCalendarDto dto) {
		int count=session.selectOne("event.getCount", dto);
		return count;
	}

	@Override
	public List<FullCalendarDto> getList(FullCalendarDto dto) {
		List<FullCalendarDto> list=session.selectList("event.getList", dto);
		return list;
	}

	@Override
	public void deleteFromDate(String fromTime) {
		session.delete("event.deleteFromDate", fromTime);
	}
	
}
