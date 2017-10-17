<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta property="og:url"                content="http://learnist.cf" />
    <meta property="og:title"              content="${viewCourse.getName()}" />
    <meta property="og:description"        content="${viewCourse.getDescription()}" />
    <meta property="og:image"              content="${viewCourse.getImage().getUrl()}" />
    <c:set var="title" scope="application" value="${viewCourse.getName()}"/>
    <jsp:include page="../includes/head.jsp"/>
    <link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
</head>
<body>
<!-- Navigation -->
<jsp:include page="../includes/nav.jsp"/>
<div id="main">
    <div class="container container-fluid pt-4 px-0 px-3">
        <c:if test="${courseSuccess != null}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <c:choose>
                    <c:when test='${courseSuccess.equals("Course Submitted.")}'>
                        <strong>${courseSuccess}</strong> You will receive an email once your application has been processed.
                    </c:when>
                    <c:otherwise>${courseSuccess}</c:otherwise>
                </c:choose>
            </div>
        </c:if>
        <c:if test="${courseError != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                    ${courseError}
            </div>
        </c:if>
        <div class="d-flex align-items-center mx-2" id="courseHeader">
            <h1 class="display-4 my-0 mx-1">${viewCourse.getName()}</h1>
            <div class="btn-group">
                <c:choose>
                    <c:when test='${!user.getCourses().contains(viewCourse)}'>
                        <button data-toggle="modal" data-target="#submitModal" class="btn btn-success ml-auto hidden-sm-down">Join Course</button>
                        <button data-toggle="modal" data-target="#submitModal" class="btn btn-success ml-auto hidden-md-up btn-sm">Join Course</button>
                        <div class="modal fade" id="submitModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
                            <div class="modal-dialog modal-sm" role="document">
                                <div class="modal-content">
                                    <div class="modal-body">
                                        Are you sure you want to enroll on the course?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                        <form:form method="POST" action="/course/${viewCourse.getCode()}/enroll">									        <button type="submit" class="btn btn-primary">Yes</button>
                                        </form:form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${!viewCourse.reviewedBy(user)}">
                            <button data-toggle="modal" data-target="#reviewModal" class="btn btn-success ml-2 hidden-sm-down">Leave Review</button>
                            <button data-toggle="modal" data-target="#reviewModal" class="btn btn-success ml-2 hidden-md-up btn-sm">Leave Review</button>

                            <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <form:form method="POST" action="/course/${viewCourse.getCode()}/review" modelAttribute="newReview" validator="validator">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title" style="font-weight: 300;">Leave Review</h1>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label>Rate this course:</label>
                                                    <div class="d-flex justify-content-center">
                                                        <div class="stars">
                                                            <form:radiobutton path="rating" class="star star-5" id="star-5" value="5" name="star"/>
                                                            <form:label path="rating" class="star star-5" for="star-5"></form:label>
                                                            <form:radiobutton path="rating" class="star star-4" id="star-4" value="4" name="star"/>
                                                            <form:label path="rating" class="star star-4" for="star-4"></form:label>
                                                            <form:radiobutton path="rating" class="star star-3" id="star-3" value="3" name="star"/>
                                                            <form:label path="rating" class="star star-3" for="star-3"></form:label>
                                                            <form:radiobutton path="rating" class="star star-2" id="star-2" value="2" name="star"/>
                                                            <form:label path="rating" class="star star-2" for="star-2"></form:label>
                                                            <form:radiobutton path="rating" class="star star-1" id="star-1" value="1" name="star"/>
                                                            <form:label path="rating" class="star star-1" for="star-1"></form:label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <form:label path="review">Leave a Review</form:label>
                                                    <form:textarea path="review" class="form-control" style="height: 150px;" maxlength="255"/>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                                <button type="submit" class="btn btn-primary">Yes</button>
                                            </div>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${!viewCourse.getReviews().isEmpty()}">
                            <button data-toggle="modal" data-target="#reviewsModal" class="btn btn-warning ml-2 hidden-sm-down">View Reviews</button>
                            <button data-toggle="modal" data-target="#reviewsModal" class="btn btn-warning ml-2 hidden-md-up btn-sm">View Reviews</button>
                            <div class="modal fade" id="reviewsModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
                                <div class="modal-dialog modal-lg" role="document">
                                    <form:form method="POST" action="/course/${viewCourse.getCode()}/review" modelAttribute="newReview">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title" style="font-weight: 300;">View Reviews</h1>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <c:forEach items="${viewCourse.getReviews()}" var="review">
                                                    <div class="card">
                                                        <div class="card-header d-flex align-items-center justify-content-between">
                                                            <h4>${review.getLearner().getUsername()}</h4>
                                                            <span class="star-rating p-1">
                                                                <c:forEach var="i" begin="0" end="4">
                                                                    <c:choose>
                                                                        <c:when test="${viewCourse.getRating() - i  >= 0.5}">
                                                                            <c:choose>
                                                                                <c:when test="${0.5 <= viewCourse.getRating() - i && viewCourse.getRating() - i < 1}">
                                                                                    <i class="material-icons hidden-sm-down">star_half</i>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <i class="material-icons hidden-sm-down">star</i>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <i class="material-icons hidden-sm-down">star_border</i>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:forEach>
                                                            </span>
                                                        </div>
                                                        <div class="card-block">
                                                            <p>${review.getReview()}</p>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </c:if>
                            <div class="fb-share-button" data-href="https://developers.facebook.com/docs/plugins/" data-layout="button" data-size="small" data-mobile-iframe="true"><a class="fb-xfbml-parse-ignore btn btn-primary ml-2 d-flex align-items-center" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Flearnist.cf%2Fcourse%2F%0A${course.getCode()}&amp;src=sdkpreparse"><img height="20px" class="mr-1" src="https://upload.wikimedia.org/wikipedia/commons/c/c2/F_icon.svg">Share</a></div>
                        <button data-toggle="modal" data-target="#deleteModal" class="btn btn-danger ml-2 hidden-sm-down">Leave Course</button>
                        <button data-toggle="modal" data-target="#deleteModal" class="btn btn-danger ml-2 hidden-md-up btn-sm">Leave Course</button>
                        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
                            <div class="modal-dialog modal-sm" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Are you sure you want to leave the course?</h5>
                                    </div>
                                    <div class="modal-body">
                                        You will lose access to all the lessons on this course if you do.
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                        <form:form method="POST" action="/course/${viewCourse.getCode()}/leave">									<button type="submit" class="btn btn-primary">Yes</button>

                                        </form:form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <hr>
        <div class="row mx-2 mx-lg-0">
            <div class="col-lg-4 mb-2 mb-lg-0 d-flex align-items-center justify-content-center">
                <img src='${viewCourse.getImage().getUrl()}' class="img-fluid img-thumbnail" alt=""/>
            </div>
            <div class="col-lg-8 p-0 d-flex align-items-center">
                <div class="hidden-sm-down" style="width: 100%;">
                    <table class="table table-striped table-responsive mb-0">
                        <tbody style="width: 100%; display: inline-table;">
                            <tr class="toggle-desc">
                                <td><strong>Description</strong></td>
                                <td>${viewCourse.getDescription()}</td>
                            </tr>
                            <tr>
                                <td><strong>Subject</strong></td>
                                <td>${viewCourse.getSubject()}</td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="course-attrs" style="background-color: rgba(0,0,0,.05);">
                        <div class="d-inline-flex align-items-center"><strong>Rating: </strong>
                            <span class="star-rating p-1">
                            <c:forEach var="i" begin="0" end="4">
                                <c:choose>
                                    <c:when test="${viewCourse.getRating() - i  >= 0.5}">
                                        <c:choose>
                                            <c:when test="${0.5 <= viewCourse.getRating() - i && viewCourse.getRating() - i < 1}">
                                                <i class="material-icons hidden-sm-down">star_half</i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="material-icons hidden-sm-down">star</i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="material-icons hidden-sm-down">star_border</i>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            </span>
                        </div>
                        <div>
                            <strong>Current Lesson:</strong>${viewCourse.getCurrentLesson()}
                        </div>
                        <div>
                            <strong>Lecturer:</strong><a href="/user/${viewCourse.getLecturer().getUsername()}">${viewCourse.getLecturer().getFirstName()} ${viewCourse.getLecturer().getSurname()}</a>
                        </div>
                    </div>
                </div>
                <div id="course-attrs-sm" class="hidden-md-up">
                    <div class="cat">
                        <div class="d-flex">
                            <h4>Description</h4>
                        </div>
                        <p class="toggle-desc">${viewCourse.getDescription()}</p>
                    </div>
                    <div class="cat">
                        <h4>Subject</h4>
                        <p class="mb-0">${viewCourse.getSubject()}</p>
                    </div>
                    <div class="cat course-attrs">
                        <div class="d-flex align-items-center"><strong>Rating:</strong><span class="star-rating p-1">
                            <c:forEach var="i" begin="0" end="4">
                                <c:choose>
                                    <c:when test="${viewCourse.getRating() - i  >= 0.5}">
                                        <c:choose>
                                            <c:when test="${0.5 <= viewCourse.getRating() - i && viewCourse.getRating() - i < 1}">
                                                <i class="material-icons">star_half</i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="material-icons">star</i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="material-icons">star_border</i>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            </span></div>
                        <div>
                            <strong>Current Lesson:</strong>
                            <c:choose>
                                <c:when test="${viewCourse.getCurrentLesson() != null}">${viewCourse.getCurrentLesson()}</c:when>
                                <c:otherwise>Course hasn't started</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="tagsModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalL" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <form:form id="tagsForm" method="POST" action="/lecturer/course/${viewCourse.getCode()}/tags" modelAttribute="viewCourse">
                                <div class="modal-header">
                                    <h5 class="modal-title">Edit Tags</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form:label path="tags" class="control-label mb-0">Tags</form:label>
                                    <small class="form-text text-muted">Maximum of 5 tags.</small>
                                    <form:select path="tags" multiple="true" class="form-control">
                                        <form:options items="${allTags}" itemLabel="name" itemValue="id"/>
                                    </form:select>
                                </div>
                                <div class="modal-footer">
                                    <button type="reset" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Save changes</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-12">
                <h2 class="display-4 ml-0 ml-md-3" style="font-size: 2.5rem">Lessons</h2>
                <hr>
                <div id="lessonsCard" class="card course-list">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span class="ml-auto">Total Lessons: ${viewCourse.getLessons().size()}</span>
                    </div>
                    <div class="card-block">
                        <div class="table-loader load-cont p-4 m-4" style="display: none;">
                            <div class="loader"></div>
                        </div>
                        <div class="table-cont">
                            <c:set var="currentLesson" value="${viewCourse.getCurrentLesson()}" scope="request"/>
                            <c:set var="pagination" value="${viewCourse.getLessonPagination()}" scope="request"/>
                            <jsp:include page="/WEB-INF/jsp/course/pagination/lessons.jsp"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../includes/scripts.jsp"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"
        integrity="sha384-mE6eXfrb8jxl0rzJDBRanYqgBxtJ6Unn4/1F7q4xRRyIw7Vdg9jP4ycT7x1iVsgb"
        crossorigin="anonymous"></script>
<script src="<c:url value="/public/js/basic.js" />"></script>
</body>
</html>