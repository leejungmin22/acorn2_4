<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/home.jsp</title>
<jsp:include page="include/resource.jsp"/>
<link href='${pageContext.request.contextPath }/resources/css/fullcalendar/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath }/resources/css/fullcalendar/main.min.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath }/resources/js/fullcalendar/main.js'></script>
<script src='${pageContext.request.contextPath }/resources/js/fullcalendar/main.min.js'></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
    	aspectRatio: 0.5, // Default = 1.35
    	height: 600,
    	plugins: [ 'dayGrid' ]
  
    });

        calendar.render();
    });

</script>
</head>
<body>
<jsp:include page="include/navbar.jsp"/>
<div class="container">
	<div id='calendar'></div>
</div>

</body>
</html>





