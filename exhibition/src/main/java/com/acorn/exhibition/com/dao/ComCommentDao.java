package com.acorn.exhibition.com.dao;



import java.util.List;

import com.acorn.exhibition.com.dto.ComCommentDto;

public interface ComCommentDao {
	public List<ComCommentDto> getList(int ref_group);
	public void delete(int num);
	public void insert(ComCommentDto dto);
	public int getSequence();
	public void update(ComCommentDto dto);
}

