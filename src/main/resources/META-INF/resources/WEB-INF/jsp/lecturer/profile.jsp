<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Profile | ${user.getUsername()}"/>
		<jsp:include page="../includes/head.jsp"/>
		<!-- Add css here -->
		<link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="main">
			<div class="container-fluid pt-4 px-0 px-sm-3">
				<div class="container-fluid col-lg-9 p-lg-4">
					<div class="card">
						<div class="card-block">
							<h3 class="card-title">${user.getUsername()}'s Profile</h3>
							<div class="row">
								<h5 class="card-text pull-left col-lg-6"><strong>Username: </strong></h5>
								<h6 class="card-text pull-right col-lg-6">${user.getUsername()}</h6>
							</div>
							<div class="row">
								<h5 class="card-text pull-left col-lg-6"><strong>Forename: </strong></h5>
								<h6 class="card-text pull-right col-lg-6">${lecturer.getFirstName()}</h6>
							</div>
							<div class="row">
								<h5 class="card-text pull-left col-lg-6"><strong>Surname: </strong></h5>
								<h6 class="card-text pull-right col-lg-6">${lecturer.getSurname()}</h6>
							</div>
							<div class="row">
								<h5 class="card-text pull-left col-lg-6"><strong>Member Since: </strong></h5>
								<h6 class="card-text pull-right col-lg-6">${lecturer.getApplicationDate().toString()}</h6>
							</div>
							<div class="row">
								<h5 class="card-text pull-left col-lg-6"><strong>Email: </strong></h5>
								<h6 class="card-text pull-right col-lg-6">${user.getEmail()}</h6>
							</div>
							<div class="row">
								<h5 class="card-text pull-left col-lg-6"><strong>Courses: </strong></h5>
								<c:choose>
									<c:when test="${lecturer.getCourses().size() == 0}">
										<h6 class="card-text pull-right col-lg-6">None</h6>
									</c:when>
									<c:otherwise>
										<c:set var="pagination" value="${lecturer.getCoursePagination()}" scope="request"/>
										<jsp:include page="/WEB-INF/jsp/course/pagination/courses.jsp"/>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../includes/scripts.jsp"/>
		<!-- Add javascript here -->
	</body>
</html>