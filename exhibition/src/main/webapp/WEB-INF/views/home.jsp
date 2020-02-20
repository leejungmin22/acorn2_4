<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="include/resource.jsp" />

<!-- fullcalendar -->
<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath }/resources/css/fullcalendar/main.css'/>
<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath }/resources/css/fullcalendar/daygrid.min.css'/>
<script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/main.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/daygrid.min.js'/>"></script>
<script>

  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: [ 'dayGrid' ],
      defaultView: 'dayGridMonth',
      defaultDate: new Date(),
      header: {
          left: 'prev,next today',
          center: 'title',
          right: ''
        }
    });

    calendar.render();
  });

</script>
</head>
<body>
<jsp:include page="include/navbar.jsp" />
<div class="container">
	<h3>공연 일정</h3>
	<div id='calendar'></div>
	
	<h3>인기 공연</h3>
	<div class="popular_wrap">
	
	</div>
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>