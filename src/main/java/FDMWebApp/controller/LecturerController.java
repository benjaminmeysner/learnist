package FDMWebApp.controller;

import FDMWebApp.aws.StorageHandler;
import FDMWebApp.domain.*;
import FDMWebApp.repository.*;
import FDMWebApp.transfer_objects.CourseFile;
import FDMWebApp.transfer_objects.LessonFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Dani on 04/03/2017.
 */
@Controller
@RequestMapping("/lecturer")
public class LecturerController {

	@Autowired
	private LecturerRepo lecturerRepo;
	@Autowired
	private CourseRepo courseRepo;
	@Autowired
	private LessonRepo lessonRepo;
	@Autowired
	private FileRepo fileRepo;
	@Autowired
	private TagRepo tagRepo;

	@Autowired
	private SupportTicketRepo supportTicketRepo;
	@Autowired
	private NotificationRepo notificationRepo;
	@Autowired
	private AddressRepo addressRepo;

	@RequestMapping("")
	public String index(Authentication authentication,HttpSession session, Model model) {
		Lecturer lecturer = lecturerRepo.findByUsername(authentication.getName());
		session.setAttribute("user",lecturer);
		// model.addAttribute("supportTickets",
		// supportTicketRepo.getSupportTicketOfUserByUserId(lecturer.getId()));
		if ((lecturer.getAddress() == null)) {
			lecturer.setAddress(new Address());
		}
		model.addAttribute("viewUser", lecturer);
		return "lecturer/home";
	}

	@RequestMapping(value = "/course/{code}")
	public String viewCourse(@PathVariable("code") String code, HttpSession session, Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			model.addAttribute("viewCourse", course);
			model.addAttribute("allTags", tagRepo.findAll());
			return "lecturer/course";
		}
		return index(authentication,session, model);
	}

	@RequestMapping(value = "/course/add", method = RequestMethod.GET)
	public String newCourse(Authentication authentication, Model model) {
		model.addAttribute("newCourse", new CourseFile(lecturerRepo.findByUsername(authentication.getName())));
		model.addAttribute("subjects", Course.getSubjects());
		return "course/new";
	}

	@RequestMapping(value = "/course/add", method = RequestMethod.POST)
	public String addCourse(@ModelAttribute("newCourse") CourseFile courseFile, HttpSession session, Authentication authentication, Model model) {
		if (courseFile.getFile().getSize() < 1000000L) {
			if (Arrays.asList(".jpg", ".png")
					.contains(StorageHandler.getFileExtension(courseFile.getFile().getOriginalFilename()))) {
				if (6 <= courseFile.getCourse().getName().length() && courseFile.getCourse().getName().length() <= 30) {
					if (courseFile.getCourse().getDescription().length() <= 255) {
						if (Course.getSubjects().contains(courseFile.getCourse().getSubject())) {
							Course course = courseFile.getCourse();
							try {
								Lecturer lecturer = lecturerRepo.findByUsername(authentication.getName());
								course.setLecturer(lecturer);
								course = courseRepo.save(course);
								courseFile.setCourse(course);
								String url = StorageHandler.uploadCourseImage(courseFile);
								course.setImage(new SupportingFile(url));
								lecturer.addCourse(course);
								session.setAttribute("user", lecturerRepo.save(lecturer));
							} catch (Exception e) {

							}
							return "redirect:/lecturer/course/" + course.getCode();
						} else {
							model.addAttribute("courseError", "Invalid Subject!");
						}
					} else {
						model.addAttribute("courseError", "Course description needs to be less than 255 characters!");

					}
				} else {
					model.addAttribute("courseError", "Course name needs to be between 6 and 30 characters!");
				}
			} else {
				model.addAttribute("courseError", "Invalid file type!");
			}
		} else {
			model.addAttribute("courseError", "Image size too large!");
		}

		return "course/new";
	}

	@RequestMapping(value = "/course/{code}/edit")
	public String editCourse(@PathVariable("code") String code, @ModelAttribute("viewCourse") Course viewCourse, HttpSession session,
	                         Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			if (viewCourse.getDescription().length() <= 255) {
				course.setDescription(viewCourse.getDescription());
				model.addAttribute("viewCourse", courseRepo.save(course));
			} else {
				model.addAttribute("courseError", "Description too long!");
			}
			model.addAttribute("allTags", tagRepo.findAll());
			return "lecturer/course";
		}
		model.addAttribute("courseError", "Invalid Course!");
		return index(authentication,session, model);	}

	@RequestMapping(value = "/course/{code}/tags", method = RequestMethod.POST)
	public String editTags(@PathVariable("code") String code, @ModelAttribute("viewCourse") Course viewCourse, HttpSession session,
	                       Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			if (viewCourse.getTags().size() <= 5) {
				if (Arrays.asList(tagRepo.findAll()).containsAll(viewCourse.getTags())) {
					course.setTags(viewCourse.getTags());
					model.addAttribute("viewCourse", courseRepo.save(course));
				} else {
					model.addAttribute("courseError", "Invalid tags!");
				}
			} else {
				model.addAttribute("courseError", "Too many tags!");
			}
			model.addAttribute("allTags", tagRepo.findAll());
			return "lecturer/course";
		}
		model.addAttribute("courseError", "Invalid Course!");
		return index(authentication,session, model);	}

	@RequestMapping(value = "/course/{code}/submit", method = RequestMethod.POST)
	public String submitCourse(@PathVariable("code") String code, HttpSession session, Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			if (course.getStatus() == Status.Unverified) {
				course.setStatus("Submitted");
				courseRepo.save(course);

				model.addAttribute("courseSuccess", "Course Submitted.");
			} else if (course.getStatus() == Status.Submitted) {
				model.addAttribute("courseError", "Course already submitted.");
			} else if (course.getStatus() == Status.Approved) {
				model.addAttribute("courseError", "Course already Approved.");
			}
			model.addAttribute("viewCourse", course);
			model.addAttribute("allTags", tagRepo.findAll());
			return "lecturer/course";

		}
		model.addAttribute("courseError", "Invalid Course!");
		return index(authentication,session, model);	}

	@RequestMapping(value = "/course/{code}/delete", method = RequestMethod.POST)
	public String deleteCourse(@PathVariable("code") String code, HttpSession session, Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		Lecturer lecturer = lecturerRepo.findByUsername(authentication.getName());
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			if (course.getLearners().size() == 0) {
				courseRepo.delete(course);
				lecturer.getCourses().remove(course);
				session.setAttribute("user",lecturerRepo.save(lecturer));
				return index(authentication,session, model);
			} else {
				model.addAttribute("courseError", "Course cannot be deleted once there are learners.");
			}
			model.addAttribute("viewCourse", course);
			model.addAttribute("allTags", tagRepo.findAll());
			return "lecturer/course";

		}
		model.addAttribute("courseError", "Invalid Course!");
		return index(authentication,session, model);	}

	@RequestMapping(value = "/course/{code}/lesson/{order}")
	public String getLesson(@PathVariable("code") String code, @PathVariable("order") int order, HttpSession session,
	                        Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			if (order <= course.getLessons().size()) {
				model.addAttribute("viewLesson", lessonRepo.findByCourseAndOrder(course, order));
				model.addAttribute("lessonFile", new LessonFile(course));
				return "lecturer/lesson";
			} else {
				model.addAttribute("courseError", "Invalid Lesson.");
				return "lecturer/course";
			}
		}
		return index(authentication,session, model);
	}

	@RequestMapping(value = "/course/{code}/lesson/{order}/delete")
	public String deleteLesson(@PathVariable("code") String code, @PathVariable("order") int order, HttpSession session,
	                           Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			if (order > course.getCurrentLesson()) {
				course.deleteLesson(lessonRepo.findByCourseAndOrder(course, order));
				model.addAttribute("viewCourse", courseRepo.save(course));
				model.addAttribute("allTags", tagRepo.findAll());
				model.addAttribute("courseSuccess", "Lesson " + order + " deleted.");
				return "lecturer/course";
			} else {
				model.addAttribute("lessonError", "Cannot delete a lesson once it's been published.");
				model.addAttribute("viewLesson", lessonRepo.findByCourseAndOrder(course, order));
				return "lecturer/lesson";
			}
		}
		return index(authentication,session, model);
	}

	@RequestMapping(value = "/course/{code}/lesson/add", method = RequestMethod.GET)
	public String newLesson(@PathVariable("code") String code, HttpSession session, Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			model.addAttribute("newLesson", new LessonFile(course));
			return "course/lesson/new";
		}
		model.addAttribute("courseError", "Invalid Course!");
		return index(authentication,session, model);
	}

	@RequestMapping(value = "/course/{code}/meetup/new", method = RequestMethod.GET)
	public String newMeetup(@PathVariable("code") String code, HttpSession session, Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			Meetup meetup = course.getMeetup();
			if (course.getMeetup() == null){
				meetup =  new Meetup(course);
				model.addAttribute("new", true);
			}
			model.addAttribute("viewMeetup",meetup);
			return "lecturer/meetup";
		}
		model.addAttribute("courseError", "Invalid Course!");
		return index(authentication,session, model);
	}

	@RequestMapping(value = "/course/{code}/meetup/delete", method = RequestMethod.POST)
	public String deleteMeetup(@PathVariable("code") String code, HttpSession session, Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			course.setMeetup(null);
			courseRepo.save(course);
			model.addAttribute("new", true);
			model.addAttribute("meetupSuccess", "Meetup Deleted!");
			model.addAttribute("viewMeetup", new Meetup(course));
			return "lecturer/meetup";
		}
		model.addAttribute("courseError", "Invalid Course!");
		return index(authentication,session, model);
	}

	@RequestMapping(value = "/course/{code}/meetup/edit", method = RequestMethod.POST)
	public String editMeetup(@PathVariable("code") String code, @ModelAttribute("viewMeetup")Meetup meetup, HttpSession session, Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			Address address = meetup.getLocation();
			if (Address.isAddressAcceptable(address) && !Address.isEmpty(address)){
				course.setMeetup(null);
				Address address2 = addressRepo.findByCountryAndStreet_AddressAndPostalCode(address.getCountry(),address.getStreet_address(),address.getPostalcode());
				if (address2 == null){
					address2 = address;
				}
				meetup.setLocation(address2);
				course = courseRepo.save(course);
				course.setMeetup(meetup);
				course = courseRepo.save(course);
				List<User> users = new ArrayList<>();
				users.addAll(course.getLearners());
				notificationRepo.save(new Notification("The course "+course.getName()+" has a new meetup.",users,"/course/"+course.getCode()+"/meetup"));
				model.addAttribute("viewCourse", course);
				model.addAttribute("courseSuccess", "Meetup Added!");
				model.addAttribute("allTags", tagRepo.findAll());
				return "lecturer/course";
			}
			else {
				model.addAttribute("new", true);
				model.addAttribute("meetupError", "Address cannot have any empty fields");
				return "lecturer/meetup";
			}
		}
		model.addAttribute("courseError", "Invalid Course!");
		return index(authentication,session, model);
	}

	@RequestMapping(value = "/course/{code}/lesson/add", method = RequestMethod.POST)
	public String addLesson(@PathVariable("code") String code, @ModelAttribute("newLesson") LessonFile lessonFile, HttpSession session,
	                        Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			lessonFile.getLesson().setCourse(course);
			if (3 <= lessonFile.getLesson().getName().length() || lessonFile.getLesson().getName().length() <= 30) {
				if (lessonFile.getFile().getSize() < 300000000) {
					String fileType = lessonFile.getFile().getContentType();
					if (fileType.equals("application/vnd.oasis.opendocument.presentation")
							|| fileType.contains("video")) {
						Lesson lesson = lessonFile.getLesson();
						lesson.setOrder();
						try {
							String url = StorageHandler.getUrl(lessonFile, true);
							SupportingFile file = fileRepo.findByUrl(url);
							if (file == null) {
								file = new SupportingFile(url);
								StorageHandler.uploadLessonFile(lessonFile, true);
							}
							lesson.setMainFile(file);
							course.addLesson(lessonRepo.save(lesson));
							courseRepo.save(course);
							model.addAttribute("viewLesson", lesson);
							model.addAttribute("lessonFile", new LessonFile(course));
							model.addAttribute("lessonSuccess", "Lesson added.");
							return "lecturer/lesson";
						} catch (Exception e) {
							model.addAttribute("lessonError", e.getMessage());
						}
					} else {
						model.addAttribute("lessonError", "Invalid file type.");
					}
				} else {
					model.addAttribute("lessonError", "File too large!");
				}
			} else {
				model.addAttribute("lessonError", "Invalid Lesson name.");
			}
			return "course/lesson/new";
		}
		model.addAttribute("lessonError", "Invalid Course!");
		return index(authentication,session, model);
	}

	@RequestMapping(value = "/course/{code}/next", method = RequestMethod.POST)
	public String nextLesson(@PathVariable("code") String code, HttpSession session, Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			if (course.getCurrentLesson() < course.getLessons().size()) {
				course.nextLesson();
				model.addAttribute("viewCourse", courseRepo.save(course));
				List<User> users = new ArrayList<>();
				users.addAll(course.getLearners());
				notificationRepo.save(new Notification("The course "+course.getName()+" has a new lesson.",users,"/course/"+course.getCode()+"/lesson/"+course.getCurrentLesson()));
				model.addAttribute("courseSuccess", "Lesson Published!");
			} else {
				model.addAttribute("courseError", "There are no more lessons to publish.");
			}
			return "lecturer/course";
		}
		model.addAttribute("lessonError", "Invalid Course!");
		return index(authentication,session, model);
	}

	@RequestMapping(value = "/course/{code}/lesson/{order}/file", method = RequestMethod.POST)
	public String editLessonFile(@PathVariable("code") String code, @PathVariable("order") int order,
	                             @ModelAttribute("lessonFile") LessonFile lessonFile, HttpSession session, Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			Lesson lesson = lessonRepo.findByCourseAndOrder(course, order);
			if (lesson != null) {
				if (lesson.getFiles().size() < 5) {
					if (lessonFile.getFile().getSize() < 5000000) {
						if (lessonFile.getFile().getOriginalFilename().length() < 35) {
							if (StorageHandler.isValidFile(lessonFile.getFile())) {
								try {
									lessonFile.setLesson(lesson);
									String url = StorageHandler.getUrl(lessonFile, false);
									SupportingFile file = fileRepo.findByUrl(url);
									if (file == null) {
										file = new SupportingFile(url);
										StorageHandler.uploadLessonFile(lessonFile, false);
										lesson.getFiles().add(fileRepo.save(file));
										lesson = lessonRepo.save(lesson);
										courseRepo.save(course);
										model.addAttribute("viewLesson", lesson);
										model.addAttribute("lessonFile", new LessonFile(course));
										if (lesson.getOrder() <= course.getCurrentLesson()){
											List<User> users = new ArrayList<>();
											users.addAll(course.getLearners());
											notificationRepo.save(new Notification("The lesson "+lesson.getName()+" of the course "+course.getName()+" has a new supporting file.",users,"/course/"+course.getCode()+"/lesson/"+lesson.getOrder()));
										}
										model.addAttribute("lessonSuccess", "Successfully added supporting file.");
										return "lecturer/lesson";
									} else {
										model.addAttribute("lessonError", "File already exists");
									}
								} catch (Exception e) {
									model.addAttribute("lessonError", e.getMessage());
								}
							} else {
								model.addAttribute("lessonError",
										"Invalid File type. Only pdf, images and text files supported.");
							}
						} else {
							model.addAttribute("lessonError",
									"Filename too large please shorten it to less than 30 characters.");
						}
					} else {
						model.addAttribute("lessonError", "File too large!");
						model.addAttribute("viewLesson", lesson);
					}
				} else {
					model.addAttribute("lessonError", "File limit reached.");
				}
			} else {
				model.addAttribute("courseError", "Lesson doesn't exist!");
				model.addAttribute("viewCourse", course);
				return "lecturer/course";
			}
		}
		model.addAttribute("lessonError", "Invalid Course!");
		return index(authentication,session, model);
	}

	@RequestMapping(value = "/course/{code}/lesson/{order}/file/delete", method = RequestMethod.POST)
	public String removeLessonFile(@PathVariable("code") String code, @PathVariable("order") int order,
	                               @RequestParam("url") String url, HttpSession session, Authentication authentication, Model model) {
		Course course = courseRepo.findById(Course.getIdFromCode(code));
		if (course != null && authentication.getName().equals(course.getLecturer().getUsername())) {
			Lesson lesson = lessonRepo.findByCourseAndOrder(course, order);
			if (lesson != null) {
				if (order <= lesson.getFiles().size()) {
					if (lesson.getFiles().remove(fileRepo.findByUrl(url))) {
						model.addAttribute("lessonSuccess", "Supporting file removed.");
						model.addAttribute("lessonFile", new LessonFile(course));
					} else {
						model.addAttribute("lessonError", "Supporting file doesn't exist.");
					}
					model.addAttribute("viewLesson", lesson);
					return "lecturer/lesson";
				} else {
					model.addAttribute("courseError", "Lesson doesn't exist!");
					model.addAttribute("viewCourse", course);
					return "lecturer/course";
				}
			} else {
				model.addAttribute("courseError", "Lesson doesn't exist!");
				model.addAttribute("viewCourse", course);
				return "lecturer/course";
			}
		}
		model.addAttribute("lessonError", "Invalid Course!");
		return index(authentication,session, model);
	}
}
