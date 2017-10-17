<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <c:set var="title" scope="application" value="Learnist"/>
    <jsp:include page="includes/head.jsp"/>
    <link rel="stylesheet" href="<c:url value="/public/css/index.css" />">
</head>
<body>
<!-- Navigation -->
<jsp:include page="includes/nav.jsp"/>
<main>
    <div class="container-fluid">
        <div class="intro-text">

            <h3 id="greetingMessage" class="display-3">Start your journey here with us....</h3>
            <div class="intro-heading">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#loginModal">
                    Login
                </button>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#registerModal">
                    Join
                </button>
            </div>
        </div>
    </div>
	<a name="courses">
    <div id="courses">
        <div class="container py-3">
            <h1 class="display-4">A selection of our courses:</h1>
            <h3>View our top courses</h3>
            <div class="row">
                <c:if test="${topCourses.size() == 0}">
                    <div class="col-md-6 col-lg-4 pb-4 mx-auto">
                        <div class="card">
                            <img src="../public/images/course.png" class="card-img-top" alt="">
                            <div class="card-block">
                                <h4 class="card-title">Course Name</h4>
                                <p class="card-text">Course Description</p>
                                <div class="moreButton">
                                    <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#">More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4 pb-4 mx-auto">
                        <div class="card">
                            <img src="../public/images/course.png" class="card-img-top" alt="">
                            <div class="card-block">
                                <h4 class="card-title">Course Name</h4>
                                <p class="card-text">Course Description</p>
                                <div class="moreButton">
                                    <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#">More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4 pb-4 mx-auto">
                        <div class="card">
                            <img src="../public/images/course.png" class="card-img-top" alt="">
                            <div class="card-block">
                                <h4 class="card-title">Course Name</h4>
                                <p class="card-text">Course Description</p>
                                <div class="moreButton">
                                    <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#">More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:forEach var="course" items="${topCourses}">
                    <div class="col-md-6 col-lg-4 pb-4 mx-auto">
                        <div class="card">
                            <img width="100%" height="auto" src='${course.getImage().getUrl()}' class="card-img-top" alt="">
                            <div class="card-block">
                                <h4 class="card-title">${course.getName()}</h4>
                                <p class="card-text">${course.getDescription()}</p>
                                <div class="moreButton">
                                    <a href="/course/${course.getCode()}" class="btn btn-primary" data-toggle="modal" data-target="#">More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <h3>View our most popular courses</h3>
            <div class="row">
                <c:if test="${popularCourses.size() == 0 }">
                    <div class="col-md-6 col-lg-4 pb-4 mx-auto">
                        <div class="card">
                            <img src="../public/images/course.png" class="card-img-top" alt="">
                            <div class="card-block">
                                <h4 class="card-title">Course Name</h4>
                                <p class="card-text">Course Description</p>
                                <div class="moreButton">
                                    <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#">More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4 pb-4 mx-auto">
                        <div class="card">
                            <img src="../public/images/course.png" class="card-img-top" alt="">
                            <div class="card-block">
                                <h4 class="card-title">Course Name</h4>
                                <p class="card-text">Course Description</p>
                                <div class="moreButton">
                                    <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#">More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4 pb-4 mx-auto">
                        <div class="card">
                            <img src="../public/images/course.png" class="card-img-top" alt="">
                            <div class="card-block">
                                <h4 class="card-title">Course Name</h4>
                                <p class="card-text">Course Description</p>
                                <div class="moreButton">
                                    <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#">More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:forEach var="course" items="${popularCourses}">
                    <div class="col-md-6 col-lg-4 pb-4 mx-auto">
                        <div class="card">
                            <img width="100%" height="auto" src='${course.getImage().getUrl()}' class="card-img-top" alt="">
                            <div class="card-block">
                                <h4 class="card-title">${course.getName()}</h4>
                                <p class="card-text">${course.getDescription()}</p>
                                <div class="moreButton">
                                    <a href="/course/${course.getCode()}" class="btn btn-primary" data-toggle="modal" data-target="#">More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    </a>
    <div id="sources">
        <div class="container my-4 pt-2">
            <h1 class="display-4 m-2">Powered by</h1>
            <div class="row">
                <div class="col-12 col-sm-6 col-md-4 my-3 source">
                    <div>
                        <img class="mb-2"
                             src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/AmazonWebservices_Logo.svg/2000px-AmazonWebservices_Logo.svg.png">
                        <p>Amazon Web Services</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 my-3 source">
                    <div>
                        <img src="https://spring.io/img/spring-by-pivotal.png">
                        <p>Spring</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 my-3 source">
                    <div>
                        <img src="https://stripe.com/img/about/logos/logos/blue.png">
                        <p>Stripe</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 my-3 source">
                    <div style="width: 60%;">
                        <img src="http://getbootstrap.com/assets/brand/bootstrap-solid.svg">
                        <p>Bootstrap</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 my-3 source">
                    <div>
                        <img src="https://upload.wikimedia.org/wikipedia/en/a/ab/Updated_logo_for_Gradle.png">
                        <p>Gradle</p>
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-md-4 my-3 source">
                    <div style="width: 60%;">
                        <img src="https://lh3.googleusercontent.com/HPc5gptPzRw3wFhJE1ZCnTqlvEvuVFBAsV9etfouOhdRbkp-zNtYTzKUmUVPERSZ_lAL=w300">
                        <p>Google Authenticator</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/loginModal.jsp"/>
<jsp:include page="includes/registerModal.jsp"/>
<jsp:include page="includes/scripts.jsp"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"
        integrity="sha384-mE6eXfrb8jxl0rzJDBRanYqgBxtJ6Unn4/1F7q4xRRyIw7Vdg9jP4ycT7x1iVsgb"
        crossorigin="anonymous"></script>
<script src="<c:url value="/public/js/index.js" />"></script>
<script src="<c:url value="/public/js/login.js" />"></script>
<c:if test="${login}">
    <script type="text/javascript">
        toggleLogin();
    </script>
</c:if>
</body>
</html>