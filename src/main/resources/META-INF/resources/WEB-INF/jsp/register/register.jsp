<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="form-group">
    <form:label path="username" for="inputuserName" class="control-label">Username</form:label>
    <form:input path="username" type="text" class="form-control" id="inputUsername" placeholder="Enter Username"
                data-minlength="6" maxlength="16" data-remote="/register/username"
                data-remote-error="Username already in use" pattern="[A-Za-z0-9]*"
                data-pattern-error="Field only allows alphanumeric characters" required=""/>
    <div class="help-block with-errors"></div>
</div>
<div class="form-group">
    <form:label path="email" for="inputEmail">Email address</form:label>
    <form:input path="email" type="email" class="form-control" id="inputEmail" aria-describedby="emailHelp"
                placeholder="Enter Email" data-remote="/register/email" data-remote-error="Email already in use"
                autocomplete="email" required=""/>
    <div class="help-block with-errors"></div>
</div>
<div class="form-group">
    <form:label path="password" for="inputPassword" class="control-label">Password</form:label>
    <form:input path="password" type="password" data-minlength="6" maxlength="30" class="form-control"
                id="inputPassword" pattern="[A-Za-z0-9]*" data-pattern-error="Field only allows alphanumeric characters"
                placeholder="Enter Password" autocomplete="off" required=""/>
    <div class="help-block with-errors"></div>
</div>
<div class="form-group">
    <label for="inputConfirm" class="control-label">Confirm Password</label>
    <input type="password" class="form-control" id="inputConfirm" placeholder="Confirm Password"
           data-match="#inputPassword" data-match-error="Passwords do not match" autocomplete="off" required>
    <div class="help-block with-errors"></div>
</div>
<hr/>
<c:if test="${addressError != null}">
    <div class="alert alert-danger">${addressError}</div>
</c:if>
<h2>Address</h2>
<div class="form-group">
    <form:label path="address.street_address" for="inputAdd1" class="control-label">Street Address</form:label>
    <form:textarea path="address.street_address" type="textarea" class="form-control" id="inputAdd1"
                   placeholder="Street Address" pattern="[A-Za-z0-9]*"
                   data-pattern-error="Field only allows alphanumeric characters" autocomplete="street-address"
                   rows="2"></form:textarea>
    <div class="help-block with-errors"></div>
</div>
<div class="form-group">
    <form:label path="address.postalcode" for="inputAdd2" class="control-label">Postcode</form:label>
    <form:input path="address.postalcode" type="text" class="form-control" id="inputAdd2" placeholder="Postcode"
                pattern="[A-Za-z0-9]{3,4}[ ][A-Za-z0-9]{3}" data-pattern-error="Please enter a valid postcode"
                autocomplete="postal-code"/>
    <div class="help-block with-errors"></div>
</div>
<div class="form-group">
    <form:label path="address.country" for="inputAdd3" class="control-label">Country</form:label>
    <form:select path="address.country" id="inputAdd3" class="form-control custom-select" autocomplete="country"
                 disabled="disabled">
        <form:option value="">None</form:option>
        <form:option value="gb">United Kingdom</form:option>
    </form:select>
</div>