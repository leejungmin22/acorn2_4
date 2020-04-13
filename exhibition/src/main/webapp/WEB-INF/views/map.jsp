<%@page import="com.acorn.exhibition.home.dto.mapDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역별 공연</title>
<link rel="stylesheet"
   href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<jsp:include page="include/resource.jsp" />
<style>
.btn-group.food {
   display: flex;
}
   .map_wrap, .map_wrap * {
      margin: 0;
      padding: 0;
      font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
      font-size: 12px;
   }
   .map_wrap a, .map_wrap a:hover, .map_wrap a:active {
      color: #000;
      text-decoration: none;
   }
   .map_wrap {
      position: relative;
      width: 100%;
      height: 500px;
   }
  
   .bg_white {
      background: #fff;
   }
   #menu_wrap hr {
      display: block;
      height: 1px;
      border: 0;
      border-top: 2px solid #5F5F5F;
      margin: 3px 0;
   }
   #menu_wrap .option {
      text-align: center;
   }
   #menu_wrap .option p {
      margin: 10px 0;
   }
   #menu_wrap .option button {
      margin-left: 5px;
   }
  

   #pagination {
      margin: 10px auto;
      text-align: center;
   }
   #pagination a {
      display: inline-block;
      margin-right: 10px;
   }
   #pagination .on {
      font-weight: bold;
      cursor: default;
      color: #777;
   }
   .sub-nav-left{
		display:block;
		position:relative;
		font-size:15px;
		float:none;
		margin:10px 0 10px 0;
		text-align:left;
		border-bottom:1px solid #ddd;
		padding:1px 0 5px;
		font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic",;
	}

	.heart{
	width: 20px;
	height: auto;
	}
	.maplist, .page-display{
		padding-top: 20px;
	}
	.maplist{
		padding-bottom: 40px;
	}
	.table-hover > thead > tr >  th {
		text-align: center;
	}
</style>
</head>
<body>

   <jsp:include page="include/navbar.jsp">
  	 <jsp:param value="map" name="category"/>
	</jsp:include>
	<div class="container">

   <div class="sub-nav-left">
		<a href="home.do">
			<img src="resources/images/home.png" alt="홈" />
		</a>
		> 
		<a href="${pageContext.request.contextPath }/map.do">지도</a>
	</div>	
   <h1>지역별 공연 </h1>
      <div class="map_wrap">
         <div id="map"
            style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
      </div>
</div>
</body>
<script type="text/javascript"
         src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9493bea6d98de2e126bef936b4f25a8d&libraries=services"></script>
      <script>
         
         var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
         mapOption = {
            //center : new kakao.maps.LatLng(37.49795,127.027637), // 지도의 중심좌표
            center : new kakao.maps.LatLng(37.266444,126.997219), // 지도의 중심좌표
            level : 5
         // 지도의 확대 레벨
         };
        

         var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
         
         
     	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
         if (navigator.geolocation) {
             
             // GeoLocation을 이용해서 접속 위치를 얻어옵니다
             navigator.geolocation.getCurrentPosition(function(position) {
                 
                 var lat = position.coords.latitude, // 위도
                     lon = position.coords.longitude; // 경도
                 
                 var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
                     message = '<div style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다
                 
                 // 마커와 인포윈도우를 표시합니다
                 displayMarker(locPosition, message);
                     
               });
             
         } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
             
             var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
                 message = 'geolocation을 사용할수 없어요..'
                 
             displayMarker(locPosition, message);
         }
         
         
      // 지도에 마커와 인포윈도우를 표시하는 함수입니다
         function displayMarker(locPosition, message) {
    	  
        	 var imageSrc = '${pageContext.request.contextPath }/resources/images/user_location_marker.png', // 마커이미지의 주소입니다    
        	    imageSize = new kakao.maps.Size(28, 44), // 마커이미지의 크기입니다
        	    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
			
        	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
        	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
        	 
             // 마커를 생성합니다
             var marker = new kakao.maps.Marker({  
                 map: map, 
                 position: locPosition,
                 image: markerImage // 마커이미지 설정 
             }); 
             
             var iwContent = message, // 인포윈도우에 표시할 내용
                 iwRemoveable = true;

             // 인포윈도우를 생성합니다
             var infowindow = new kakao.maps.InfoWindow({
                 content : iwContent,
                 removable : iwRemoveable
             });
             
             // 인포윈도우를 마커위에 표시합니다 
             infowindow.open(map, marker);
             
             // 지도 중심좌표를 접속위치로 변경합니다
             map.setCenter(locPosition);      
         }   

         var places=[];     
         
         <c:forEach items="${maplist}" var="item1">
         	var objplaces={
         			place:"${item1.place}",
         			gpsx:"${item1.gpsx}",
         			gpsy:"${item1.gpsy}"
         	}
	         places.push(objplaces);
    	 </c:forEach>
    	 var positions=[]; 
         	for(var i=0; i<places.length; i++){
	        	 var tmp=places[i];
	        	 var obj={
	        			 content:tmp.place,
	        			 latlng: new kakao.maps.LatLng(tmp.gpsy, tmp.gpsx)
	        	 };
	        	 positions.push(obj);
         }

         for (var i = 0; i < positions.length; i++) {
            // 마커를 생성합니다
            var marker = new kakao.maps.Marker({
               map : map, // 마커를 표시할 지도
               position : positions[i].latlng
            // 마커의 위치
            });

            // 마커에 표시할 인포윈도우를 생성합니다 
            var infowindow = new kakao.maps.InfoWindow({
               content : positions[i].content
            // 인포윈도우에 표시할 내용
            });

            // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
            // 이벤트 리스너로는 클로저를 만들어 등록합니다 
            // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
            kakao.maps.event.addListener(marker, 'mouseover',
                  makeOverListener(map, marker, infowindow));
            kakao.maps.event.addListener(marker, 'mouseout',
                  makeOutListener(infowindow));
            kakao.maps.event.addListener(marker, 'click',
                  makeClickListener(infowindow));
         }
		
         function makeClickListener(infowindow) {
             return function() {
            	 
            	 $.ajax({
         			url:"maplist.do",
         			method:"post",
         			data:{"keyword":infowindow.getContent()}, //data : 파라미터로 전달할 문자열 
         			success:function(responseData){
         				$(".maplist").remove();
         				$(".map_wrap").append(responseData);
         					
         			}
         		});
             };
          }
         // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
         function makeOverListener(map, marker, infowindow) {
            return function() {
               infowindow.open(map, marker);
            };
         }

         // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
         function makeOutListener(infowindow) {
            return function() {
               infowindow.close();
            };
         }

         /* 아래와 같이도 할 수 있습니다 */
         /*
          for (var i = 0; i < positions.length; i ++) {
          // 마커를 생성합니다
          var marker = new kakao.maps.Marker({
          map: map, // 마커를 표시할 지도
          position: positions[i].latlng // 마커의 위치
          });

          // 마커에 표시할 인포윈도우를 생성합니다 
          var infowindow = new kakao.maps.InfoWindow({
          content: positions[i].content // 인포윈도우에 표시할 내용
          });

          // 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저를 만듭니다
          // 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
          (function(marker, infowindow) {
          // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
          kakao.maps.event.addListener(marker, 'mouseover', function() {
          infowindow.open(map, marker);
          });

          // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
          kakao.maps.event.addListener(marker, 'mouseout', function() {
          infowindow.close();
          });
          })(marker, infowindow);
          }
          */
      </script>

</html>