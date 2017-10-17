<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="FDMWebApp.domain.Course"%>
<div id="adminContainer">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/administrator/dashboard">Home</a></li>
        <li class="breadcrumb-item">Administrator</li>
        <li class="breadcrumb-item active">Dashboard</li>
    </ol>
    <div class="container-fluid mt-1 p-0 px-sm-3 px-xl-1">
        <div id="ui-view">
            <div class="row">
                <div class="col-12 col-xl-3">
                    <div class="card">
                        <div class="card-header">Search Users</div>
                        <div class="card-block">
                            <form:form class="user-page-form" action="/administrator/users/search" method="POST" modelAttribute="userSearch">
                                <div class="form-group">
                                    <form:label path="username" for="searchUsername">Username</form:label>
                                    <div class="input-group">
                                        <form:input path="username" id="searchUsername" type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1"/>
                                        <span class="input-group-button p-0">
                                    <button type="submit" class="btn btn-default searchSubmit hidden-xl-up" type="button"><i class="fa fa-search"></i> Search</button>
                                    <button type="submit" class="btn btn-default searchSubmit hidden-lg-down" type="button"><i class="fa fa-search"></i></button>
                                </span>
                                    </div>
                                </div>
                                <div id="toggleSearch" class="collapse">
                                    <div class="form-group">
                                        <form:label path="role" for="searchRole">Role</form:label>
                                        <form:select path="role" name="role" class="form-control" id="searchRole">
                                            <form:option value="">Any</form:option>
                                            <form:option value="learner">Learner</form:option>
                                            <form:option value="lecturer">Lecturer</form:option>
                                        </form:select>
                                    </div>
                                    <div class="form-group">
                                        <form:label path="status" for="searchStatus">Status</form:label>
                                        <form:select path="status" multiple="true" name="status" class="form-control" id="searchStatus" selected="selected">
                                            <form:option value="Unverified">Unverified</form:option>
                                            <form:option value="Verified">Verified</form:option>
                                            <form:option value="Authorised">Authorised</form:option>
                                            <form:option value="Approved">Approved</form:option>
                                        </form:select>
                                    </div>
                                    <div class="form-group">
                                        <label>Activated</label>
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
                                </div>
                                <button type="submit" class="btn btn-default collapse searchSubmit btn-block mb-1" type="button"><i class="fa fa-search"></i> Search</button>
                                <div class="form-group d-flex mb-0">
                                    <button type="button" id="toggleSearchDiv" class="btn mx-auto"><i id="searchChevron" class="fa fa-chevron-down"></i></button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-xl-9">
                    <div class="card">
                        <div class="card-header">Search Results</div>
                        <div class="card-block p-1 p-sm-1">
                            <div id="searchLoader" class="table-loader load-cont p-4 m-4" style="display: none;">
                                <div class="loader"></div>
                            </div>
                            <div class="table-cont">
                                <c:set var="pagination" value="${userList}" scope="request"/>
                                <jsp:include page="includes/pagination/users.jsp"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12 col-xl-3">
                    <div class="card">
                        <div class="card-header">Search Courses</div>
                        <div class="card-block">
                            <form:form class="user-page-form" action="/administrator/courses/search" method="POST" modelAttribute="courseSearch">
                                <div class="form-group">
                                    <form:label path="name" for="searchName">Name</form:label>
                                    <div class="input-group">
                                        <form:input path="name" id="searchName" type="text" class="form-control" placeholder="Name" aria-describedby="basic-addon1"/>
                                        <span class="input-group-button p-0">
                                    <button type="submit" class="btn btn-default searchSubmit2 hidden-xl-up" type="button"><i class="fa fa-search"></i> Search</button>
                                    <button type="submit" class="btn btn-default searchSubmit2 hidden-lg-down" type="button"><i class="fa fa-search"></i></button>
                                </span>
                                    </div>
                                </div>
                                <div id="toggleSearch2" class="collapse">
                                    <div class="form-group">
                                        <form:label path="subject" for="searchSubject">Subject</form:label>
                                        <form:select path="subject"  class="form-control" id="searchSubject">
                                            <form:option value="">Any</form:option>
                                            <form:options items="${Course.getSubjects()}"/>
                                        </form:select>
                                    </div>
                                    <div class="form-group">
                                        <form:label path="status" for="searchStatus2">Status</form:label>
                                        <form:select path="status" multiple="true" class="form-control" id="searchStatus2" selected="selected">
                                            <form:option value="Unverified">Unverified</form:option>
                                            <form:option value="Submitted">Submitted</form:option>
                                            <form:option value="Approved">Approved</form:option>
                                        </form:select>
                                    </div>
                                    <div class="form-group">
                                        <label>Activated</label>
                                        <div class="input-group d-flex justify-content-around">

                                        </div>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-default collapse searchSubmit2 btn-block mb-1" type="button"><i class="fa fa-search"></i> Search</button>
                                <div class="form-group d-flex mb-0">
                                    <button type="button" id="toggleSearchDiv2" class="btn mx-auto"><i id="searchChevron2" class="fa fa-chevron-down"></i></button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-xl-9">
                    <div class="card">
                        <div class="card-header">Course Search Results</div>
                        <div class="card-block p-1 p-sm-1">
                            <div id="search-Loader" class="table-loader load-cont p-4 m-4" style="display: none;">
                                <div class="loader"></div>
                            </div>
                            <div class="table-cont">
                                <c:set var="pagination" value="${courseList}" scope="request"/>
                                <jsp:include page="includes/pagination/courses.jsp"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
</div>