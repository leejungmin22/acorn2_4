package com.acorn.exhibition.home.dto;

public class Com_LikeDto {
	private String Id;
	private int num;
	private int seq;
	
	public Com_LikeDto(){}
	

	public Com_LikeDto(String id, int num, int seq) {
		super();
		Id = id;
		this.num = num;
		this.seq = seq;
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

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	
	
}
