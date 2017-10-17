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
			<form:form id="registerForm" data-toggle="validator" autocomplete="on" modelAttribute="lecturer" action="/register/lecturer">
				<h1>Lecturer Application</h1>
				<hr/>
				<h2>Details</h2>
				<div class="form-group">
					<form:label path="firstName" for="inputFirstName" class="control-label">First Name</form:label>
					<form:input path="firstName" type="text" class="form-control" id="inputFirstName" placeholder="Enter First Name" data-maxlength="30" pattern="[A-Za-z0-9-']*" data-pattern-error="Field only allows alphanumeric characters" autocomplete="given-name" required=""/>
					<div class="help-block with-errors"></div>
				</div>
				<div class="form-group">
					<form:label path="surname" for="inputSurname">Surname</form:label>
					<form:input path="surname" type="text" class="form-control" id="inputSurname" placeholder="Enter Surname" autocomplete="family-name" data-maxlength="50" pattern="[A-Za-z0-9-']*" data-pattern-error="Field only allows alphanumeric characters" required=""/>
					<div class="help-block with-errors"></div>
				</div>
				<jsp:include page="register.jsp"/>
				<div id="submitGroup" class="form-group">
					<form:button type="submit" class="btn btn-primary">Submit</form:button>
				</div>
			</form:form>
		</div>
		<jsp:include page="../includes/loginModal.jsp"/>
		<jsp:include page="../includes/scripts.jsp"/>
		<script src="<c:url value="/public/js/login.js" />"></script>>
	</body>
</html>