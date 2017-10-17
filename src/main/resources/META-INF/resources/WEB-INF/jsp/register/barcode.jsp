<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Learnist | Authentication"/>
		<jsp:include page="../includes/head.jsp"/>
		<link rel="stylesheet" href="<c:url value="/public/css/register.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="registerPage">

			<img src="https://learnist.s3.amazonaws.com/test/admin/${user.getUsername()}/barcode.png"/>
		</div>
		<jsp:include page="../includes/loginModal.jsp"/>
		<jsp:include page="../includes/scripts.jsp"/>
		<script src="<c:url value="/public/js/login.js" />"></script>
	</body>
</html>