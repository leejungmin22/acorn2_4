<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>홈페이지명</title>
<jsp:include page="include/resource.jsp" />
<!-- fullcalendar -->
<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath }/resources/css/fullcalendar/main.css'/>
<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath }/resources/css/fullcalendar/daygrid.min.css'/>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/fullcalendar/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/fullcalendar/daygrid.min.js"></script>
<!-- owl.carousel -->
<link rel="stylesheet" type='text/css' href="${pageContext.request.contextPath }/resources/css/owl.carousel/owl.carousel.min.css" />
<link rel="stylesheet" type='text/css' href="${pageContext.request.contextPath }/resources/css/owl.carousel/owl.theme.default.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/owl.carousel/owl.carousel.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<!-- jQuery UI Datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>

body{
   background-color:#FFFFFF; /* 백그라운드 색상 */
}

@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

   .form-group{
      font-size:25px;
      font-color:#FFFFFF;
      font-family: 'Nanum Pen Script', cursive;
   }
   h3{
      font-size:25px;
      font-family: 'Nanum Pen Script', cursive;
   }
   
   button{
      vertical-align:middle;
   }      
   button.img-button{
      background:url("resources/images/button_search.png") no-repeat;
      border:none;
      width:38px;
      height:38px;
      cursor:pointer
   }

</style>
<!-- fullcalendar -->
<style type="text/css">
	.fc-sat {color:#1F618D; background-color:#A9CCE3;} /*토요일*/	
	.fc-sun {color:#B03A2E; background-color:#F2D7D5;} /*일요일*/
</style>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');   
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	height: 600,
		plugins: [ 'dayGrid' ],
		defaultView: 'dayGridMonth',
		defaultDate: new Date(),
		header: {
		    left: '',
		    center: 'title',
		    right: 'prev,next today'
		  },
		eventLimit: true,
		eventLimitText: "more",
		eventLimitClick: "popover",
		editable: false,
		droppable: false,
		dayPopoverFormat: { year: 'numeric', month: 'long', day: 'numeric' },
		events:function(info, successCallback, failureCallback){
			$.ajax({
		           url: '${pageContext.request.contextPath}/getEvents.do',
		           dataType: 'json',
		           success: 
		        	   function(result) {
 
			               var events = [];
			              
			               if(result!=null){
			            	   
				            	   $.each(result, function(index, element) {
			            		   var enddate=element.enddate;
									if(enddate==null){
										enddate=element.startdate;
									}
									
									var startdate=moment(element.startdate).format('YYYY-MM-DD');
									var enddate=moment(enddate).format('YYYY-MM-DD');
									var realmname = element.realmname;
									
									// realmname (분야) 분야별로 color 설정
									if (realmname == "기타"){
										events.push({
											   title: element.title,
						                       start: startdate,
						                       end: enddate,
						           			   url: "${pageContext.request.contextPath }/detail.do?seq="+element.seq,
						           			   color:"#6937a1"						           				
						                    }); //.push()
									}
																		
									else if (realmname == "무용"){
										events.push({
											   title: element.title,
						                       start: startdate,
						                       end: enddate,
						           			   url: "${pageContext.request.contextPath }/detail.do?seq="+element.seq,
						           			   color:"#f7e600"						           				
						                    }); //.push()
									}
									
									else if (realmname == "미술"){
										events.push({
											   title: element.title,
						                       start: startdate,
						                       end: enddate,
						           			   url: "${pageContext.request.contextPath }/detail.do?seq="+element.seq,
						           			   color:"#2a67b7"						           				
						                    }); //.push()
									}
									
									else if (realmname == "연극"){
										events.push({
											   title: element.title,
						                       start: startdate,
						                       end: enddate,
						           			   url: "${pageContext.request.contextPath }/detail.do?seq="+element.seq,
						           			   color:"#008d62"						           				
						                    }); //.push()
									}
									
									else if (realmname == "음악"){
										events.push({
											   title: element.title,
						                       start: startdate,
						                       end: enddate,
						           			   url: "${pageContext.request.contextPath }/detail.do?seq="+element.seq,
						           			   color:"#6937a1"						           				
						                    }); //.push()
									}
									
									else{
										events.push({
											   title: element.title,
						                       start: startdate,
						                       end: enddate,
						           			   url: "${pageContext.request.contextPath }/detail.do?seq="+element.seq,
						           			   color:"#ff3399"						           				
						                    }); //.push()
									}
									
				               }); //.each()
				               
			            	   console.log(events);
				               
			               }//if end			               
			               successCallback(events);				               
			           }//success: function end						  
			}); //ajax end
		}, //events:function end
		//이벤트를 클릭하면 요청 주소를 받아와서 ajax로 요청을 보내고 dtail page의 내용의 JSON 문자열로 전달한다.(bridge 사용)
		eventClick: function sendData(data) {
			data.jsEvent.preventDefault();
			// seq 번호 갖고 오기
			var search=data.el.search;
			var seq=search.substr(5,6);
			//mobile 접속인지 pc 접속인지 검증
			var filter = "win16|win32|win64|mac|macintel"; 
			if ( navigator.platform ) { 
				if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {
					//1.mobile 에서 접속했으면
					//1-1.ajax로 detail 페이지의 내용을 갖고오고
					$.ajax({
						url:"android/detail.do",
						method:"get",
						data:{"seq":seq}, //158709
						dataType:"json",
						success:function(responseData){
							Android.getDetailData(JSON.stringify(responseData));
						}
					});

				} else { 
					//2. pc 에서 접속했으면(새로운 창에서 detail 페이지로 이동)
					window.open(data.el.href);
				} 
				
			}//if ( navigator.platform ) end
			
	    } //eventClick end
   });//new FullCalendar end

   calendar.render();
   
  });
</script>
<!-- owl.carousel -->
<script>
$(document).ready(function(){
  $('.owl-carousel').owlCarousel({
      loop:true,
      margin:10,
      autoplay:true,
      autoplayTimeout:1000,
       autoplayHoverPause:true,
      responsiveClass:true,
      responsive:{
          0:{
              items:3,
          },
          600:{
              items:3,
          },
          1000:{
              items:5,
              loop:false //Infinity loop. Duplicate last and first items to get loop illusion.
          }
      }
  })
});

//인기 공연의 img를 클릭했을 때 동작할 함수
function sendData(seq) {
	var filter = "win16|win32|win64|mac|macintel"; 
	if ( navigator.platform ) { 
		if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {
			//1.mobile 에서 접속했으면
			//1-1.ajax로 detail 페이지의 내용을 갖고오고
			$.ajax({
				url:"android/detail.do",
				method:"get",
				data:{"seq":seq}, //158709
				dataType:"json",
				success:function(responseData){
					Android.getDetailData(JSON.stringify(responseData));
				}
			});

		} else { 
			//2. pc 에서 접속했으면(새로운 창에서 detail 페이지로 이동)
			window.open("http://localhost:8888/exhibition/detail.do?seq="+seq);
		} 
		
	}//if ( navigator.platform ) end
}
</script>
<style>
   .owl-carousel .item {
       padding: 1rem;
    }
    .condition{
       margin: 10px 0 20px 0;
    }
    
    /* 썸네일 최대 크기 300px로 */
    .item{
       max-height:300px;
    }
    /* fullcalendar pophover 버튼 메뉴가 가장 위에 표기 될 수 있도록 하기 */
    .owl-carousel {
    z-index: 0;
	}
</style>
<!-- jQuery UI Datepicker -->
<script type="text/javascript">
   $(function() {
        //시작일.
        $('#startDate').datepicker({
            prevText: '이전달', //prev 아이콘의 툴팁.
         nextText: '다음달', //next 아이콘의 툴팁.
            buttonText: "날짜선택",             // 버튼의 대체 텍스트
            dateFormat: "yy-mm-dd",             // 날짜의 형식
            changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
            changeYear: true,
            showMonthAfterYear: true,
            //minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
            onClose: function( selectedDate ) {    
                // 시작일(fromDate) datepicker가 닫힐때
                // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                $("#endDate").datepicker( "option", "minDate", selectedDate );
            }                
        });

        //종료일
        $('#endDate').datepicker({
           prevText: '이전달', //prev 아이콘의 툴팁.
         nextText: '다음달', //next 아이콘의 툴팁.
            buttonText: "날짜선택",             // 버튼의 대체 텍스트
            dateFormat: "yy-mm-dd",             // 날짜의 형식
            changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
            changeYear: true,
            showMonthAfterYear: true,
            //minDate: 0, // 오늘 이전 날짜 선택 불가
            onClose: function( selectedDate ) {
                // 종료일(toDate) datepicker가 닫힐때
                // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
                $("#startDate").datepicker( "option", "maxDate", selectedDate );
            }                
        });

   });
</script>
<style type="text/css">

   .ui-datepicker{font-size: 12px; width: 200px;}
   .ui-datepicker select.ui-datepicker-month{width: 100%; font-size: 11px;}
   .ui-datepicker select.ui-datepicker-year{width: 100%; font-size: 11px;}
   .ui-datepicker-calendar > tbody td.ui-datepicker-week-end:first-child a {color:#f00;}
   .ui-datepicker-calendar > tbody td.ui-datepicker-week-end:last-child a {color:#00f;}
   .form-group{
      max-width:200px;
   }

</style>
</head>
<body>
<jsp:include page="include/navbar.jsp" />
<div class="container">
   <div class="condition" align="right">
      <form class="form-inline" action="list.do" method="get"> 
         <div class="form-group">
            <label for="condition">검색조건</label>
            <select class="form-control" name="condition" id="condition">
               <option value="none">선택하세요</option>
               <option value="title" <c:if test="${condition eq 'title' }">selected</c:if>>제목</option>
               <option value="place" <c:if test="${condition eq 'place' }">selected</c:if>>장소</option>
               <option value="date" <c:if test="${condition eq 'date' }">selected</c:if>>기간</option>
            </select>
         </div>
         <div class="form-group">
            <input class="form-control" type="text" name="keyword" id="keyword" value="${keyword }" placeholder="검색어를 입력하세요"/>
            <input class="form-control date" type="text" name="startDate" class="date" id="startDate" value="${startdate }" autocomplete="off" readonly/>
            <span class="date">~</span>
         </div>
         <div class="form-group">            
            <input class="form-control date" type="text" name="endDate" class="date" id="endDate" value="${enddate }" autocomplete="off" readonly/>
            <button class="img-button" type="submit"></button>
         </div>
      </form>
   </div>

	<!-- fullcalendar 출력 -->
	<div id='calendar'></div>
	
	<!-- owl.carousel data-->
	<h3>인기 공연</h3>
	<div class="row">
		<div class="large-12 columns">
			<div class="owl-carousel owl-theme">
				<c:forEach var="tmp" items="${list }" end="9">
					<div class="item">
						<img alt="${tmp.title }" src="${tmp.thumbnail }" onclick="sendData(${tmp.seq})">
				    </div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<jsp:include page="include/footer.jsp" />
<script>
	//select 된 정보를 담을 변수
	var value=$("#condition").val();
	//페이지가 로딩되는 시점에 어떤 값이 선택되었는지 확인 후 그에 맞는 input tag를 보여준다.
	checkeSelectBox(value);
	//select 옵션이 변경된 경우 그에 맞는 input tag를 보여준다.
	$("#condition").change(function(){
		value=$(this).val();
		checkeSelectBox(value);
	});
	//어떤 옵션이 선택되었는지 확인할 함수
	function checkeSelectBox(value){
		if(value=="none"){
			$("#keyword").attr("disabled", "disabled").hide();
			$(".date").attr("disabled", "disabled").hide();
		}
		if(value=="date"){
			$("#keyword").attr("disabled", "disabled").hide();
			$(".date").removeAttr("disabled").show();
			console.log("기간 선택");
		}
		if(value=="title"){
			$("#keyword").removeAttr("disabled").show();
			$(".date").attr("disabled", "disabled").hide();
			console.log("제목 선택");
		}
		
		if(value=="place"){
			$("#keyword").removeAttr("disabled").show();
			$(".date").attr("disabled", "disabled").hide();
			console.log("장소 선택");
		}
		
	}	
	
	//페이지 로딩시 키워드, 시작, 끝 날짜에 입력되어 있는값 갖고오기 
	var keyword=$("#keyword").val();
	var startDate=$("#startDate").val();
	var endDate=$("#endDate").val();
	
	//페이지 로딩시 
	if(!isEmpty(keyword) || (!isEmpty(startDate) && !isEmpty(endDate))){//키워드가 입력되어 있다면 disabled 속성 없애기
		$("button[type=submit]").removeAttr("disabled");
	}else{ //키워드가 입력되지 않은 경우 disabled 속성 추가하기
		$("button[type=submit]").attr("disabled","disabled");
	}
	
	//input#keyword 요소가 변경될때마다 확인해서 disabled 속성 추가하기
 	$("#keyword").on("input", function(){
		keyword=$("#keyword").val();
		if(!isEmpty(keyword)){//키워드가 입력된 경우
			$("button[type=submit]").removeAttr("disabled");
		}else{ //키워드가 입력되지 않은 경우
			$("button[type=submit]").attr("disabled","disabled");
		}

   });
   //input#startDate, #endDate 요소가 변경될때마다 확인해서 disabled 속성 추가하기
   $("#startDate, #endDate").change(function(){
      startDate=$("#startDate").val();
      endDate=$("#endDate").val();
      if(!isEmpty(startDate) && !isEmpty(endDate)){//#startDate, #endDat가 입력된 경우
         $("button[type=submit]").removeAttr("disabled");
      }else{ //#startDate, #endDat가 입력되지 않은 경우
         $("button[type=submit]").attr("disabled","disabled");
      }

   });
   
   //input 요소가 비어있는지 확인할 함수
   function isEmpty(str){
      if(str==" " || str=="" || typeof str == "undefined" || str == null){
         return true;
      }
   }
</script>
</body>
</html>