<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="pagination-table">
	<c:choose>
		<c:when test="${pagination.getPage().hasContent()}">
			<table class="table table-hover mb-0">
				<thead>
					<tr>
						<th class="text-center">Order</th>
						<th>Name</th>
						<th class="text-center">Files</th>
					</tr>
				</thead>
				<tbody>
					<c:if test='${user.getRole().equals("lecturer")}'>
						<c:set var="prefix" value="/lecturer" scope="page"/>
					</c:if>
					<c:forEach items="${pagination.getPage().getContent()}" var="tableLesson">
						<c:choose>
							<c:when test='${user.getRole().equals("learner") && currentLesson < tableLesson.getOrder()}'>
								<c:set var="clickable" value="" scope="page"/>
							</c:when>
							<c:otherwise>
								<c:set var="clickable" value="clickable-row" scope="page"/>
							</c:otherwise>
						</c:choose>
						<tr class="${clickable}" data-href="${prefix}/course/${tableLesson.getCourse().getCode()}/lesson/${tableLesson.getOrder()}">
							<td class="text-center">${tableLesson.getOrder()}</td>
							<td>${tableLesson.getName()}</td>
							<td class="text-center">${tableLesson.getFiles().size()}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr class="mt-0"/>
			<jsp:include page="/WEB-INF/jsp/includes/pagination.jsp"/>
		</c:when>
		<c:otherwise>
			<div class="alert alert-info">
				No Lessons.
			</div>
		</c:otherwise>
	</c:choose>
</div>