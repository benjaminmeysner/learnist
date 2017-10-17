<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="FDMWebApp.domain.Course"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta property="og:url"                content="http://learnist.cf" />
		<meta property="og:title"              content="${viewCourse.getName()}" />
		<meta property="og:description"        content="${viewCourse.getDescription()}" />
		<meta property="og:image"              content="${viewCourse.getImage().getUrl()}" />
		<c:set var="title" scope="application" value="View Course"/>
		<jsp:include page="../includes/head.jsp"/>
		<!-- Add css here -->
		<link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="main">
			<div class="container container-fluid pt-4 px-0 px-sm-3">
				<c:if test="${courseSuccess != null}">
					<div class="alert alert-success alert-dismissible fade show" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<c:choose>
							<c:when test='${courseSuccess.equals("Course Submitted.")}'>
								<strong>${courseSuccess}</strong> You will receive an email once your application has been processed.
							</c:when>
							<c:otherwise>${courseSuccess}</c:otherwise>
						</c:choose>
					</div>
				</c:if>
				<c:if test="${courseError != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						${courseError}
					</div>
				</c:if>
				<div class="d-flex align-items-center mx-2" id="courseHeader">
					<h1 class="display-4 my-0 mx-1">${viewCourse.getName()}</h1>
					<div class="btn-group">
						<c:if test="${!viewCourse.getReviews().isEmpty()}">
							<button data-toggle="modal" data-target="#reviewsModal" class="btn btn-warning ml-2 hidden-sm-down">View Reviews</button>
							<button data-toggle="modal" data-target="#reviewsModal" class="btn btn-warning ml-2 hidden-md-up btn-sm">View Reviews</button>
							<div class="modal fade" id="reviewsModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
								<div class="modal-dialog modal-lg" role="document">
									<div class="modal-content">
											<div class="modal-header">
												<h1 class="modal-title" style="font-weight: 300;">View Reviews</h1>
												<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												<c:forEach items="${viewCourse.getReviews()}" var="review">
													<div class="card">
														<div class="card-header d-flex align-items-center justify-content-between">
															<h4>${review.getLearner().getUsername()}</h4>
															<span class="star-rating p-1">
                                                                <c:forEach var="i" begin="0" end="4">
	                                                                <c:choose>
		                                                                <c:when test="${viewCourse.getRating() - i  >= 0.5}">
			                                                                <c:choose>
				                                                                <c:when test="${0.5 <= viewCourse.getRating() - i && viewCourse.getRating() - i < 1}">
					                                                                <i class="material-icons hidden-sm-down">star_half</i>
				                                                                </c:when>
				                                                                <c:otherwise>
					                                                                <i class="material-icons hidden-sm-down">star</i>
				                                                                </c:otherwise>
			                                                                </c:choose>
		                                                                </c:when>
		                                                                <c:otherwise>
			                                                                <i class="material-icons hidden-sm-down">star_border</i>
		                                                                </c:otherwise>
	                                                                </c:choose>
                                                                </c:forEach>
                                                            </span>
														</div>
														<div class="card-block">
															<p>${review.getReview()}</p>
														</div>
													</div>
													<hr>
												</c:forEach>
											</div>
										</div>
								</div>
							</div>
						</c:if>
						<c:if test='${viewCourse.getStatus().toString().equals("Unverified")}'>
							<button data-toggle="modal" data-target="#submitModal" class="btn btn-warning ml-auto">Submit Course</button>
							<div class="modal fade" id="submitModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
								<div class="modal-dialog modal-sm" role="document">
									<div class="modal-content">
										<div class="modal-body">
											Are you sure you want to submit the course?
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
											<form:form method="POST" action="/lecturer/course/${viewCourse.getCode()}/submit">									<button type="submit" class="btn btn-primary">Yes</button>

											</form:form>
										</div>
									</div>
								</div>
							</div>
						</c:if>
						<c:if test='${viewCourse.getStatus().toString().equals("Approved") && viewCourse.getCurrentLesson() < viewCourse.getLessons().size()}'>
							<button data-toggle="modal" data-target="#nextModal" class="btn btn-warning ml-auto">Publish next lesson</button>
							<div class="modal fade" id="nextModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
								<div class="modal-dialog modal-sm" role="document">
									<div class="modal-content">
										<div class="modal-body">
											Are you sure you want to publish the next lesson?
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
											<form:form method="POST" action="/lecturer/course/${viewCourse.getCode()}/next">									<button type="submit" class="btn btn-primary">Yes</button>
											</form:form>
										</div>
									</div>
								</div>
							</div>
							<a href='/lecturer/course/${viewCourse.getCode()}/meetup/new' class="btn btn-success ml-2">
							<c:choose>
								<c:when test="${viewCourse.getMeetup() == null}">
									New Meetup
								</c:when>
								<c:otherwise>
									Edit Meetup
								</c:otherwise>
							</c:choose>
							</a>
						</c:if>
						<c:if test='${viewCourse.getStatus().toString().equals("Approved")}'>
							<div class="fb-share-button" data-href="https://developers.facebook.com/docs/plugins/" data-layout="button" data-size="small" data-mobile-iframe="true"><a class="fb-xfbml-parse-ignore btn btn-primary ml-2 d-flex align-items-center" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Flearnist.cf%2Fcourse%2F%0A${course.getCode()}&amp;src=sdkpreparse"><img height="20px" class="mr-1" src="https://upload.wikimedia.org/wikipedia/commons/c/c2/F_icon.svg">Share</a></div>
						</c:if>
						<c:if test='${viewCourse.getLearners().size() == 0}'>
							<button data-toggle="modal" data-target="#deleteModal" class="btn btn-danger ml-2">Delete Course</button>
							<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
								<div class="modal-dialog modal-sm" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">Are you sure you want to delete the course?</h5>
										</div>
										<div class="modal-body">
											You will lose all data associated with this course if you do and this operation cannot be undone.
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
											<form:form method="POST" action="/lecturer/course/${viewCourse.getCode()}/delete">									<button type="submit" class="btn btn-primary">Yes</button>

											</form:form>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
				<hr/>
				<div class="row mx-2 mx-lg-0">
					<div class="col-lg-4 mb-2 mb-lg-0 d-flex align-items-center justify-content-center">
						<img src='${viewCourse.getImage().getUrl()}' class="img-fluid img-thumbnail" alt=""/>
					</div>
					<div class="col-lg-8 p-0">
						<div class="hidden-sm-down" style="width: 100%">
							<table class="table table-striped table-responsive mb-0">
								<tbody style="width: 100%; display: inline-table;">
									<form:form method="POST" action="/lecturer/course/${viewCourse.getCode()}/edit" modelAttribute="viewCourse" validator="validator">
										<tr class="toggle-desc" style="display: none;">
											<td><strong>Description</strong></td>
											<td><form:textarea path="description" class="form-control" maxlength="255" cssStyle="height:100px;"/></td>
											<td style="display: flex;flex-direction: column;align-items: center;">
												<button type="submit" class="btn btn-success mb-3">Submit</button>
												<button type="reset" data-target=".toggle-desc" class="toggle-cancel btn btn-danger">Cancel</button>
											</td>
										</tr>
									</form:form>
									<tr class="toggle-desc">
										<td><strong>Description</strong></td>
										<td>${viewCourse.getDescription()}</td>
										<td>
											<button data-target=".toggle-desc" class="toggle-edit btn btn-success">Edit</button>
										</td>
									</tr>
									<tr>
										<td><strong>Subject</strong></td>
										<td>${viewCourse.getSubject()}</td>
										<td></td>
									</tr>
									<tr>
										<td><strong>Tags</strong></td>
										<td>${viewCourse.getTags()}</td>
										<td><button data-target="#tagsModal" data-toggle="modal" class="btn btn-success">Edit</button></td>
									</tr>
								</tbody>
							</table>
							<div class="course-attrs">
								<div>
									<strong>Status:</strong>
									<c:set var="tableUser" value="${viewCourse}" scope="request"/>

									<jsp:include page="../admin/includes/status.jsp"/>
								</div>
								<div><strong>Rating:</strong>${viewCourse.getRating()}</div>
								<div>
									<strong>Current Lesson:</strong>${viewCourse.getCurrentLesson()}
								</div>
							</div>
						</div>
						<div id="course-attrs-sm" class="hidden-md-up">
							<div class="cat">
								<div class="d-flex">
									<h4>Description</h4>
									<button data-target=".toggle-desc" class="toggle-edit toggle-desc btn badge badge-success ml-3"><i class="material-icons">edit</i></button>
								</div>
								<p class="toggle-desc">${viewCourse.getDescription()}</p>
								<form:form id="mobileViewCourse" cssClass="desc-form" method="POST" action="/lecturer/course/${viewCourse.getCode()}/edit" modelAttribute="viewCourse" validator="validator">
									<div class="toggle-desc" style="display: none;">
										<form:textarea path="description" class="form-control" max-length="255" cssStyle="height:100px;"/>
										<div class="py-1" style="display: flex;flex-direction: column;align-items: center;">
											<div class="ml-auto">
												<button type="submit" class="btn btn-success">Submit</button>
												<button type="reset" data-target=".toggle-desc" class="toggle-cancel btn btn-danger ml-1">Cancel</button>
											</div>
										</div>
									</div>
								</form:form>
							</div>
							<div class="cat">
								<h4>Subject</h4>
								<p class="mb-0">${viewCourse.getSubject()}</p>
							</div>
							<div class="cat course-attrs">
								<div class="d-flex align-items-center"><strong>Tags:</strong>${viewCourse.getTags()}<button data-target="#tagsModal" data-toggle="modal" class="btn badge badge-success ml-auto"><i class="material-icons">add</i></button></div>
								<div>
									<strong>Status:</strong>
									<c:set var="tableUser" value="${viewCourse}" scope="request"/>

									<jsp:include page="../admin/includes/status.jsp"/>
								</div>
								<div><strong>Rating:</strong>${viewCourse.getRating()}</div>
								<div>
									<strong>Current Lesson:</strong>
									<c:choose>
										<c:when test="${viewCourse.getCurrentLesson() != null}">${viewCourse.getCurrentLesson()}</c:when>
										<c:otherwise>No Lessons</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
						<!-- Modal -->
						<div class="modal fade" id="tagsModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalL" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<form:form id="tagsForm" method="POST" action="/lecturer/course/${viewCourse.getCode()}/tags" modelAttribute="viewCourse">
										<div class="modal-header">
										<h5 class="modal-title">Edit Tags</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
										<div class="modal-body">
											<form:label path="tags" class="control-label mb-0">Tags</form:label>
											<small class="form-text text-muted">Maximum of 5 tags.</small>
											<form:select path="tags" multiple="true" class="form-control">
												<form:options items="${allTags}" itemLabel="name" itemValue="id"/>
											</form:select>
										</div>
										<div class="modal-footer">
											<button type="reset" class="btn btn-secondary" data-dismiss="modal">Close</button>
											<button type="submit" class="btn btn-primary">Save changes</button>
										</div>
									</form:form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<hr>
				<div class="row mx-1">
					<div class="col-12 col-lg-4">
						<div id="learnersCard" class="card course-list">
							<div class="card-header d-flex justify-content-between">Learners<span>Total Learners: ${viewCourse.getLearners().size()}</span></div>
							<div class="card-block">
								<div class="table-loader load-cont p-4 m-4" style="display: none;">
									<div class="loader"></div>
								</div>
								<div class="table-cont">
									<c:set var="pagination" value="${viewCourse.getLearnerPagination()}" scope="request"/>
									<c:set var="code" value="${viewCourse.getCode()}" scope="request"/>
									<jsp:include page="/WEB-INF/jsp/course/pagination/learners.jsp"/>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-lg-8 my-2 mt-lg-0 pl-lg-0">
						<div id="lessonsCard" class="card course-list">
							<div class="card-header d-flex justify-content-between align-items-center">Lessons
								<span>Total Lessons: ${viewCourse.getLessons().size()}</span>
								<div>
									<a href="/lecturer/course/${viewCourse.getCode()}/lesson/add" class="btn btn-sm btn-success"><span class="hidden-sm-down">Add new Lesson</span><i class="material-icons hidden-md-up">add</i></a>
								</div>
							</div>
							<div class="card-block">
								<div class="table-loader load-cont p-4 m-4" style="display: none;">
									<div class="loader"></div>
								</div>
								<div class="table-cont">
									<c:set var="pagination" value="${viewCourse.getLessonPagination()}" scope="request"/>
									<jsp:include page="/WEB-INF/jsp/course/pagination/lessons.jsp"/>
								</div>
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