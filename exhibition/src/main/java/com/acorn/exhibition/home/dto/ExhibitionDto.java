package com.acorn.exhibition.home.dto;

import java.util.Map;

public class ExhibitionDto {
	private int seq;
	private String title;
	private String startDate;
	private String endDate;
	private String place;
	private String realmName;
	private String area;
	private String subTitle;
	private String price;
	private String contents1;
	private String contents2;
	private String url;
	private String phone;
	private String gpsX;
	private String gpsY;
	private String imgUrl;
	private String placeUrl;
	private String placeAddr;
	private String placeSeq;
	
	public ExhibitionDto() {}

	public ExhibitionDto(int seq, String title, String startDate, String endDate, String place, String realmName,
			String area, String subTitle, String price, String contents1, String contents2, String url, String phone,
			String gpsX, String gpsY, String imgUrl, String placeUrl, String placeAddr, String placeSeq) {
		super();
		this.seq = seq;
		this.title = title;
		this.startDate = startDate;
		this.endDate = endDate;
		this.place = place;
		this.realmName = realmName;
		this.area = area;
		this.subTitle = subTitle;
		this.price = price;
		this.contents1 = contents1;
		this.contents2 = contents2;
		this.url = url;
		this.phone = phone;
		this.gpsX = gpsX;
		this.gpsY = gpsY;
		this.imgUrl = imgUrl;
		this.placeUrl = placeUrl;
		this.placeAddr = placeAddr;
		this.placeSeq = placeSeq;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getRealmName() {
		return realmName;
	}

	public void setRealmName(String realmName) {
		this.realmName = realmName;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getSubTitle() {
		return subTitle;
	}

	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getContents1() {
		return contents1;
	}

	public void setContents1(String contents1) {
		this.contents1 = contents1;
	}

	public String getContents2() {
		return contents2;
	}

	public void setContents2(String contents2) {
		this.contents2 = contents2;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getGpsX() {
		return gpsX;
	}

	public void setGpsX(String gpsX) {
		this.gpsX = gpsX;
	}

	public String getGpsY() {
		return gpsY;
	}

	public void setGpsY(String gpsY) {
		this.gpsY = gpsY;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getPlaceUrl() {
		return placeUrl;
	}

	public void setPlaceUrl(String placeUrl) {
		this.placeUrl = placeUrl;
	}

	public String getPlaceAddr() {
		return placeAddr;
	}

	public void setPlaceAddr(String placeAddr) {
		this.placeAddr = placeAddr;
	}

	public String getPlaceSeq() {
		return placeSeq;
	}

	public void setPlaceSeq(String placeSeq) {
		this.placeSeq = placeSeq;
	}
	
	
	
}
