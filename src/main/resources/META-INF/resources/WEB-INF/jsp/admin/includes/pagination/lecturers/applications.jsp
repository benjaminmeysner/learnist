<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="pagination-table">
    <c:choose>
        <c:when test="${pagination.getPage().hasContent()}">
            <table class="table table-hover table-bordered">
                <thead>
                <tr>
                    <th class="hidden-sm-down">Name</th>
                    <th>Username</th>
                    <th>Date</th>
                    <th>Application</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pagination.getPage().getContent()}" var="tableUser">
                    <tr>
                        <td class="hidden-sm-down"><strong>${tableUser.getFirstName().toString()} ${tableUser.getSurname()}</strong></td>
                        <td><a class="user-page-link" href='/administrator/user/${tableUser.getUsername()}'>${tableUser.getUsername()}</a></td>
                        <td>${tableUser.getApplicationDate()}</td>
                        <td class="d-flex b-a-0"><button id='viewApp1' type="button" onclick="viewPdf($(this).data('name'))" data-name='${tableUser.getUsername()}' class="mx-auto btn btn-sm btn-primary">View</button></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <hr class="mt-0"/>
            <jsp:include page="/WEB-INF/jsp/includes/pagination.jsp"/>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">
                No pending applications.
            </div>
        </c:otherwise>
    </c:choose>
</div>