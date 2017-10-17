<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="FDMWebApp.domain.Lecturer"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Settings | ${user.getUsername()}"/>
		<jsp:include page="../includes/head.jsp"/>
		<!-- Add css here -->
		<link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="main">
			<c:if test="${userSuccess != null}">
				<div class="alert alert-success alert-dismissible fade show" role="alert">
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
						${userSuccess}
				</div>
			</c:if>
			<c:if test="${userError != null}">
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
						${userError}
				</div>
			</c:if>
			<h1 class="display-4 m-3">Settings</h1>
			<hr>
			<div class="container-fluid pt-4 px-0 px-sm-3">
				<h2 class="p-1 px-lg-3">Details</h2>
				<div class="row">
					<div class="col-lg-6 p-0 p-lg-4">
						<div class="card">
							<div class="card-header">Personal</div>
							<div class="card-block">
								<table class="table table-striped">
									<tbody>
										<tr>
											<td><strong>Username</strong></td>
											<td class="word-wrap">${user.getUsername()}</td>
											<td></td>
										</tr>
										<tr>
											<td><strong>Email Address</strong></td>
											<td class="word-wrap">${user.getEmail()}</td>
											<td></td>
										</tr>
										<tr class="pass-edit">
											<td><strong>Password</strong></td>
											<td class="word-wrap">***********</td>
											<td>
												<button class="btn btn-success p-1 px-lg-3 py-lg-2 pass-tog"><span class="hidden-md-down">Edit</span><i class="material-icons hidden-lg-up">mode_edit</i></button>
											</td>
										</tr>
										<form:form action="/user/new-password" method="POST" data-toggle="validator">
											<tr class="pass-edit" style="display: none;">
												<td><strong>New Password</strong></td>
												<td class="form-group"><input id="inputPassword" type="password" name="password" data-minlength="6" maxlength="30" class="form-control" required=""><div class="help-block with-errors"></div></td>

											</tr>
											<tr class="pass-edit" style="display: none;">
												<td><strong>Confirm Password</strong></td>
												<td><input class="form-control" type="password" name="confirm"  data-match="#inputPassword" required><div class="help-block with-errors"></div></td>

											</tr>
											<tr class="pass-edit" style="display: none;">
												<td></td>
												<td class="d-flex justify-content-between"><button type="reset" class="btn btn-warning pass-tog">Cancel</button><button type="submit" class="btn btn-success">Submit</button></td>
												<td></td>
											</tr>
										</form:form>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="col-lg-6 p-0 p-lg-4">
						<div class="card">
							<div class="card-header">Address</div>
							<div class="card-block">
								<div class="table-loader load-cont p-4 m-4" style="display: none;">
									<div class="loader"></div>
								</div>
								<div class="table-cont">
									<jsp:include page="/WEB-INF/jsp/includes/address.jsp"/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<h2 class="p-1 px-lg-3 my-3 my-lg-0">My Courses</h2>
				<div class="row">
					<div class="col-lg-12 p-0 p-lg-4">
						<div class="card">
							<div class="card-header d-flex align-items-center">All Courses<div class="ml-auto"><a href="/lecturer/course/add" class="btn btn-success">Add New Course</a></div></div>
							<div class="card-block">
								<div class="table-loader load-cont p-4 m-4" style="display: none;">
									<div class="loader"></div>
								</div>
								<div class="table-cont">
									<c:set var="pagination" value="${viewUser.getCoursePagination()}" scope="request"/>
									<jsp:include page="/WEB-INF/jsp/course/pagination/courses.jsp"/>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../includes/scripts.jsp"/>
		<!-- Add javascript here -->
	</body>
</html>