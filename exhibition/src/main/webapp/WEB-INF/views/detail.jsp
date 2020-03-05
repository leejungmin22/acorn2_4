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
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=J9pKcIA6C6zcJbrEq4BOe4ThezO1rQry20s67foq&callback=initMap"></script>
<script type="text/javascript">
  var map = null;

  function initMap() {
      map = new naver.maps.Map('map', {
          center: new naver.maps.LatLng(${dto.gpsx}, ${dto.gpsy}),
          zoom: 10
      });
  }
</script>
<style>
	div{
		border: 1px solid red;
	}
	.row{
		border: 1px solid blue;
	}
	.row > div{
		border: 1px dotted green;
	}
	img{
		max-width: 100%;
	}
    .col-sm-1{
        height: 100px;
    }
    
    /* 댓글 css */
    	/* 글 내용을 출력할 div 에 적용할 css */
	.contents, table{
		width: 100%;
		border: 1px dotted #cecece;
		box-shadow: 3px 3px 5px 6px #ccc;
	}
	/* 댓글에 관련된 css */
	.comments ul{
		padding: 0;
		margin: 0;
		list-style-type: none;
	}
	.comments ul li{
		border-top: 1px solid #888; /* li 의 윗쪽 경계선 */
	}
	.comments dt{
		margin-top: 5px;
	}
	.comments dd{
		margin-left: 26px;
	}
	.comments form textarea, .comments form button{
		float: left;
	}
	.comments li{
		clear: left;
	}
	.comments form textarea{
		width: 85%;
		height: 100px;
	}
	.comments form button{
		width: 15%;
		height: 100px;
	}
	/* 댓글에 댓글을 다는 폼과 수정폼을 일단 숨긴다. */
	.comment form{
		display: none;
	}
	.comment{
		position: relative;
	}
	.comment .reply_icon{
		width: 8px;
		height: 8px;
		position: absolute;
		top: 10px;
		left: 30px;
	}
	.comments .user-img{
		width: 20px;
		height: 20px;
		border-radius: 50%;
	}
</style>
</head>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>
<div class="container">
	<h3>${dto.title }</h3>
	<div class="row">
		<div class="col-sm-4">
            <img src="${dto.thumbnail }" alt="${dto.title } 포스터">
        </div>

        <div class="col-sm-8">
            <div>
                <h4>제목 : ${dto.title }</h4>
                <h4>분류 : ${dto.realmname }</h4>
                <h4>일시 : ${dto.startdate } ~ ${dto.enddate }</h4>
                <h4>장소 : ${dto.place }</h4>
            </div>
            <div>
                <div id="map" style="width:100%;height:380px;"></div>
            </div>
        </div>
	</div>
    <div class="row">
        <div class="col-sm-1">
            
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
			<div class="comments">
				<ul>
					<c:forEach items="${commentList }" var="tmp">
						<c:choose>
							<c:when test="${tmp.deleted ne 'yes' }">
								<li class="comment" id="comment${tmp.num }" <c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if> >
									<c:if test="${tmp.num ne tmp.comment_group }">
										<img class="reply_icon" src="${pageContext.request.contextPath}/resources/images/re.gif"/>
									</c:if>
									<dl>
										<dt>
											<c:choose>
												<c:when test="${empty tmp.profile }">
													<img class="user-img" src="${pageContext.request.contextPath}/resources/images/default_user.jpeg"/>
												</c:when>
												<c:otherwise>
													<img class="user-img" src="${pageContext.request.contextPath}${tmp.profile}"/>
												</c:otherwise>
											</c:choose>
											<span>${tmp.writer }</span>
											<c:if test="${tmp.num ne tmp.comment_group }">
												to <strong>${tmp.target_id }</strong>
											</c:if>
											<span>${tmp.regdate }</span>
											<a href="javascript:" class="reply_link">답글</a> |
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
									<form class="comment-insert-form" action="comment_insert.do" method="post">
										<!-- 덧글 그룹 -->
										<input type="hidden" name="ref_group" value="${dto.seq }" />
										<!-- 덧글 대상 -->
										<input type="hidden" name="target_id" value="${tmp.writer }" />
										<input type="hidden" name="comment_group" value="${tmp.comment_group }" />
										<textarea name="content"><c:if test="${empty id }">로그인이 필요합니다.</c:if></textarea>
										<button type="submit">등록</button>
									</form>	
									<!-- 로그인한 아이디와 댓글의 작성자와 같으면 수정폼 출력 -->				
									<c:if test="${id eq tmp.writer }">
										<form class="comment-update-form" action="comment_update.do" method="post">
											<input type="hidden" name="num" value="${tmp.num }" />
											<textarea name="content">${tmp.content }</textarea>
											<button type="submit">수정</button>
										</form>
									</c:if>
								</li>				
							</c:when>
							<c:otherwise>
								<li class="comment" id="comment${tmp.num }" <c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if>>
									<c:if test="${tmp.num ne tmp.comment_group }">
										<img class="reply_icon" src="${pageContext.request.contextPath}/resources/images/re.gif"/>
									</c:if>
									<dl>
										<dt>
											<c:choose>
												<c:when test="${empty tmp.profile }">
													<img class="user-img" src="${pageContext.request.contextPath}/resources/images/default_user.jpeg"/>
												</c:when>
												<c:otherwise>
													<img class="user-img" src="${pageContext.request.contextPath}${tmp.profile}"/>
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
					<form action="comment_insert.do" method="post">
						<input type="hidden" name="ref_group" value="${dto.seq }" /> <!-- 몇번 글의 글번호인지(댓글의 그룹번호) -->
						<%-- <input type="hidden" name="target_id" value="${tmp.writer }" />--%><!-- 원글의 작성자 id(댓글의 대상자) -->
						<textarea name="content"><c:if test="${empty id }">로그인이 필요합니다.</c:if></textarea> <!-- 로그인을 하지않았을 때 '로그인이 필요합니다' 출력 -->
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