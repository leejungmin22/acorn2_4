package com.acorn.exhibition;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HomeDao {
	@Autowired
	private SqlSession session;
	
	public List<FullCalendarDto> getEvent() {
		List<FullCalendarDto> list=session.selectList("event.getevent");
		return list;
	}
}
