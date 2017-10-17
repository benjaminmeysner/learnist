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
						<th class="text-center">Rating</th>
						<th class="text-center">Status</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pagination.getPage().getContent()}" var="tableCourse">
						<tr class="clickable-row" data-href="/course/${tableCourse.getCode()}">
							<td>${tableCourse.getName()}</td>
							<td class="hidden-sm-down">${tableCourse.getSubject()}</td>
							<td class="text-center">${tableCourse.getRating()}</td>
							<c:set var="tableUser" value="${tableCourse}" scope="request"/>
							<td class="text-center">
								<jsp:include page="../../admin/includes/status.jsp"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr class="mt-0"/>
			<jsp:include page="/WEB-INF/jsp/includes/pagination.jsp"/>
		</c:when>
		<c:otherwise>
			<div class="alert alert-info">
				No courses.
			</div>
		</c:otherwise>
	</c:choose>
</div>