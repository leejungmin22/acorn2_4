package com.acorn.exhibition.home.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.acorn.exhibition.home.dto.ApiDto;

import com.acorn.exhibition.home.dto.FullCalendarDto;
import com.acorn.exhibition.home.dto.LikeDto;
import com.acorn.exhibition.home.dto.mapDto;

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
	// 좋아요
	@Override
	public int findLike(FullCalendarDto dto) {
		int check=session.selectOne("event.findLike", dto);
		return check;
	}
	
	@Override
	public int getLikeCount(int seq) {
		int getLikeCount=session.selectOne("event.getLikeCount", seq);
		return getLikeCount;
	}
	

	@Override
	public boolean removeOnExhibitionLike(FullCalendarDto dto) {
		int result=session.delete("event.remove", dto);
		if(result>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean addOnExhibitionLike(FullCalendarDto dto) {
		int result = session.insert("event.add", dto);
		if(result>0) {
			return true;
		}
		else {
			return false;
		}
	}
	
	@Override
	public boolean addLikeCount(FullCalendarDto dto) {
		int result =session.update("event.addLikeCount", dto);
		if(result>0) {
			return true;
		}
		else {
			return false;
		}
	}

	@Override
	public boolean minusLikeCount(FullCalendarDto dto) {
		int result=session.update("event.minusLikeCount", dto);
		if(result>0) {
			return false;
		}else {
			return true;
		}

	}

	@Override
	public String getExhibitionLikeId(LikeDto likeDto) {
		String id=session.selectOne("event.getid", likeDto);
		return id;
	}

	@Override
	public List<FullCalendarDto> getListfavor(FullCalendarDto dto) {
		List<FullCalendarDto> list=session.selectList("event.getListfavor", dto);
		return list;
	}

	@Override
	public List<mapDto> mapList(mapDto dto) {
		List<mapDto> maplist=session.selectList("event.mapList",dto);
		return maplist;
	}

	
}
