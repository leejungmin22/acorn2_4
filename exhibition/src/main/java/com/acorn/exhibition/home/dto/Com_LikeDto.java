package com.acorn.exhibition.home.dto;

public class Com_LikeDto {
	private String id;
	private int num;

	public Com_LikeDto(){}
	

	public Com_LikeDto(String id, int num) {
		super();
		this.id = id;
		this.num = num;
	
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}



	
	
}
