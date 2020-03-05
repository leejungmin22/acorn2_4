package com.acorn.exhibition.home.service;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.acorn.exhibition.home.dto.ExhibitionDto;


public class XmlParsing {
    // tag값의 정보를 가져오는 메소드
	public static String getTagValue(String tag, Element eElement) {
	    NodeList nlList =  eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) {
	        return null;
	    }    
	    return nValue.getNodeValue();
	}

	public static ExhibitionDto getData(int seq) {
		ExhibitionDto dto=new ExhibitionDto();
		try{
			String url = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/"
					+ "?ServiceKey=ePfX3pu9m%2BajEWgHGiwfbd%2BNSNIpVJ58g9N%2Fp%2B%2F996n%2FnwagNeyc52WUEYYlE34jKS00Eg3EOlVVVu4g0OTkSQ%3D%3D"
					+ "&seq="+seq;
			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(url);
			
			// root tag 
			doc.getDocumentElement().normalize();
			System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
			
			// 파싱할 tag
			NodeList nList = doc.getElementsByTagName("perforInfo");
			System.out.println("파싱할 리스트 수 : "+ nList.getLength());
			
			
			for(int temp = 0; temp < nList.getLength(); temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					
					Element eElement = (Element)nNode;
					
					dto.setSeq(Integer.parseInt(getTagValue("seq", eElement)));
					dto.setTitle(getTagValue("title", eElement));
					dto.setStartDate(getTagValue("startDate", eElement));
					dto.setEndDate(getTagValue("endDate", eElement));
					dto.setPlace(getTagValue("place", eElement));
					dto.setRealmName(getTagValue("realmName", eElement));
					dto.setArea(getTagValue("area", eElement));
					dto.setSubTitle(getTagValue("subTitle", eElement));
					dto.setPrice(getTagValue("price", eElement));
					dto.setContents1(getTagValue("contents1", eElement));
					dto.setContents2(getTagValue("contents2", eElement));
					dto.setUrl(getTagValue("url", eElement));
					dto.setPhone(getTagValue("phone", eElement));
					dto.setGpsX(getTagValue("gpsX", eElement));
					dto.setGpsY(getTagValue("gpsY", eElement));
					dto.setImgUrl(getTagValue("imgUrl", eElement));
					dto.setPlaceUrl(getTagValue("placeUrl", eElement));
					dto.setPlaceAddr(getTagValue("placeAddr", eElement));
					dto.setPlaceSeq(getTagValue("placeSeq", eElement));
					
					System.out.println("######################");
					//System.out.println(eElement.getTextContent());
					System.out.println("일련번호  : " + getTagValue("seq", eElement));
					System.out.println("제목  : " + getTagValue("title", eElement));
					System.out.println("시작일 : " + getTagValue("startDate", eElement));
					System.out.println("마감일  : " + getTagValue("endDate", eElement));
					System.out.println("장소  : " + getTagValue("place", eElement));
					System.out.println("분류명  : " + getTagValue("realmName", eElement));
					System.out.println("지역  : " + getTagValue("area", eElement));
					System.out.println("공연부제목  : " + getTagValue("subTitle", eElement));
					System.out.println("티켓요금  : " + getTagValue("price", eElement));
					System.out.println("내용1  : " + getTagValue("contents1", eElement));
					System.out.println("내용2  : " + getTagValue("contents2", eElement));
					System.out.println("관람URL  : " + getTagValue("url", eElement));
					System.out.println("문의처  : " + getTagValue("phone", eElement));
					System.out.println("GPS-X좌표  : " + getTagValue("gpsX", eElement));
					System.out.println("GPS-Y좌표  : " + getTagValue("gpsY", eElement));
					System.out.println("이미지  : " + getTagValue("imgUrl", eElement));
					System.out.println("공연장URL  : " + getTagValue("placeUrl", eElement));
					System.out.println("공연장 주소  : " + getTagValue("placeAddr", eElement));
					System.out.println("문화예술공간 일련번호  : " + getTagValue("placeSeq", eElement));
					
				}	// for end
			}	// if end
				
		
		} catch (Exception e){	
			e.printStackTrace();
		}	// try~catch end
		
		return dto;
		
	} //getData method end
	

}
