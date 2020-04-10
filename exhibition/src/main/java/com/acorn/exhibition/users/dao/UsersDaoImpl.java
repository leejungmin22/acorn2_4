package com.acorn.exhibition.users.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.exhibition.home.dto.FullCalendarDto;
import com.acorn.exhibition.users.dto.UsersDto;


@Repository 
public class UsersDaoImpl implements UsersDao{
	@Autowired
	private SqlSession session;

	@Override
	public boolean isExist(String inputId) {
		//인자로 전달 되는 아이디를 이용해서 select  를 한다.
		String id=session.selectOne("users.isExist",inputId);
		//만일 select 된 결과가 null이면 존재하지 않는 아디디이다.
		if(id==null) {
			return false;
		}else {
			return true;
		}
	}

	@Override
	public int insert(UsersDto dto) {
		return session.insert("users.insert",dto);
		
	}

	@Override
	public String getPwdHash(String inputId) {
		String savedPwd=session.selectOne("users.getPwdHash",inputId);
		return savedPwd;
	}

	@Override
	public UsersDto getData(String id) {
		return session.selectOne("users.getData",id);
	}

	@Override
	public int updateProfile(UsersDto dto) {
		return session.update("users.updateProfile",dto);
		
	}

	@Override
	public void updatePwd(UsersDto dto) {
		session.update("users.updatePwd", dto);
		
	}

	@Override
	public void updateUser(UsersDto dto) {
		session.update("users.updateUser",dto);	
	}

	@Override
	public void delete(String id) {
		session.delete("users.delete",id);
		session.delete("users.deletelike",id);
		session.delete("users.deletecomment",id);
		session.delete("users.deletecomcomment",id);
	}

	@Override
	public String getAdminAuth(String inputId) {
		String getAdminAuth = session.selectOne("users.getAdminAuth",inputId);
		return getAdminAuth;
	}
	
	@Override
	public List<FullCalendarDto> getlikeList(FullCalendarDto dto) {
		List<FullCalendarDto> likelist=session.selectList("users.getLikeList", dto);
		return likelist;
	}
	
	@Override
	public int getCount(FullCalendarDto dto) {
		int count=session.selectOne("users.getCount", dto);
		return count;
	}

	
}
