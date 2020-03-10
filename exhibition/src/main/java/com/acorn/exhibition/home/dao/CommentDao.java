package com.acorn.exhibition.home.dao;

import java.util.List;

import com.acorn.exhibition.com.dto.ComDto;
import com.acorn.exhibition.home.dto.CommentDto;
import com.acorn.exhibition.home.dto.FullCalendarDto;

public interface CommentDao {
	public List<CommentDto> getList(FullCalendarDto dto);
	public void delete(int num);
	public void insert(CommentDto dto);
	public int getSequence();
	public void update(CommentDto dto);
	public int getCount();
	public List<CommentDto> getList(ComDto dto);
}
