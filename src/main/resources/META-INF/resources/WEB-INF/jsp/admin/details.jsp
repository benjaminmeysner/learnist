<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="adminContainer">
    <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/administrator/dashboard">Home</a></li>
    <li class="breadcrumb-item"><a href="/administrator">Administrator</a></li>
    <li class="breadcrumb-item active">Details</li>
</ol>
    <div class="container-fluid mt-1 px-0 px-sm-3">
    <div id="ui-view">
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
        <div class="row">
            <div class="col-lg-6">
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
                                        <button class="btn btn-success pass-tog"><span class="hidden-md-down">Edit</span><i class="material-icons hidden-lg-up">mode_edit</i></button>
                                    </td>
                                </tr>
                                <form:form class="user-page-form" action="/user/new-password" method="POST" data-toggle="validator">
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
                            <tr>
                                <td><strong>Access Level</strong></td>
                                <td>${user.getAccessLevel()}</td>
                                <td></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
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
    </div>
</div>
</div>