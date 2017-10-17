package FDMWebApp.controller;

import FDMWebApp.domain.Address;
import FDMWebApp.domain.Learner;
import FDMWebApp.repository.LearnerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * Created by Dani on 02/03/2017.
 */
@Controller
@RequestMapping("/learner")
public class LearnerController {

	@Autowired
	private LearnerRepo learnerRepo;

	@RequestMapping("")
	public String index(Authentication authentication, HttpSession session, Model model) {
		Learner viewUser = learnerRepo.findByUsername(authentication.getName());
		session.setAttribute("user",viewUser);
		if ((viewUser.getAddress() == null)) {
			viewUser.setAddress(new Address());
		}
		model.addAttribute("viewUser", viewUser);
		return "learner/home";
	}

}
