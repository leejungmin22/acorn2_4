package com.acorn.exhibition.comment.dao;

import java.util.List;

import com.acorn.exhibition.home.dto.Com_LikeDto;
import com.acorn.exhibition.home.dto.CommentDto;
import com.acorn.exhibition.home.dto.FullCalendarDto;

public interface CommentDao {
	public List<CommentDto> getList(FullCalendarDto dto);
	public void delete(int num);
	public void insert(CommentDto dto);
	public int getSequence();
	public void update(CommentDto dto);
	public int getCount();
	
	public CommentDto getlikeCount(int num);
	public int findLike(CommentDto dto);
	public boolean removeOncommentLike(CommentDto dto);
	public boolean addOnCommentLike(CommentDto dto);
	public boolean addcommentLikeCount(int num);
 	public boolean minuscommentLikeCount(int num);
 	public String getCommentLikeId(Com_LikeDto comlikeDto);
}
