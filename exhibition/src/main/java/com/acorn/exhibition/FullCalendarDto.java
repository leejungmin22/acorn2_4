package com.acorn.exhibition;

public class FullCalendarDto {
	private String title;
	private String startdate;
	private String enddate;
	private String url;
	
	public FullCalendarDto() {}

	public FullCalendarDto(String title, String startdate, String enddate, String url) {
		super();
		this.title = title;
		this.startdate = startdate;
		this.enddate = enddate;
		this.url = url;
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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	
	
}
