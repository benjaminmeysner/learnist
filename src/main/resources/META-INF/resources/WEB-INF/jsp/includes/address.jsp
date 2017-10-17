<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="FDMWebApp.domain.Address" %>
<div class="form-table">
	<div class="addressToggle">
		<c:if test="${addressSuccess != null}">
			<div class="alert alert-success alert-dismissible fade show" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
					${addressSuccess}
			</div>
		</c:if>
		<c:if test="${addressError != null}">
			<div class="alert alert-danger alert-dismissible fade show" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
					${addressError}
			</div>
		</c:if>
		<c:if test="${!Address.isNull(viewUser.getAddress())}">
			<table class="table table-striped">
				<tbody>
					<tr>
						<td><strong>Street</strong></td>
						<td>${viewUser.getAddress().getStreet_address()}</td>
					</tr>
					<tr>
						<td><strong>Postcode</strong></td>
						<td>${viewUser.getAddress().getPostalcode()}</td>
					</tr>
					<tr>
						<td><strong>Country</strong></td>
						<td>${viewUser.getAddress().getCountry()}</td>
					</tr>
				</tbody>
			</table>
		</c:if>
		<button type="button" onclick="$('.addressToggle').toggle();"
		        class="btn btn-success btn-block">
			<c:choose>
				<c:when test="${Address.isNull(viewUser.getAddress())}">Add</c:when>
				<c:otherwise>Edit</c:otherwise>
			</c:choose>
		</button>
	</div>
	<div id="collapseAddress" class="addressToggle collapse">
		<form:form id="addressForm" class="user-page-form user-card-form" data-toggle="validator" autocomplete="on" method="POST" modelAttribute="viewUser" action="/user/${viewUser.getUsername()}/details/address">
			<h4>Edit/Add Address</h4>
			<div class="form-group">
				<form:label path="address.street_address" for="inputAdd1"
				            class="control-label">Street Address</form:label>
				<form:textarea path="address.street_address" type="textarea" class="form-control"
				               id="inputAdd1" placeholder="Street Address"
				               pattern="[A-Za-z0-9]*"
				               data-pattern-error="Field only allows alphanumeric characters"
				               autocomplete="street-address" rows="2"></form:textarea>
				<div class="help-block with-errors"></div>
			</div>
			<div class="form-group">
				<form:label path="address.postalcode" for="inputAdd2"
				            class="control-label">Postcode</form:label>
				<form:input path="address.postalcode" type="text" class="form-control"
				            id="inputAdd2" placeholder="Postcode"
				            pattern="[A-Za-z0-9]{3,4}[ ][A-Za-z0-9]{3}"
				            data-pattern-error="Please enter a valid postcode"
				            autocomplete="postal-code"/>
				<div class="help-block with-errors"></div>
			</div>
			<div class="form-group">
				<form:label path="address.country" for="inputAdd3"
				            class="control-label">Country</form:label>
				<form:select path="address.country" id="inputAdd3"
				             class="form-control custom-select" autocomplete="country"
				             disabled="disabled">
					<form:option value="">None</form:option>
					<form:option value="gb">United Kingdom</form:option>
				</form:select>
			</div>
			<div class="form-group">
				<form:button type="submit" class="btn btn-success">Submit</form:button>
				<form:button type="reset" class="btn btn-warning">Reset</form:button>
				<form:button type="button"
				             onclick="$('#addressForm')[0].reset();$('.addressToggle').toggle();"
				             class="btn btn-danger">Cancel</form:button>
			</div>
		</form:form>
	</div>
</div>