package com.acorn.exhibition.users.controller;



import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.exhibition.users.dto.UsersDto;
import com.acorn.exhibition.users.service.UsersService;



@Controller
public class UsersController {

	@Autowired
	private UsersService service;
	
	//회원가입 폼 요청 처리
	@RequestMapping("/users/signup_form")
	public String sign_up_form() {
		return "users/signup_form";
	} 
	
	@ResponseBody
	@RequestMapping("/users/checkid")
	public Map<String ,Object> checkid(@RequestParam String inputId){
		Map<String,Object> map = service.isExistId(inputId);
		return map;
	}
	
	// 회원가입 컨트롤
   @ResponseBody
   @RequestMapping(value = "/users/signup",method = RequestMethod.POST)
   public Map<String, Object> signup(@ModelAttribute("dto") UsersDto dto) {
      Map<String, Object> map=service.addUser(dto);
      return map;
   }
	
	
	//로그인 폼 요청 처리
	@RequestMapping("/users/loginform")
	public String loginform(HttpServletRequest request) {
		// "url" 이라는 파라미터가 넘어오는지 읽어와 본다.  
		String url=request.getParameter("url");
		if(url==null){//만일 없으면 
			//로그인 성공후에 index 페이지로 보낼수 있도록 구성한다. 
			url=request.getContextPath()+"/home.do";
		}
		//아이디, 비밀번호가 쿠키에 저장되었는지 확인해서 저장 되었으면 폼에 출력한다.
		Cookie[] cookies=request.getCookies();
		//저장된 아이디와 비밀번호를 담을 변수 선언하고 초기값으로 빈 문자열 대입 
		String savedId="";
		String savedPwd="";
		if(cookies != null){
			for(Cookie tmp:cookies){
				if(tmp.getName().equals("savedId")){
					savedId=tmp.getValue();
				}else if(tmp.getName().equals("savedPwd")){
					savedPwd=tmp.getValue();
				}
			}
		}	
		//view page 에서 필요한 정보 넘겨주기 
		request.setAttribute("url", url);
		request.setAttribute("savedId", savedId);
		request.setAttribute("savedPwd", savedPwd);
		return "users/loginform";
	}

	//로그인 요청 처리 
	@ResponseBody
	@RequestMapping(value = "/users/login", method = RequestMethod.POST)
	public Map<String, Object> login(@ModelAttribute UsersDto dto,
			ModelAndView mView, 
			HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> map=new HashMap<String, Object>();
		//목적지 정보
		String url=request.getParameter("url");
		if(url==null){
			url=request.getContextPath()+"/home.do";
		}
		//목적지 정보를 미리 인코딩 해 놓는다.
		String encodedUrl=URLEncoder.encode(url);
		map.put("url", url);
		map.put("encodedUrl", encodedUrl);
		
		//아이디 비밀번호 저장 체크박스를 체크 했는지 읽어와 본다.
		String isSave=request.getParameter("isSave");	
		//아이디, 비밀번호를 쿠키에 저장
		Cookie idCook=new Cookie("savedId", dto.getId());
		Cookie pwdCook=new Cookie("savedPwd", dto.getPwd());
		if(isSave != null){ // null 이 아니면 체크 한 것이다.
			//한달 동안 저장하기
			idCook.setMaxAge(60*60*24*30);
			pwdCook.setMaxAge(60*60*24*30);
		}else{
			//쿠키 지우기 
			idCook.setMaxAge(0);
			pwdCook.setMaxAge(0);
		}
		//응답할때 쿠키도 심어 지도록 
		response.addCookie(idCook);
		response.addCookie(pwdCook);
		boolean isSuccess=service.validUser(dto, request.getSession(), mView);
		map.put("isSuccess", isSuccess);
		return map;
	}

	//로그아웃 처리
	@RequestMapping("/users/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/home.do";
	}
	
	//개인정보 보기 요청 처리
	@RequestMapping("/users/info")
	public ModelAndView authinfo(HttpServletRequest request, ModelAndView mView ) {
		String id=(String)request.getSession().getAttribute("id");
		//UsersService 객체를 이용해서 개인정보를 ModelAndView 객체에 담기도록 한다.
		service.showInfo(id, mView);
		mView.setViewName("users/info");	
		return mView;
	}
	/*
	 * [ 파일 업로드 설정 ]
	 * 
	 * 1.pom.xml 에 commons-fileupload , commons-io dependency 명시하기
	 * 2.servlet-context.xml 에 CommonsMultipartResolver bean 설정
	 * 3.MultipartFile  객체 활용
	 * 4.upload 폴더 만들기
	 */
	@ResponseBody
	@RequestMapping(value="/users/profile_upload",method=RequestMethod.POST)
	public Map<String,Object> profileUpload(HttpServletRequest request, 
			@RequestParam MultipartFile profileImage,
			@ModelAttribute UsersDto dto,
			@RequestParam int checkReqPage){
		Map<String,Object> map = new HashMap<>();
		if(checkReqPage==2) {
			//{"savedPath":"/upload/xxxx.jpg"}형식의 JSON 문자열을 리턴해 주도록
			String path= service.saveProfileImage(request, profileImage);
			map.put("savePath", path);
		}else if(checkReqPage==1) {
			String path= service.saveProfileImage(request, profileImage);
			dto.setProfile(path);
			boolean saveSuccess=service.updateProfile(dto);
			map.put("savePath", path);
			map.put("saveSuccess", saveSuccess);
		}

		return map;
	}
		
	@RequestMapping("/users/pwd_updateform")
	public ModelAndView authPwdForm(HttpServletRequest request, ModelAndView mView) {
		mView.setViewName("users/pwd_updateform");
		return mView;
	}
	@ResponseBody
	@RequestMapping("/users/checkPwd")
	public Map<String, Object> checkPwd(@RequestParam String inputPwd, HttpSession session){
		return service.checkPwd(inputPwd, session);
	}
	
	//비밀번호 수정반영 요청처리
	@RequestMapping("/users/pwd_update")
	public ModelAndView authPwdUpdate(HttpServletRequest request, ModelAndView mView) {
		//기존비밀번호
		String pwd=request.getParameter("pwd");
		//새비밀번호
		String newPwd=request.getParameter("newPwd");
		String id=(String)request.getSession().getAttribute("id");
		//위의 3가지 정보를 UsersDto 객체에 담고
		UsersDto dto = new UsersDto();
		dto.setPwd(pwd);
		dto.setNewPwd(newPwd);
		dto.setId(id);
		//서비스에 전달
		service.updatePassword(dto, mView);
		mView.setViewName("users/pwd_update");
		return mView;
	}
	@RequestMapping("/users/updateform")
	public ModelAndView UserupdateForm(HttpServletRequest request,ModelAndView mView) {
		String id=(String)request.getSession().getAttribute("id");
		//UsersService 객체를 이용해서 개인정보를 ModelAndView 객체에 담기도록 한다.
		service.showInfo(id, mView);
		mView.setViewName("users/updateform");
		return mView;
	}
	@RequestMapping(value="/users/update", method=RequestMethod.POST)
	public ModelAndView authUserUpdate(@ModelAttribute UsersDto dto, HttpServletRequest request) {
		service.updateUser(dto);		
		return new ModelAndView("redirect:/users/info.do");
	}
	@RequestMapping("/users/delete")
	public ModelAndView authDelete(HttpServletRequest request, ModelAndView mView) {
		HttpSession session = request.getSession();
		String id =(String)session.getAttribute("id");
		//서비스를 이용해서 해당 회원 정보 삭제
		service.delete(id);
		//로그아웃처리 
		session.invalidate();
		mView.addObject("id", id);
		mView.setViewName("users/delete");
		return mView;
	}
	@ResponseBody
	@RequestMapping("/users/likelist")
	public ModelAndView list(ModelAndView mView, HttpServletRequest request,HttpSession session) {
		service.likelist(request,session);
		mView.setViewName("users/likelist");
		return mView;
	}
}
     