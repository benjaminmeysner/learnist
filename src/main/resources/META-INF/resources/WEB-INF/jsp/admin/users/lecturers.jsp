<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="adminContainer">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/administrator/dashboard">Home</a></li>
        <li class="breadcrumb-item"><a href="/administrator">Administrator</a></li>
        <li class="breadcrumb-item">Users</li>
        <li class="breadcrumb-item active">Lecturers</li>
    </ol>
    <div class="container-fluid mt-1 px-1 px-sm-3">
        <div id="ui-view">
            <div class="row">
                <div class="applicationToggle col-lg-6">
                    <div class="card">
                        <div class="card-header">Applications</div>
                        <div class="card-block p-1 p-sm-1">
                            <div class="table-loader load-cont p-4 m-4" style="display: none">
                                <div class="loader"></div>
                            </div>
                            <div class="table-cont">
                                <c:if test="${applicationError != null}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                            ${applicationError}
                                    </div>
                                </c:if>
                                <c:if test="${applicationSuccess != null}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                            ${applicationSuccess}
                                    </div>
                                </c:if>
                                <c:set var="pagination" value="${adminLecturerDAO.getApplication()}" scope="request"/>
                                <jsp:include page="../includes/pagination/lecturers/applications.jsp"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="applicationToggle col-lg-12 collapse">
                    <div class="card">
                        <div class="card-header">Applications</div>
                        <div id="applicationContainer" class="card-block p-1" >
                            <iframe id="applicationFrame" width="100%" height="90%" allowfullscreen webkitallowfullscreen></iframe>
                            <div>
                                <form:form action="/administrator/users/lecturers/application" method="post" class="d-flex">
                                    <button onclick="viewPdf('')" type="reset" class="btn btn-warning">Cancel</button>
                                    <div class="ml-auto">
                                        <input id="applUser" type="hidden" name="username" value=""/>
                                        <button type="submit" name="approve" value="false" class="btn btn-danger mr-sm-1 approval">
                                            <i class ="pr-1 fa fa-ban"></i>Deny
                                        </button>
                                        <button type="submit" name="approve" value="true" class="btn btn-success approval">
                                            <i class ="pr-1 fa fa-check"></i>Approve
                                        </button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">Inactive</div>
                        <div class="card-block p-1 p-sm-1">
                            <div class="table-loader load-cont p-4 m-4" style="display: none;">
                                <div class="loader"></div>
                            </div>
                            <div class="table-cont">
                                <c:set var="pagination" value="${adminLecturerDAO.getInactives()}" scope="request"/>
                                <jsp:include page="../includes/pagination/lecturers/inactives.jsp"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">Active</div>
                        <div class="card-block p-0 p-sm-1">
                            <div class="table-loader load-cont p-4 m-4" style="display: none;">
                                <div class="loader"></div>
                            </div>
                            <div class="table-cont">
                                <c:set var="pagination" value="${adminLecturerDAO.getActives()}" scope="request"/>
                                <jsp:include page="../includes/pagination/lecturers/actives.jsp"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>