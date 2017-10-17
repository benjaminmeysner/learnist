<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="adminContainer">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/administrator/dashboard">Home</a></li>
        <li class="breadcrumb-item"><a href="/administrator">Administrator</a></li>
        <li class="breadcrumb-item">Users</li>
        <li class="breadcrumb-item active">Administrators</li>
    </ol>
    <div class="container-fluid mt-1 px-1 px-sm-3">
        <div id="ui-view">
            <div class="row">
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">Register Administrator</div>
                        <div class="card-block p-1 p-sm-1">
                            <c:if test="${registerSuccess != null}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    ${registerSuccess} added!
                                </div>
                            </c:if>
                            <c:if test="${registerError != null}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                        ${registerError}
                                </div>
                            </c:if>
                            <form:form action="/administrator/user/administrator/add" method="POST" class="user-page-form" data-toggle="validator" modelAttribute="addUser">
                                <div class="form-group">
                                    <form:label path="username" for="inputuserName" class="control-label">Username</form:label>
                                    <form:input path="username" type="text" class="form-control" id="inputUsername" placeholder="Enter Username" data-minlength="6" maxlength="16" data-remote="/register/username" data-remote-error="Username already in use" pattern="[A-Za-z0-9]*" data-pattern-error="Field only allows alphanumeric characters" required=""/>
                                    <div class="help-block with-errors"></div>
                                </div>
                                <div class="form-group">
                                    <form:label path="email" for="inputEmail">Email address</form:label>
                                    <form:input path="email" type="email" class="form-control" id="inputEmail" aria-describedby="emailHelp" placeholder="Enter Email" data-remote="/register/email" data-remote-error="Email already in use" autocomplete="email" required=""/>
                                    <div class="help-block with-errors"></div>
                                </div>
                                <div class="form-group">
                                    <form:label path="password" for="inputPassword" class="control-label">Password</form:label>
                                    <form:input path="password" type="password" data-minlength="6" maxlength="30" class="form-control" id="inputPassword" pattern="[A-Za-z0-9]*" data-pattern-error="Field only allows alphanumeric characters" placeholder="Enter Password" autocomplete="off" required=""/>
                                    <div class="help-block with-errors"></div>
                                </div>
                                <div class="form-group">
                                    <label for="inputConfirm" class="control-label">Confirm Password</label>
                                    <input type="password" class="form-control" id="inputConfirm" placeholder="Confirm Password" data-match="#inputPassword" data-match-error="Passwords do not match" autocomplete="off" required>
                                    <div class="help-block with-errors"></div>
                                </div>
                                <div class="form-group">
                                    <form:label path="accessLevel" for="inputAccess" class="control-label">Access Level</form:label>
                                    <form:select path="accessLevel" class="form-control custom-select">
                                        <form:option value="1"/>
                                        <form:option value="2"/>
                                    </form:select>
                                </div>
                                <hr class="mt-0"/>
                                 <div class="d-flex justify-content-between">
                                    <button type="reset" class="btn btn-danger">Reset</button>
                                    <button type="submit" class="btn btn-success">Submit</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">All</div>
                        <div class="card-block p-0 p-sm-1">
                            <div class="table-loader load-cont p-4 m-4" style="display: none;">
                                <div class="loader"></div>
                            </div>
                            <div class="table-cont">
                                <c:set var="pagination" value="${administrators}" scope="request"/>
                                <jsp:include page="../includes/pagination/administrators.jsp"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>