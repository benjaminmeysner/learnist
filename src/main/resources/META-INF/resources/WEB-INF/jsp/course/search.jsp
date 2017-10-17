<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="FDMWebApp.domain.Course"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Search Courses"/>
		<jsp:include page="../includes/head.jsp"/>
		<!-- Add css here -->
		<link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="main">
			<div class="container container-fluid pt-4 px-0 px-3">
				<c:if test="${courseError != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
							${courseError}
					</div>
				</c:if>
				<c:choose>
					<c:when test="${myCourses != null}">
						<div class="d-flex justify-content-between align-items-center hidden-md-down">
							<h1 class="display-4 ">Browse Courses</h1>
						</div>
						<div class="d-flex justify-content-between align-items-center hidden-lg-up">
							<h1 class="">Browse Courses</h1>
						</div>
					</c:when>
					<c:otherwise>
						<div class="d-flex justify-content-between align-items-center hidden-md-down">
							<h1 class="display-4 ">Courses</h1>
							<button class="btn btn-default btn-lg" data-toggle="collapse" data-target="#refineDiv">Refine Search</button>
						</div>
						<div class="d-flex justify-content-between align-items-center hidden-lg-up">
							<h1 style="font-weight: 300;">Courses</h1>
							<button class="btn btn-default btn-sm" data-toggle="collapse" data-target="#refineDiv">Refine Search</button>
						</div>
						<div id="refineDiv" class="collapse">
							<form:form action="/course/search" method="POST" modelAttribute="searchCourse">
								<div class="row">
									<div class="form-group col-6">
										<div>
											<h4 style="font-weight: 300;">Search by subject and tags</h4>
											<form:select class="form-control custom-select" path="subject">
												<form:options items="${Course.getSubjects()}"/>
											</form:select>
											<div class="d-flex mt-2">
												<button type="submit" style="width: 120px;" class="btn btn-success">Search</button>
											</div>
										</div>
									</div>
									<div class="form-group col-6">
										<form:select class="form-control" path="tags" multiple="true">
											<form:options items="${allTags}" itemValue="id"/>
										</form:select>
									</div>
								</div>
							</form:form>
						</div>
					</c:otherwise>
				</c:choose>
				<hr>
				<c:choose>
					<c:when test="${myCourses == null || courses.getPage().getContent().size() > 0}">
						<div class="card-block">
							<div class="table-loader load-cont p-4 m-4" style="display: none;">
								<div class="loader"></div>
							</div>
							<div id="coursesReplace" class="table-cont">
								<c:set var="pagination" value="${courses}" scope="request"/>
								<jsp:include page="pagination/searches.jsp"/>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="row">
							<div class="col-12">
								<h2 style="font-weight: 300;">Popular Courses</h2>
								<div id="carouselPop" class="carousel slide" data-ride="carousel" data-interval="3000">
									<ol class="carousel-indicators">
										<li data-target="#carouselPop" data-slide-to="0" class="active"></li>
										<li data-target="#carouselPop" data-slide-to="1"></li>
										<li data-target="#carouselPop" data-slide-to="2"></li>
									</ol>
									<div class="carousel-inner" role="listbox">
										<c:set var="isFirst" value="${true}" scope="page"/>
										<c:forEach var="course" items="${popularCourses}">
											<c:choose>
												<c:when test="${isFirst}">
													<div class="carousel-item mx-auto active">
														<div class="carousel-div">
															<img class="d-block img-fluid" src="${course.getImage().getUrl()}" alt="...">
														</div>
														<div class="carousel-caption d-none d-md-block">
															<h3>${course.getName()}</h3>
															<p>${course.getDescription()}</p>
															<a href="/course/${course.getCode()}" class="btn btn-primary">View</a>
														</div>
													</div>
													<c:set var="isFirst" value="${false}" scope="page"/>
												</c:when>
												<c:otherwise>
													<div class="carousel-item mx-auto">
														<div class="carousel-div">
															<img class="d-block img-fluid" src="${course.getImage().getUrl()}" alt="...">
														</div>
														<div class="carousel-caption d-none d-md-block">
															<h3>${course.getName()}</h3>
															<p>${course.getDescription()}</p>
															<a href="/course/${course.getCode()}" class="btn btn-primary">View</a>
														</div>
													</div>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<h2 style="font-weight: 300;">Top Courses</h2>
								<div id="carouselTop" class="carousel slide" data-ride="carousel" data-interval="3000">
									<ol class="carousel-indicators">
										<li data-target="#carouselTop" data-slide-to="0" class="active"></li>
										<li data-target="#carouselTop" data-slide-to="1"></li>
										<li data-target="#carouselTop" data-slide-to="2"></li>
									</ol>
									<div class="carousel-inner" role="listbox">
										<c:set var="isFirst" value="${true}" scope="page"/>
										<c:forEach var="course" items="${topCourses}">
											<c:choose>
												<c:when test="${isFirst}">
													<div class="carousel-item mx-auto active">
														<div class="carousel-div">
															<img class="d-block img-fluid" src="${course.getImage().getUrl()}" alt="...">
														</div>
														<div class="carousel-caption d-none d-md-block">
															<h3>${course.getName()}</h3>
															<p>${course.getDescription()}</p>
															<a href="/course/${course.getCode()}" class="btn btn-primary">View</a>
														</div>
													</div>
													<c:set var="isFirst" value="${false}" scope="page"/>
												</c:when>
												<c:otherwise>
													<div class="carousel-item mx-auto">
														<div class="carousel-div">
															<img class="d-block img-fluid" src="${course.getImage().getUrl()}" alt="...">
														</div>
														<div class="carousel-caption d-none d-md-block">
															<h3>${course.getName()}</h3>
															<p>${course.getDescription()}</p>
															<a href="/course/${course.getCode()}" class="btn btn-primary">View</a>
														</div>
													</div>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</div>
									<a class="carousel-control-prev" href="#carouselTop" role="button" data-slide="prev">
										<span class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="sr-only">Previous</span>
									</a>
									<a class="carousel-control-next" href="#carouselTop" role="button" data-slide="next">
										<span class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="sr-only">Next</span>
									</a>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<jsp:include page="../includes/scripts.jsp"/>
	</body>
</html>