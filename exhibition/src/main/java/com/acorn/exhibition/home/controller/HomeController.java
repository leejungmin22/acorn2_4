package com.acorn.exhibition.home.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.acorn.exhibition.home.dto.ApiDto;
import com.acorn.exhibition.home.dto.CommentDto;
import com.acorn.exhibition.home.service.HomeService;

@Controller
public class HomeController {
	@Autowired
	private HomeService service;

	@RequestMapping(value = "/home")
	public ModelAndView home(HttpServletRequest request, @ModelAttribute("dto") ApiDto dto, ModelAndView mView) {
		service.getPopularEvents(request);
		
		int page = 1;
		
		try{
			
		while(true){
			/*
				// 공연/전시상세정보조회 apiUrl
				String apiUrl = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?serviceKey" // API URL
				+ "=Gz2ltmko3fuxZQxk8hBjvYFNlR9DqV9a2SSG80HzdcKMvY99yDDYxCV5H%2Fl0mJtEmDimd9LEm5T5TgX%2BOH9IHA%3D%3D"
				+ "&from=20140101"
	            + "&to=20201201"
	            +page;
			*/
				// 기간별공연/전시목록조회 apiUrl
			  	String apiUrl = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period?serviceKey" // API URL
					+ "=Gz2ltmko3fuxZQxk8hBjvYFNlR9DqV9a2SSG80HzdcKMvY99yDDYxCV5H%2Fl0mJtEmDimd9LEm5T5TgX%2BOH9IHA%3D%3D"
					+ "&from=20140101"
	                + "&to=20201201"
	                +page;
			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(apiUrl);
			
			// root tag 
			doc.getDocumentElement().normalize();
			System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
			
			// 파싱할 tag
			NodeList nList = doc.getElementsByTagName("perforList");
			System.out.println("파싱할 리스트 수 : "+ nList.getLength());
			
			
			for(int temp = 0; temp < nList.getLength(); temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					dto=new ApiDto();
					Element eElement = (Element)nNode;
					
					int seq = Integer.parseInt(getTagValue("seq", eElement));
					String title = getTagValue("title", eElement);
					String startDate = getTagValue("startDate", eElement);
					String endDate = getTagValue("endDate", eElement);
					String place = getTagValue("place", eElement);
					String realmName = getTagValue("realmName", eElement);
					String area = getTagValue("area", eElement);
					String thumbNail = getTagValue("thumbnail", eElement);
					//String price = getTagValue("price", eElement);
					//String contents1 = getTagValue("contents1", eElement);
					//String contents2 = getTagValue("contents2", eElement);
					//String url = getTagValue("url", eElement); // String url로 사용하기 위해 이미 사용중이라 (Line 40) String apiUrl로 변경해줌
					//String phone = getTagValue("phone", eElement);
					String gpsX = getTagValue("gpsX", eElement);
					String gpsY = getTagValue("gpsY", eElement);
					//String imgUrl = getTagValue("imgUrl", eElement);
					//String placeUrl = getTagValue("placeUrl", eElement);
					//String placeAddr = getTagValue("placeAddr", eElement);
					//String placeSeq = getTagValue("placeSeq", eElement);
					
					dto.setSeq(seq);
					dto.setTitle(title);
					dto.setStartDate(startDate);
					dto.setEndDate(endDate);
					dto.setPlace(place);
					dto.setRealmName(realmName);
					dto.setArea(area);
					dto.setThumbNail(thumbNail);
					//dto.setPrice(price);
					//dto.setContents1(contents1);
					//dto.setContents2(contents2);
					//dto.setUrl(url);
					//dto.setPhone(phone);
					dto.setGpsX(gpsX);
					dto.setGpsY(gpsY);
					//dto.setImgUrl(imgUrl);
					//dto.setPlaceUrl(placeUrl);
					//dto.setPlaceAddr(placeAddr);
					//dto.setPlaceSeq(placeSeq);			
					
					service.addExhibition(dto);
					
					System.out.println("------------------------------------------기간별 공연/전시목록------------------------------------------");
					//System.out.println(eElement.getTextContent());
					System.out.println("일련번호  : " + getTagValue("seq", eElement));
					/*
					System.out.println("제목  : " + getTagValue("title", eElement));
					System.out.println("시작일 : " + getTagValue("startDate", eElement));
					System.out.println("마감일  : " + getTagValue("endDate", eElement));
					System.out.println("장소  : " + getTagValue("place", eElement));
					System.out.println("분류명  : " + getTagValue("realmName", eElement));
					System.out.println("지역  : " + getTagValue("area", eElement));
					System.out.println("썸네일   : " + getTagValue("thumbnail", eElement));
					System.out.println("gps-X좌표  : " + getTagValue("gpsX", eElement));
					System.out.println("gps-Y좌표  : " + getTagValue("gpsY", eElement));
					*/
					
				}	// for end
			}	// if end
				
		     page += 1;
	          System.out.println("page number : "+page);
	          
	          if(page > 1000){   
	             break;
	          }
	       }   // while end
		}
		catch (Exception e){	
			e.printStackTrace();
		}	// try~catch end
	
		mView.setViewName("home");

		return mView;
	}

	public static String getTagValue(String tag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		if (nValue == null) {
			return null;
		}
		return nValue.getNodeValue();
	}

	@ResponseBody
	@RequestMapping(value = "/getEvents")
	public String getEvents() {
		String jsonStr = service.getEvent();
		return jsonStr;
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, @RequestParam int seq) {
		service.getData(request);
		return "detail";
	}

	// 댓글 저장 요청 처리
	@RequestMapping(value = "/comment_insert")
	public ModelAndView authCommentInsert(HttpServletRequest request, @RequestParam int ref_group) {
		service.saveComment(request);
		return new ModelAndView("redirect:/detail.do?seq=" + ref_group);
	}

	@ResponseBody
	@RequestMapping(value = "/comment_delete", method = RequestMethod.POST)
	public Map<String, Object> authCommentDelete(HttpServletRequest request, @RequestParam int num) {
		service.deleteComment(num);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("isSuccess", true);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/comment_update", method = RequestMethod.POST)
	public Map<String, Object> authCommentUpdate(HttpServletRequest request, @ModelAttribute CommentDto dto) {
		service.updateComment(dto);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("isSuccess", true);
		return map;
	}

	@RequestMapping(value = "/more_comment")
	public ModelAndView getComment(HttpServletRequest request, ModelAndView mView) {
		service.commentList(request);
		mView.addObject("id", request.getSession().getAttribute("id"));
		mView.setViewName("commentprint");
		return mView;
	}

	@RequestMapping("/list")
	public ModelAndView list(ModelAndView mView, HttpServletRequest request) {
		service.list(request);
		mView.setViewName("list");
		return mView;
	}

}
