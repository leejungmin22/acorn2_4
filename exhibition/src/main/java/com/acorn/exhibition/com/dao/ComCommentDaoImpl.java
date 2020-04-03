package com.acorn.exhibition.com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.exhibition.com.dto.ComCommentDto;

@Repository
public class ComCommentDaoImpl implements ComCommentDao{
	@Autowired
	private SqlSession session;
	
	//원글의 글번호에 해당되는 댓글 목록 얻어오기
	@Override
	public List<ComCommentDto> getList(int ref_group) {
		return session.selectList("comComment.getList", ref_group);
	}

	@Override
	public void delete(int num) {
		session.update("comComment.delete", num);
	}

	@Override
	public void insert(ComCommentDto dto) {
		session.insert("comComment.insert", dto);
	}
	//저장 할 댓글의 글번호를 리턴하는 메소드
	@Override
	public int getSequence() {
		//시퀀스값을 얻어내서
		int seq=session.selectOne("comComment.getSequence");
		//리턴
		return seq;
	}

	@Override
	public void update(ComCommentDto dto) {
		session.update("comComment.update", dto);
	}

}
