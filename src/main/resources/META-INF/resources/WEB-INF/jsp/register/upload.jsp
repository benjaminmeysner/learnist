<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Learnist | Lecturer application"/>
		<jsp:include page="../includes/head.jsp"/>
		<link rel="stylesheet" href="<c:url value="/public/css/register.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="registerPage">
			<form:form id="registerForm" data-toggle="validator" enctype="multipart/form-data" action="/register/lecturer/upload" method="POST">
				<h2>Upload CV</h2>
				<div class="form-group">
					<label for="inputCv" class="control-label">Username</label>
					<input id="inputUsername" type="text" class="form-control" value="${lecturer.getUsername()}" disabled="disabled"/>
				</div>
				<div class="form-group">
					<label for="inputCv" class="control-label">Upload CV</label>
					<input name="file" accept=".pdf" type="file" id="inputCv" class="form-control"/>
				</div>
				<div id="submitGroup" class="form-group">
					<button type="submit" class="btn btn-primary">Submit</button>
				</div>
			</form:form>
		</div>
		<jsp:include page="../includes/loginModal.jsp"/>
		<jsp:include page="../includes/scripts.jsp"/>
		<script src="<c:url value="/public/js/login.js" />"></script>
	</body>
</html>