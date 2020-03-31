package com.acorn.exhibition.users.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.exhibition.home.dto.FullCalendarDto;
import com.acorn.exhibition.users.dao.UsersDao;
import com.acorn.exhibition.users.dto.UsersDto;


@Service
public class UsersServiceImpl implements UsersService{

	@Autowired
	private UsersDao dao;
	//인자로 전달된 아이디가 존재하는지 여부를 Map 에 담아서 리턴하는 메소드
	@Override
	public Map<String, Object> isExistId(String inputId) {
		boolean isExist=dao.isExist(inputId);
		Map<String,Object> map = new HashMap<>();
		map.put("isExist", isExist);
		return map;
	}
	
	   @Override
	   public Map<String, Object> addUser(UsersDto dto) {
	      //비밀번호를 암호화 한다,
	      String encodePwd = new BCryptPasswordEncoder().encode(dto.getPwd());
	      //암호화된 비밀번호를 UsersDto 에 다시 넣어준다
	      dto.setPwd(encodePwd);
	      Map<String, Object> map = new HashMap<String, Object>();
	      //UsersDao 객체를 통해서 DB에 저장하기
	      int isSuccess = dao.insert(dto);
	      if(isSuccess==1) {
	         map.put("isSuccess", true);
	      }else {
	         map.put("isSuccess", false);
	      }
	      
	      return map;
	   }

	@Override
	public Map<String, Object> checkPwd(String inputPwd, HttpSession session) {
		Map<String, Object> map=new HashMap<String, Object>();
		String id=(String) session.getAttribute("id");
		//아이디 비밀번호가 유효한지 여부
		boolean isValid=false;
		//아이디를 이용해서 저장된 비밀번호를 읽어온다.
		String pwdHash=dao.getPwdHash(id);
		if(pwdHash != null) { //비밀번호가 존재하고
			//입력한 비밀번호와 일치 하다면 로그인 성공
			isValid=BCrypt.checkpw(inputPwd, pwdHash);
			map.put("isValid", isValid);
		}
		map.put("isValid", isValid);
		return map;
	}

	
	@Override
	public boolean validUser(UsersDto dto, HttpSession session, ModelAndView mView) {
		//아이디 비밀번호가 유효한지 여부
		boolean isValid=false;
		//아이디를 이용해서 저장된 비밀번호를 읽어온다.
		String pwdHash=dao.getPwdHash(dto.getId());
		String getAdminAuth = dao.getAdminAuth(dto.getId());
		if(pwdHash != null) { //비밀번호가 존재하고
			//입력한 비밀번호와 일치 하다면 로그인 성공
			isValid=BCrypt.checkpw(dto.getPwd(), pwdHash);
		}
		if(isValid) {
			//로그인성공
			session.setAttribute("id", dto.getId());	
			session.setAttribute("admin", getAdminAuth);
			return isValid;
		}
		
		return isValid;
		
	}
	
	@Override
	public void showInfo(String id, ModelAndView mView) {
		UsersDto dto = dao.getData(id);
		mView.addObject("dto",dto);
	}
	
	@Override
	public String saveProfileImage(HttpServletRequest request, MultipartFile mFile) {
		//파일을 저장할 폴더의 절대 경로를 얻어온다.
		String realPath=request
				.getServletContext().getRealPath("/upload");
		//원본 파일명
		String orgFileName=mFile.getOriginalFilename();
		//저장할 파일의 상세 경로
		String filePath=realPath+File.separator;
		//디렉토리를 만들 파일 객체 생성
		File file=new File(filePath);
		if(!file.exists()){//디렉토리가 존재하지 않는다면
			file.mkdir();//디렉토리를 만든다.
		}
		//파일 시스템에 저장할 파일명을 만든다. (겹치치 않게)
		String saveFileName=
				System.currentTimeMillis()+orgFileName;
		try{
			//upload 폴더에 파일을 저장한다.
			mFile.transferTo(new File(filePath+saveFileName));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		//UsersDao 객체를 이용해서 프로파일 이미지
		String path="/upload/"+saveFileName;				
		//이미지 경로 리턴해주기 
		return path;
	}
	
	@Override
	public boolean updateProfile(UsersDto dto) {
		int isSuccess=dao.updateProfile(dto);
		if(isSuccess==1) {
			return true;
		}else {
			return false;
		}
	}
	
	@Override
	public void updatePassword(UsersDto dto, ModelAndView mView) {
		//1.예전 비밀번호가 맞는 정보인지 확인
		String pwdHash=dao.getData(dto.getId()).getPwd();
		//2. 만일 맞다면 새로 비밀번호를 암호화해서 저장하기
		boolean isValid=BCrypt.checkpw(dto.getPwd(), pwdHash);
		if(isValid) {
			//새비밀번호를 암호화해서  dto에담고
			String encodedPwd=new BCryptPasswordEncoder().encode(dto.getNewPwd());
			dto.setPwd(encodedPwd);
			dao.updatePwd(dto);
			mView.addObject("isSuccess", true);
			//db에 수정반영하기
		}else {
			mView.addObject("isSuccess",false);
			}
	}
	@Override
	public void updateUser(UsersDto dto) {
		String birth=dto.getBirth();
		String birthFormat="";
		
		if(birth!=null){
			String[] birtheArr=birth.split("-");
			
			for(int i=0; i<birtheArr.length; i++) {
				birthFormat+=birtheArr[i];
			}
		}
		
		dto.setBirth(birthFormat);
		dao.updateUser(dto);
	}
	@Override
	public void delete(String id) {
		dao.delete(id);
	}

	@Override
	public void likelist(HttpServletRequest request,HttpSession session) {
		/*
		 *  request 에 검색 keyword 가 전달될수도 있고 안될수도 있다.
		 *  - 전달 안되는 경우 : navbar 에서 cafe를 누른경우 
		 *  - 전달 되는 경우 : 하단에 검색어를 입력하고 검색 버튼을 누른경우
		 *  - 전달 되는 경우2: 이미 검색을 한 상태에서 하단 페이지 번호를 누른 경우 
		 */
		
		//검색과 관련된 파라미터를 읽어와 본다.
		String id=(String) session.getAttribute("id");
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
		dto.setId(id);
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
		List<FullCalendarDto> likelist=dao.getlikeList(dto);
		request.setAttribute("likelist", likelist);
		
		//EL, JSTL 을 활용하기 위해 필요한 모델을 request 에 담는다.
		
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("totalRow", totalRow);
		
	}


}