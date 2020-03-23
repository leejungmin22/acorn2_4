package com.acorn.exhibition.com.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.exhibition.com.dto.ComDto;

public interface ComService {
	public void getList(HttpServletRequest request);
	public void saveContent(ComDto dto);
	public void getDetail(HttpServletRequest request);
	public void deleteContent(int num, HttpServletRequest request);
	public void getUpdateData(ModelAndView mView, int num);
	public void updateContent(ComDto dto);
}
