package com.acorn.exhibition.home.dto;

public class FullCalendarDto {
	private int seq;
	private String title;
	private String startdate;
	private String enddate;
	private String place;
	private String realmname;
	private String area;
	private String thumbnail;
	private String gpsx;
	private String gpsy;
	private int startRowNum;
	private int endRowNum;
	
	public FullCalendarDto() {}

	public FullCalendarDto(int seq, String title, String startdate, String enddate, String place, String realmname,
			String area, String thumbnail, String gpsx, String gpsy, int startRowNum, int endRowNum) {
		super();
		this.seq = seq;
		this.title = title;
		this.startdate = startdate;
		this.enddate = enddate;
		this.place = place;
		this.realmname = realmname;
		this.area = area;
		this.thumbnail = thumbnail;
		this.gpsx = gpsx;
		this.gpsy = gpsy;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
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

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getRealmname() {
		return realmname;
	}

	public void setRealmname(String realmname) {
		this.realmname = realmname;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public String getGpsx() {
		return gpsx;
	}

	public void setGpsx(String gpsx) {
		this.gpsx = gpsx;
	}

	public String getGpsy() {
		return gpsy;
	}

	public void setGpsy(String gpsy) {
		this.gpsy = gpsy;
	}

	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}

	
}
