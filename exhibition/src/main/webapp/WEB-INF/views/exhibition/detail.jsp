<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/resource.jsp" />
<!--네이버지도-->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=lhmuiegp2n&callback=initMap"></script>
<script type="text/javascript">
  var map = null;

  function initMap() {
      map = new naver.maps.Map('map', {
          center: new naver.maps.LatLng(${dto.gpsx}, ${dto.gpsy}),
          zoom: 10
      });
  }
</script>
<link rel="stylesheet" href="css/bootstrap.css">
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
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
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
        <div class="col-sm-1">
            comment
        </div>
    </div>
</div>	
</body>
</html>