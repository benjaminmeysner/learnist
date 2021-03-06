<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="pagination-table">
	<c:choose>
		<c:when test="${pagination.getPage().hasContent()}">
			<table class="table table-hover mb-0">
				<thead>
					<tr>
						<th>Username</th>
						<th class="hidden-sm-down">Email</th>
						<th class="text-center">Status</th>
						<th class="text-center">Access Level</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pagination.getPage().getContent()}" var="tableUser">
						<tr><a href="#">
							<td><a class="user-page-link" href='/administrator/user/${tableUser.getUsername()}'>${tableUser.getUsername()}</a></td>
							<td class="hidden-sm-down">${tableUser.getEmail()}</td>
							<c:set var="tableUser" value="${tableUser}" scope="request"/>
							<td class="text-center">
								<jsp:include page="../status.jsp"/>
							</td>
							<td class="text-center">${tableUser.getAccessLevel()}</td>
						</a></tr>
					</c:forEach>
				</tbody>
			</table>
			<hr class="mt-0"/>
			<jsp:include page="/WEB-INF/jsp/includes/pagination.jsp"/>
		</c:when>
		<c:otherwise>
			<div class="alert alert-info">
				No administrators.
			</div>
		</c:otherwise>
	</c:choose>
</div>