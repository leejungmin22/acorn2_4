package com.acorn.exhibition.comment.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acorn.exhibition.comment.dao.CommentDao;
import com.acorn.exhibition.home.dto.CommentDto;
import com.acorn.exhibition.home.dto.FullCalendarDto;


@Service
public class CommentServiceImpl implements CommentService{
	@Autowired
	private CommentDao commentDao;
	
	@Override
	public void saveComment(HttpServletRequest request) {
		//댓글 작성자
		String writer=(String)request.getSession().getAttribute("id");
		//댓글의 그룹번호
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));
		//댓글의 대상자 아이디
		String target_id=request.getParameter("target_id");
		//댓글의 내용
		String content=request.getParameter("content");
		//댓글 내에서의 그룹번호 (null 이면 원글의 댓글이다)
		String comment_group=request.getParameter("comment_group");		
		//저장할 댓글의 primary key 값이 필요하다
		int seq = commentDao.getSequence();
		//댓글 정보를 Dto 에 담기
		CommentDto dto=new CommentDto();
		dto.setNum(seq);
		dto.setWriter(writer);
		dto.setTarget_id(target_id);
		dto.setContent(content);
		dto.setRef_group(ref_group);
		
		if(comment_group==null) {//원글의 댓글인 경우
			//댓글의 글번호가 댓글의 그룹 번호가 된다.
			dto.setComment_group(seq);
		}else {//댓글의 댓글인 경우
			//comment_group 번호가 댓글의 그룹번호가 된다.
			dto.setComment_group(Integer.parseInt(comment_group));
		}
		
		//댓글 정보를 DB 에 저장한다.
		commentDao.insert(dto);
		
	}

	@Override
	public void deleteComment(int num) {
		commentDao.delete(num);
		
	}

	@Override
	public void updateComment(CommentDto dto) {
		commentDao.update(dto);
		
	}
	
	public void commentList(HttpServletRequest request) {
		
		//파라미터로 전달되는 글번호
		int seq=Integer.parseInt(request.getParameter("seq"));
		FullCalendarDto dto=new FullCalendarDto();
		dto.setSeq(seq);
		/* 댓글 페이징 처리 */
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
		//2. 글 목록을 응답한다.
		
		//EL, JSTL 을 활용하기 위해 필요한 모델을 request 에 담는다.
		request.setAttribute("commentList", commentList);
		request.setAttribute("dto", dto);
	}

	@Override
	public Map<String, Object> com_updateLikeCount(HttpServletRequest request) {

		int seq=Integer.parseInt(request.getParameter("seq"));
		String id=(String)request.getSession().getAttribute("id");
		int num = commentDao.getSequence(); 
		
		CommentDto dto=new CommentDto();
		dto.setRef_group(seq);
		dto.setId(id);
		dto.setNum(num);
		
		FullCalendarDto fdto=new FullCalendarDto();
		fdto.setSeq(seq);
		fdto.setId(id);
		
		//[{"isSuccess":boolean, "likecount":number}]
		Map<String, Object> map=new HashMap<String, Object>();

		//exhibition_like 테이블에서 로그인된 id가 like를 클릭한적 있는지 찾아보기
		int num_like=commentDao.findLike(dto);
		List<CommentDto> likeCount=commentDao.getList(fdto);
		
		if(num_like==1) { //클릭한적 있다면
			
			//exhibition_like 테이블에서 정보를 제거하고
			boolean result1=commentDao.removeOncommentLike(dto);
			//tb_api_date 테이블에서 like 개수를 하나 빼준다.
			boolean result2=commentDao.minuscommentLikeCount(dto);
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
			boolean result1=commentDao.addOnCommentLike(dto);
			//tb_api_date 테이블에서 like 개수를 하나 더해준다.
			boolean result2=commentDao.addcommentLikeCount(dto);
			
			if(result1 && result2) {
				map.put("isSuccess", true);
				map.put("likecount", likeCount);
				return map;
			}else {
				map.put("isSuccess", false);
				map.put("likecount", likeCount);
				return map;
			}
		}//if e
	}
	
}
