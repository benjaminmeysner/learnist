<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="FDMWebApp.domain.Course"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="View Lesson"/>
		<jsp:include page="../includes/head.jsp"/>
		<!-- Add css here -->
		<link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="main">
			<div class="container container-fluid pt-4 px-0 px-sm-3">
				<c:if test="${lessonSuccess != null}">
					<div class="alert alert-success alert-dismissible fade show" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						${lessonSuccess}
					</div>
				</c:if>
				<c:if test="${lessonError != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
							${lessonError}
					</div>
				</c:if>
				<div class="d-flex align-items-center mx-2" id="courseHeader">
					<h1 class="display-4 my-0 mx-1">${viewLesson.getOrder()}: ${viewLesson.getName()}</h1>
					<div class="btn-group">
						<a href='/lecturer/course/${viewLesson.getCourse().getCode()}' class="btn btn-success ml-2">Back to course</a>
						<c:if test='${viewLesson.getCourse().getCurrentLesson() < viewLesson.getOrder()}'>
							<button data-toggle="modal" data-target="#deleteModal" class="btn btn-danger ml-2">Delete Lesson</button>
							<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
								<div class="modal-dialog modal-sm" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">Are you sure you want to delete the lesson?</h5>
										</div>
										<div class="modal-body">
											You will lose all data associated with this lesson if you do and this operation cannot be undone.
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
											<form:form method="POST" action="/lecturer/course/${viewLesson.getCourse().getCode()}/lesson/${viewLesson.getOrder()}/delete">									<button type="submit" class="btn btn-primary">Yes</button>

											</form:form>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
				<hr/>
				<div id="lessonsCard" class="card course-list">
					<div class="card-header d-flex justify-content-between align-items-center">
						<h1 class="card-title my-0 mr-4">Lesson Files</h1>
						<div>
							<h4>Main File: </h4><a href="${viewLesson.getMainFile().getUrl()}">${viewLesson.getMainFile().getUrl()}</a>
						</div>
					</div>
					<div class="card-block">
						<c:choose>
							<c:when test="${viewLesson.getFiles().size() != 0}">
								<table class="table table-hover mb-0">
									<thead>
										<tr>
											<th>Location</th>
											<th class="text-center"></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${viewLesson.getFiles()}" var="file">
											<tr>
												<td><a href="${file.getUrl()}">${file.getUrl()}</a></td>
												<td>
													<button data-toggle="modal" data-target="#deleteModal2" class="btn btn-danger ml-2">Remove File</button>
													<div class="modal fade" id="deleteModal2" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
														<div class="modal-dialog modal-sm" role="document">
															<div class="modal-content">
																<div class="modal-header">
																	<h5 class="modal-title">Are you sure you want to delete the file?</h5>
																</div>
																<div class="modal-body">
																	You will lose all data associated with this course if you do and this operation cannot be undone.
																</div>
																<div class="modal-footer">
																	<button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
																	<form:form method="POST" action="/lecturer/course/${viewLesson.getCourse().getCode()}/lesson/${viewLesson.getOrder()}/file/delete">									<button type="submit" name="url" value="${file.getUrl()}" class="btn btn-primary">Yes</button>

																	</form:form>
																</div>
															</div>
														</div>
													</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:when>
							<c:otherwise>
								<div class="alert alert-info">
									No supporting files.
								</div>
							</c:otherwise>
						</c:choose>
						<hr>
						<c:if test="${viewLesson.getFiles().size() < 5}">
								<form:form action="/lecturer/course/${viewLesson.getCourse().getCode()}/lesson/${viewLesson.getOrder()}/file" method="POST" enctype="multipart/form-data" validator="true" modelAttribute="lessonFile">
									<h4>Add Supporting file.</h4>
								<form:label path="file" for="lessonFile" class="control-label">Course Image</form:label>
								<div class="form-group">
									<label class="custom-file">
										<form:input path="file" accept="text/*,image/*,application/pdf" type="file" id="lessonFile" class="form-control py-0 file-upload" required="true"/>
										<span data-filename="Upload File..." class="custom-file-control file-upload-text"></span>
									</label>
									<p id="imageHelpBlock" class="form-text text-muted">The file must be an image, text file or pdf with a max size of 5MB.
									</p>
								</div>
								<button type="submit" class="btn btn-success">Submit File</button>
							</form:form>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../includes/scripts.jsp"/>
		<!-- Add javascript here -->
	</body>
</html>