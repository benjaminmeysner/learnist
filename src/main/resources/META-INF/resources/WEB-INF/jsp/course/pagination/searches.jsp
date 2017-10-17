<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagination-table">
	<c:choose>
		<c:when test="${pagination.getPage().hasContent()}">
			<div>
				<c:forEach var="course" items="${pagination.getPage().getContent()}">
					<div class="card row">
					<div class="col-lg-4 py-2 py-md-0">
						<img class="card-img-left img-fluid" src="<c:url value="${course.getImage().getUrl()}"/>" />
					</div>
					<div class="card-block col-lg-8">
						<div id="top" class="d-flex justify-content-between">
							<h3 class="card-title m-0">${course.getName()}</h3>
							<div class="star-rating">
								<c:forEach var="i" begin="0" end="4">
									<c:choose>
										<c:when test="${course.getRating() - i  >= 0.5}">
											<c:choose>
												<c:when test="${0.5 <= course.getRating() - i && course.getRating() - i < 1}">
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
								<span class="hidden-md-up">${course.getRating()}</span>
							</div>
						</div>
						<hr>
						<p>${course.getDescription()}</p>
						<div class="d-flex justify-content-between align-items-center">
							<span>Subject: ${course.getSubject()}</span>
							<span>Lecturer: <a href="/user/${course.getLecturer().getUsername()}">${course.getLecturer().getFirstName()} ${course.getLecturer().getSurname()}</a></span>
						</div>
						<div id="viewCourse" class="d-flex mt-2">
							<a href="/course/${course.getCode()}" class="btn btn-success ml-auto">View</a>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
			<hr class="mt-0"/>
			<jsp:include page="/WEB-INF/jsp/includes/pagination.jsp"/>
		</c:when>
		<c:otherwise>
			<c:forEach items="${backtag}" var="tag">
				<p>${tag.getId()}</p><p>${tag.getName()}</p>
			</c:forEach>
			<div class="alert alert-warning">
				<p>Your search returned no results.</p>
			</div>
		</c:otherwise>
	</c:choose>

</div>