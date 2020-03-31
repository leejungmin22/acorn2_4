package com.acorn.exhibition.com.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.exhibition.com.dao.ComCommentDao;
import com.acorn.exhibition.com.dao.ComDao;
import com.acorn.exhibition.com.dto.ComCommentDto;
import com.acorn.exhibition.com.dto.ComDto;


@Service
public class ComServiceImpl implements ComService{
	@Autowired
	private ComDao comDao;
	@Autowired
	private ComCommentDao comCommentDao;
	
	static final int PAGE_ROW_COUNT=10;	
	static final int PAGE_DISPLAY_COUNT=5;

	@Override
	public void getList(HttpServletRequest request) {
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");
		
		//ComDto 객체 생성(select 할 때 필요한 정보 담기위해) 
		ComDto dto=new ComDto();
		
		if(keyword != null) {
			if(condition.equals("titlecontent")) {//제목+내용
				dto.setTitle(keyword);
				dto.setContent(keyword);
			}else if(condition.equals("title")) {//제목
				dto.setTitle(keyword);
			}else if(condition.equals("writer")) {//작성자
				dto.setWriter(keyword);
			}
			
			/*
			 *  검색 키워드에는 한글이 포함될 가능성이 있기 때문에
			 *  링크에 그대로 출력가능하도록 하기 위해 미리 인코딩을 해서
			 *  request 에 담아준다.
			 */			
			String encodedKeyword=null;
			
			try {
				encodedKeyword=URLEncoder.encode(keyword,"utf-8");
			}catch(UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			request.setAttribute("encodedKeyword", encodedKeyword);
			request.setAttribute("keyword", keyword);
			request.setAttribute("condition", condition);
		}
		//보여줄 페이지 번호
		int pageNum=1;
		
		String strPageNum=request.getParameter("pageNum");
		
		if(strPageNum != null) {
			pageNum=Integer.parseInt(strPageNum);
		}
		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		//전체 row의 갯수 읽어오기
		int totalRow=comDao.getCount(dto);
		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//시작 페이지 번호
		int startPageNum=1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		if(totalPageCount<endPageNum) {
			endPageNum=totalPageCount;
		}
	
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		List<ComDto> list=comDao.getList(dto);
		
		//필요한 값 request에 담기
		request.setAttribute("list", list);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("totalRow", totalRow); //전체글의 갯수
	}

	@Override
	public void saveContent(ComDto dto) {
		comDao.insert(dto);
	}

	@Override
	public void getDetail(HttpServletRequest request) {
		int num=Integer.parseInt(request.getParameter("num"));
		
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");

		//CafeDto 객체 생성 (select 할때 필요한 정보를 담기 위해)
		ComDto dto=new ComDto();

		if(keyword != null) {//검색 키워드가 전달된 경우
			if(condition.equals("titlecontent")) {//제목+내용 검색
				dto.setTitle(keyword);
				dto.setContent(keyword);
			}else if(condition.equals("title")) {//제목 검색
				dto.setTitle(keyword);
			}else if(condition.equals("writer")) {//작성자 검색
				dto.setWriter(keyword);
			}
			//request 에 검색 조건과 키워드 담기
			request.setAttribute("condition", condition);
			/*
			 *  검색 키워드에는 한글이 포함될 가능성이 있기 때문에
			 *  링크에 그대로 출력가능하도록 하기 위해 미리 인코딩을 해서
			 *  request 에 담아준다.
			 */
			String encodedKeyword=null;
			try {
				encodedKeyword=URLEncoder.encode(keyword, "utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			//인코딩된 키워드와 인코딩 안된 키워드를 모두 담는다.
			request.setAttribute("encodedKeyword", encodedKeyword);
			request.setAttribute("keyword", keyword);
		}		
		//ComDto 에 글번호도 담기
		dto.setNum(num);
		//조회수 1 증가 시키기
		comDao.addViewCount(num);
		//글정보를 얻어와서
		ComDto dto2=comDao.getData(dto);
		//request 에 글정보를 담고 
		request.setAttribute("dto", dto2);
		//댓글 목록 얻어와서 request에 담아준다.
		List<ComCommentDto> comCommentList=comCommentDao.getList(num);
		request.setAttribute("comCommentList", comCommentList);
	}

	@Override
	public void deleteContent(int num, HttpServletRequest request) {
		String id=(String)request.getSession().getAttribute("id");
		String admin = (String)request.getSession().getAttribute("admin");
		String writer=comDao.getData(num).getWriter();
		// admin
		if(!id.equals(writer) || !admin.equals("1")) {
			
		}
		comDao.delete(num);
	}

	@Override
	public void getUpdateData(ModelAndView mView, int num) {
		ComDto dto=comDao.getData(num);
		mView.addObject("dto", dto);
	}

	@Override
	public void updateContent(ComDto dto) {
		comDao.update(dto);
	}
	//댓글 저장하는 메소드
	@Override
	public void saveComment(HttpServletRequest request) {
		//댓글 작성자
		String writer=(String)request.getSession()
						.getAttribute("id");
		//댓글 그룹번호
		int ref_group=
				Integer.parseInt(request.getParameter("ref_group"));
		//댓글의 대상자 아이디
		String target_id=request.getParameter("target_id");
		//댓글의 내용
		String content=request.getParameter("content");
		//댓글 내에서의 그룹번호(null이면 원글의 댓글)
		String comment_group=
				request.getParameter("comment_group");
		//저장 할 댓글의 primary key 값이 필요하다
		int seq=comCommentDao.getSequence();
		//댓글 정보를 Dto에 담기
		ComCommentDto dto=new ComCommentDto();
		dto.setNum(seq);
		dto.setWriter(writer);
		dto.setTarget_id(target_id);
		dto.setContent(content);
		dto.setRef_group(ref_group);
		
		if(comment_group==null) { //원글의 댓글
			//댓글의 글번호가 댓글의 그룹번호가 된다.
			dto.setComment_group(seq);
		}else { //댓글의 댓글
			//comment_group번호가 댓글의 그룹번호가 된다.
			dto.setComment_group(Integer.parseInt(comment_group));
		}
		//댓글정보 DB 저장
		comCommentDao.insert(dto);
	}

	@Override
	public void deleteComment(int num) {
		comCommentDao.delete(num);
	}
}

