<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <c:set var="title" scope="application" value="Learnist | Register"/>
    <jsp:include page="../includes/head.jsp"/>
    <!-- Add css here -->
    <link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
</head>
<body>
<jsp:include page="../includes/nav.jsp"/>
<div id="main">
    <div class="pt-4">
        <div class="container container-fluid my-3">
            <div class="jumbotron jumbotron-fluid mb-0">
                <div class="container">
                    <h1 class="display-4"><c:out value="${title}"/></h1>
                    <p class="lead"><c:out value="${text}"/></p>
                    <c:if test="${image}">
                        <div style="text-align: left;">
                            <h3>Setup Google Authenticator</h3>
                            <ol>
                                <li>Download and install app. *</li>
                                <li>Select add an account.</li>
                                <li>Scan the barcode using you phones camera.</li>
                            </ol>
                            <p>*links to download the app:</p>
                            <ul>
                                <li>
                                    <a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2">Android</a>
                                </li>
                                <li><a href="https://itunes.apple.com/gb/app/google-authenticator/id388497605">IOS</a></li>
                            </ul>
                            <div class="toggle-cam">
                                <h4>Scan QR Code</h4>
                                <img class="mb-2" src="<c:url value="${authImg}"/>"/>
                            </div>
                            <div class="collapse" id="collapseSecret">
                                <h4>Enter this key instead</h4>
                                <p>${auth.getSecretKey()}</p>
                            </div>
                            <a href="#collapseSecret" data-toggle="collapse"><small>Haven't got a camera?</small></a>
                            <form:form id="confirmKeyForm" action="/register/keyConfirm" method="POST" data-toggle="validator"
                                       class="d-flex align-items-center">
                                <div class="form-group d-flex my-2">
                                    <input type="text" name="key" class="form-control" id="keyToConfirm"
                                           placeholder="Please Insert the 6 Digit key" autocomplete="off" data-minlength="6"
                                           maxlength="6" pattern="[0-9]*" data-pattern-error="Field only allows numbers" style="text-align: center;" required>
                                </div>
                                <div class="button-group">
                                    <button type="submit" class="btn btn-success">Check</button>
                                </div>
                            </form:form>
                            <div id="key_status" class="alert alert-danger" style="display: none; text-align: center;" role="alert">
                            </div>
                        </div>
                    </c:if>
                    <c:choose>
                        <c:when test="${button != null}">
                            <a href="<c:url value="${linkUrl}"/>" class="btn btn-primary btn-lg"><c:out
                                    value="${linkText}"/></a>
                        </c:when>
                        <c:otherwise>
                            <a class="btn btn-primary btn-lg mt-2" href="/" role="button">Back to Home</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../includes/loginModal.jsp"/>
<jsp:include page="../includes/registerModal.jsp"/>
<jsp:include page="../includes/scripts.jsp"/>
<script src="<c:url value="/public/js/login.js" />"></script>
<script src="<c:url value="/public/js/authentication.js" />"></script>
</body>
</html>