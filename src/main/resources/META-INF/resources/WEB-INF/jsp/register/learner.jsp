<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Learnist | Register learner"/>
		<jsp:include page="../includes/head.jsp"/>
		<link rel="stylesheet" href="<c:url value="/public/css/register.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="registerPage">
			<form:form id="registerForm" data-toggle="validator" autocomplete="on" method="POST" modelAttribute="learner" action="/register/learner">
				<h1>Register - Learner</h1>
				<hr/>
				<h2>Details</h2>
				<jsp:include page="register.jsp"/>
				<div id="submitGroup" class="form-group">
					<form:button type="submit" class="btn btn-primary">Submit</form:button>
				</div>
			</form:form>
		</div>
		<jsp:include page="../includes/loginModal.jsp"/>
		<jsp:include page="../includes/scripts.jsp"/>
		<script src="<c:url value="/public/js/login.js" />"></script>
	</body>
</html>