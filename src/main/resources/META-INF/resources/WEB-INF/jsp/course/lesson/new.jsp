<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="FDMWebApp.domain.Course"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Add Lesson | ${user.getUsername()}"/>
		<jsp:include page="../../includes/head.jsp"/>
		<!-- Add css here -->
		<link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
	</head>
	<body>
		<jsp:include page="../../includes/nav.jsp"/>
		<div id="main">
			<div class="container container-fluid pt-4 px-2 px-sm-3">
				<h1 class="display-4 my-0">Add Lesson</h1>
				<hr>
				<c:if test="${lessonError != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
							${lessonError}
					</div>
				</c:if>
				<form:form modelAttribute="newLesson" enctype="multipart/form-data" method="POST" action="/lecturer/course/${newLesson.getLesson().getCourse().getCode()}/lesson/add" data-toggle="validator">
					<div class="d-flex align-items-center">
						<h2>${newLesson.getLesson().getCourse().getName()}: ${newLesson.getLesson().getOrder()}</h2>
					</div>
					<div class="form-group">
						<form:label path="lesson.name" for="lessonName" class="control-label">Lesson Name</form:label>
						<form:input path="lesson.name" type="text" class="form-control" id="lessonName" placeholder="Enter Lesson Name" data-minlength="3" maxlength="30" pattern="[A-Za-z0-9 ]*" data-pattern-error="Field only allows alphanumeric characters" required="true"/>
						<div class="help-block with-errors"></div>
					</div>
					<form:label path="file" for="courseMain" class="control-label">Lesson Content</form:label>
					<div class="form-group">
						<label class="custom-file">
							<form:input path="file" accept="video/*,.odp" type="file" id="courseMain" class="form-control py-0 file-upload" required="true"/>
							<span data-filename="Upload Video or ODP" class="custom-file-control file-upload-text"></span>
						</label>
						<p class="form-text text-muted">The file must be a video or presentation file in the format of (.odp) with a max size of 300MB.
						</p>
					</div>
					<button type="submit" class="btn btn-primary">Submit</button>
				</form:form>
			</div>
		</div>
		<jsp:include page="../../includes/scripts.jsp"/>
		<!-- Add javascript here -->
	</body>
</html>