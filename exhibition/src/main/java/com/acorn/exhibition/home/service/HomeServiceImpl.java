package com.acorn.exhibition.home.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acorn.exhibition.comment.dao.CommentDao;
import com.acorn.exhibition.home.dao.HomeDao;
import com.acorn.exhibition.home.dto.ApiDto;
import com.acorn.exhibition.home.dto.Com_LikeDto;
import com.acorn.exhibition.home.dto.CommentDto;
import com.acorn.exhibition.home.dto.FullCalendarDto;

import com.acorn.exhibition.home.dto.LikeDto;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class HomeServiceImpl implements HomeService{
	@Autowired
	private HomeDao dao;
	@Autowired
	private CommentDao commentDao;
	
	@Override
	public String getEvent() {
		List<FullCalendarDto> list=dao.getEvent();
		String jsonStr=null;
		try {
			ObjectMapper mapper=new ObjectMapper();
			jsonStr=mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return jsonStr;
	}

	@Override
	public void getPopularEvents(HttpServletRequest request) {
		List<FullCalendarDto> list=dao.getEvent();
		request.setAttribute("list", list);
	}

	@Override
	public void getData(HttpServletRequest request) {
		
		//파라미터로 전달되는 글번호
		int seq=Integer.parseInt(request.getParameter("seq"));
		String id=(String)request.getSession().getAttribute("id");
		
		FullCalendarDto dto=new FullCalendarDto();
		dto.setSeq(seq);
		
		////////////////DB에 있는 데이터 갖고 오기/////////////////////////
		//ExhibitionDto exhibitionDto=XmlParsing.getData(seq);
		ApiDto apiDto = XmlParsing.getData(seq);

		////////////////댓글 페이징 처리/////////////////////////
		//한 페이지에 나타낼 row 의 갯수
		final int PAGE_ROW_COUNT=8;
		//하단 디스플레이 페이지 갯수
		final int PAGE_DISPLAY_COUNT=5;
		
		//보여줄 페이지의 번호
		int pageNum=1;
		//보여줄 페이지의 번호가 파라미터로 전달되는지 읽어와 본다.	
		String strPageNum=request.getParameter("pageNum");
		if(strPageNum != null){//페이지 번호가 파라미터로 넘어온다면
		//페이지 번호를 설정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		//전체 row 의 갯수를 읽어온다.
		int totalRow=commentDao.getCount();
		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//시작 페이지 번호
		int startPageNum=1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		//끝 페이지 번호가 잘못된 값이라면 
		if(totalPageCount < endPageNum){
			endPageNum=totalPageCount; //보정해준다. 
		}		
		// CafeDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다.
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//1. DB 에서 댓글 목록을 얻어온다.
		List<CommentDto> commentList=commentDao.getList(dto);
		List<Com_LikeDto> comLikeList=new ArrayList<Com_LikeDto>();
		
		//좋아요
		String ExhibitionLikeId=null;
		String CommentLikeId=null;
		
		boolean isCommentLikeId=false;
		if(id!=null) {
		     LikeDto likeDto=new LikeDto(seq, id);
		     ExhibitionLikeId=dao.getExhibitionLikeId(likeDto);
		     
		     for(int i=0;i<commentList.size();i++) {
				CommentDto commentDto = commentList.get(i);
				int num = commentDto.getNum();
				Com_LikeDto comLikeDto = new Com_LikeDto(id,num);
				CommentLikeId=commentDao.getCommentLikeId(comLikeDto);
				if(id.equals(CommentLikeId)) {
				   isCommentLikeId = true;
				   comLikeDto.setIsCommentLikeId(isCommentLikeId);
				  
				}else {
				   isCommentLikeId = false;
				   comLikeDto.setIsCommentLikeId(isCommentLikeId);
				}
				comLikeList.add(comLikeDto);
			 }//for end
		}//if end
		      
		
		request.setAttribute("comLikeList", comLikeList);
		request.setAttribute("ExhibitionLikeId", ExhibitionLikeId);
		
		
		FullCalendarDto tmp=dao.getData(seq);
		dto.setLikeCount(tmp.getLikeCount());

		
		//EL, JSTL 을 활용하기 위해 필요한 모델을 request 에 담는다.
		request.setAttribute("commentList", commentList);
		request.setAttribute("id", id);
		request.setAttribute("dto", dto);
		request.setAttribute("exhibitionDto", apiDto);
	}
	
	@Override
	public void addExhibition(ApiDto dto) {
		dao.insert(dto);
		
	}

	@Override
	public void list(HttpServletRequest request) {
		/*
		 *  request 에 검색 keyword 가 전달될수도 있고 안될수도 있다.
		 *  - 전달 안되는 경우 : navbar 에서 cafe를 누른경우 
		 *  - 전달 되는 경우 : 하단에 검색어를 입력하고 검색 버튼을 누른경우
		 *  - 전달 되는 경우2: 이미 검색을 한 상태에서 하단 페이지 번호를 누른 경우 
		 */
		//검색과 관련된 파라미터를 읽어와 본다.
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");
		String startdate=request.getParameter("startDate");
		String enddate=request.getParameter("endDate");
		String startdateFormat="";
		String enddateFormat="";
		
		if(startdate!=null && startdate!=null){
			String[] startdateArr=startdate.split("-");
			String[] enddateArr=enddate.split("-");
			
			for(int i=0; i<startdateArr.length; i++) {
				startdateFormat+=startdateArr[i];
			}
			
			for(int i=0; i<enddateArr.length; i++) {
				enddateFormat+=enddateArr[i];
			}
			
		}
		
		FullCalendarDto dto=new FullCalendarDto();
		if(keyword!=null || (startdate!=null && startdate!=null)) {
			if (condition.equals("title")) {//제목 검색
				dto.setTitle(keyword);
			}else if (condition.equals("place")) {//장소 검색
				dto.setPlace(keyword);
			}else if (condition.equals("date")) {//기간 검색
				dto.setStartdate(startdateFormat);
				dto.setEnddate(enddateFormat);
			}
			
			/*
			 *  검색 키워드에는 한글이 포함될 가능성이 있기 때문에
			 *  링크에 그대로 출력가능하도록 하기 위해 미리 인코딩을 해서
			 *  request 에 담아준다.
			 */
			String encodedKeyword=null;
			if(keyword!=null) {
				try {
					encodedKeyword=URLEncoder.encode(keyword, "utf-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}

			//키워드와 검색조건을 request 에 담는다. 
			request.setAttribute("keyword", keyword);
			request.setAttribute("encodedKeyword", encodedKeyword);
			request.setAttribute("condition", condition);
			request.setAttribute("startdate", startdate);
			request.setAttribute("enddate", enddate);
			request.setAttribute("startdateFormat", startdateFormat);
			request.setAttribute("enddateFormat", enddateFormat);

		}//if end
		
		//한 페이지에 나타낼 row 의 갯수
		final int PAGE_ROW_COUNT=10;
		//하단 디스플레이 페이지 갯수
		final int PAGE_DISPLAY_COUNT=5;
		
		//보여줄 페이지의 번호
		int pageNum=1;
		//보여줄 페이지의 번호가 파라미터로 전달되는지 읽어와 본다.	
		String strPageNum=request.getParameter("pageNum");
		if(strPageNum != null){//페이지 번호가 파라미터로 넘어온다면
			//페이지 번호를 설정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		//전체 row 의 갯수를 읽어온다.
		int totalRow=dao.getCount(dto);
		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//시작 페이지 번호
		int startPageNum=1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		//끝 페이지 번호가 잘못된 값이라면 
		if(totalPageCount < endPageNum){
			endPageNum=totalPageCount; //보정해준다. 
		}		
		// CafeDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다.
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//1. DB 에서 글 목록을 얻어온다.
		List<FullCalendarDto> list=dao.getList(dto);
		
		//EL, JSTL 을 활용하기 위해 필요한 모델을 request 에 담는다.
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("totalRow", totalRow);
		
	}

	//좋아요
	@Override
	public Map<String, Object> updateLikeCount(HttpServletRequest request) {
		
		int seq=Integer.parseInt(request.getParameter("seq"));
		String id=(String)request.getSession().getAttribute("id");
		
		FullCalendarDto dto=new FullCalendarDto();
		dto.setSeq(seq);
		dto.setId(id);
		
		//[{"isSuccess":boolean, "likecount":number}]
		Map<String, Object> map=new HashMap<String, Object>();

		//exhibition_like 테이블에서 로그인된 id가 like를 클릭한적 있는지 찾아보기
		int isClicked=dao.findLike(dto);
		int likeCount=0;
		
		if(isClicked==1) { //클릭한적 있다면
			//exhibition_like 테이블에서 정보를 제거하고
			boolean result1=dao.removeOnExhibitionLike(dto);
			//exhibition_likecount 테이블에서 like 개수를 하나 빼준다.
			boolean result2=dao.minusLikeCount(dto);
			likeCount=dao.getData(seq).getLikeCount();

			if(result1 && result2) {
				map.put("isSuccess", true);
				map.put("likecount", likeCount);
				return map;
			}else {
				map.put("isSuccess", false);
				map.put("likecount", likeCount);
				return map;
			}
			
			
		}else { //클릭한적 없다면
			
			//exhibition_like 테이블에 id와 seq번호를 저장하고
			boolean result1=dao.addOnExhibitionLike(dto);
			//exhibition_likecount 테이블에서 like 개수를 하나 더해준다.
			boolean result2=dao.addLikeCount(dto);
			likeCount=dao.getData(seq).getLikeCount();
			
			if(result1 && result2) {
				map.put("isSuccess", true);
				map.put("likecount", likeCount);
				return map;
			}else {
				map.put("isSuccess", false);
				map.put("likecount", likeCount);
				return map;
			}
		}//if end
		
	}//updateLikeCount() end

}
