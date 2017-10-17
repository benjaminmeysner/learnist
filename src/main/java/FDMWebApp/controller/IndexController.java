/**
 * Created by Rusty on 16/02/2017.
 */
package FDMWebApp.controller;


import FDMWebApp.domain.Status;
import FDMWebApp.domain.User;
import FDMWebApp.repository.CourseRepo;
import FDMWebApp.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/")
public class IndexController {

	@Autowired
	private CourseRepo courseRepo;

	@Autowired
	private UserRepo userRepo;


	@RequestMapping("")
	public String index(Authentication authentication, Model model) {
		if (authentication == null) {
			model.addAttribute("courseCount", courseRepo.count());
			model.addAttribute("topCourses", courseRepo.findTop3ByStatusOrderByRatingDesc(Status.Approved));
			model.addAttribute("popularCourses", courseRepo.getPopularCourses(Status.Approved.toString()));
			return "index";
		} else {
			User user = userRepo.findByUsername(authentication.getName());
			if (user.getRole().equals("administrator")) {
				return "redirect:/administrator";
			} else {
				return "redirect:/user/" + user.getUsername();
			}
		}
	}

	@RequestMapping("404")
	public String error(HttpServletRequest request, HttpServletResponse response, Model model) {
		int code;
		if (request.getAttribute("javax.servlet.error.status_code") == null) {
			code = 404;
			response.setStatus(code);
		} else {
			code = (Integer) request.getAttribute("javax.servlet.error.status_code");
		}
		String message = HttpStatus.valueOf(code).getReasonPhrase();
		model.addAttribute("message", code + ": " + message);
		return "error/error";
	}

}
