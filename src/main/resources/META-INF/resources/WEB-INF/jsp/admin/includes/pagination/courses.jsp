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
						<th class="text-center">Status</th>
						<th class="text-center hidden-sm-down">Rating</th>
						<th class="text-center">Learners</th>
						<th class="text-center">Status</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pagination.getPage().getContent()}" var="tableCourse">
						<tr>
							<td><a href="/administrator/course/${tableCourse.getCode()}">${tableCourse.getName()}</a></td>
							<td class="hidden-sm-down">${tableCourse.getSubject()}</td>
							<td><a class="user-page-link" href="/administrator/user/${tableCourse.getLecturer().getUsername()}">${tableCourse.getLecturer().getUsername()}</a></td>
							<c:set var="tableUser" value="${tableCourse}" scope="request"/>
							<td class="text-center"><jsp:include page="../status.jsp"/></td>
							<td class="text-center hidden-sm-down">${tableCourse.getRating()}</td>
							<td class="text-center
">${tableCourse.getLearners().size()}</td>
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