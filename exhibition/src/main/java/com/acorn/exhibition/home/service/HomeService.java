package com.acorn.exhibition.home.service;

import javax.servlet.http.HttpServletRequest;

public interface HomeService {
	public String getEvent();
	public void getPopularEvents(HttpServletRequest request);
}
