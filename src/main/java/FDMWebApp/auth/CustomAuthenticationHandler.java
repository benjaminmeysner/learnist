package FDMWebApp.auth;

import FDMWebApp.domain.User;
import FDMWebApp.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by Rusty on 07/03/2017.
 */

public class CustomAuthenticationHandler implements AuthenticationSuccessHandler {

	@Autowired
	UserRepo userRepo;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
	                                    Authentication authentication) throws ServletException, IOException {

		HttpSession session = request.getSession();
		User user = userRepo.findByUsername(authentication.getName());
		session.setAttribute("user", user);
		response.setStatus(HttpServletResponse.SC_OK);
		if (user.getRole().equals("administrator")) {
			response.sendRedirect("/administrator");
		} else {
			response.sendRedirect("/user/" + user.getUsername());
		}
	}

}
