<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="formContainer">
    <c:if test="${error != null}">
        <div class="alert alert-danger">
            <strong><c:out value="${error}"/>
                <c:if test="${notVerified}"> please check your email for a link to activate your account<a href="/register/verify/new"> or click here to resend the email.</a>
                </c:if>
                <c:if test="${notApproved}">
                    <a href="/register/lecturer/upload">Or click here to send a new application.</a>
                </c:if>
                <c:if test="${notAuthorised}">
                    <a href="/register/authenticate"> Click here to authenticate it.</a>
                </c:if>
                <c:if test="${notActivated}">
                    <a href="/register/authenticate"> You may have been banned or your account is under investigation.</a>
                </c:if>
            </strong>
        </div>
    </c:if>
    <form:form id="modalForm" data-toggle="validator" action="/login" method="POST">
        <div class="form-group">
            <label for="formUsername">Username or Email address</label>
            <input name="username" type="text" class="form-control" id="formUsername" tabindex="1" placeholder="Enter Username or Email Address" required/>
            <div class="help-block with-errors"></div>
        </div>
        <div class="form-group">
            <div id="passwordGroup">
                <label for="formPassword">Password</label>
                <a href="" onclick="return forgot()" id="passwordHelp" tabindex="3" class="small">Forgotten password?</a>
            </div>
            <input name="password" type="password" class="form-control" id="formPassword" tabindex="2" placeholder="Password" required/>
        </div>
        <div class="form-check">
            <label for="remember-me" class="form-check-label"><input id="remember-me" type="checkbox" tabindex="4" class="form-check-input"/> Remember Me</label>
        </div>
        <div class="button-group" id="loginBtn">
            <hr/>
            <button type="submit" tabindex="5" class="btn btn-success">Login</button>
        </div>
    </form:form>
</div>