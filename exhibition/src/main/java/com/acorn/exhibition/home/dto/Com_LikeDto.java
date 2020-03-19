package com.acorn.exhibition.home.dto;

public class Com_LikeDto {
	private String Id;
	private int num;

	public Com_LikeDto(){}
	

	public Com_LikeDto(String id, int num) {
		super();
		Id = id;
		this.num = num;
	
	}


	public String getId() {
		return Id;
	}

	public void setId(String id) {
		Id = id;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}



	
	
}
