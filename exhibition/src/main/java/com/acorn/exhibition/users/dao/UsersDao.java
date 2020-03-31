package com.acorn.exhibition.users.dao;

import java.util.List;

import com.acorn.exhibition.home.dto.FullCalendarDto;
import com.acorn.exhibition.users.dto.UsersDto;

public interface UsersDao {
	public boolean isExist(String inputId);
	public int insert(UsersDto dto);
	public String getPwdHash(String inputId);
	public UsersDto getData(String id);
	public int updateProfile(UsersDto dto);
	public void updatePwd(UsersDto dto);
	public void updateUser(UsersDto dto);
	public void delete(String id);
	public String getAdminAuth(String inputId);
	public List<FullCalendarDto> getlikeList(FullCalendarDto dto);
	public int getCount(FullCalendarDto dto);
}