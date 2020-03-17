package com.acorn.exhibition.comment.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.acorn.exhibition.home.dto.CommentDto;

public interface CommentService {
	//댓글 저장하는 메소드
		public void saveComment(HttpServletRequest request);
		public void deleteComment(int num);
		public void updateComment(CommentDto dto);
		public void commentList(HttpServletRequest request);
		public Map<String, Object> com_updateLikeCount(HttpServletRequest request);
}
