<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Learnist"/>
		<jsp:include page="includes/head.jsp"/>
		<!-- Add css here -->
		<link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
	</head>
	<body>
		<jsp:include page="includes/nav.jsp"/>
		<div id="main">
			<!-- Add content here -->
		</div>
		<!--  Footer -->
		<jsp:include page="includes/footer.jsp"/>

		<jsp:include page="includes/loginModal.jsp"/>
		<jsp:include page="includes/registerModal.jsp"/>
		<jsp:include page="includes/scripts.jsp"/>
		<script src="<c:url value="/public/js/login.js" />"></script>
	</body>
</html>