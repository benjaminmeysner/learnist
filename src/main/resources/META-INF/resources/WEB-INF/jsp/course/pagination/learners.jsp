<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="pagination-table">
	<c:choose>
		<c:when test="${pagination.getPage().hasContent()}">
			<table class="table table-hover mb-0">
				<thead>
					<tr>
						<th>Username</th>
						<th class="text-center">Message</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pagination.getPage().getContent()}" var="tableUser">
						<tr>
						<c:choose>
							<c:when test='${user.getRole().equals("administrator")}'>
								<td><a class="user-page-link" href="/administrator/user/${tableUser.getUsername()}">${tableUser.getUsername()}</a></td>
							</c:when>
							<c:otherwise>
								<td>${tableUser.getUsername()}</td>
							</c:otherwise>
						</c:choose>
							<td class="text-center"><button class="btn btn-success msg-btn" data-toggle="modal"  data-target="#messageModal" data-value="${tableUser.getUsername()}"><span class="fa fa-envelope"></span></button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<form:form method="POST" action="/user/message/" validator="validator">
						<div class="modal-header">
							<h1 style="font-weight: 300">Compose Message</h1>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							</button>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label>To: </label>
								<input class="form-control"disabled class="form-control"/>
							</div>
							<div class="form-group">
								<label>Body: </label>
								<textarea style="height: 100px;" maxlength="255" class="form-control"></textarea>
							</div>
						</div>
						<div class="modal-footer">
		                    <button id="removeLearner" type="submit" class="btn btn-success">Send</button>
						</div>
						</form:form>
					</div>
				</div>
			</div>
			<hr class="mt-0"/>
			<jsp:include page="/WEB-INF/jsp/includes/pagination.jsp"/>
		</c:when>
		<c:otherwise>
			<div class="alert alert-info">
				No Learners.
			</div>
		</c:otherwise>
	</c:choose>
</div>