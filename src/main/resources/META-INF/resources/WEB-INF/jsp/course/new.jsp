<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="FDMWebApp.domain.Course"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Add Course | ${user.getUsername()}"/>
		<jsp:include page="../includes/head.jsp"/>
		<!-- Add css here -->
		<link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="main">
			<div class="container container-fluid pt-4 px-0 px-sm-3" style="width: 50%;">
				<h1 class="display-4">Add Course</h1>
				<hr>
				<c:if test="${courseError != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
							${courseError}
					</div>
				</c:if>
				<form:form modelAttribute="newCourse" enctype="multipart/form-data" method="POST" action="/lecturer/course/add" data-toggle="validator">
						<div class="form-group">
							<form:label path="course.subject" for="courseSubject" class="control-label">Subject</form:label>
							<form:select path="course.subject" id="courseSubject" class="form-control py-0">
								<form:option value="">Select Subject...</form:option>
								<form:options items="${Course.getSubjects()}"/>
							</form:select>
						</div>
						<form:label path="file" for="courseImage" class="control-label">Course Image</form:label>
						<div class="form-group">
							<label class="custom-file">
								<form:input path="file" accept=".jpg, .png" type="file" id="courseImage" class="form-control py-0 file-upload" required="true"/>
								<span data-filename="Upload File..." class="custom-file-control file-upload-text"></span>
							</label>
							<p id="imageHelpBlock" class="form-text text-muted">The file must be a jpeg (.jpg) or png (.png) with a max size of 1MB.
							</p>
						</div>
						<div class="form-group">
							<form:label path="course.name" for="courseName" class="control-label">Course Name</form:label>
							<form:input path="course.name" type="text" class="form-control" id="courseName" placeholder="Enter Course Name" data-minlength="6" maxlength="30" pattern="[A-Za-z0-9 ]*" data-pattern-error="Field only allows alphanumeric characters" required="true"/>
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<form:label path="course.description" for="courseDescription" class="control-label">Description</form:label>
							<form:textarea path="course.description" class="form-control" id="courseDescription" placeholder="Enter Description" maxlength="255"/>
							<div class="help-block with-errors"><p id="descHelpBlock" class="form-text text-muted">Max 255 characters.
							</p></div>
						</div>
						<button type="submit" class="btn btn-primary">Submit</button>
					</form:form>
			</div>
		</div>
		<jsp:include page="../includes/scripts.jsp"/>
		<!-- Add javascript here -->
	</body>
</html>