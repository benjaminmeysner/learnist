package FDMWebApp.controller;


import FDMWebApp.aws.StorageHandler;
import FDMWebApp.domain.*;
import FDMWebApp.repository.CourseRepo;
import FDMWebApp.repository.LearnerRepo;
import FDMWebApp.repository.LecturerRepo;
import FDMWebApp.repository.LessonRepo;
import FDMWebApp.repository.NotificationRepo;
import FDMWebApp.repository.TagRepo;
import FDMWebApp.repository.UserRepo;
import FDMWebApp.transfer.CourseSearch;
import FDMWebApp.transfer.pagination.AdminPaginationDAO;
import FDMWebApp.transfer.pagination.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by dani1 on 18/04/2017.
 */
@Controller
@RequestMapping("/course")
public class CourseController {

	@Autowired
	private UserRepo userRepo;
	@Autowired
	private LearnerRepo learnerRepo;
	@Autowired
	private LecturerRepo lecturerRepo;
	@Autowired
	private CourseRepo courseRepo;
	@Autowired
	private TagRepo tagRepo;
	@Autowired

	LessonRepo lessonRepo;
	@Autowired
	NotificationRepo notificationRepo;

	@RequestMapping()
	public String index(HttpSession session, Model model) {
		Page<Course> courses = courseRepo.findAllByStatusOrderByRatingDesc(Status.Approved, new PageRequest(0, Pagination.SIZE));
		model.addAttribute("courses", new Pagination("/course/paginate", courses));
		List<Tag> tags = new ArrayList<>();
		tagRepo.findAll().forEach(tags::add);
		CourseSearch searchCourse = new CourseSearch(tags);
		model.addAttribute("searchCourse", searchCourse);
		session.setAttribute("searchCourse", searchCourse);
		model.addAttribute("allTags", tags);
		return "course/search";
	}

	@RequestMapping("/{code}")
	public String home(Model model, @PathVariable("code") String code, HttpSession session,
	                   Authentication authentication) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		model.addAttribute("allTags", tagRepo.findAll());
		User user = userRepo.findByUsername(authentication.getName());
		if (course != null) {

			model.addAttribute("viewCourse", courseRepo.findById(Course.getIdFromCode(code)));
			if (authentication.getName().equals(course.getLecturer().getUsername())) {
				model.addAttribute("viewCourse", course);
				model.addAttribute("allTags", tagRepo.findAll());
				return "lecturer/course";
			} else {
				if (user.getRole().equals("administrator")) {
					model.addAttribute("viewCourse", course);
					model.addAttribute("allTags", tagRepo.findAll());
					model.addAttribute("page", "courses/course");
					return "admin/admin";
				} else {
					model.addAttribute("viewCourse", course);
					model.addAttribute("newReview", new Review());
					session.setAttribute("user", user);
					return "course/home";
				}
			}
		}
		if (user.getRole().equals("administrator")) {
			model.addAttribute("page", "courses");
			model.addAttribute("title", "Courses");
			Page<Course> applications = courseRepo.findAllByStatus(Status.Submitted, new PageRequest(0, AdminPaginationDAO.SIZE));
			model.addAttribute("adminCoursesDAO", new AdminPaginationDAO(new Pagination(), new Pagination(), new Pagination("/administrator/courses/applications", applications)));
			return "admin/admin";
		}
		if (code == null || code.equals("")) {
			code = "";
		}
		Page<Course> courses = courseRepo.findAllByStatusAndNameContainingOrSubjectContainingOrderByRatingDesc(Status.Approved, code, code, new PageRequest(0, Pagination.SIZE));
		model.addAttribute("courses", new Pagination("/course/paginate", courses));
		List<Tag> tags = new ArrayList<>();
		tagRepo.findAll().forEach(tags::add);
		CourseSearch searchCourse = new CourseSearch(tags);
		model.addAttribute("searchCourse", searchCourse);
		session.setAttribute("searchCourse", searchCourse);
		model.addAttribute("allTags", tags);
		return "course/search";

	}

	@RequestMapping(value = "/paginate", method = RequestMethod.POST)
	public String paginateCourses(@RequestParam("pageNumber") int pageNumber, HttpSession session, Model model) {
		CourseSearch course = (CourseSearch) session.getAttribute("searchCourse");
		Page<Course> courses;
		if (pageNumber == -1) {
			pageNumber = courseRepo.findAllByStatusAndNameContainingOrSubjectContainingOrTagsInOrderByRatingDesc(Status.Approved, course.getName(), course.getSubject(), course.getTags()).size();
		}
		courses = courseRepo.findAllByStatusAndNameContainingOrSubjectContainingOrTagsInOrderByRatingDesc(Status.Approved, course.getName(), course.getSubject(), course.getTags(), new PageRequest(pageNumber, Pagination.SIZE));

		model.addAttribute("pagination", new Pagination("/course/paginate", courses));
		return "course/pagination/searches";
	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)

	public String refineSearch(@ModelAttribute("searchCourse") CourseSearch course, HttpSession session, Model model) {
		course.setName("");
		Page<Course> courses = courseRepo.findAllByStatusAndNameContainingOrSubjectContainingOrTagsInOrderByRatingDesc(Status.Approved, course.getName(), course.getSubject(), course.getTags(), new PageRequest(0, Pagination.SIZE));
		session.setAttribute("searchCourse", course);
		model.addAttribute("pagination", new Pagination("/course/paginate", courses));
		return "course/search";
	}

	@ResponseBody
	@RequestMapping(value = "/search/autocomplete", method = RequestMethod.GET)
	public String autocomplete(@RequestParam("search") String search) {
		StringBuilder courses = new StringBuilder("[");
		for (Course course : courseRepo.findAllByStatusAndNameContainingOrSubjectContainingOrderByRatingDesc(Status.Approved, search, search, new PageRequest(0, Pagination.SIZE)).getContent()) {
			courses.append("{" + "\"label\": \"").append(course.getName()).append("\", \"value\": \"").append(course.getCode()).append("\"").append("},");
		}
		if (courses.toString().endsWith(","))
			courses = new StringBuilder(courses.substring(0, courses.length() - 1));
		return courses + "]";
	}

	@RequestMapping(value = "/user/{username}", method = RequestMethod.POST)
	public String getCoursePagination(@PathVariable("username") String username,
	                                  @RequestParam("pageNumber") Integer pageNumber, HttpSession session, Model model) {
		Page<Course> page;
		List<Course> courses = new ArrayList<>();
		User user = userRepo.findByUsername(username);
		if (!user.getRole().equals("administrator")) {
			if (user.getRole().equals("learner")) {
				courses.addAll(learnerRepo.findByUsername(username).getCourses());
			} else if (user.getRole().equals("lecturer")) {
				courses = lecturerRepo.findByUsername(username).getCourses();
			}
			if (pageNumber == -1) {
				pageNumber = (courses.size() - 1) / Pagination.SIZE;
			}
			page = new PageImpl<>(courses, new PageRequest(pageNumber, Pagination.SIZE), courses.size());
			model.addAttribute("pagination", new Pagination("/course/user/" + username, page));
			return "course/pagination/courses";
		}
		return index(session, model);
	}

	@RequestMapping(value = "/{code}/users", method = RequestMethod.POST)

	public String paginateUsers(@PathVariable("code")String code,@RequestParam("pageNumber") Integer pageNumber, HttpSession session, Model model){
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null) {
			Page<Learner> page;
			if (pageNumber == -1) {
				pageNumber = (course.getLearners().size() - 1) / Pagination.SIZE;
			}
			page = new PageImpl<>(course.getLearners(), new PageRequest(pageNumber, Pagination.SIZE),
					course.getLearners().size());
			model.addAttribute("pagination", new Pagination("/course/" + course.getCode() + "/users", page));
			return "course/pagination/learners";
		} else {
			model.addAttribute("courseError", "Invalid Course");
		}
		return index(session, model);

	}

	@RequestMapping(value = "/{code}/lessons", method = RequestMethod.POST)

	public String paginateLessons(@PathVariable("code")String code,@RequestParam("pageNumber") Integer pageNumber, HttpSession session, Model model){
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null) {
			Page<Lesson> page;
			if (pageNumber == -1) {
				pageNumber = (course.getLessons().size() - 1) / Pagination.SIZE;
			}
			page = lessonRepo.findByCourse(course, new PageRequest(pageNumber, Pagination.SIZE));
			model.addAttribute("pagination", new Pagination("/course/" + course.getCode() + "/lessons", page));
			return "course/pagination/lessons";
		} else {
			model.addAttribute("courseError", "Invalid Course!");
		}
		return index(session, model);
	}

	@RequestMapping(value = "/{code}/enroll", method = RequestMethod.POST)
	public String enroll(@PathVariable("code") String code, Authentication authentication, HttpSession session, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null) {
			User user = userRepo.findByUsername(authentication.getName());
			if (user.getRole().equals("learner")) {
				Learner learner = learnerRepo.findByUsername(authentication.getName());
				if (!learner.isEnrolled(course)) {
					course.getLearners().add(learner);
					course = courseRepo.save(course);
					session.setAttribute("user", learnerRepo.findById(learner.getId()));
					notificationRepo.save(new Notification(learner.getUsername() + " has enrolled in "+course.getName()+"!",course.getLecturer(),"/lecturer/course/"+course.getCode()));
					model.addAttribute("viewCourse", course);
					model.addAttribute("courseSuccess", "You have successfully enrolled in this course.");
					model.addAttribute("newReview", new Review());
					session.setAttribute("user", learnerRepo.findByUsername(authentication.getName()));
					return "course/home";
				} else {
					model.addAttribute("courseError", "You are already enrolled on this course.");
				}
			} else {
				model.addAttribute("courseError", "You cannot enroll on this course.");
			}
		} else {
			model.addAttribute("courseError", "Invalid Course!");
		}
		return index(session, model);
	}

	@RequestMapping(value = "/{code}/leave", method = RequestMethod.POST)
	public String leave(@PathVariable("code") String code, Authentication authentication, HttpSession session, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null) {
			User user = userRepo.findByUsername(authentication.getName());
			if (user.getRole().equals("learner")) {
				Learner learner = learnerRepo.findByUsername(authentication.getName());
				if (learner.isEnrolled(course)) {
					course.getLearners().remove(learner);
					course = courseRepo.save(course);
					session.setAttribute("user", learnerRepo.findById(learner.getId()));
					notificationRepo.save(new Notification("A learner has left " + course.getName() +" .",course.getLecturer(),"/lecturer/course/"+course.getCode()));
					model.addAttribute("viewCourse", course);
					model.addAttribute("courseSuccess", "You have successfully left this course.");
					model.addAttribute("newReview", new Review());
					return "course/home";
				}
			}
			model.addAttribute("courseError", "You are aren't enrolled on this course.");
		} else {
			model.addAttribute("courseError", "Invalid Course!");
		}
		return index(session, model);
	}

	@RequestMapping(value = "/{code}/review", method = RequestMethod.POST)
	public String setReview(@PathVariable("code") String code, @ModelAttribute("newReview") Review review, Authentication authentication, HttpSession session, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null) {
			Learner learner = learnerRepo.findByUsername(authentication.getName());
			if (learner.getCourses().contains(course)) {
				if (!course.reviewedBy(learner)) {
					if (review.getReview().length() < 256) {
						review.setLearner(learner);
						review.setCourse(course);
						course.addReview(review);
						session.setAttribute("user", learner);
						notificationRepo.save(new Notification("Your course " + course.getName() +" has a new review!",course.getLecturer(),"/lecturer/course/"+course.getCode()));
						model.addAttribute("courseSuccess", "Review successfully added!");
						model.addAttribute("viewCourse", courseRepo.save(course));
						model.addAttribute("newReview", new Review());
						return "course/home";
					} else {
						model.addAttribute("courseError", "Review must be no longer that 255 characters");

					}
				} else {
					model.addAttribute("courseError", "You have already reviewed this course.");
				}
			} else {
				model.addAttribute("courseError", "You cannot leave a review on a course you're not enrolled in");
			}
		} else {
			model.addAttribute("courseError", "Invalid Course!");
		}
		return index(session, model);
	}

	@RequestMapping("/{code}/lesson/{order}")
	public String getLesson(@PathVariable("code") String code, @PathVariable("order") int order, HttpSession session, Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null) {
			User user = userRepo.findByUsername(authentication.getName());
			if (course.hasUser(user)){
				if (order <= course.getLessons().size()) {
					if (order <= course.getCurrentLesson()) {
						Lesson lesson = lessonRepo.findByCourseAndOrder(course, order);
						if (StorageHandler.getFileExtension(lesson.getMainFile().getUrl()).equals(".odp")) {
							model.addAttribute("pdf", true);
						}
						try {
							model.addAttribute("isLesson", true);
						} catch (Exception ignored) {

						}
						model.addAttribute("viewLesson", lesson);
						return "course/lesson";
					} else {
						model.addAttribute("courseError", "The lesson hasn't started yet.");
					}
				} else {
					model.addAttribute("courseError", "The lesson doesn't exist");
				}
				model.addAttribute("viewCourse", course);
				model.addAttribute("newReview", new Review());
				return "course/home";
			}
		}
		else {
			model.addAttribute("courseError", "Invalid Course!");

		}
		return index(session, model);
	}

	@RequestMapping(value = "/{code}/meetup")
	public String viewMeetup(@PathVariable("code") String code, HttpSession session, Authentication authentication, Model model){
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null) {
			User user = userRepo.findByUsername(authentication.getName());
			if (course.hasUser(user)){
				Meetup meetup = course.getMeetup();
				if (meetup == null){
					model.addAttribute("courseError","This course doesn't have a meetup.");
					if (user.getRole().equals("learner")){
						model.addAttribute("viewCourse", course);
						model.addAttribute("newReview", new Review());
					}
					else if (user.getRole().equals("lecturer")){
						model.addAttribute("viewCourse", course);
						model.addAttribute("allTags", tagRepo.findAll());
						return "lecturer/course";
					}
				}
				else{
					model.addAttribute("viewMeetup", course.getMeetup());
					return "course/meetup";
				}
			}
		} else {
			model.addAttribute("courseError", "Invalid Course!");
		}
		return index(session, model);
	}
}
