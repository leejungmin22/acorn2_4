package com.acorn.exhibition.home.dto;

public class mapDto {
	private String place;
	private String gpsx;
	private String gpsy;
	
	public mapDto() {}
	
	public mapDto(String place, String gpsx, String gpsy) {
		super();
		this.place = place;
		this.gpsx = gpsx;
		this.gpsy = gpsy;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
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
	
	
}
