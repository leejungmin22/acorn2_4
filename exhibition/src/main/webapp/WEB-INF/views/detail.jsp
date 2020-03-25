<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="include/resource.jsp" />

<style>

div {
	border: 1px solid red;
}

.row {
	border: 1px solid blue;
}

.row>div {
	border: 1px dotted green;
}

.poster {
	max-width: 100%;
	height: 560px;
}

img {
	height: auto;
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

.heart{
	width: 20px;
	height: auto;
}
</style>

</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	<div class="container">
		<h3>${exhibitionDto.title }</h3>
		<div class="row">
			<div class="col-sm-4">
				<img class="poster" src="${exhibitionDto.imgUrl }"alt="${exhibitionDto.title } 포스터">
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
					<button class="btn btn-default like" type="button">
						<c:choose>
							<c:when test="${id eq ExhibitionLikeId and id ne null }">
								<img class="heart" src="${pageContext.request.contextPath }/resources/images/red-heart.png" alt="" />
							</c:when>
							<c:otherwise>
								<img class="heart" src="${pageContext.request.contextPath }/resources/images/empty-heart.png" alt="" />
							</c:otherwise>
						</c:choose>
						좋아요
						<span>${dto.likeCount }</span>

					</button>
				</div> 
				<div >
					<h6>지도</h6>
						<div id="map"
							style="width: 100%; height: 400px;"></div>
				</div>
			</div>
		</div>	
		<div class="row">
			<div class="col-sm-12">
				<h3>줄거리</h3>
				<c:choose>
					<c:when test="${exhibitionDto.contents1 ne null }">

						${exhibitionDto.contents1 }
					</c:when>
						<c:when test="${exhibitionDto.contents2 ne null }">
						${exhibitionDto.contents2 }
					</c:when>
						<c:when
							test="${exhibitionDto.contents1 eq null and exhibitionDto.contents2 eq null }">
							<p>상세내용이 없습니다 예매 페이지에서 상세내용을 확인해주세요.</p>
						</c:when>
					</c:choose>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<div class="comments">
						<ul>
							<c:forEach items="${commentList }" var="tmp" varStatus="status">
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
											</dt>
											<dd>
												<pre>${tmp.content }</pre>
											</dd>
											<dd>
												<span>${tmp.regdate }</span> 
												<a href="javascript:" class="reply_link">답글</a> 
												<c:choose>
													<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
													<c:when test="${ admin eq 1 || id eq tmp.writer }">
														<a href="javascript:" class="comment-update-link">수정</a>&nbsp;&nbsp;
													<a href="javascript:deleteComment(${tmp.num })">삭제</a>
													</c:when>
													<c:otherwise>
														<a href="javascript:">신고</a>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${id ne null }" >
														<c:forEach items="${comLikeList }" var="comList">
															<c:choose>
																<c:when test="${tmp.num eq comList.num }">
																	<button class="btn btn-default comlike" id="comlike" type="button" value=${tmp.num }>
																		<c:choose>
																			<c:when test="${comList.isCommentLikeId }">
																				<img src="${pageContext.request.contextPath }/resources/images/comment_red-heart.png" alt="" />
																				<%-- <span>${tmp.num }${comList.num }</span> --%>
																			</c:when>
																			<c:otherwise>
																				<img src="${pageContext.request.contextPath }/resources/images/comment_empty-heart.png" alt="" />
																			</c:otherwise>
																		</c:choose>
																		좋아요
																		<span>${tmp.com_likeCount }</span>
																	</button>
																</c:when>	
															</c:choose>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<button class="btn btn-default comlike" id="comlike" type="button" value=${tmp.num }>
															<img src="${pageContext.request.contextPath }/resources/images/comment_empty-heart.png" alt="" />
															좋아요
															<span>${tmp.com_likeCount }</span>
														</button>
													</c:otherwise>
												</c:choose>
											</dd>
										</dl>
										<form class="comment-insert-form" action="comment_insert.do" method="post">
											<!-- 덧글 그룹 -->
											<input type="hidden" name="ref_group" value="${dto.seq }" />
											<!-- 덧글 대상 -->
											<input type="hidden" name="target_id" value="${tmp.writer }" />
											<input type="hidden" name="comment_group"
												value="${tmp.comment_group }" />
											<textarea name="content"><c:if test="${empty id }">로그인이 필요합니다.</c:if></textarea>
											<button type="submit">등록</button>
										</form> <!-- 로그인한 아이디와 댓글의 작성자와 같으면 수정폼 출력 --> 
										<c:if test="${ admin eq 1 || id eq tmp.writer }">
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
												 	<strong>${tmp.target_id }</strong>
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
						</div><!--  class="comment_form -->
					</div><!--  class="comments -->
				</div><!-- class="col-sm-12" -->
			</div><!-- class="row" -->
		</div><!-- class="container" -->
<script>
	//좋아요 수 올리기
	$(".like").on("click", function(){
		var isLogin=${not empty id};
		if(isLogin==true){
			$.ajax({
				url:"updateLikeCount.do",
				method:"post",
				data:{"seq":${dto.seq}}, //data : 파라미터로 전달할 문자열 
				dataType:"json",
				success:function(responseData){
					console.log(responseData);
					var imgTag=$('.like').children('img');
					var span=$('.like').children('span');
					if(responseData.isSuccess==true){
						//location.href="${pageContext.request.contextPath}/detail.do?seq=${dto.seq}";
						imgTag.attr('src', '${pageContext.request.contextPath }/resources/images/red-heart.png');
						span.text(responseData.likecount);
						console.log(responseData.likecount);
					}else if(responseData.isSuccess==false){
						imgTag.attr('src', '${pageContext.request.contextPath }/resources/images/empty-heart.png');
						span.text(responseData.likecount);
					}
				}
		});
		//폼 제출 막기 
		return false; 
	}

	if(isLogin==false){
		var goLoginPage=confirm("로그인이 필요합니다. 로그인 하시겠습니까?");
		if(goLoginPage==true){
			location.href="${pageContext.request.contextPath}/users/loginform.do?url=${pageContext.request.contextPath}/detail.do?seq=${dto.seq}";
			imgLike=false;
		}
		return false;//폼 전송 막기 
	}
	});
	
	//댓글좋아요 수 올리기
	$(".comlike").on("click",function(){
		var num = $(this).attr('value');
		var isLogin=${not empty id};
		var imgTag=$(this).children('img');
		var span=$(this).children('span');
		if(isLogin==true){
			 $.ajax({
				url:"com_updateLikeCount.do",
				method:"post",
				data:{"num":num}, //data : 파라미터로 전달할 문자열 
				dataType:"json",
				success:function(responseData){
					console.log(responseData);
					//var imgTag=$('.num').children('img');
					if(responseData.comisSuccess==true ){
						imgTag.attr('src', '${pageContext.request.contextPath }/resources/images/comment_red-heart.png');
						span.text(responseData.comlikecount);
						console.log(responseData.comlikecount);
					}else if(responseData.comisSuccess==false){
						imgTag.attr('src', '${pageContext.request.contextPath }/resources/images/comment_empty-heart.png');
						span.text(responseData.comlikecount);
					}
				} 
			});
			//폼 제출 막기 
			return false; 
		}
		
		if(isLogin==false){
			var goLoginPage=confirm("로그인이 필요합니다. 로그인 하시겠습니까?");
			if(goLoginPage==true){
				location.href="${pageContext.request.contextPath}/users/loginform.do?url=${pageContext.request.contextPath}/detail.do?seq=${dto.seq}";
				imgLike=false;
			}
			return false;//폼 전송 막기 
		}
	});

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
	$(document).on("click", ".comment-update-link", function(){
		$(this)
		.parent().parent().parent()
		.find(".comment-update-form")
		.slideToggle(200);
	});
	
	//댓글 수정 폼에 submit 이벤트가 일어났을때 호출되는 함수 등록
	$(document).on("submit", ".comment-update-form", function(){
		// "private/comment_update.do"
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
	function deleteComment(seq){
		var isDelete=confirm("확인을 누르면 댓글이 삭제 됩니다.");
		if(isDelete){
			//페이지 전환 없이 ajax 요청을 통해서 삭제하기
			$.ajax({
				url:"comment_delete.do",
				method:"post",
				data:{"seq":seq},
				success:function(responseData){
					if(responseData.isSuccess){
						location.href="${pageContext.request.contextPath}/detail.do?seq=${dto.seq}";
					}
				}
			});
		}
	}
	
	//폼에 submit 이벤트가 일어 났을때 실행할 함수 등록 
	$(document).on("submit", ".comments form", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin==false){
			alert("로그인 페이지로 이동 합니다.");
			location.href="${pageContext.request.contextPath}/users/loginform.do?url=${pageContext.request.contextPath}/cafe/detail.do?seq=${dto.seq}";
			return false;//폼 전송 막기 
		}
	});
	
	//폼에 focus 이벤트가 일어 났을때 실행할 함수 등록 
	$(document).on("click", ".comments form textarea", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin==false){
			var isMove=confirm("로그인 페이지로 이동하시겠습니까?");
			if(isMove){
				location.href="${pageContext.request.contextPath }/users/loginform.do?url=${pageContext.request.contextPath}/cafe/detail.do?seq=${dto.seq}";
			}
		}
	});
	
	//답글 달기 링크를 클릭했을때 실행할 함수 등록
	$(document).on("click", ".comment .reply_link", function(){
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
<!-- kakao map -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9493bea6d98de2e126bef936b4f25a8d&libraries=services"></script>
<script>
	// 마커를 담을 배열입니다
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(${exhibitionDto.gpsY}, ${exhibitionDto.gpsX}), // 지도의 중심좌표
		level : 2
	// 지도의 확대 레벨
	};
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(${exhibitionDto.gpsY}, ${exhibitionDto.gpsX}); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	var iwContent = '<div style="padding:5px;">${exhibitionDto.place} <br><a href="https://map.kakao.com/link/to/${exhibitionDto.place},${exhibitionDto.gpsY}, ${exhibitionDto.gpsX}" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new kakao.maps.LatLng(${exhibitionDto.gpsY }, ${exhibitionDto.gpsX }); //인포윈도우 표시 위치입니다

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
    position : iwPosition, 
    content : iwContent 
	});
    
  
// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker);
	function relayout() {    
    
    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
    map.relayout();
	};
</script>
</body>
</html>