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
<div class="container" style="margin-top: 120px !important;">
	<div style="width: 70%; margin: auto !important;">
		<h1>Help and Support</h1>
		<hr/>
		<h3>${ticketTitle}</h3>
		<c:choose>
			<c:when test="${not success}">
				<form:form id="SupportForm" autocomplete="on" modelAttribute="ticket" action="${action}" method="post">
					<div class="form-group">
						<form:label path="supportReason" for="inputFirstName" class="control-label">Issue</form:label>
						<form:select path="supportReason" class="form-control custom-select" id="reason"
									 required="" onchange="this.form.submit()">
							<c:choose>
								<c:when test="${type == 'general'}">
									<form:option value="">----- More
										-----</form:option>
									<form:option selected="true" value="General_Enquiry">General Enquiry</form:option>
								</c:when>
								<c:when test="${type == 'user'}">
									<form:option value="">----- More
										-----</form:option>
									<form:option selected="true" value="Report_User">Report a User</form:option>
								</c:when>
								<c:when test="${type == 'lecture'}">
									<form:option value="">----- More
										-----</form:option>
									<form:option selected="true"
												 value="Report_Lecture_Content">Report Course Content </form:option>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${RegisteredUser}">
											<form:option selected="true" value="">----- Please select One
												-----</form:option>
											<form:option value="General_Enquiry">General Enquiry</form:option>
											<form:option value="Report_User">Report a User</form:option>
											<form:option
													value="Report_Lecture_Content">Report Course Content </form:option>
										</c:when>
										<c:otherwise>
											<form:option value="General_Enquiry">General Enquiry</form:option>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</form:select>
					</div>
					<c:choose>
						<c:when test="${type == 'user'}">
							<div class="form-group" id="username">
								<form:label path="username" for="inputUsername" class="control-label">Username</form:label>
								<form:input path="username" type="text" class="form-control" id="inputUsername"
											placeholder="Enter Username" data-maxlength="30" required=""/>
							</div>
						</c:when>
						<c:when test="${type == 'lecture'}">
							<div class="form-group">
								<div id="navSearch" class="list-group">
									<div id="mainSearchCont2" class="input-group scroll mx-auto">
										<input id="mainSearch2" class="form-control" type="search"
											   placeholder="Search Courses..." autocomplete="off">
										<div class="input-group-addon">
										</div>
									</div>
								</div>
							</div>
						</c:when>
					</c:choose>
					<div class="form-group">
						<form:label path="description" for="description" class="control-label">Your Message</form:label>
						<form:textarea path="description" type="textarea" class="form-control" id="inputAdd1"
									   placeholder="Insert your comment here" pattern="[A-Za-z0-9]*"
									   data-pattern-error="Field only allows alphanumeric characters"
									   rows="4"></form:textarea>
						<div class="help-block with-errors"></div>
					</div>
					<div id="submitGroup" class="form-group">
						<c:choose>
							<c:when test="${button}">
								<form:button type="submit" class="btn btn-primary" disabled="false">Submit</form:button>
							</c:when>
							<c:otherwise>
								<form:button type="submit" class="btn btn-primary" disabled="true">Submit</form:button>
							</c:otherwise>
						</c:choose>
					</div>
				</form:form>
			</c:when>
			<c:otherwise>
				<h5>
						${ticketText}
				</h5>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<jsp:include page="../includes/loginModal.jsp"/>
<jsp:include page="../includes/registerModal.jsp"/>
<jsp:include page="../includes/scripts.jsp"/>
<script src="<c:url value="/public/js/login.js" />"></script>
</body>
</html>