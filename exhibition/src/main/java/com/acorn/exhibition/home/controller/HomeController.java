package com.acorn.exhibition.home.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import com.acorn.exhibition.home.dto.ApiDto;
import com.acorn.exhibition.home.service.HomeService;


@Controller
public class HomeController {
	@Autowired
	private HomeService service;
	  

	@RequestMapping(value = "/home")
	public ModelAndView home(HttpServletRequest request, @ModelAttribute("dto") ApiDto dto, ModelAndView mView) {
		service.getPopularEvents(request);
		
		// 데이터 검색 기간( 현재시간 ~ 현재시간 +1년 ) 검색하기 위한 부분
		Date todate = new Date();
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd"); // 시간 포맷 YYYYMMDD 
		Calendar cal = Calendar.getInstance();
		cal.setTime(todate); 
		cal.add(Calendar.YEAR, 1); // 현재시간 + 1년
		
		String fromTime = format1.format(todate); // fromTime : 컴퓨터의 현재 시간
		String toTime = format1.format(cal.getTime()); // toTime : fromTime + 1년

		int page = 1; // 읽어올 첫 페이지
		
		String apiUrl;
		String url = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period?serviceKey" // API URL
				+ "=Gz2ltmko3fuxZQxk8hBjvYFNlR9DqV9a2SSG80HzdcKMvY99yDDYxCV5H%2Fl0mJtEmDimd9LEm5T5TgX%2BOH9IHA%3D%3D"
				+ "&sortStdr=1" 
				+ "&from="+fromTime // 현재시간
				+ "&to="+toTime  // 현재시간 +1년
				+ "&rows=1" // 페이지당 1개 조회
				+ "&place=1" 
				+ "&cPage="; // 중요!
							 //apiUrl = url + Integer.toString(i);
							 // TotalCount 만큼 cPage를 증가시켜서 Data를 얻어오기 위함.
		
		try {
			apiUrl = url + Integer.toString(page); // 처음 Parsing할 Data의 페이지는 항상 1이다. cPage=1
			// ex) "http://www.culture.----&place=1&cPage=1"

			System.out.println("----- Parsing URL -----");
			System.out.println(apiUrl);

			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(apiUrl);

			// root tag
			doc.getDocumentElement().normalize();
			System.out.println("Root element :" + doc.getDocumentElement().getNodeName());

			// msgBody의 0번 node가 totalCount 값
			NodeList msgBodyTag = doc.getElementsByTagName("msgBody");
			Node msgNode = msgBodyTag.item(0).getFirstChild();
			
			if (msgNode != null && msgNode.getNodeName().equals("totalCount")) {
				System.out.println("뽑아올 공연 데이터 갯수 : " + msgNode.getFirstChild().getNodeValue());
			} else {
				System.out.println("뽑아올 데이터가 없습니다.");
			}
			
			// totalCount 값 얻어오기 ("msgBody"의 첫번째 자식 요소의 값을 얻어온다.)
			int TotalCount = Integer.parseInt(msgNode.getFirstChild().getNodeValue());
			
			// From~ToDate에서 조회된 Data Parsing을 하기위해서 TotalCount 만큼 반복
			for (int i = 1; i <= TotalCount; i++) {
				
				
				dto = new ApiDto();				

				apiUrl = url + Integer.toString(i);
				System.out.println(i+"번째 Parsing URL : "+apiUrl); // 데이터를 얻어올 XML URL 출력 (필요 없음)
				Document parseDoc = dBuilder.parse(apiUrl);

				// 파싱할 tag "perforList" 하위 노드에 데이터가 존재
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
					// 중복 데이터가 없으면 INSERT
					service.addExhibition(dto);
					System.out.println("일련번호  : " + getTagValue("seq", eElement) + " 공연 추가 완료.");
				} catch (Exception e) {
					System.out.println("일련번호  : " + getTagValue("seq", eElement) + " 공연은 이미 추가돼있습니다.");
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
	@RequestMapping("/list")
	public ModelAndView list(ModelAndView mView, HttpServletRequest request) {
		service.list(request);
		mView.setViewName("list");
		return mView;
	}
	
	@ResponseBody
	@RequestMapping("/updateLikeCount")
	public Map<String, Object> updateLikeCount(HttpServletRequest request) {
		Map<String, Object> result= service.updateLikeCount(request);
		return result;
	}

}
