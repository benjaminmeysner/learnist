package FDMWebApp.controller;

import FDMWebApp.aws.MailHandler;
import FDMWebApp.domain.*;
import FDMWebApp.repository.*;
import FDMWebApp.transfer.CourseSearch;
import FDMWebApp.transfer.UserSearch;
import FDMWebApp.transfer.pagination.AdminPaginationDAO;
import FDMWebApp.transfer.pagination.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Rusty on 23/03/2017.
 */
@Controller
@RequestMapping("/administrator")
public class AdminController {

	@Autowired
	UserRepo userRepository;
	@Autowired
	AdministratorRepo administratorRepo;
	@Autowired
	LearnerRepo learnerRepo;
	@Autowired
	LecturerRepo lecturerRepo;
	@Autowired
	AddressRepo addressRepo;
	@Autowired
	CourseRepo courseRepo;
	@Autowired
	VerificationTokenRepo verificationTokenRepo;
	@Autowired
	TagRepo tagRepo;
	@Autowired
	NotificationRepo notificationRepo;
	@Autowired
	ReviewRepo reviewRepo;

	@RequestMapping("")

	public String index(HttpServletResponse response, HttpSession session, Authentication authentication, Model model) {
		response.addHeader("Redirect","/administrator");
		session.setAttribute("user",userRepository.findByUsername(authentication.getName()));
		model.addAttribute("userSearch", new UserSearch());
		model.addAttribute("courseSearch", new CourseSearch());
		model.addAttribute("allTags",tagRepo.findAll());
		model.addAttribute("page","dashboard");
		model.addAttribute("title","Dashboard");
		return "admin/admin";
	}

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboardGet(Model model) {
		model.addAttribute("userSearch", new UserSearch());
		model.addAttribute("courseSearch", new CourseSearch());
		model.addAttribute("allTags",tagRepo.findAll());
		model.addAttribute("page","dashboard");
		model.addAttribute("title","Dashboard");
		return "admin/admin";
	}

	@RequestMapping(value = "/dashboard", method = RequestMethod.POST)
	public String dashboardPost(Model model) {
		model.addAttribute("userSearch", new UserSearch());
		model.addAttribute("courseSearch", new CourseSearch());
		model.addAttribute("allTags",tagRepo.findAll());
		return "admin/dashboard";
	}

	@RequestMapping(value = "/analytics", method = RequestMethod.GET)
	public String analyticsGet(Model model) {
		model.addAttribute("page", "analytics");
		model.addAttribute("title", "Analytics");
		return "admin/admin";
	}

	@RequestMapping(value = "/analytics", method = RequestMethod.POST)
	public String analyticsPost() {
		return "admin/analytics";
	}

	@RequestMapping(value = "/details", method = RequestMethod.GET)
	public String detailsGet(Authentication authentication, HttpSession session, Model model) {
		model.addAttribute("page", "details");
		model.addAttribute("title", "Details");
		Administrator viewUser = administratorRepo.findByUsername(authentication.getName());
		if ((viewUser.getAddress() == null)) {
			viewUser.setAddress(new Address());
		}
		model.addAttribute("viewUser", viewUser);
		return "admin/admin";
	}

	@RequestMapping(value = "/details", method = RequestMethod.POST)
	public String detailsPost(Authentication authentication, Model model) {
		Administrator viewUser = administratorRepo.findByUsername(authentication.getName());
		if ((viewUser.getAddress() == null)) {
			viewUser.setAddress(new Address());
		}
		model.addAttribute("viewUser", viewUser);
		return "admin/details";
	}

	@RequestMapping(value = "/preferences", method = RequestMethod.GET)
	public String preferencesGet(Model model) {
		model.addAttribute("page", "preferences");
		model.addAttribute("title", "Preferences");
		return "admin/admin";
	}

	@RequestMapping(value = "/preferences", method = RequestMethod.POST)
	public String preferencesPost() {
		return "admin/preferences";
	}

	@RequestMapping(value = "/courses", method = RequestMethod.GET)
	public String coursesGet(Model model) {
		model.addAttribute("page", "courses");
		model.addAttribute("title", "Courses");
		model.addAttribute("adminCoursesDAO", newCoursesDAO());
		return "admin/admin";
	}

	@RequestMapping(value = "/courses", method = RequestMethod.POST)
	public String coursesPost(Model model) {
		model.addAttribute("adminCoursesDAO", newCoursesDAO());
		return "admin/courses";
	}

	@RequestMapping(value = "/users/learners", method = RequestMethod.GET)
	public String learnersGet(Model model) {
		model.addAttribute("adminLearnerDAO", newLearnerDAO());
		model.addAttribute("page", "users/lecturers");
		model.addAttribute("title", "Lecturers");
		return "admin/admin";
	}

	@RequestMapping(value = "/users/learners", method = RequestMethod.POST)
	public String learnersPost(Model model) {
		model.addAttribute("adminLearnerDAO", newLearnerDAO());
		return "admin/users/learners";
	}

	@RequestMapping(value = "/users/lecturers", method = RequestMethod.GET)
	public String lecturersGet(Model model) {
		model.addAttribute("adminLecturerDAO", newLecturerDAO());
		model.addAttribute("page", "users/lecturers");
		model.addAttribute("title", "Lecturers");
		return "admin/admin";
	}

	@RequestMapping(value = "/users/lecturers", method = RequestMethod.POST)
	public String lecturersPost(Model model) {
		model.addAttribute("adminLecturerDAO", newLecturerDAO());
		return "admin/users/lecturers";
	}

	@RequestMapping(value = "/users/learners/actives", method = RequestMethod.POST)
	public String learnerActives(@RequestParam("pageNumber") Integer pageNumber, Model model) {
		Page<Learner> page;
		if (pageNumber == -1) {
			pageNumber = (learnerRepo.countByActivated(true) - 1) / AdminPaginationDAO.SIZE;
		}
		page = learnerRepo.findAllByActivated(true, new PageRequest(pageNumber, AdminPaginationDAO.SIZE));
		model.addAttribute("pagination", new Pagination("/administrator/users/learners/actives", page));
		return "admin/includes/pagination/learners/actives";
	}

	@RequestMapping(value = "/users/learners/inactives", method = RequestMethod.POST)
	public String learnerInactives(@RequestParam("pageNumber") Integer pageNumber, Model model) {
		Page<Learner> page;
		if (pageNumber == -1) {
			pageNumber = (learnerRepo.countByActivated(false) - 1) / AdminPaginationDAO.SIZE;
		}
		page = learnerRepo.findAllByActivated(false, new PageRequest(pageNumber, AdminPaginationDAO.SIZE));
		model.addAttribute("pagination", new Pagination("/administrator/users/learners/inactives", page));
		return "admin/includes/pagination/learners/inactives";
	}

	@RequestMapping(value = "/users/lecturers/actives", method = RequestMethod.POST)
	public String lecturerActives(@RequestParam("pageNumber") Integer pageNumber, Model model) {
		Page<Lecturer> page;
		if (pageNumber == -1) {
			pageNumber = (lecturerRepo.countByActivated(true) - 1) / AdminPaginationDAO.SIZE;
		}
		page = lecturerRepo.findAllByActivated(true, new PageRequest(pageNumber, AdminPaginationDAO.SIZE));
		model.addAttribute("pagination", new Pagination("/administrator/users/lecturers/actives", page));
		return "admin/includes/pagination/lecturers/actives";
	}

	@RequestMapping(value = "/users/lecturers/inactives", method = RequestMethod.POST)
	public String lecturerInactives(@RequestParam("pageNumber") Integer pageNumber, Model model) {
		Page<Lecturer> page;
		if (pageNumber == -1) {
			pageNumber = (lecturerRepo.countByActivated(false) - 1) / AdminPaginationDAO.SIZE;
		}
		page = lecturerRepo.findAllByActivated(false, new PageRequest(pageNumber, AdminPaginationDAO.SIZE));
		model.addAttribute("pagination", new Pagination("/administrator/users/lecturers/inactives", page));
		return "admin/includes/pagination/lecturers/inactives";
	}

	@RequestMapping(value = "/users/lecturers/applications", method = RequestMethod.POST)
	public String lecturerApplications(@RequestParam("pageNumber") Integer pageNumber, Model model) {
		Page<Lecturer> page;
		if (pageNumber == -1) {
			pageNumber = (lecturerRepo.countByStatus(Status.Authorised) - 1) / AdminPaginationDAO.SIZE;
		}
		page = lecturerRepo.findAllByStatus(Status.Authorised, new PageRequest(pageNumber, AdminPaginationDAO.SIZE));
		model.addAttribute("pagination", new Pagination("/administrator/users/lecturers/applications", page));
		return "admin/includes/pagination/lecturers/applications";
	}

	@RequestMapping(value = "/users/lecturers/application")
	public String approveLecturer(@RequestParam("username") String username, @RequestParam("approve") Boolean approve,
	                              Model model) {
		Lecturer lecturer = lecturerRepo.findByUsername(username);
		if (lecturer != null && lecturer.getStatus() == Status.Authorised) {
			if (approve) {
				lecturer.setStatus(Status.Approved);
				lecturer.setActivated(true);
				lecturerRepo.save(lecturer);
				model.addAttribute("applicationSuccess", "Application approved.");
			} else {
				model.addAttribute("applicationSuccess", "Application denied.");
			}
		} else {
			model.addAttribute("applicationError", "Invalid Request!");
		}

		model.addAttribute("adminLecturerDAO", newLecturerDAO());
		return "admin/users/lecturers";
	}

	@RequestMapping(value = "/users/administrators", method = RequestMethod.GET)
	public String administratorsGet(Model model) {
		model.addAttribute("page", "users/administrators");
		model.addAttribute("title", "Administrators");
		model.addAttribute("addUser", new Administrator());
		model.addAttribute("administrators",new Pagination("/administrator/users/administrators/paginate",administratorRepo.findAll(new PageRequest(0, AdminPaginationDAO.SIZE))));
		return "admin/admin";
	}

	@RequestMapping(value = "/users/administrators", method = RequestMethod.POST)
	public String administratorsPost(Model model) {
		model.addAttribute("addUser", new Administrator());
		model.addAttribute("administrators",new Pagination("/administrator/users/administrators/paginate",administratorRepo.findAll(new PageRequest(0, AdminPaginationDAO.SIZE))));
		return "admin/users/administrators";
	}

	@RequestMapping(value = "/users/search/paginate", method = RequestMethod.POST)
	public String paginateSearchUser(@RequestParam("pageNumber") Integer pageNumber, HttpSession session, Model model) {
		UserSearch userSearch = (UserSearch) session.getAttribute("userSearch");
		List<Status> statusList = new ArrayList<>(userSearch.getStatus());
		Page<User> userList;
		if (userSearch.getActivated() == null) {
			if (pageNumber == -1) {
				pageNumber = userRepository.findByUsernameContainingAndRoleContainingAndStatusIn(
						userSearch.getUsername(), userSearch.getRole(), statusList).size() / Pagination.SIZE;
			}
			userList = userRepository.findByUsernameContainingAndRoleContainingAndStatusInOrderByUsernameDesc(
					userSearch.getUsername(), userSearch.getRole(), statusList,
					new PageRequest(pageNumber, Pagination.SIZE));
		} else {
			if (pageNumber == -1) {
				pageNumber = userRepository.findByUsernameContainingAndRoleContainingAndStatusInAndActivated(
						userSearch.getUsername(), userSearch.getRole(), statusList, userSearch.getActivated()).size()
						/ Pagination.SIZE;
			}
			userList = userRepository
					.findByUsernameContainingAndRoleContainingAndStatusInAndActivatedOrderByUsernameDesc(
							userSearch.getUsername(), userSearch.getRole(), statusList, userSearch.getActivated(),
							new PageRequest(pageNumber, Pagination.SIZE));
		}
		model.addAttribute("pagination", new Pagination("/administrator/users/search/paginate", userList));
		return "admin/includes/pagination/users";
	}

	@RequestMapping(value = "/users/search", method = RequestMethod.POST)
	public String searchUser(@ModelAttribute("userSearch") UserSearch userSearch, HttpSession session, Model model) {
		List<Status> statusList = new ArrayList<>(userSearch.getStatus());
		Page<User> userList;
		if (userSearch.getActivated() == null) {
			userList = userRepository.findByUsernameContainingAndRoleContainingAndStatusInOrderByUsernameDesc(
					userSearch.getUsername(), userSearch.getRole(), statusList, new PageRequest(0, Pagination.SIZE));
		} else {
			userList = userRepository
					.findByUsernameContainingAndRoleContainingAndStatusInAndActivatedOrderByUsernameDesc(
							userSearch.getUsername(), userSearch.getRole(), statusList, userSearch.getActivated(),
							new PageRequest(0, Pagination.SIZE));
		}
		model.addAttribute("pagination", new Pagination("/administrator/users/search/paginate", userList));
		session.setAttribute("userSearch", userSearch);
		return "admin/includes/pagination/users";
	}

	@RequestMapping(value = "/user/{username}")
	public String user(@PathVariable("username") String username, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("user", user);
		if (user.getUsername().equals(username)) {
			return "admin/details";
		}
		User viewUser = userRepository.findByUsername(username);
		if ((viewUser.getAddress() == null)) {
			viewUser.setAddress(new Address());
		}
		switch (viewUser.getRole()) {
			case "learner":
				Learner learner = learnerRepo.findByUsername(username);
				learner.setAddress(viewUser.getAddress());
				model.addAttribute("viewUser", learner);
				session.setAttribute("viewUser", learner);
				break;
			case "lecturer":
				Lecturer lecturer = lecturerRepo.findByUsername(username);
				lecturer.setAddress(viewUser.getAddress());
				model.addAttribute("viewUser", lecturer);
				session.setAttribute("viewUser", lecturer);
				break;
			case "administrator":
				Administrator administrator = administratorRepo.findByUsername(username);
				administrator.setAddress(viewUser.getAddress());
				model.addAttribute("viewUser", administrator);
				session.setAttribute("viewUser", administrator);
				break;
		}
		return "admin/users/user";
	}

	@RequestMapping(value = "/user/learner/edit", method = RequestMethod.POST)
	public String editLearner(@ModelAttribute("viewUser") Learner viewUser, HttpSession session, Model model) {
		Learner learner = (Learner) session.getAttribute("viewUser");
		learner.setStatus(viewUser.getStatus());
		learner.setActivated(viewUser.isActivated());
		learnerRepo.save(learner);
		notificationRepo.save(new Notification("An Administrator has edited your account.",learner,"/learner"));
		model.addAttribute("viewUser", learner);
		session.setAttribute("viewUser", learner);
		return "admin/users/user";
	}

	@RequestMapping(value = "/user/lecturer/edit", method = RequestMethod.POST)
	public String editLecturer(@ModelAttribute("viewUser") Lecturer viewUser, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("user", user);
		Lecturer lecturer = (Lecturer) session.getAttribute("viewUser");
		lecturer.setStatus(viewUser.getStatus());
		lecturer.setActivated(viewUser.isActivated());
		lecturerRepo.save(lecturer);
		notificationRepo.save(new Notification("An Administrator has edited your account.",lecturer,"/lecturer"));
		model.addAttribute("viewUser", lecturer);
		session.setAttribute("viewUser", lecturer);
		return "admin/users/user";
	}

	@RequestMapping(value = "/user/administrator/add", method = RequestMethod.POST)
	public String addAdministrator(@Valid @ModelAttribute("addUser") Administrator administrator, BindingResult result,
	                               HttpSession session, HttpServletRequest request, Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("user", user);
		if (!result.hasErrors()) {
			Integer accessLevel = administrator.getAccessLevel();
			if (0 < accessLevel && accessLevel < 3) {
				if (administratorRepo.findByUsername(request.getUserPrincipal().getName()).getAccessLevel() < 2) {
					if (!(userRepository.existsByEmail(administrator.getEmail())
							|| userRepository.existsByUsername(administrator.getUsername()))) {
						administrator.setPassword(BCrypt.hashpw(administrator.getPassword(), BCrypt.gensalt()));
						administrator.setBarcode();
						administratorRepo.save(administrator);
						try {
							sendVerificationEmail(administrator, request.getRequestURL().toString());
						} catch (Exception e) {
							e.printStackTrace();
						}
						new MailHandler("no-reply@learnist.cf", administrator, MailHandler.NEWADMIN,
								request.getRequestURL().toString());
						administratorRepo.save(administrator);
						model.addAttribute("registerSuccess", administrator.getUsername());
						administrator = new Administrator();
					}
				} else {
					model.addAttribute("registerError", "Your access level too low!");
				}
			} else {
				model.addAttribute("registerError", "Invalid Access Level!");
			}

		}
		administrator.setPassword("");
		model.addAttribute("addUser", administrator);
		return "admin/users/administrators";
	}

	@RequestMapping(value = "/user/administrator/edit", method = RequestMethod.POST)
	public String editAdministrator(@ModelAttribute("viewUser") Administrator viewUser, HttpSession session,
	                                Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("user", user);
		Administrator administrator = (Administrator) session.getAttribute("viewUser");
		administrator.setStatus(viewUser.getStatus());
		notificationRepo.save(new Notification("An Administrator has edited your account.",administrator,"/administrator/details"));
		administratorRepo.save(administrator);
		model.addAttribute("viewUser", administrator);
		session.setAttribute("viewUser", administrator);
		return "admin/users/user";
	}

	@RequestMapping(value = "/users/administrators/paginate", method = RequestMethod.POST)
	public String paginateAdministrators(@RequestParam("pageNumber") Integer pageNumber, Model model){
		Page<Administrator> page;// = administratorRepo.findAll(new PageRequest(0, AdminPaginationDAO.SIZE));
		if (pageNumber == -1) {
			pageNumber = (int)  administratorRepo.count() / AdminPaginationDAO.SIZE;
		}
		page = administratorRepo.findAll( new PageRequest(pageNumber, AdminPaginationDAO.SIZE));
		model.addAttribute("pagination", new Pagination("/administrator/users/administrators/paginate", page));
		return "admin/includes/pagination/administrators";
	}

	@RequestMapping(value = "/course/{code}", method = RequestMethod.GET)
	public String viewCourseGet(@PathVariable("code") String code, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null) {
			model.addAttribute("viewCourse", course);
			model.addAttribute("allTags", tagRepo.findAll());
			model.addAttribute("page", "courses/course");
		} else {
			model.addAttribute("page", "courses");
			model.addAttribute("title", "Courses");
			model.addAttribute("adminCoursesDAO", newCoursesDAO());
		}
		return "admin/admin";
	}

	@RequestMapping(value = "/course/{code}", method = RequestMethod.POST)
	public String viewCoursePost(@PathVariable("code") String code, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null) {
			model.addAttribute("viewCourse", course);
			model.addAttribute("allTags", tagRepo.findAll());
			return "admin/courses/course";
		}
		model.addAttribute("adminCoursesDAO", newCoursesDAO());
		return "admin/courses";
	}


	@RequestMapping(value = "/course/{code}/approved", method = RequestMethod.POST)
	public String approveCourse(@PathVariable("code")String code, @RequestParam("approved")Boolean approved, Model model){
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null) {
			if (course.getStatus() == Status.Submitted) {
				if (approved) {
					course.setStatus(Status.Approved);
					model.addAttribute("courseSuccess", "Course approved.");
					notificationRepo.save(new Notification("The course "+course.getName()+" has been approved.", course.getLecturer(),"/lecturer/course/"+course.getCode()));
				}
				else {
					course.setStatus(Status.Unverified);
					model.addAttribute("courseSuccess", "Course denied.");
					notificationRepo.save(new Notification("The course "+course.getName()+" has been denied.", course.getLecturer(),"/lecturer/course/"+course.getCode()));
				}
			} else {
				model.addAttribute("courseError", "Course already approved.");
			}
			model.addAttribute("viewCourse", courseRepo.save(course));
			model.addAttribute("allTags", tagRepo.findAll());
			return "admin/courses/course";
		}
		model.addAttribute("adminCoursesDAO", newCoursesDAO());
		return "admin/courses";
	}

	@RequestMapping(value = "/course/{code}/delete", method = RequestMethod.POST)
	public String deleteCourse(@PathVariable("code")String code, Model model){
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null){
			course.getLearners().forEach(l -> l.getCourses().remove(course));
			learnerRepo.save(course.getLearners());
			course.setLearners(null);
			courseRepo.delete(course);
			model.addAttribute("courseSuccess", "Course deleted.");
			List<User> users = new ArrayList<>(Arrays.asList(course.getLecturer()));
			users.addAll(course.getLearners());
			notificationRepo.save(new Notification("The course "+course.getName()+" has been deleted.",users));
		}
		model.addAttribute("adminCoursesDAO", newCoursesDAO());
		return "admin/courses";
	}

	@RequestMapping(value = "/course/{code}/suspend", method = RequestMethod.POST)
	public String suspendCourse(@PathVariable("code")String code, Model model){
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null){
			if (course.getStatus() != Status.Unverified){
				course.setStatus(Status.Unverified);
				model.addAttribute("courseSuccess", "Course suspended.");
				List<User> users = new ArrayList<>();
				users.addAll(course.getLearners());
				notificationRepo.save(new Notification("The course "+course.getName()+" has been suspended.", users));
				notificationRepo.save(new Notification("The course "+course.getName()+" has been suspended.", course.getLecturer(),"/lecturer/course/"+course.getCode()));
			}
			else {
				model.addAttribute("courseError", "Course already suspended.");
			}
			model.addAttribute("viewCourse",courseRepo.save(course));
			model.addAttribute("allTags", tagRepo.findAll());
			return "admin/courses/course";
		}
		model.addAttribute("adminCoursesDAO", newCoursesDAO());
		return "admin/courses";
	}

	@RequestMapping(value = "/courses/applications", method = RequestMethod.POST)
	public String paginateCourseApplications(@RequestParam("pageNumber") Integer pageNumber, Model model) {
		Page<Course> page;
		if (pageNumber == -1) {
			pageNumber = (courseRepo.countByStatus(Status.Submitted) - 1) / AdminPaginationDAO.SIZE;
		}
		page = courseRepo.findAllByStatus(Status.Submitted, new PageRequest(pageNumber, AdminPaginationDAO.SIZE));
		model.addAttribute("pagination", new Pagination("/administrator/courses/applications", page));
		return "admin/includes/pagination/lecturers/applications";
	}

	@RequestMapping(value = "/courses/unverified", method = RequestMethod.POST)
	public String paginateCourseUnverified(@RequestParam("pageNumber") Integer pageNumber, Model model){
		Page<Course> page;
		if (pageNumber == -1) {
			pageNumber = (courseRepo.countByStatus(Status.Unverified) - 1) / AdminPaginationDAO.SIZE;
		}
		page = courseRepo.findAllByStatus(Status.Unverified, new PageRequest(pageNumber, AdminPaginationDAO.SIZE));
		model.addAttribute("pagination", new Pagination("/administrator/courses/unverified", page));
		return "admin/includes/pagination/courses/unverified";
	}

	@RequestMapping(value = "/courses/approved", method = RequestMethod.POST)
	public String paginateCourseApproved(@RequestParam("pageNumber") Integer pageNumber, Model model){
		Page<Course> page;
		if (pageNumber == -1) {
			pageNumber = (courseRepo.countByStatus(Status.Approved) - 1) / AdminPaginationDAO.SIZE;
		}
		page = courseRepo.findAllByStatus(Status.Approved, new PageRequest(pageNumber, AdminPaginationDAO.SIZE));
		model.addAttribute("pagination", new Pagination("/administrator/courses/approved", page));
		return "admin/includes/pagination/courses/approved";
	}

	@RequestMapping(value = "/courses/search/paginate", method = RequestMethod.POST)
	public String paginateSearchCourses(@RequestParam("pageNumber") Integer pageNumber, HttpSession session, Model model) {
		CourseSearch courseSearch = (CourseSearch) session.getAttribute("courseSearch");
		Page<Course> courseList;
		if (pageNumber == -1) {
			pageNumber = courseRepo.findAllByStatusInAndNameContainingAndSubjectContainingAndTagsIn(courseSearch.getStatus(), courseSearch.getName(), courseSearch.getSubject(), courseSearch.getTags()).size() / Pagination.SIZE;
		}
		courseList = courseRepo.findAllByStatusInAndNameContainingAndSubjectContainingAndTagsInOrderByRatingDesc(courseSearch.getStatus(), courseSearch.getName(), courseSearch.getSubject(), courseSearch.getTags(), new PageRequest(pageNumber, Pagination.SIZE));
		model.addAttribute("pagination", new Pagination("/administrator/courses/search/paginate", courseList));
		return "admin/includes/pagination/courses";
	}


	@RequestMapping(value = "/courses/search", method = RequestMethod.POST)
	public String searchCourse(@ModelAttribute("courseSearch") CourseSearch courseSearch, HttpSession session, Model model) {
		if (courseSearch.getSubject() == null){
			courseSearch.setSubject("");
		}
		Page<Course> courseList = courseRepo.findAllByStatusInAndNameContainingAndSubjectContainingAndTagsInOrderByRatingDesc(courseSearch.getStatus(), courseSearch.getName(), courseSearch.getSubject(), courseSearch.getTags(), new PageRequest(0, Pagination.SIZE));

		model.addAttribute("pagination", new Pagination("/administrator/courses/search/paginate", courseList));
		session.setAttribute("courseSearch",courseSearch);
		return "admin/includes/pagination/courses";
	}

	@RequestMapping(value = "/course/{code}/review/delete", method = RequestMethod.POST)
	public String deleteReview(@PathVariable("code")String code, @RequestParam("id")long id, Model model){
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		course.getReviews().remove(reviewRepo.findOne(id));
		model.addAttribute("courseSuccess", "Review deleted.");
		model.addAttribute("viewCourse",courseRepo.save(course));
		model.addAttribute("allTags", tagRepo.findAll());
		return "admin/courses/course";

	}

	private AdminPaginationDAO newLecturerDAO(){
		Page<Lecturer> actives = lecturerRepo.findAllByActivated(true, new PageRequest(0, AdminPaginationDAO.SIZE));
		Page<Lecturer> inactives = lecturerRepo.findAllByActivated(false, new PageRequest(0, AdminPaginationDAO.SIZE));
		Page<Lecturer> application = lecturerRepo.findAllByStatus(Status.Authorised,
				new PageRequest(0, AdminPaginationDAO.SIZE));

		return new AdminPaginationDAO(new Pagination("/administrator/users/lecturers/actives", actives),
				new Pagination("/administrator/users/lecturers/inactives", inactives),
				new Pagination("/administrator/users/lecturers/applications", application));

	}

	private AdminPaginationDAO newLearnerDAO() {
		Page<Learner> actives = learnerRepo.findAllByActivated(true, new PageRequest(0, AdminPaginationDAO.SIZE));
		Page<Learner> inactives = learnerRepo.findAllByActivated(false, new PageRequest(0, AdminPaginationDAO.SIZE));

		return new AdminPaginationDAO(new Pagination("/administrator/users/lecturers/actives", actives),
				new Pagination("/administrator/users/lecturers/inactives", inactives), new Pagination());

	}

	private AdminPaginationDAO newCoursesDAO() {
		Page<Course> approved = courseRepo.findAllByStatus(Status.Approved, new PageRequest(0, AdminPaginationDAO.SIZE));
		Page<Course> applications  = courseRepo.findAllByStatus(Status.Submitted, new PageRequest(0, AdminPaginationDAO.SIZE));
		Page<Course> unverified = courseRepo.findAllByStatus(Status.Unverified, new PageRequest(0, AdminPaginationDAO.SIZE));
		return new AdminPaginationDAO(new Pagination("/administrator/courses/approved",approved), new Pagination("/administrator/courses/unverified", unverified),new Pagination("/administrator/courses/applications",applications));
	}

	private void sendVerificationEmail(User user, String url) throws Exception {
		VerificationToken verificationToken = new VerificationToken(user);
		while (verificationTokenRepo.findUserByToken(verificationToken.getToken()) != null) {
			verificationToken = new VerificationToken();
		}
		user.setVerificationToken(verificationToken);
		userRepository.save(user);
		MailHandler mail = new MailHandler("no-reply@learnist.cf", user, MailHandler.VERIFY, url);
		mail.sendMail();
	}
}