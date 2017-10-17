<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Learnist"/>
		<jsp:include page="../includes/head.jsp"/>
		<!-- Add css here -->
		<link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="main">
			<!-- Add content here -->
			<div class="jumbotron jumbotron-fluid">
				<div class="container">
					<h1 class="display-3">Reset Password</h1>
					<p class="lead">Please enter your new password.</p>
					<form:form id="resetPassword" data-toggle="validator" action="/login/new-password" method="POST">
						<div class="form-group">
							<label for="inputPassword" class="control-label">Password</label>
							<input name="password" type="password" data-minlength="6" maxlength="30" class="form-control" id="inputPassword" pattern="[A-Za-z0-9]*" data-pattern-error="Field only allows alphanumeric characters" placeholder="Enter Password" autocomplete="off" required=""/>
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<label for="inputConfirm" class="control-label">Confirm Password</label>
							<input name="confirm" type="password" class="form-control" id="inputConfirm" placeholder="Confirm Password" data-match="#inputPassword" data-match-error="Passwords do not match" autocomplete="off" required=""/>
							<div class="help-block with-errors"></div>
						</div>
						<div class="button-group">
							<button type="submit" class="btn btn-success">Submit</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
		</div>
		<jsp:include page="../includes/loginModal.jsp"/>
		<jsp:include page="../includes/registerModal.jsp"/>
		<jsp:include page="../includes/scripts.jsp"/>
		<script src="<c:url value="/public/js/login.js" />"></script>
	</body>
</html>