<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModal" aria-hidden="true" style="padding-right: 0;">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<img src="/public/images/logos/logo_no_fill.png">
				<button type="button" class="close close-login" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="loginLoader"class="p-4 m-4" style="display: none;">
				<div class="loader"></div>
			</div>
			<div id="login" class="modal-body">

				<jsp:include page="login/login.jsp"/>

			</div>
		</div>
	</div>
</div>