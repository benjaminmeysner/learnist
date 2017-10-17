<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Meetup"/>
		<jsp:include page="../includes/head.jsp"/>
		<!-- Add css here -->
		<link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="main">
			<div class="container container-fluid pt-4 px-0 px-sm-3">
				<c:if test="${meetupSuccess != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
							${meetupSuccess}
					</div>
				</c:if>
				<c:if test="${meetupError != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
							${meetupError}
					</div>
				</c:if>
				<div class="d-flex align-items-center mx-2" id="courseHeader">
					<h1 class="display-4 my-0 mx-1">Meetup: ${viewMeetup.getCourse().getName()}</h1>
					<div class="btn-group">
						<a href="/lecturer/course/${viewMeetup.getCourse().getCode()}" class="btn btn-primary ml-auto">View Course</a>
						<c:if test="${viewMeetup.getCourse().getMeetup() != null}">
							<a href="/course/${viewMeetup.getCourse().getCode()}/meetup" class="btn btn-success ml-2">View Meetup</a>
							<button data-toggle="modal" data-target="#deleteModal" class="btn btn-danger ml-2">Delete Meetup</button>
							<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
								<div class="modal-dialog modal-sm" role="document">
									<div class="modal-content">
										<div class="modal-body">
											Are you sure you want to delete the meetup?
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
											<form:form method="POST" action="/lecturer/course/${viewMeetup.getCourse().getCode()}/meetup/delete">									<button type="submit" class="btn btn-primary">Yes</button>

											</form:form>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
				<hr/>
				<form:form method="POST" id="meetupForm" class="container container-fluid pt-4" action="/lecturer/course/${viewMeetup.getCourse().getCode()}/meetup/edit" modelAttribute="viewMeetup" data-toggle="validator">
					<div style="width: 50%;">
						<h3 style="font-weight: 300;">Location</h3>
						<hr>
					</div>
					<div class="form-group">
						<form:label path="location.street_address" for="inputAdd1" class="control-label">Street Address</form:label>
						<form:textarea path="location.street_address" type="textarea" class="form-control" id="inputAdd1"
						               placeholder="Street Address" pattern="[A-Za-z0-9]*"
						               data-pattern-error="Field only allows alphanumeric characters" autocomplete="street-address"
						               rows="2"></form:textarea>
						<div class="help-block with-errors"></div>
					</div>
					<div class="form-group">
						<form:label path="location.postalcode" for="inputAdd2" class="control-label">Postcode</form:label>
						<form:input path="location.postalcode" type="text" class="form-control" id="inputAdd2" placeholder="Postcode"
						            pattern="[A-Za-z0-9]{3,4}[ ][A-Za-z0-9]{3}" data-pattern-error="Please enter a valid postcode"
						            autocomplete="postal-code"/>
						<div class="help-block with-errors"></div>
					</div>
					<div class="form-group">
						<form:label path="location.country" for="inputAdd3" class="control-label">Country</form:label>
						<form:select path="location.country" id="inputAdd3" class="form-control custom-select" autocomplete="country"
						             disabled="disabled">
							<form:option value="">None</form:option>
							<form:option value="gb">United Kingdom</form:option>
						</form:select>
					</div>
					<div style="width: 50%;">
						<h3 style="font-weight: 300;">Date</h3>
						<hr>
					</div>
					<div class="form-group">
						<form:input path="date" id="newDate" type="datetime-local" required="required" class="form-control"/>
						<div class="help-block with-errors"></div>
					</div>
					<div class="input-group pt-5 d-flex justify-content-center">
						<button type="submit" style="width: 100%;" class="btn btn-success">Submit</button>
					</div>
				</form:form>
			</div>
		</div>
		<jsp:include page="../includes/scripts.jsp"/>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.1/moment.min.js"></script>
		<!-- Add javascript here -->

		<script type="text/javascript">
            var date = moment('${viewMeetup.getDate()}');
            $('#newDate').val(date.format("YYYY-MM-DDThh:mm"))
		</script>
	</body>
</html>