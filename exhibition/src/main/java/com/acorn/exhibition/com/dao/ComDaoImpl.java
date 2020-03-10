package com.acorn.exhibition.com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.exhibition.com.dto.ComDto;

@Repository
public class ComDaoImpl implements ComDao{
	@Autowired
	private SqlSession session;

	@Override
	public int getCount(ComDto dto) {
		
		return session.selectOne("community.getCount", dto);
	}

	@Override
	public List<ComDto> getList(ComDto dto) {
		
		return session.selectList("community.getList", dto);
	}

	@Override
	public void insert(ComDto dto) {
		session.insert("community.insert", dto);
	}

	@Override
	public ComDto getData(ComDto dto) {
		
		return session.selectOne("community.getData", dto);
	}

	@Override
	public void addViewCount(int num) {
		session.update("community.addViewCount", num);
	}

	@Override
	public void delete(int num) {
		session.delete("community.delete",num);
	}

	@Override
	public ComDto getData(int num) {
		
		return session.selectOne("community.getData2", num);
	}

	@Override
	public void update(ComDto dto) {
		session.update("community.update", dto);
	}
}
