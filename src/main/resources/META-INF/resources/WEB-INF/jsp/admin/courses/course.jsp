<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="adminContainer">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/administrator/dashboard">Home</a></li>
		<li class="breadcrumb-item"><a href="/administrator">Administrator</a></li>
		<li class="breadcrumb-item"><a href="/administrator/courses">Course</a></li>
		<li class="breadcrumb-item active">${viewCourse.getName()}</li>
	</ol>
	<div class="container-fluid mt-1 px-1 px-sm-3">
		<c:if test="${courseSuccess != null}">
			<div class="alert alert-success alert-dismissible fade show" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				${courseSuccess}
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
		<div id="ui-view">
			<div id="flex-row" class="d-flex align-items-center justify-content-between">
				<h1 class="display-4">${viewCourse.getName()}</h1>
				<div class="btn-group">

				</div>
			</div>
			<div class="row mx-0 mb-2">
				<div class="col-lg-4 mb-2 mb-lg-0 d-flex align-items-center justify-content-center">
					<img src='${viewCourse.getImage().getUrl()}' class="img-fluid img-thumbnail" alt=""/>
				</div>
				<div class="col-lg-6">
					<div class="row course-attrs">
						<div class="col-3 course-header">
							<strong>Lecturer:</strong>
						</div>
						<div class="col-9">
							<a class="user-page-link" href="/administrator/user/${viewCourse.getLecturer().getUsername()}">
								${viewCourse.getLecturer().getFirstName()} ${viewCourse.getLecturer().getSurname()}
							</a>
						</div>
					</div>
					<div class="row course-attrs">
						<div class="col-3 course-header">
							<strong>Description:</strong>
						</div>
						<div class="col-9">${viewCourse.getDescription()}</div>
					</div>
					<div class="row course-attrs">
						<div class="col-3 course-header">
							<strong>Subject:</strong>
						</div>
						<div class="col-9">${viewCourse.getSubject()}</div>
					</div>
					<div class="row course-attrs">
						<div class="col-3 course-header">
							<strong>Tags:</strong>
						</div>
						<div class="col-9">${viewCourse.getTags()}</div>
					</div>
					<div class="row course-attrs">
						<div class="col-3 course-header">
							<strong>Status:</strong>
						</div>
						<c:set var="tableUser" value="${viewCourse}" scope="request"/>
						<div class="col-9"><jsp:include page="../includes/status.jsp"/></div>
					</div>
					<div class="row course-attrs las">
						<div class="col-6 row d-flex align-items-center">
							<div class="col-6 col-md-4">
								<strong>Rating:</strong>
							</div>
							<div class="col-6 col-md-8">
								<span class="star-rating p-1">
                            <c:forEach var="i" begin="0" end="4">
	                            <c:choose>
		                            <c:when test="${viewCourse.getRating() - i  >= 0.5}">
			                            <c:choose>
				                            <c:when test="${0.5 <= viewCourse.getRating() - i && viewCourse.getRating() - i < 1}">
					                            <i class="material-icons">star_half</i>
				                            </c:when>
				                            <c:otherwise>
					                            <i class="material-icons">star</i>
				                            </c:otherwise>
			                            </c:choose>
		                            </c:when>
		                            <c:otherwise>
			                            <i class="material-icons">star_border</i>
		                            </c:otherwise>
	                            </c:choose>
                            </c:forEach>
                            </span>
							</div>
						</div>
						<div class="col-6 row d-flex align-items-center">
							<div class="col-3">
								<strong>Reviews:</strong>
							</div>
							<div class="col-9">
								<button data-toggle="modal" data-target="#reviewsModal" class="btn btn-primary btn-sm">View Reviews</button><c:if test="${!viewCourse.getReviews().isEmpty()}">
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
																<form:form class="user-page-form" action="/administrator/courses/${viewCourse.getCode()}/review/delete" method="POST">
																	<input type="hidden" name="id" value="${review.getId()}">
																	<button type="submit" class="btn btn-danger">Remove</button>
																</form:form>
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
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-2">
					<div class="ml-auto d-flex px-4 flex-column">
						<c:if test='${viewCourse.getStatus().toString().equals("Submitted")}'>
							<form:form method="POST" id="approvalForm" action="/administrator/course/${viewCourse.getCode()}/approved" class="user-page-form">
								<input id="inptApprove" name="approved" hidden value="" type="text"/>
								<button type="submit" name="approved" value="true" onclick="$('#inptApprove').attr('value','true')" class="btn btn-success ml-auto mb-3 btn-block">Approve Course</button>
								<button type="submit" name="approved" value="false" onclick="$('#inptApprove').attr('value','false')" class="btn btn-danger ml-auto mb-3 btn-block">Deny Course</button>
							</form:form>
						</c:if>
						<c:if test='${!viewCourse.getStatus().toString().equals("Unverified")}'>
							<button class="btn btn-warning mb-3" data-toggle="modal" data-target="#suspendModal">Suspend Course</button>
							<div class="modal fade" id="suspendModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
								<div class="modal-dialog modal-sm" role="document">
									<div class="modal-content">
										<div class="modal-body">
											Are you sure you want to suspend this course?
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
											<form:form class="user-page-form" method="POST" action="/administrator/course/${viewCourse.getCode()}/suspend">									        <button type="submit" class="btn btn-primary">Yes</button>
											</form:form>
										</div>
									</div>
								</div>
							</div>
						</c:if>

							<button class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">Delete Course</button>

							<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
								<div class="modal-dialog modal-sm" role="document">
									<div class="modal-content">
										<div class="modal-body">
											Are you sure you want to delete this course?
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
											<form:form method="POST" class="user-page-form" action="/administrator/course/${viewCourse.getCode()}/delete">									        <button type="submit" class="btn btn-primary">Yes</button>
											</form:form>
										</div>
									</div>
								</div>
							</div>
					</div>
				</div>
			</div>
			<div class="row mx-0">
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
</div>