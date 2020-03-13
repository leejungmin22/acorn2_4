package com.acorn.exhibition.home.dao;

import java.util.List;

import com.acorn.exhibition.home.dto.ApiDto;

import com.acorn.exhibition.home.dto.FullCalendarDto;
import com.acorn.exhibition.home.dto.LikeDto;

public interface HomeDao {
	public List<FullCalendarDto> getEvent();
	public FullCalendarDto getData(int seq);
	public void insert(ApiDto dto);
	// 전체 공연 list
	public int getCount(FullCalendarDto dto);
	public List<FullCalendarDto> getList(FullCalendarDto dto);
	// 좋아요
	public int findLike(FullCalendarDto dto);
	public int getLikeCount(int seq);
	public void removeOnExhibitionLike(FullCalendarDto dto);
	public void addOnExhibitionLike(FullCalendarDto dto);
	public void addLikeCount(FullCalendarDto dto);
 	public boolean minusLikeCount(FullCalendarDto dto);
 	public String getExhibitionLikeId(LikeDto likeDto);
 	
}
