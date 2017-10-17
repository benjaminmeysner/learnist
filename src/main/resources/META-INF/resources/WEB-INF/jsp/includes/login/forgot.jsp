<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="formContainer">
    <c:if test="${error != null}">
        <div class="alert alert-danger">
            <strong><c:out value="${error}"/></strong>
        </div>
    </c:if>
    <form:form id="modalForm" data-toggle="validator" action="/login/forgot-password" method="POST">
        <h1>Forgotten Password</h1>
        <div class="alert alert-info" role="alert">
            Please enter your email address and we'll send you an email with instructions on changing your password.
        </div>

        <div class="form-group">
            <label for="inputEmail">Email address</label>
            <input name="email" type="email" class="form-control" id="inputEmail" aria-describedby="emailHelp" placeholder="Enter Email" autocomplete="email" required="" autofocus/>
            <div class="help-block with-errors"></div>
        </div>
        <div class="form-group">
            <label for="authKey">Enter Authentication Key</label>
            <input name="key" type="number" class="form-control" id="authKey" placeholder="Enter Key" data-minlength="6" maxlength="6" pattern="[0-9]*" data-pattern-error="Field only allows numbers" required/>
            <div class="help-block with-errors"></div>
        </div>
        <div class="button-group" id="forgotBtn">
            <button type="submit" class="btn btn-success">Submit</button>
            <button type="cancel" class="btn btn-danger mt-2 close-login">Cancel</button>
        </div>
    </form:form>
</div>