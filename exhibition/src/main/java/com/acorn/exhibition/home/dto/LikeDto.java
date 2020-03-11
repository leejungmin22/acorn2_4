package com.acorn.exhibition.home.dto;

public class LikeDto {
	private int seq;
	private String id;
	
	public LikeDto() {}

	public LikeDto(int seq, String id) {
		super();
		this.seq = seq;
		this.id = id;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	
}
