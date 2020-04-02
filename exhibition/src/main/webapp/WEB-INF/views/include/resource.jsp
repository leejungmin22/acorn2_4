<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 필요한 css 로딩하기  --%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/custom.css" />
<%-- 필요한 javascript 로딩하기 --%>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
	

	/* nav bar 메뉴 #bdbdbd;*/
	#one a {
  		color: #FFFFFF;
	}

	
	/*  */	
	#two{
		font-size:15px;
		font-family: 'NanumGothic ExtraBold', cursive;
		background-color: #111111;
	}
	
	#two a {
  		color: #FFFFFF;
	}
	
	/* two bar의 li 요소 */
	#two li{
		font-size:15px;
		font-family: 'NanumGothic ExtraBold', cursive;
		/* background-color: #ffefa1; */
		background-color: #111111;
	}	
	
	/* 하단 레터박스 */
	#footer{
		background-color: #FFFFFF;
		border: 2px ridge black;
	}
</style>
