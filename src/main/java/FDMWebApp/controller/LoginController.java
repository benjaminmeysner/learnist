/**
 * Created by Rusty on 16/02/2017.
 */
package FDMWebApp.controller;

import FDMWebApp.aws.MailHandler;
import FDMWebApp.domain.Status;
import FDMWebApp.domain.User;
import FDMWebApp.domain.VerificationToken;
import FDMWebApp.repository.CourseRepo;
import FDMWebApp.repository.UserRepo;
import FDMWebApp.repository.VerificationTokenRepo;
import googleAuthenticatorHandler.GoogleAuthHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
@RequestMapping("/login")
public class LoginController {
	@Autowired
	UserRepo userRepo;

	@Autowired
	VerificationTokenRepo verificationTokenRepo;

	@Autowired
	private CourseRepo courseRepo;

	@RequestMapping("")
	public String login(HttpSession session, Authentication authentication, Model model) {
		if(authentication == null){
			model.addAttribute("login", true);
			String error = (String) session.getAttribute("error");
			session.removeAttribute("error");
			if (error != null) {
				model.addAttribute("error", error);
				model.addAttribute("username", session.getAttribute("token-username"));
				session.removeAttribute("token-username");
				return "includes/login/pass";
			}
			model.addAttribute("topCourses", courseRepo.findTop3ByStatusOrderByRatingDesc(Status.Approved));
			model.addAttribute("popularCourses", courseRepo.getPopularCourses(Status.Approved.toString()));
			return "index";
		}
		return "redirect:/user/"+authentication.getName();
	}

	@RequestMapping("/close")
	public String loginClose() {
		return "includes/login/login";
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public String loginRequest(@RequestParam("username") String username, @RequestParam("password") String password,
	                           HttpServletRequest request, Model model) {
		String error = null;
		User user = userRepo.findByUsernameOrEmail(username);
		if (username.equals("")) {
			error = "Please enter a username or email address.";
		} else {
			if ((user == null) || (!BCrypt.checkpw(password, user.getPassword()))) {
				error = "That combination didn't work, please try again!";
			} else {
				if (user.getStatus() == Status.Unverified) {
					error = "Account not verified";
					request.getSession().setAttribute("token-user", user);
					model.addAttribute("notVerified", true);
				} else if (user.getStatus() == Status.Verified) {
					error = "Account has not been authenticated yet.";
					model.addAttribute("notAuthorised", true);
					request.getSession().setAttribute("auth", user);

				} else if (user.getStatus() == Status.Authorised || user.getStatus() == Status.Approved) {
					if (user.getStatus() == Status.Authorised && user.getRole().equals("lecturer")) {
						error = "Your application has not been approved, please await confirmation before attempting to log in.";
						request.getSession().setAttribute("lecturer", user);
						model.addAttribute("notApproved", true);
					} else {
						if (!user.isActivated()) {
							error = "Account deactivated!";
							model.addAttribute("notActivated", true);
						} else {
							// model.addAttribute("pass", true);
							model.addAttribute("username", user.getUsername());
							return "includes/login/pass";
						}
					}
				}
			}
		}
		model.addAttribute("error", error);

		return "includes/login/login";
	}

	@RequestMapping("/forgot-password")
	public String forgotPassword() {
		return "includes/login/forgot";

	}

	@RequestMapping(value = "/forgot-password", method = RequestMethod.POST)
	public String forgotPasswordEmail(@RequestParam("email") String email, @RequestParam("key") String key,
	                                  HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = userRepo.findByEmail(email);
		if (user != null) {
			if (key.equals(GoogleAuthHandler.getTOTPCode(user.getSecretKey()))) {
				if (user.getStatus() != Status.Unverified) {
					VerificationToken verificationToken = new VerificationToken(user);
					user.setVerificationToken(verificationToken);
					userRepo.save(user);
					MailHandler mail = new MailHandler("no-reply@learnist.cf", user, MailHandler.RESETPASS,
							request.getRequestURL().toString());
					try {
						mail.sendMail();
						model.addAttribute("title", "Request Sent");
						model.addAttribute("text",
								"An email has been sent, please follow the instructions there to reset you password.");
					} catch (Exception e) {
						e.printStackTrace();
					}
					return "includes/login/request";
				} else {
					model.addAttribute("error", "Account not verified");
					request.getSession().setAttribute("token-user", user);
					model.addAttribute("notVerified", true);
				}

			} else {
				model.addAttribute("error", "Invalid key");
			}
		} else {
			model.addAttribute("error", "Invalid email address");
		}
		return "includes/login/forgot";
	}

	@RequestMapping(value = "/reset-password", method = RequestMethod.GET)
	public String resetPass(@RequestParam("token") String token, Model model, HttpSession session) {
		VerificationToken verificationToken = verificationTokenRepo.findByToken(token);
		if (verificationToken == null || !verificationToken.getExpiryDate().after(new Date())) {
			model.addAttribute("title", "Invalid Token");
			model.addAttribute("text", "The reset password link has expired or doesn't exist");
			return "register/success";
		}
		User user = verificationToken.getUser();
		user.setPassword("");
		session.setAttribute("reset", user);
		return "login/reset";
	}

	@RequestMapping(value = "/new-password", method = RequestMethod.POST)
	public String resetPassword(@RequestParam("password") String password, @RequestParam("confirm") String confirm,
	                            HttpSession session, Model model) {
		User user = (User) session.getAttribute("reset");
		if (user == null) {
			return "redirect:/";
		}
		if (password.length() >= 6) {
			if (password.equals(confirm)) {
				user.setPassword(BCrypt.hashpw(confirm, BCrypt.gensalt()));
				userRepo.save(user);
				session.removeAttribute("reset");
				model.addAttribute("title", "Password Reset");
				model.addAttribute("text", "Password has successfully been reset");
				return "register/success";
			}
		}
		return "login/reset";
	}

}
