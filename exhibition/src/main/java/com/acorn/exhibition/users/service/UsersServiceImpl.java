package com.acorn.exhibition.users.service;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

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
	public void addUser(UsersDto dto, HttpServletRequest request, MultipartFile mFile) {
		
		if(request!=null && mFile != null && mFile.getSize() != 0) { // 업로드된 파일이 있을 경우에만 실행
			//파일을 저장할 폴더의 절대 경로를 얻어온다.
			String realPath=request.getServletContext().getRealPath("/upload");
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
			String saveFileName=System.currentTimeMillis()+orgFileName;
			try{
				//upload 폴더에 파일을 저장한다.
				mFile.transferTo(new File(filePath+saveFileName));
			}catch(Exception e){
				e.printStackTrace();
			}
			
			//UsersDao 객체를 이용해서 프로파일 이미지경로를 DB 에 저장하기
			String path="/upload/"+saveFileName;
			dto.setProfile(path);
		}
		
		//비밀번호를 암호화 한다,
		String encodePwd = new BCryptPasswordEncoder().encode(dto.getPwd());
		//암호화된 비밀번호를 UsersDto 에 다시 넣어준다
		dto.setPwd(encodePwd);
		//UsersDao 객체를 통해서 DB에 저장하기
		dao.insert(dto);
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
	public void validUser(UsersDto dto, HttpSession session, ModelAndView mView) {
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
		}
		
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
				//경로를 DB 에 저장하기
				String path="/upload/"+saveFileName;			
				//로그인된 아이디
				String id=(String)request.getSession().getAttribute("id");
				//아이디와 프로파일 이미지 경로를 dto 에 담고 
				UsersDto dto=new UsersDto();
				dto.setId(id);
				dto.setProfile(path);
				// UsersDao 를 이용해서 DB 에 반영하기 
				dao.updateProfile(dto);
				
				//이미지 경로 리턴해주기 
				return path;
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


}