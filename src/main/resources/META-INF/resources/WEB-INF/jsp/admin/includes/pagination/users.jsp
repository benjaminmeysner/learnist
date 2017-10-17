<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="searchTable" class="pagination-table">
<c:choose>
	<c:when test="${pagination.getPage().getContent() != null }">
		<table class="table table-hover mb-0">
			<thead>
				<tr>
					<th>Username</th>
					<th class="hidden-sm-down">Email</th>
					<th class="text-center">Role</th>
					<th class="text-center hidden-xs-down">Status</th>
					<th class="text-center">Activated</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${pagination.getPage().getContent()}" var="tableUser">
					<tr>
						<td class="word-wrap"><a class="user-page-link" href='/administrator/user/${tableUser.getUsername()}'>${tableUser.getUsername()}</a></td>
						<td class="hidden-sm-down word-wrap">${tableUser.getEmail()}</td>
						<td class="text-center">${tableUser.getRole()}</td>
						<c:set var="tableUser" value="${tableUser}" scope="request"/>
						<td class="text-center hidden-xs-down">
							<jsp:include page="../status.jsp"/>
						</td>
						<td class="text-center">
							<c:choose>
								<c:when test="${tableUser.isActivated()}">
									<span class="badge badge-pill badge-success">Yes</span>
								</c:when>
								<c:otherwise>
									<span class="badge badge-pill badge-danger">No</span>
								</c:otherwise>
							</c:choose>
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
			No Results.
		</div>
	</c:otherwise>
</c:choose>
</div>