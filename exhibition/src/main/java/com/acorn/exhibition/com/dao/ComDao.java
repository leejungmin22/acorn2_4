package com.acorn.exhibition.com.dao;

import java.util.List;

import com.acorn.exhibition.com.dto.ComDto;

public interface ComDao {
	public int getCount(ComDto dto); //글 갯수
	public List<ComDto> getList(ComDto dto); //글 목록
	public void insert(ComDto dto); //글 추가
	public ComDto getData(ComDto dto); //글 정보 얻어오기
	public void addViewCount(int num); //조회수 증가
	public void delete(int num);
	public ComDto getData(int num); //글 하나의 정보
	public void update(ComDto dto);
}
