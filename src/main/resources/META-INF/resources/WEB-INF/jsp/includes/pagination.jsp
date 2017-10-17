<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<form:form class="pagination-form" action="${pagination.getUrl()}" method="POST">
    <ul class="pagination justify-content-center">
        <li class="page-item">
            <button class="paginate-btn page-link" name="pageNumber" value="0" class="page-link">First</button>
        </li>
        <c:if test="${pagination.getPage().hasPrevious()}">
            <li class="page-item">
                <button class="paginate-btn page-link" name="pageNumber" value="${pagination.getPage().getNumber()-1}" class="page-link">${pagination.getPage().getNumber()}</button>
            </li>
        </c:if>
        <li class="page-item active">
            <button class="page-link" disabled>${pagination.getPage().getNumber() + 1}</button>
        </li>
        <c:if test="${pagination.getPage().hasNext()}">
            <li class="page-item">
                <button class="paginate-btn page-link" name="pageNumber" value="${pagination.getPage().getNumber()+1}" class="page-link">${pagination.getPage().getNumber() + 2}</button>
            </li>
        </c:if>
        <li class="page-item">
            <button class="paginate-btn page-link" name="pageNumber" value="-1" class="page-link">Last</button>
        </li>
    </ul>
</form:form>