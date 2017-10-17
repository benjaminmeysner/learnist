package FDMWebApp.controller;

import FDMWebApp.domain.ReportedLecture;
import FDMWebApp.domain.ReportedUser;
import FDMWebApp.domain.SupportCategory;
import FDMWebApp.domain.SupportTicket;
import FDMWebApp.repository.ReportedLectureRepo;
import FDMWebApp.repository.ReportedUserRepo;
import FDMWebApp.repository.SupportTicketRepo;
import FDMWebApp.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

/**
 * Created by dani1 on 30/04/2017.
 */

@Controller
@RequestMapping("/support")
public class SupportTicketController {

	@Autowired
	private UserRepo userRepo;
	@Autowired
	private SupportTicketRepo supportTicketRepo;
	@Autowired
	private ReportedLectureRepo reportedLectureRepo;
	@Autowired
	private ReportedUserRepo reportedUserRepo;

	@RequestMapping("")
	public String index(HttpSession session, Model model) {
		model = basicModelSetup(null, model, session, false);
		return "support/main";
	}

	private Model basicModelSetup(SupportCategory supportReason, Model model, HttpSession session, boolean success) {
		model.addAttribute("ticketTitle", "Please choose one of the following Issue!");
		if (session.getAttribute("user") == null) {
			model.addAttribute("RegisteredUser", false);
		} else {
			model.addAttribute("RegisteredUser", true);
			model.addAttribute("user", session.getAttribute("user"));
		}
		if (success) {
			model.addAttribute("success", true);
			model.addAttribute("ticketTitle", "Issue successfully reported!");
			model.addAttribute("ticketText", "Our support team will, (be in touch if need be to) sort it out as " +
					"soon as " +
					"possible!");
		}
		if (supportReason == SupportCategory.General_Enquiry) {
			model.addAttribute("type", "general");
			model.addAttribute("ticket", new SupportTicket());
			model.addAttribute("action", "/support/general");
			model.addAttribute("button", true);
		} else if (supportReason == SupportCategory.Report_User) {
			model.addAttribute("type", "user");
			model.addAttribute("ticket", new ReportedUser());
			model.addAttribute("action", "/support/user");
			model.addAttribute("button", true);
		} else if (supportReason == SupportCategory.Report_Lecture_Content) {
			model.addAttribute("type", "lecture");
			model.addAttribute("ticket", new ReportedLecture());
			model.addAttribute("action", "/support/lecture");
			model.addAttribute("button", true);
		} else {
			model.addAttribute("type", "");
			model.addAttribute("ticket", new SupportTicket());
			model.addAttribute("action", "/support");
			model.addAttribute("button", false);
		}
		System.out.println(model);
		return model;
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public String choosingTicketType(HttpSession session, Model model, @ModelAttribute("ticket") SupportTicket ticket) {
		System.out.println("from choosing :" + ticket.getSupportReason());
		model = basicModelSetup(ticket.getSupportReason(), model, session, false);
		return "support/main";
	}

	@RequestMapping(value = "/general", method = RequestMethod.POST)
	public String generalEnquiry(HttpSession session, Model model, @ModelAttribute("ticket") SupportTicket ticket) {
		System.out.println("from GEN: " + ticket.getSupportReason());
		if (ticket.getSupportReason() != SupportCategory.General_Enquiry) {
			basicModelSetup(ticket.getSupportReason(),model,session,false);
			return "redirect:/support";
		} else if (checkTicketValidity(ticket, SupportCategory.General_Enquiry)) {
			SupportTicket supportTicket = new SupportTicket();
			supportTicket.setDescription(ticket.getDescription());
			supportTicket.setSupportReason(SupportCategory.General_Enquiry);
			supportTicketRepo.save(ticket);
			model = basicModelSetup(ticket.getSupportReason(), model, session, true);
		}
		model = basicModelSetup(ticket.getSupportReason(), model, session, false);
		return "support/main";
	}

	private boolean checkTicketValidity(SupportTicket ticket, SupportCategory general_enquiry) {
		return !ticket.getDescription().equals("")
				&& ticket.getDescription() == null
				&& ticket.getSupportReason() == general_enquiry;
	}

	@RequestMapping(value = "/user", method = RequestMethod.POST)
	public String userReport(HttpSession session, Model model, @ModelAttribute("ticket") ReportedUser user) {
		System.out.println("from User: " + user.getSupportReason());
		if (user.getSupportReason() != SupportCategory.Report_User) {
			basicModelSetup(user.getSupportReason(),model,session,false);
			return "redirect:/support";
		} else if (checkUserReportedValidity(user, SupportCategory.Report_User)) {
			ReportedUser reportedUser = new ReportedUser();
			reportedUser.setUsername(user.getUsername());
			reportedUser.setDescription(user.getDescription());
			reportedUser.setSupportReason(SupportCategory.Report_User);
			reportedUserRepo.save(reportedUser);
			model = basicModelSetup(user.getSupportReason(), model, session, true);
		}
		if (!checkUserReportedValidity(user, SupportCategory.Report_User))
			model = basicModelSetup(user.getSupportReason(), model, session, false);
		return "support/main";
	}

	private boolean checkUserReportedValidity(ReportedUser user, SupportCategory report_user) {
		return !user.getDescription().equals("")
				&& user.getDescription() == null
				&& !user.getUsername().equals("")
				&& user.getUsername() != null
				&& user.getSupportReason() == report_user;
	}

	@RequestMapping(value = "/lecture", method = RequestMethod.POST)
	public String lectureReport(HttpSession session, Model model, @ModelAttribute("ticket") ReportedLecture lecture) {
		System.out.println("from lecture: " + lecture.getSupportReason());
		if (lecture.getSupportReason() != SupportCategory.Report_Lecture_Content) {
			basicModelSetup(lecture.getSupportReason(),model,session,false);
			return "redirect:/support";
		} else if (checkLectureReportValidity(lecture, SupportCategory
				.Report_Lecture_Content)) {
			ReportedLecture reportedLecture = new ReportedLecture();
			reportedLecture.setDescription(lecture.getDescription());
			reportedLecture.setCourse(lecture.getCourse());
			reportedLecture.setLesson(lecture.getLesson());
			reportedLecture.setSupportReason(SupportCategory.Report_Lecture_Content);
			reportedLectureRepo.save(lecture);
			model = basicModelSetup(lecture.getSupportReason(), model, session, true);
		}
		if (!checkLectureReportValidity(lecture, SupportCategory
				.Report_Lecture_Content))
			model = basicModelSetup(lecture.getSupportReason(), model, session, false);
		return "support/main";
	}

	private boolean checkLectureReportValidity(ReportedLecture lecture, SupportCategory report_lecture_content) {
		return !lecture.getDescription().equals("")
				&& lecture.getDescription() == null
				&& lecture.getCourse() != null
				&& lecture.getLesson() != null
				&& lecture.getSupportReason() == report_lecture_content;
	}
}
