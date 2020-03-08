<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="include/resource.jsp" />
<!--네이버지도-->
<!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=J9pKcIA6C6zcJbrEq4BOe4ThezO1rQry20s67foq&callback=initMap"></script>
<script type="text/javascript">
  var map = null;

  function initMap() {
      map = new naver.maps.Map('map', {
          center: new naver.maps.LatLng(${exhibitionDto.gpsX}, ${exhibitionDto.gpsY}),
          zoom: 10
      });
  }
</script> -->

<style>
btn-group.food {
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

div {
	border: 1px solid red;
}

.row {
	border: 1px solid blue;
}

.row>div {
	border: 1px dotted green;
}

img {
	max-width: 100%;
	height: 560px;
}

/* 댓글 css */
/* 글 내용을 출력할 div 에 적용할 css */
.contents, table {
	width: 100%;
	border: 1px dotted #cecece;
	box-shadow: 3px 3px 5px 6px #ccc;
}
/* 댓글에 관련된 css */
.comments ul {
	padding: 0;
	margin: 0;
	list-style-type: none;
}

.comments ul li {
	border-top: 1px solid #888; /* li 의 윗쪽 경계선 */
}

.comments dt {
	margin-top: 5px;
}

.comments dd {
	margin-left: 26px;
}

.comments form textarea, .comments form button {
	float: left;
}

.comments li {
	clear: left;
}

.comments form textarea {
	width: 85%;
	height: 100px;
}

.comments form button {
	width: 15%;
	height: 100px;
}
/* 댓글에 댓글을 다는 폼과 수정폼을 일단 숨긴다. */
.comment form {
	display: none;
}

.comment {
	position: relative;
}

.comment .reply_icon {
	width: 8px;
	height: 8px;
	position: absolute;
	top: 10px;
	left: 30px;
}

.comments .user-img {
	width: 20px;
	height: 20px;
	border-radius: 50%;
}
</style>

</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	<div class="container">
		<h3>${exhibitionDto.title }</h3>
		<div class="row">
			<div class="col-sm-4">
				<img src="${exhibitionDto.imgUrl }"
					alt="${exhibitionDto.title } 포스터">
			</div>

			<div class="col-sm-8">
				<div>
					<h6>
						공연 장소 : <a href="${exhibitionDto.placeUrl }">${exhibitionDto.place }</a>
					</h6>
					<h6>분류 : ${exhibitionDto.realmName }</h6>
					<h6>공연 기간 : ${exhibitionDto.startDate } ~
						${exhibitionDto.endDate }</h6>
					<h6>장소 : ${exhibitionDto.place }</h6>
					<h6>요금 : ${exhibitionDto.price }</h6>
					<h6>문의 : ${exhibitionDto.phone }</h6>
					<a class="btn btn-success" href="${exhibitionDto.url }">결제</a>
				</div>
				<div>
					<div class="container">
						<h1>지도</h1>

						<div class="map_wrap">
							<div id="map"
								style="width:500px;height:400px; position: relative; overflow: hidden;"></div>

							<div id="menu_wrap" class="bg_white">
								<div class="option">
									<div>
										<form onsubmit="searchPlaces(); return false;">
											키워드 : <input type="text" value="${exhibitionDto.place }" id="keyword"
												size="15">
											<button type="submit">검색하기</button>
										</form>
									</div>
								</div>
								<hr>
								<ul id="placesList"></ul>
								<div id="pagination"></div>
							</div>
						</div>

						<script type="text/javascript"
							src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9493bea6d98de2e126bef936b4f25a8d&libraries=services"></script>
						<script>
			// 마커를 담을 배열입니다
			var markers = [];
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
				level : 3
			// 지도의 확대 레벨
			};
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);
			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places();
			// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
				zIndex : 1
			});
			// 키워드로 장소를 검색합니다
			searchPlaces();
			// 키워드 검색을 요청하는 함수입니다
			function searchPlaces() {
				var keyword = document.getElementById('keyword').value;
				if (!keyword.replace(/^\s+|\s+$/g, '')) {
					alert('키워드를 입력해주세요!');
					return false;
				}
				// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
				ps.keywordSearch(keyword, placesSearchCB);
			}
			// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
			function placesSearchCB(data, status, pagination) {
				if (status === kakao.maps.services.Status.OK) {
					// 정상적으로 검색이 완료됐으면
					// 검색 목록과 마커를 표출합니다
					displayPlaces(data);
					// 페이지 번호를 표출합니다
					displayPagination(pagination);
				} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
					alert('검색 결과가 존재하지 않습니다.');
					return;
				} else if (status === kakao.maps.services.Status.ERROR) {
					alert('검색 결과 중 오류가 발생했습니다.');
					return;
				}
			}
			// 검색 결과 목록과 마커를 표출하는 함수입니다
			function displayPlaces(places) {
				var listEl = document.getElementById('placesList'), menuEl = document
						.getElementById('menu_wrap'), fragment = document
						.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';
				// 검색 결과 목록에 추가된 항목들을 제거합니다
				removeAllChildNods(listEl);
				// 지도에 표시되고 있는 마커를 제거합니다
				removeMarker();
				for (var i = 0; i < places.length; i++) {
					// 마커를 생성하고 지도에 표시합니다
					var placePosition = new kakao.maps.LatLng(places[i].y,
							places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
							i, places[i]); // 검색 결과 항목 Element를 생성합니다
					// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
					// LatLngBounds 객체에 좌표를 추가합니다
					bounds.extend(placePosition);
					// 마커와 검색결과 항목에 mouseover 했을때
					// 해당 장소에 인포윈도우에 장소명을 표시합니다
					// mouseout 했을 때는 인포윈도우를 닫습니다
					(function(marker, title) {
						kakao.maps.event.addListener(marker, 'mouseover',
								function() {
									displayInfowindow(marker, title);
								});
						kakao.maps.event.addListener(marker, 'mouseout',
								function() {
									infowindow.close();
								});
						itemEl.onmouseover = function() {
							displayInfowindow(marker, title);
						};
						itemEl.onmouseout = function() {
							infowindow.close();
						};
					})(marker, places[i].place_name);
					fragment.appendChild(itemEl);
				}
				// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
				listEl.appendChild(fragment);
				menuEl.scrollTop = 0;
				// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				map.setBounds(bounds);
			}
			// 검색결과 항목을 Element로 반환하는 함수입니다
			function getListItem(index, places) {
				var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
						+ (index + 1)
						+ '"></span>'
						+ '<div class="info">'
						+ '   <h5>' + places.place_name + '</h5>';
				if (places.road_address_name) {
					itemStr += '    <span>' + places.road_address_name
							+ '</span>' + '   <span class="jibun gray">'
							+ places.address_name + '</span>';
				} else {
					itemStr += '    <span>' + places.address_name + '</span>';
				}
				itemStr += '  <span class="tel">' + places.phone + '</span>'
						+ '</div>';
				el.innerHTML = itemStr;
				el.className = 'item';
				return el;
			}
			// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
			function addMarker(position, idx, title) {
				var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
				imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
				imgOptions = {
					spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
					spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
					offset : new kakao.maps.Point(13, 37)
				// 마커 좌표에 일치시킬 이미지 내에서의 좌표
				}, markerImage = new kakao.maps.MarkerImage(imageSrc,
						imageSize, imgOptions), marker = new kakao.maps.Marker(
						{
							position : position, // 마커의 위치
							image : markerImage
						});
				marker.setMap(map); // 지도 위에 마커를 표출합니다
				markers.push(marker); // 배열에 생성된 마커를 추가합니다
				return marker;
			}
			// 지도 위에 표시되고 있는 마커를 모두 제거합니다
			function removeMarker() {
				for (var i = 0; i < markers.length; i++) {
					markers[i].setMap(null);
				}
				markers = [];
			}
			// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
			function displayPagination(pagination) {
				var paginationEl = document.getElementById('pagination'), fragment = document
						.createDocumentFragment(), i;
				// 기존에 추가된 페이지번호를 삭제합니다
				while (paginationEl.hasChildNodes()) {
					paginationEl.removeChild(paginationEl.lastChild);
				}
				for (i = 1; i <= pagination.last; i++) {
					var el = document.createElement('a');
					el.href = "#";
					el.innerHTML = i;
					if (i === pagination.current) {
						el.className = 'on';
					} else {
						el.onclick = (function(i) {
							return function() {
								pagination.gotoPage(i);
							}
						})(i);
					}
					fragment.appendChild(el);
				}
				paginationEl.appendChild(fragment);
			}
			// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
			// 인포윈도우에 장소명을 표시합니다
			function displayInfowindow(marker, title) {
				var content = '<div style="padding:5px;z-index:1;">' + title
						+ '</div>';
				infowindow.setContent(content);
				infowindow.open(map, marker);
			}
			// 검색결과 목록의 자식 Element를 제거하는 함수입니다
			function removeAllChildNods(el) {
				while (el.hasChildNodes()) {
					el.removeChild(el.lastChild);
				}
			}

			
		</script>



					</div>
				</div>
			</div>
				
		</div>
		<div class="row">
			<div class="col-sm-12">
				<h3>줄거리</h3>
				${exhibitionDto.contents1 }
				<c:if test="${exhibitionDto.contents2 ne null }">${exhibitionDto.contents2 }</c:if>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<div class="comments">
					<ul>
						<c:forEach items="${commentList }" var="tmp">
							<c:choose>
								<c:when test="${tmp.deleted ne 'yes' }">
									<li class="comment" id="comment${tmp.num }"
										<c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if>>
										<c:if test="${tmp.num ne tmp.comment_group }">
											<img class="reply_icon"
												src="${pageContext.request.contextPath}/resources/images/re.gif" />
										</c:if>
										<dl>
											<dt>
												<c:choose>
													<c:when test="${empty tmp.profile }">
														<img class="user-img"
															src="${pageContext.request.contextPath}/resources/images/default_user.jpeg" />
													</c:when>
													<c:otherwise>
														<img class="user-img"
															src="${pageContext.request.contextPath}${tmp.profile}" />
													</c:otherwise>
												</c:choose>
												<span>${tmp.writer }</span>
												<c:if test="${tmp.num ne tmp.comment_group }">
												to <strong>${tmp.target_id }</strong>
												</c:if>
												<span>${tmp.regdate }</span> <a href="javascript:"
													class="reply_link">답글</a> |
												<c:choose>
													<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
													<c:when test="${id eq tmp.writer }">
														<a href="javascript:" class="comment-update-link">수정</a>&nbsp;&nbsp;
													<a href="javascript:deleteComment(${tmp.num })">삭제</a>
													</c:when>
													<c:otherwise>
														<a href="javascript:">신고</a>
													</c:otherwise>
												</c:choose>
											</dt>
											<dd>
												<pre>${tmp.content }</pre>
											</dd>
										</dl>
										<form class="comment-insert-form" action="comment_insert.do"
											method="post">
											<!-- 덧글 그룹 -->
											<input type="hidden" name="ref_group" value="${dto.seq }" />
											<!-- 덧글 대상 -->
											<input type="hidden" name="target_id" value="${tmp.writer }" />
											<input type="hidden" name="comment_group"
												value="${tmp.comment_group }" />
											<textarea name="content"><c:if test="${empty id }">로그인이 필요합니다.</c:if></textarea>
											<button type="submit">등록</button>
										</form> <!-- 로그인한 아이디와 댓글의 작성자와 같으면 수정폼 출력 --> <c:if
											test="${id eq tmp.writer }">
											<form class="comment-update-form" action="comment_update.do"
												method="post">
												<input type="hidden" name="num" value="${tmp.num }" />
												<textarea name="content">${tmp.content }</textarea>
												<button type="submit">수정</button>
											</form>
										</c:if>
									</li>
								</c:when>
								<c:otherwise>
									<li class="comment" id="comment${tmp.num }"
										<c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if>>
										<c:if test="${tmp.num ne tmp.comment_group }">
											<img class="reply_icon"
												src="${pageContext.request.contextPath}/resources/images/re.gif" />
										</c:if>
										<dl>
											<dt>
												<c:choose>
													<c:when test="${empty tmp.profile }">
														<img class="user-img"
															src="${pageContext.request.contextPath}/resources/images/default_user.jpeg" />
													</c:when>
													<c:otherwise>
														<img class="user-img"
															src="${pageContext.request.contextPath}${tmp.profile}" />
													</c:otherwise>
												</c:choose>
												<span>${tmp.writer }</span>
												<c:if test="${tmp.num ne tmp.comment_group }">
												to <strong>${tmp.target_id }</strong>
												</c:if>
												<span>${tmp.regdate }</span>
											</dt>
											<dd>
												<pre>삭제된 댓글 입니다.</pre>
											</dd>
										</dl>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</ul>
					<div class="clearfix"></div>
					<div class="comment_form">
						<!-- 원글에 댓글을 작성할 수 있는 폼 : 누가 쓴 어떤글에 댓글을 작성하는지 파라미터로 담아서 폼 제출시 post 방식으로 전달 -->
						<form class="comment-insert-form" action="comment_insert.do"
							method="post">
							<input type="hidden" name="ref_group" value="${dto.seq }" />
							<!-- 몇번 글의 글번호인지(댓글의 그룹번호) -->
							<%-- <input type="hidden" name="target_id" value="${tmp.writer }" />--%>
							<!-- 원글의 작성자 id(댓글의 대상자) -->
							<textarea name="content"><c:if test="${empty id }">로그인이 필요합니다.</c:if></textarea>
							<!-- 로그인을 하지않았을 때 '로그인이 필요합니다' 출력 -->
							<button type="submit">등록</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	var pageNum=1;
	//댓글 스크롤로 보이기
	$(window).scroll(function() {
		
	    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
	    	pageNum++;
	    	$.ajax({
				url:"more_comment.do",
				method:"post",
				data:{"pageNum":pageNum, "seq":${dto.seq}}, //data : 파라미터로 전달할 문자열 
				dataType:"html",
				success:function(responseData){
					
					$(".comments ul").append(responseData);
				
				}
					
			})
	    }
	});
     

	//댓글 수정 링크를 눌렀을때 호출되는 함수 등록
	$(".comment-update-link").click(function(){
		$(this)
		.parent().parent().parent()
		.find(".comment-update-form")
		.slideToggle(200);
	});
	
	//댓글 수정 폼에 submit 이벤트가 일어났을때 호출되는 함수 등록
	$(".comment-update-form").on("submit", function(){
		var url=$(this).attr("action"); //action 속성의 value를 읽어온다.
		//폼에 작성된 내용을 query 문자열로 읽어온다.
		// num=댓글번호&content=댓글내용
		var data=$(this).serialize();
		//이벤트가 일어난 폼을 선택해서 변수에 담아 놓는다.
		var $this=$(this);
		$.ajax({
			url:url,
			method:"post",
			data:data, //data : 파라미터로 전달할 문자열 
			success:function(responseData){
				// responseData : {isSuccess:true}
				if(responseData.isSuccess){
					//폼을 안보이게 한다 
					$this.slideUp(200);
					//폼에 입력한 내용 읽어오기
					var content=$this.find("textarea").val();
					//pre 요소에 수정 반영하기 
					$this.parent().find("pre").text(content);
				}
			}
		});
		//폼 제출 막기 
		return false; 
		//기본 동작(폼에 submit 이벤트가 일어나면 form 제출하면서 새로운 페이지로 이동하게된다.)을 막기 위해 return값을 false로 준다. (jquery에서만 가능)
		//마치 preventDefault() 메소드를 사용한 것과 같다.(vanilla js에서는 메소드를 사용해야됨)
	});
	
	//댓글 삭제를 눌렀을때 호출되는 함수
	function deleteComment(num){
		var isDelete=confirm("확인을 누르면 댓글이 삭제 됩니다.");
		if(isDelete){
			//페이지 전환 없이 ajax 요청을 통해서 삭제하기
			$.ajax({
				url:"comment_delete.do",
				method:"post",
				data:{"num":num},
				success:function(responseData){
					if(responseData.isSuccess){
						location.href="${pageContext.request.contextPath}/detail.do?seq=${dto.seq}";
					}
				}
			});
		}
	}
	
	//폼에 submit 이벤트가 일어 났을때 실행할 함수 등록 
	$(".comments form").on("submit", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin==false){
			alert("로그인 페이지로 이동 합니다.");
			location.href="${pageContext.request.contextPath}/users/loginform.do?url=${pageContext.request.contextPath}/detail.do?seq=${dto.seq}";
			return false;//폼 전송 막기 
		}
	});
	
	//폼에 focus 이벤트가 일어 났을때 실행할 함수 등록 
	$(".comments form textarea").on("click", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin==false){
			var isMove=confirm("로그인 페이지로 이동하시겠습니까?");
			if(isMove){
				location.href="${pageContext.request.contextPath }/users/loginform.do?url=${pageContext.request.contextPath}/detail.do?seq=${dto.seq}";
			}
		}
	});
	
	//답글 달기 링크를 클릭했을때 실행할 함수 등록
	$(".comment .reply_link").click(function(){
		$(this)
		.parent().parent().parent()
		.find(".comment-insert-form")
		.slideToggle(200); //접혀져 있으면 펼치고, 펼쳐져 있으면 접음.
		
		// 답글 <=> 취소가 서로 토글 되도록 한다. 
		if($(this).text()=="답글"){
			$(this).text("취소");
		}else{
			$(this).text("답글");
		}
	});
</script>




</body>
</html>