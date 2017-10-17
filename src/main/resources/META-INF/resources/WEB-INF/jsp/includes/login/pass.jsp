<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="formContainer">
    <c:if test="${error != null}">
        <div class="alert alert-danger">
            <strong><c:out value="${error}"/></strong>
        </div>
    </c:if>
    <form:form id="modalForm" data-toggle="validator" action="/login-request" method="POST">
        <div class="form-group">
            <label for="authUsername" class="control-label" hidden>Username</label>
            <input name="username" id="authUsername" type="text" class="form-control" value="${username}" hidden/>
        </div>
        <div class="form-group">
            <label for="authPassword">Enter Key</label>
            <input name="password" type="text" class="form-control" id="authPassword" data-minlength="6" maxlength="6" pattern="[0-9]*" data-pattern-error="Field only allows numbers" required autofocus/>
            <div class="help-block with-errors"></div>
        </div>
        <div class="button-group" id="loginBtn">
            <hr/>
            <button type="submit" class="btn btn-success">Login</button>
        </div>
    </form:form>
</div>
