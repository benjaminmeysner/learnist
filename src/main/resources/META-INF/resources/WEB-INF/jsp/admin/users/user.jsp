<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="adminContainer">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/administrator/dashboard">Home</a></li>
        <li class="breadcrumb-item"><a href="/administrator">Administrator</a></li>
        <li class="breadcrumb-item">Users</li>
        <li class="breadcrumb-item active">${viewUser.getUsername()}</li>
    </ol>
    <div class="container-fluid mt-1 px-0 px-sm-3">
        <div id="ui-view">
            <h1>${viewUser.getUsername()}</h1>
            <div class="row">
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">Personal</div>
                        <div class="card-block">
                            <c:if test="${editSuccess != null}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                        ${editSuccess}
                                </div>
                            </c:if>
                            <c:if test="${editError != null}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                        ${editError}
                                </div>
                            </c:if>
                            <form:form class="user-page-form" action="/administrator/user/${viewUser.getRole()}/edit" method="POST" modelAttribute="viewUser">
                                <table class="table table-striped mb-0">
                                    <tbody>
                                    <tr>
                                        <td><strong>Username</strong></td>
                                        <td>${viewUser.getUsername()}</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Email Address</strong></td>
                                        <td>${viewUser.getEmail()}</td>
                                        <td>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Role</strong></td>
                                        <td>${viewUser.getRole()}</td>
                                        <td>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Status</strong></td>
                                        <td>
                                            <div class="toggleEditActivated">
                                                <c:set var="tableUser" value="${viewUser}" scope="request"/>
                                                <jsp:include page="../includes/status.jsp"/>
                                            </div>
                                            <div class="toggleEditActivated collapse">
                                                <div class="form-group">
                                                    <form:select path="status" name="status" class="form-control" id="searchStatus">
                                                        <form:option value="Unverified">Unverified</form:option>
                                                        <form:option value="Verified">Verified</form:option>
                                                        <form:option value="Authorised">Authorised</form:option>
                                                        <form:option value="Approved">Approved</form:option>
                                                    </form:select>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <c:if test='${!(user.getAccessLevel() > 0 && viewUser.getRole().equals("administrator"))}'>
                                                <button type="button" class="toggleEditActivated btn btn-success btn-sm" onclick="$('.toggleEditActivated').toggle()">Edit</button>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Activated</strong></td>
                                        <td>
                                            <div class="toggleEditActivated">
                                                <c:choose>
                                                    <c:when test="${viewUser.isActivated()}">
                                                        <span class="badge badge-pill badge-success">Yes</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-pill badge-danger">No</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="toggleEditActivated collapse">
                                                <div class="input-group d-flex justify-content-around">
                                                    <form:label path="activated" class="form-check-label">
                                                        <form:radiobutton path="activated" id="searchActivatedTrue" class="form-check-input" name="activated" value="true"/>
                                                        <i class="fa fa-check"></i>
                                                    </form:label>
                                                    <form:label path="activated" class="form-check-label">
                                                        <form:radiobutton path="activated" id="searchActivatedFalse" class="form-check-input" name="activated" value="false"/>
                                                        <i class="fa fa-ban"></i>
                                                    </form:label>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <c:if test='${!viewUser.getRole().equals("administrator")}'>
                                                <button type="button" class="toggleEditActivated btn btn-success btn-sm" onclick="$('.toggleEditActivated').toggle()">Edit</button>
                                            </c:if>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <hr class="mt-0"/>
                                <div class="toggleEditActivated collapse">
                                    <div class="d-flex justify-content-between">
                                        <button type="reset" onclick="$('.toggleEditActivated').toggle()" class="btn btn-danger">Cancel Changes</button>
                                        <button type="submit" class="btn btn-success">Submit Changes</button>
                                    </div>
                                </div>
                            </form:form>
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
            <div class="row">
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header d-flex align-items-center">${viewUser.getUsername()}'s Courses</div>
                        <div class="card-block">
                            <div class="table-loader load-cont p-4 m-4" style="display: none;">
                                <div class="loader"></div>
                            </div>
                            <div class="table-cont">
                                <c:set var="pagination" value='${viewUser.getCoursePagination()}' scope="request"/>
                                <jsp:include page="/WEB-INF/jsp/course/pagination/courses.jsp"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>