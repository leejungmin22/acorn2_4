import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class MemberDto {
	public static void main(String[] args) throws IOException {
		 // tag값의 정보를 가져오는 메소드
	       private static String getTagValue(String tag, Element eElement) {
	           NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	           Node nValue = (Node) nlList.item(0);
	           if(nValue == null) 
	               return null;
	           return nValue.getNodeValue();
	       }

	       public static void main(String[] args) {
	          int page = 1;   // 페이지 초기값 
	          try{
	             while(true){
	                // parsing할 url 지정(API 키 포함해서)
	                String url = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period?serviceKey" // API URL
	                      + "=Gzucim5lzooErQ0Qgc1a9JJdDvmsLFen8FrtxvyyHIunOxx72D2lv5DYVSkZEiT8dBJcFMz72lDgSRQifsLx1Q%3D%3D" // 인증
	                      // 검색 조건부분
	                      //+ "&sortStdr=1"
	                      //+ "&RequestTime=20100810%3A23003422"
	                      + "&from=20140101"
	                      + "&to=20201201"
	                      //+ "&cPage=1"
	                      //+ "&rows=100"
	                      //+ "&place=1"
	                      +page;
	                
	                DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
	                DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
	                Document doc = dBuilder.parse(url);
	                
	                // root tag 
	                doc.getDocumentElement().normalize();
	                System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
	                
	                // 파싱할 tag
	                NodeList nList = doc.getElementsByTagName("perforList"); // "baseinfo" --> "perforList"
	                //System.out.println("파싱할 리스트 수 : "+ nList.getLength());
	                
	                for(int temp = 0; temp < nList.getLength(); temp++){
	                   Node nNode = nList.item(temp);
	                   if(nNode.getNodeType() == Node.ELEMENT_NODE){
	                      
	                      Element eElement = (Element) nNode;
	                      System.out.println("기간별 공연/전시목록-----------------------------------------------------------------------------------");
	                      //System.out.println(eElement.getTextContent());
	                      System.out.println("일련번호  : " + getTagValue("seq", eElement));
	                      System.out.println("제목  : " + getTagValue("title", eElement));
	                      System.out.println("시작일 : " + getTagValue("startDate", eElement));
	                      System.out.println("마감일  : " + getTagValue("endDate", eElement));
	                      System.out.println("장소  : " + getTagValue("place", eElement));
	                      System.out.println("분류명  : " + getTagValue("realmName", eElement));
	                      System.out.println("지역  : " + getTagValue("area", eElement));
	                      System.out.println("썸네일   : " + getTagValue("thumbnail", eElement));
	                      System.out.println("gps-X좌표  : " + getTagValue("gpsX", eElement));
	                      System.out.println("gps-Y좌표  : " + getTagValue("gpsY", eElement));               
	                   }   // for end
	                }   // if end
	                
	                page += 1;
	                System.out.println("page number : "+page);
	                if(page > 12){   
	                   break;
	                }
	             }   // while end
	             
	          } catch (Exception e){   
	             e.printStackTrace();
	          }   // try~catch end
	       }   // main end

	}

}
