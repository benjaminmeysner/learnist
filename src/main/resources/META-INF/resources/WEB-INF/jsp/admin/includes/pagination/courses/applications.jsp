<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="pagination-table">
	<c:choose>
		<c:when test="${pagination.getPage().hasContent()}">
			<table class="table table-hover mb-0">
				<thead>
					<tr>
						<th>Name</th>
						<th class="hidden-sm-down">Subject</th>
						<th>Lecturer</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pagination.getPage().getContent()}" var="tableCourse">
						<tr>
							<td>${tableCourse.getName()}</td>
							<td class="hidden-sm-down">${tableCourse.getSubject()}</td>
							<td><a class="user-page-link" href="/administrator/user/${tableCourse.getLecturer().getUsername()}">${tableCourse.getLecturer().getUsername()}</a></td>
							<td class="text-center"><a class="btn btn-success nav-page" data-title="${tableCourse.getName()}" href="/administrator/course/${tableCourse.getCode()}">View</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr class="mt-0"/>
			<jsp:include page="/WEB-INF/jsp/includes/pagination.jsp"/>
		</c:when>
		<c:otherwise>
			<div class="alert alert-info">
				No pending applications.
			</div>
		</c:otherwise>
	</c:choose>
</div>