<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="<c:url value="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />">
<nav id="nav" class="navbar navbar-toggleable-lg fixed-top p-1 p-lg-2 m-0">
    <div class="d-flex">
        <!-- add logo here -->
        <a class="navbar-brand hidden-xl-up ml-0 mx-md-4" style="height: 55px;" href="/"><img height="100%" src="/public/images/logos/logo_no_fill.png"></a>
	    <a href="#" class="notification hidden-xl-up btn btn-sm m-0 my-0 mr-3 ml-auto" data-toggle="dropdown">
						<span class="fa-stack fa-lg">
						    <i class="fa fa-bell-o fa-stack-2x"></i>
							<i class="fa fa-stack-1x">
								<p class="fa-arr read-no">
									${user.getNotifications().size()}
								</p>
							</i>
						</span>
	    </a>
		    <c:if test="${!user.getNotifications().isEmpty()}">
			    <ul class="dropdown-menu notification-menu dropdown-menu-right" role="menu">
				    <li><span class="dropdown-item pull-left">Notifications</span></li>
				    <hr>
				    <form:form id="notificationForm" action="/user/${user.getUsername()}/notification" method="POST">
					    <c:forEach items="${user.getNotifications()}" var="notification">
						    <li class="d-flex">
							    <button type="button" name="id" data-val="${notification.getId()}" class="btn p-1 fa fa-check-circle-o read-notification mx-2" aria-hidden="true"></button>
							    <a href="${notification.getUrl()}" data-val="${notification.getId()}" class="dropdown-item read-notification d-flex align-items-center pl-0">
								    <span class="badge">${notification.getLocalDate()}</span>${notification.getMessage()}</a>
						    </li>
					    </c:forEach>
				    </form:form>
			    </ul>
		    </c:if>
        <button type="button" id="menuButton" class="navbar-toggler my-auto mr-2" data-toggle="collapse" data-target="#navToggle"><i
                class="material-icons">menu</i></button>
    </div>
    <!-- -->
    <div class="collapse navbar-collapse justify-content-between" id="navToggle">
        <hr class="mb-0 hidden-xl-up" style="background-color: white;">
        <div class="d-flex align-content-center">
            <a class="navbar-brand hidden-lg-down mb-2" style="height: 55px;" href="/"><img height="100%" src="/public/images/logos/logo_no_fill.png"></a>
        </div>
        <c:if test="${sessionScope.user != null}">
            <c:choose>
                <c:when test="${isLesson != null}">
                    <div id="lessonTitle" class="scroller">
                       <a id="titleText" href="/course/${viewLesson.getCourse().getCode()}" class="display-4 m-0">${viewLesson.getName()}</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <form:form id="autoSearch" method="POST" action="/course" class="nav-content form-inline my-2 my-lg-0 p-3 p-md-0">
                        <div id="navSearch" class="list-group">
                            <div id="mainSearchCont" class="input-group scroll mx-auto">
                                <input id="mainSearch" class="form-control" type="search"
									   placeholder="Search Courses..." autocomplete="off">
                                <div class="input-group-addon">
                                    <button type="submit" class="btn my-2 my-sm-0 p-0 d-flex"><i class="material-icons">search</i> </button>
                                    <c:if test="${searchCourse.getName() != null}">
                                        <script>document.getElementById('mainSearch').value = "${searchCourse.getName()}"</script>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </form:form>
                </c:otherwise>
            </c:choose>
        </c:if>
        <ul class="navbar-nav nav-content">
            <c:choose>
                <c:when test="${sessionScope.user != null}">
                    <c:choose>
                        <c:when test='${!sessionScope.user.getRole().equals("administrator")}'>
                            <li class="ml-auto">
                                <a href="/${sessionScope.user.getRole()}" class="page-scroll btn btn-sm animated-button gibson-four">Account</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="ml-auto">
                                <a href="/${sessionScope.user.getRole()}" class="page-scroll btn btn-sm animated-button gibson-four">Dashboard</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                    <c:if test='${sessionScope.user.getRole().equals("lecturer")}'>
                   		<li class="ml-auto">
	                    	<a href="/user/${sessionScope.user.getUsername()}" class="page-scroll btn btn-sm animated-button gibson-four">Profile</a>
	                 	</li>
	                </c:if>
	                <c:if test='${sessionScope.user.getRole().equals("learner")}'>
		                <li class="ml-auto">
			                <a href="/user/${sessionScope.user.getUsername()}/courses" class="page-scroll btn btn-sm animated-button gibson-four">My Courses</a>
		                </li>
	                </c:if>
                    <li class="ml-auto">
                        <form:form id="logoutForm" action="/logout" method="post">
                            <a href="#" onclick="document.getElementById('logoutForm').submit();"
                               class="page-scroll btn btn-sm animated-button gibson-four">Logout</a>
                        </form:form>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="ml-auto">
                        <a class="page-scroll btn btn-sm animated-button gibson-four" href="#registerModal" data-toggle="modal">Register</a>
                    </li>
                    <li class="ml-auto">
                        <a class="page-scroll btn btn-sm animated-button gibson-four" href="#loginModal" data-toggle="modal">Login</a>
                    </li>
                </c:otherwise>
            </c:choose>
			<li class="ml-auto">
				<a class="btn btn-sm m-0 p-0 notification hidden-xl-down" href="/support"><i class="fa fa-question-circle-o fa-stack fa-lg" style="font-size: xx-large" aria-hidden="true"></i></a>
				<a class="page-scroll btn btn-sm animated-button gibson-four" href="/support">Support</a>
			</li>
	        <c:if test="${sessionScope.user != null}">
		        <li class="dropdown ml-auto">
			        <a href="#" class="notification btn btn-sm m-0" data-toggle="dropdown">
						<span class="fa-stack fa-lg">
						    <i class="fa fa-bell-o fa-stack-2x"></i>
							<i class="fa fa-stack-1x">
								<p class="fa-arr read-no">
										${user.getNotifications().size()}
								</p>
							</i>
						</span>
			        </a>
			        <c:if test="${!user.getNotifications().isEmpty()}">
				        <ul class="dropdown-menu notification-menu dropdown-menu-right" role="menu">
					        <li><span class="dropdown-item pull-left">Notifications</span></li>
					        <hr />
					        <form:form id="notificationForm" action="/user/${user.getUsername()}/notification" method="POST">
						        <c:forEach items="${user.getNotifications()}" var="notification">
							        <li>
								        <button type="button" name="id" data-val="${notification.getId()}" class="btn p-1 fa fa-check-circle-o read-notification mx-2" aria-hidden="true"></button>
								        <a href="${notification.getUrl()}" data-val="${notification.getId()}" class="dropdown-item read-notification d-flex align-items-center pl-0">
									        <span class="badge">${notification.getLocalDate()}</span>${notification.getMessage()}</a>
							        </li>
						        </c:forEach>
					        </form:form>
				        </ul>
			        </c:if>
		        </li>
	        </c:if>
        </ul>
    </div>
    <!-- /.navbar-collapse -->
    <!-- /.container-fluid -->
</nav>