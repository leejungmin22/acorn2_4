package com.acorn.exhibition.home.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
		
		Date todate = new Date();
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyyMMdd");
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(todate);
		cal.add(Calendar.YEAR, 1); // 현재시간 + 1년
		
		String fromTime = format1.format(todate);				
		String toTime = format1.format(cal.getTime());
				
		System.out.println("from : "+fromTime);
		System.out.println("to : "+toTime);

		// 필드
		int page = 1;
		String apiUrl;
		String url = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period?serviceKey" // API URL
				+ "=Gz2ltmko3fuxZQxk8hBjvYFNlR9DqV9a2SSG80HzdcKMvY99yDDYxCV5H%2Fl0mJtEmDimd9LEm5T5TgX%2BOH9IHA%3D%3D"
				+ "&sortStdr=1" 
				+ "&from="+fromTime 
				+ "&to="+toTime 
				+ "&rows=1" 
				+ "&place=1" 
				+ "&cPage=";
		
		

		try {
			apiUrl = url + Integer.toString(page);

			System.out.println("----- Parsing URL -----");
			System.out.println(apiUrl);

			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(apiUrl);

			// root tag
			doc.getDocumentElement().normalize();
			System.out.println("Root element :" + doc.getDocumentElement().getNodeName());

			// totalCount 값 출력
			NodeList msgBodyTag = doc.getElementsByTagName("msgBody");
			Node msgNode = msgBodyTag.item(0).getFirstChild();

			if (msgNode != null && msgNode.getNodeName().equals("totalCount")) {
				System.out.println("totalCount=" + msgNode.getFirstChild().getNodeValue());
			} else {
				System.out.println("뽑아올 데이터가 없습니다.");
			}

			int TotalCount = Integer.parseInt(msgNode.getFirstChild().getNodeValue());

			for (int i = 1; i <= TotalCount; i++) {
				
				dto = new ApiDto();				

				apiUrl = url + Integer.toString(i);
				System.out.println(i+"번째 URL : "+apiUrl);
				Document parseDoc = dBuilder.parse(apiUrl);

				// 파싱할 tag
				NodeList nList = parseDoc.getElementsByTagName("perforList");
				Node nNode = nList.item(0);
				Element eElement = (Element) nNode;		
				
				int seq = Integer.parseInt(getTagValue("seq", eElement));
				String title = getTagValue("title", eElement);
				String startDate = getTagValue("startDate", eElement);
				String endDate = getTagValue("endDate", eElement);
				String place = getTagValue("place", eElement);
				String realmName = getTagValue("realmName", eElement);
				String area = getTagValue("area", eElement);
				String thumbNail = getTagValue("thumbnail", eElement);
				String gpsX = getTagValue("gpsX", eElement);
				String gpsY = getTagValue("gpsY", eElement);

				dto.setSeq(seq);
				dto.setTitle(title);
				dto.setStartDate(startDate);
				dto.setEndDate(endDate);
				dto.setPlace(place);
				dto.setRealmName(realmName);
				dto.setArea(area);
				dto.setThumbNail(thumbNail);
				dto.setGpsX(gpsX);
				dto.setGpsY(gpsY);

				try {								
					service.addExhibition(dto);
				} catch (Exception e) {
					System.out.println("일련번호  : " + getTagValue("seq", eElement) + "는 이미 추가되있습니당.");
					break;
				}
				

			}

		}

		catch (Exception e) {
			e.printStackTrace();
		} // try~catch end

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
