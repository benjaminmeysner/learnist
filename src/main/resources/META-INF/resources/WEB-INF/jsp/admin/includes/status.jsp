<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test='${tableUser.getStatus() == "Approved"}'>
        <span class="badge badge-success">Approved</span>
    </c:when>
    <c:when test='${tableUser.getStatus() == "Authorised"}'>
        <span class="badge badge-primary">Authorised</span>
    </c:when>
    <c:when test='${tableUser.getStatus() == "Verified"}'>
        <span class="badge badge-warning">Authorised</span>
    </c:when>
    <c:when test='${tableUser.getStatus() == "Submitted"}'>
        <span class="badge badge-warning">Submitted</span>
    </c:when>
    <c:otherwise>
        <span class="badge badge-danger">Unverified</span>
    </c:otherwise>
</c:choose>