<%@page import="com.acorn.exhibition.home.dto.mapDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/myPage/lunch.jsp</title>
<link rel="stylesheet"
   href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<jsp:include page="include/resource.jsp" />
<style>
.btn-group.food {
   display: flex;
}

.food .btn {
   flex: 1
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

#menu_wrap {
   position: absolute;
   top: 0;
   left: 0;
   bottom: 0;
   width: 250px;
   margin: 10px 0 30px 10px;
   padding: 5px;
   overflow-y: auto;
   background: rgba(255, 255, 255, 0.7);
   z-index: 1;
   font-size: 12px;
   border-radius: 10px;
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

#placesList li {
   list-style: none;
}

#placesList .item {
   position: relative;
   border-bottom: 1px solid #888;
   overflow: hidden;
   cursor: pointer;
   min-height: 65px;
}

#placesList .item span {
   display: block;
   margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}

#placesList .item .info {
   padding: 10px 0 10px 55px;
}

#placesList .info .gray {
   color: #8a8a8a;
}

#placesList .info .jibun {
   padding-left: 26px;
   background:
      url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
      no-repeat;
}

#placesList .info .tel {
   color: #009900;
}

#placesList .item .markerbg {
   float: left;
   position: absolute;
   width: 36px;
   height: 37px;
   margin: 10px 0 0 10px;
   background:
      url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
      no-repeat;
}

#placesList .item .marker_1 {
   background-position: 0 -10px;
}

#placesList .item .marker_2 {
   background-position: 0 -56px;
}

#placesList .item .marker_3 {
   background-position: 0 -102px
}

#placesList .item .marker_4 {
   background-position: 0 -148px;
}

#placesList .item .marker_5 {
   background-position: 0 -194px;
}

#placesList .item .marker_6 {
   background-position: 0 -240px;
}

#placesList .item .marker_7 {
   background-position: 0 -286px;
}

#placesList .item .marker_8 {
   background-position: 0 -332px;
}

#placesList .item .marker_9 {
   background-position: 0 -378px;
}

#placesList .item .marker_10 {
   background-position: 0 -423px;
}

#placesList .item .marker_11 {
   background-position: 0 -470px;
}

#placesList .item .marker_12 {
   background-position: 0 -516px;
}

#placesList .item .marker_13 {
   background-position: 0 -562px;
}

#placesList .item .marker_14 {
   background-position: 0 -608px;
}

#placesList .item .marker_15 {
   background-position: 0 -654px;
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
</style>
</head>
<body>
   <jsp:include page="include/navbar.jsp" />
   <div class="container">
      <h1>지역별 공연</h1>

      <div class="map_wrap">
         <div id="map"
            style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

         
      </div>

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

             // 마커를 생성합니다
             var marker = new kakao.maps.Marker({  
                 map: map, 
                 position: locPosition
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
	        			 content:'<div>'+tmp.place+'</div>',
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

   <div class="container">
   <table class="table table-hover">

		<colgroup>
			<col class="col-xs-6"/>
			<col class="col-xs-1"/>
			<col class="col-xs-2"/>
			<col class="col-xs-3"/>
		</colgroup>
		<thead>
			<tr class="title">
				<th>공연명 </th>
				<th>좋아요</th>
				<th>장소</th>
				<th>공연기간</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="tmp" items="${requestScope.list }">
				<tr class="tr">
					<td>
						<a href="detail.do?seq=${tmp.seq }">
							${tmp.title }
						</a>				
					</td>				
					<td>
						<img class="heart" src="${pageContext.request.contextPath }/resources/images/red-heart.png" alt="" />
						${tmp.likeCount }
					</td>				
					<td>${tmp.place }</td>
					<td>${tmp.startdate } ~ ${tmp.enddate }</td>
				</tr>	
			</c:forEach>
		</tbody>	
	</table>
	
	<div class="page-display" style="text-align: center;">
		<ul class="pagination pagination-sm">
			<c:choose>
				<c:when test="${startPageNum ne 1 }">
					<li>
						<c:choose>
							<c:when test="${encodedKeyword ne null }">
								<a href="list.do?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedKeyword }">&laquo;</a>
							</c:when>
							<c:when test="${startdate ne null and enddate ne null or sort ne null  }">
								<a href="list.do?pageNum=${startPageNum-1 }&condition=${condition }&startDate=${startdateFormat }&endDate=${enddateFormat }">&laquo;</a>
							</c:when>
							<c:otherwise>
								<a href="list.do?pageNum=${startPageNum-1 }">&laquo;</a>
							</c:otherwise>
						</c:choose>
					</li>
				</c:when>
				<c:otherwise>
					<li class="disabled">
						<a href="javascript:">&laquo;</a>
					</li>
				</c:otherwise>
			</c:choose>
			
			<c:forEach var="i" begin="${requestScope.startPageNum }" end="${requestScope.endPageNum }" step="1">
				<c:choose>
					<c:when test="${i eq pageNum }">
						<li class="active">
							<c:choose>
								<c:when test="${encodedKeyword ne null  }">
									<a href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedKeyword }">${i }</a>
								</c:when>
								<c:when test="${startdate ne null and enddate ne null or sort ne null }">
									<a href="list.do?pageNum=${i }&condition=${condition }&startDate=${startdateFormat }&endDate=${enddateFormat }">${i }</a>
								</c:when>
								<c:otherwise>
									<a href="list.do?pageNum=${i }">${i }</a>
								</c:otherwise>
							</c:choose>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<c:choose>
								<c:when test="${encodedKeyword ne null }">
									<a href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedKeyword }">${i }</a>
								</c:when>
								<c:when test="${startdate ne null and enddate ne null}">
									<a href="list.do?pageNum=${i }&condition=${condition }&startDate=${startdateFormat }&endDate=${enddateFormat }">${i }</a>
								</c:when>
								<c:otherwise>
									<a href="list.do?pageNum=${i }">${i }</a>
								</c:otherwise>
							</c:choose>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<c:choose>
				<c:when test="${endPageNum < totalPageCount }">
					<li>
						<c:choose>
							<c:when test="${encodedKeyword ne null }">
								<a href="list.do?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedKeyword }">&raquo;</a>
							</c:when>
							<c:when test="${startdate ne null and enddate ne null }">
								<a href="list.do?pageNum=${endPageNum+1 }&condition=${condition }&startDate=${startdateFormat }&endDate=${enddateFormat }">&raquo;</a>
							</c:when>
							<c:otherwise>
								<a href="list.do?pageNum=${endPageNum+1 }">&raquo;</a>
							</c:otherwise>
						</c:choose>
					</li>
				</c:when>
				<c:otherwise>
					<li class="disabled">
						<a href="javascript:">&raquo;</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>
   
</body>
</html>