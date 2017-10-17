package FDMWebApp.controller;

import FDMWebApp.domain.Address;
import FDMWebApp.domain.Administrator;
import FDMWebApp.domain.Learner;
import FDMWebApp.domain.Lecturer;
import FDMWebApp.domain.Notification;
import FDMWebApp.domain.Status;
import FDMWebApp.domain.User;
import FDMWebApp.repository.*;
import FDMWebApp.transfer.pagination.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by erustus on 17/04/17.
 * Used for public profile and searches etc
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserRepo userRepo;
	@Autowired
	LearnerRepo learnerRepo;
	@Autowired
	AddressRepo addressRepo;
	@Autowired
	TagRepo tagRepo;
	@Autowired
	CourseRepo courseRepo;
	@Autowired
	NotificationRepo notificationRepo;
	@Autowired
	SupportTicketRepo supportTicketRepo;
	@Autowired
	LecturerRepo lecturerRepo;
	@Autowired
	AdministratorRepo administratorRepo;

	@RequestMapping("/{username}")
	public String getUser(@PathVariable(value = "username") String username, HttpServletResponse response, HttpSession session, Authentication authentication, Model model) {
		response.addHeader("Redirect","/user/"+username);
		User profile = userRepo.findByUsername(username);
		session.setAttribute("user",userRepo.findByUsername(authentication.getName()));
		if (profile != null && !profile.getRole().equals("administrator")){
			model.addAttribute("public", profile);
			if (profile.getRole().equals("lecturer")){
				Lecturer lecturer = lecturerRepo.findByUsername(profile.getUsername());
				model.addAttribute("lecturer", lecturer);
				return "lecturer/profile";
			}
			else if(profile.getRole().equals("learner")){
				if(profile.getUsername().equals(authentication.getName())){
					Pagination courses =  learnerRepo.findByUsername(authentication.getName()).getCoursePagination();
					if (courses.getPage().getContent().size() == 0){
						model.addAttribute("topCourses", courseRepo.findTop3ByStatusOrderByRatingDesc(Status.Approved));
						model.addAttribute("popularCourses", courseRepo.getPopularCourses(Status.Approved.toString()));
					}
					model.addAttribute("courses", courses);
					model.addAttribute("myCourses",true);
					return "course/search";
				}
			}
		}
		return "/"+userRepo.findByUsername(authentication.getName()).getRole();
	}

	@RequestMapping("/{username}/courses")
	public String getUserCourses(@PathVariable(value = "username") String username, HttpServletResponse response, Authentication authentication, Model model) {
		response.addHeader("Redirect","/user/"+username);
		User profile = userRepo.findByUsername(username);
		if (profile != null){
			model.addAttribute("public", profile);
			if (profile.getRole().equals("lecturer")){
				return "lecturer/profile";
			}
			else if(profile.getRole().equals("learner")){
				Pagination courses =  learnerRepo.findByUsername(authentication.getName()).getCoursePagination();
				if (courses.getPage().getContent().size() == 0){
					model.addAttribute("topCourses", courseRepo.findTop3ByStatusOrderByRatingDesc(Status.Approved));
					model.addAttribute("popularCourses", courseRepo.getPopularCourses(Status.Approved.toString()));
				}
				model.addAttribute("courses", courses);
				model.addAttribute("myCourses",true);
				return "course/search";
			}
		}
		return "/"+userRepo.findByUsername(authentication.getName()).getRole();
	}

	@RequestMapping(value = "/{username}/details/address", method = RequestMethod.POST)
	public String addressDetails(@PathVariable("username") String username, @ModelAttribute("viewUser") User viewUser, Authentication authentication, Model model) {
		User auth = userRepo.findByUsername(authentication.getName());
		if (auth.getUsername().equals(username) || auth.getRole().equals("administrator")){
			User user = userRepo.findByUsername(username);
			if (Address.isAddressAcceptable(viewUser.getAddress())) {
				Address addressT;
				if(Address.isEmpty(viewUser.getAddress()))
					viewUser.setAddress(null);
				if (viewUser.getAddress() != null) {
					addressT = addressRepo.findByCountryAndStreet_AddressAndPostalCode(viewUser.getAddress().getCountry(),
							viewUser.getAddress().getStreet_address(), viewUser.getAddress().getPostalcode());
					if (addressT != null) {
						viewUser.setAddress(addressT);
					}
				}
				user.setAddress(viewUser.getAddress());
				userRepo.save(user);
				if ((user.getAddress() == null)){
					user.setAddress(new Address());
				}
				model.addAttribute("viewUser",user);
				model.addAttribute("userSuccess", "Address Updated.");
			} else {
				model.addAttribute("userError", "Please fill out all address fields or leave them all empty.");
			}
			return "includes/address";
		}
		model.addAttribute("userError", "You are unauthorized to do this.");
		return "includes/address";
	}

	@RequestMapping(value = "/{username}/notification")
	public ResponseEntity readNotification(@PathVariable("username")String username, @RequestParam("id")long id,HttpSession session, Authentication authentication){
		if (username.equals(authentication.getName())) {
			User user = userRepo.findByUsername(username);
			Notification notification = notificationRepo.findById(id);
			if (user.getNotifications().contains(notification)){
				notificationRepo.save(notification.removeUser(user));
				session.setAttribute("user",user.removeNotification(notification));
				if (notification.getUsers().isEmpty()){
					notificationRepo.delete(notification);
				}
				return new ResponseEntity(HttpStatus.OK);
			}
		}
		return new ResponseEntity(HttpStatus.BAD_REQUEST);
	}

	@RequestMapping(value = "/new-password", method = RequestMethod.POST)
	public String resetPassword(@RequestParam("password") String password, @RequestParam("confirm") String confirm, Authentication authentication, Model model) {
		User user = userRepo.findByUsername(authentication.getName());
		if (user == null) {
			return "redirect:/";
		}
		if (password.length() >= 6) {
			if (password.equals(confirm)) {
				user.setPassword(BCrypt.hashpw(confirm, BCrypt.gensalt()));
				userRepo.save(user);
				model.addAttribute("userSuccess","Password Changed");
			}
			else {
				model.addAttribute("userError","Password fields didn't match.");
			}
		}
		if (user.getRole().equals("learner")){
			Learner learner = learnerRepo.findByUsername(authentication.getName());
			model.addAttribute("supportTickets", supportTicketRepo.getSupportTicketOfUserByUserId(learner.getId()));
			Learner viewUser = learnerRepo.findByUsername(authentication.getName());
			if ((viewUser.getAddress() == null)){
				viewUser.setAddress(new Address());
			}
			model.addAttribute("viewUser", viewUser);
			return "learner/home";
		}
		else if(user.getRole().equals("lecturer")) {
			Lecturer viewUser = lecturerRepo.findByUsername(authentication.getName());
			if ((viewUser.getAddress() == null)){
				viewUser.setAddress(new Address());
			}
			model.addAttribute("viewUser", viewUser);
			return "lecturer/home";
		}

		Administrator viewUser = administratorRepo.findByUsername(authentication.getName());
		if ((viewUser.getAddress() == null)){
			viewUser.setAddress(new Address());
		}
		model.addAttribute("viewUser", viewUser);
		return "admin/details";

	}
}