<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="adminContainer">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/administrator/dashboard">Home</a></li>
		<li class="breadcrumb-item"><a href="/administrator">Administrator</a></li>
		<li class="breadcrumb-item">Users</li>
		<li class="breadcrumb-item active">Learners</li>
	</ol>
	<div class="container-fluid mt-1 px-1 px-sm-3">
		<div id="ui-view">
			<div class="row">
				<div class="col-lg-6">
					<div class="card">
						<div class="card-header">Inactive</div>
						<div class="card-block p-1 p-sm-1">
							<div class="table-loader load-cont p-4 m-4" style="display: none;">
								<div class="loader"></div>
							</div>
							<div class="table-cont">
								<c:set var="pagination" value="${adminLearnerDAO.getInactives()}" scope="request"/>
								<jsp:include page="../includes/pagination/learners/inactives.jsp"/>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="card">
						<div class="card-header">Active</div>
						<div class="card-block p-1 p-sm-1">
							<div class="table-loader load-cont p-4 m-4" style="display: none;">
								<div class="loader"></div>
							</div>
							<div class="table-cont">
								<c:set var="pagination" value="${adminLearnerDAO.getActives()}" scope="request"/>
								<jsp:include page="../includes/pagination/learners/actives.jsp"/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>