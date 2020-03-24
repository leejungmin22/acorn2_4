package com.acorn.exhibition.home.dto;

public class Com_LikeDto {
	private String id;
	private int num;
	private boolean isCommentLikeId;

	public Com_LikeDto(){}
	
	public Com_LikeDto(String id, int num) {
		super();
		this.id = id;
		this.num = num;
	}
	
	public Com_LikeDto(String id, int num, boolean isCommentLikeId) {
		super();
		this.id = id;
		this.num = num;
		this.isCommentLikeId = isCommentLikeId;
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

	public boolean getIsCommentLikeId() {
		return isCommentLikeId;
	}

	public void setIsCommentLikeId(boolean isCommentLikeId) {
		this.isCommentLikeId = isCommentLikeId;
	}

	
	
}
