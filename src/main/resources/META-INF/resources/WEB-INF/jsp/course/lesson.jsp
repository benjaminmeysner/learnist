<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="FDMWebApp.aws.StorageHandler"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="${viewLesson.getName()}"/>
		<jsp:include page="../includes/head.jsp"/>
		<link rel="stylesheet" href="<c:url value="/public/css/lesson.css" />">
		<c:if test="${pdf == null}">
		<link href="http://vjs.zencdn.net/5.19.2/video-js.css" rel="stylesheet">
		</c:if>
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="main">
			<div class="row">
				<div class="col-9 pr-0">
					<div id="content">
						<c:choose>
							<c:when test="${pdf == null}">
								<video id="lessonVideo" class="video-js vjs-big-play-centered" controls preload="none" poster="${viewLesson.getCourse().getImage().getUrl()}" data-setup="{}">
									<source src="${viewLesson.getMainFile().getUrl()}" type='video/${StorageHandler.getFileExtension(viewLesson.getMainFile().getUrl()).substring(1)}'>
									<p class="vjs-no-js">
										To view this video please enable JavaScript, and consider upgrading to a web browser that
										<a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
									</p>
								</video>
							</c:when>
							<c:otherwise>
								<iframe id="applicationFrame" width="100%" height="100%" src="/public/js/viewerjs/index.html#${viewLesson.getMainFile().getUrl()}"allowfullscreen webkitallowfullscreen></iframe>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="col-3 pl-0">
					<div class="container pt-4 px-0" id="rightPane">
						<div id="support" class="px-4">
							<h2>Supporting files</h2>
							<hr>
							<div class="py-4">
								<c:choose>
									<c:when test="${viewLesson.getFiles().size() == 0}">
										No supporting files.
									</c:when>
									<c:otherwise>
										<c:forEach var="file" items="${viewLesson.getFiles()}">
											<div class="card">
												<div class="card-block">
													<a href="${file.getUrl()}">${file.getFilename()}</a>												                                        </div>
											</div>
											<hr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div id="navigation">
							<c:choose>
								<c:when test="${viewLesson.getOrder() == 1}">
									<button disabled="true" class="btn btn-success"><i class="material-icons">forward</i>Previous Lesson</button>
								</c:when>
								<c:otherwise>
									<a href="/course/${viewLesson.getCourse().getCode()}/lesson/${viewLesson.getOrder() - 1}" class="btn btn-success"><i class="material-icons">forward</i>Previous Lesson</a>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${viewLesson.getOrder() == viewLesson.getCourse().getCurrentLesson()}">
									<button disabled="true" class="btn btn-primary">Next Lesson<i class="material-icons">forward</i></button>
								</c:when>
								<c:otherwise>
									<a href="/course/${viewLesson.getCourse().getCode()}/lesson/${viewLesson.getOrder() + 1}" class="btn btn-primary">Next Lesson<i class="material-icons">forward</i></a>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../includes/scripts.jsp"/>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"
		        integrity="sha384-mE6eXfrb8jxl0rzJDBRanYqgBxtJ6Unn4/1F7q4xRRyIw7Vdg9jP4ycT7x1iVsgb"
		        crossorigin="anonymous"></script>
		<c:if test="${pdf == null}">
		<script src="http://vjs.zencdn.net/5.19.2/video.js"></script>
		</c:if>
	</body>
</html>