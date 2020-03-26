package com.acorn.exhibition.android.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.acorn.exhibition.home.dto.ApiDto;
import com.acorn.exhibition.home.service.XmlParsing;

@Service
public class AndroidServiceImpl implements AndroidService{

	@Override
	public Map<String, String> getData(int seq) {
		ApiDto apiDto = XmlParsing.getData(seq);
		
		Map<String, String> map=new HashMap<String, String>();
		map.put("seq", Integer.toString(apiDto.getSeq()));
		map.put("title", apiDto.getTitle());
		map.put("startDate",apiDto.getStartDate());
		map.put("endDate", apiDto.getEndDate());
		map.put("place", apiDto.getPlace());
		map.put("realmName", apiDto.getRealmName());
		map.put("area", apiDto.getArea());
		map.put("subTitle", apiDto.getSubTitle());
		map.put("thumbNail", apiDto.getThumbNail());
		map.put("price", apiDto.getPrice());
		map.put("contents1", apiDto.getContents1());
		map.put("contents2", apiDto.getContents2());
		map.put("url", apiDto.getUrl());
		map.put("phone", apiDto.getPhone());
		map.put("gpsX", apiDto.getGpsX());
		map.put("gpsY", apiDto.getGpsY());
		map.put("imgUrl", apiDto.getImgUrl());
		map.put("placeAddr", apiDto.getPlaceAddr());
		
		return map;
	}

}
