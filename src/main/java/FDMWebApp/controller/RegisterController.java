package FDMWebApp.controller;

import FDMWebApp.aws.MailHandler;
import FDMWebApp.aws.StorageHandler;
import FDMWebApp.domain.Address;
import FDMWebApp.domain.Learner;
import FDMWebApp.domain.Lecturer;
import FDMWebApp.domain.Status;
import FDMWebApp.domain.User;
import FDMWebApp.domain.VerificationToken;
import FDMWebApp.repository.AddressRepo;
import FDMWebApp.repository.CourseRepo;
import FDMWebApp.repository.LearnerRepo;
import FDMWebApp.repository.LecturerRepo;
import FDMWebApp.repository.UserRepo;
import FDMWebApp.repository.VerificationTokenRepo;
import googleAuthenticatorHandler.GoogleAuthHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

@Controller
@RequestMapping("/register")
public class RegisterController {

	@Autowired
	private UserRepo userRepo;
	@Autowired
	private LearnerRepo learnerRepo;
	@Autowired
	private LecturerRepo lecturerRepo;
	@Autowired
	private AddressRepo addressRepo;
	@Autowired
	private VerificationTokenRepo verificationTokenRepo;
	@Autowired
	private CourseRepo courseRepo;

	@RequestMapping("/learner")
	public String registerLearner(Model model) {
		model.addAttribute("learner", new Learner());
		return "register/learner";
	}

	@RequestMapping("/lecturer")
	public String registerLecturer(Model model) {
		model.addAttribute("lecturer", new Lecturer());
		return "register/lecturer";
	}

	@RequestMapping(value = "/learner", method = RequestMethod.POST)
	public String register_learner(@Valid @ModelAttribute("learner") Learner learner, BindingResult result, Model model,
	                               HttpServletRequest request) {
		if (!result.hasErrors()) {
			if (!userRepo.existsByEmailOrUsername(learner.getEmail(), learner.getUsername())) {
				if (Address.isAddressAcceptable(learner.getAddress())) {
					learner.setAddress(checkIfExist(learner.getAddress()));
					learner.setPassword(BCrypt.hashpw(learner.getPassword(), BCrypt.gensalt()));
					learner.setBarcode();
					learnerRepo.save(learner);
					try {
						sendVerificationEmail(learner, request.getRequestURL().toString());
					} catch (Exception e) {
						e.printStackTrace();
						return "register/learner";
					}
					learnerRepo.save(learner);
					model.addAttribute("title", "Account Created");
					model.addAttribute("text",
							"An email has been sent to your email address follow the instructions there to activate your account.");
					return "register/success";
				} else {
					model.addAttribute("addressError", "Please fill out all address fields or leave them all empty.");
				}
			}
		}
		learner.setPassword("");
		return "register/learner";
	}

	private Address checkIfExist(Address address) {
		Address addressT = null;
		if (address != null) {
			addressT = addressRepo.findByCountryAndStreet_AddressAndPostalCode(address.getCountry(),
					address.getStreet_address(), address.getPostalcode());
			if (addressT != null) {
				addressT.setCountry(addressT.getCountry().toUpperCase());
			}
		}
		return addressT;
	}

	@RequestMapping(value = "/lecturer", method = RequestMethod.POST)
	public String register_lecturer(@Valid @ModelAttribute("lecturer") Lecturer lecturer, BindingResult result,
	                                HttpServletRequest request, Model model) {
		if (!result.hasErrors()) {
			if (!userRepo.existsByEmailOrUsername(lecturer.getEmail(), lecturer.getUsername())) {
				if (Address.isAddressAcceptable(lecturer.getAddress())) {
					lecturer.setAddress(checkIfExist(lecturer.getAddress()));
					lecturer.setPassword(BCrypt.hashpw(lecturer.getPassword(), BCrypt.gensalt()));
					lecturer.setBarcode();
					lecturerRepo.save(lecturer);
					try {
						sendVerificationEmail(lecturer, request.getRequestURL().toString());
					} catch (Exception e) {
						e.printStackTrace();
						return "register/lecturer";
					}
					lecturerRepo.save(lecturer);
					model.addAttribute("title", "Account Created");
					model.addAttribute("text",
							"An email has been sent to your email address follow the instructions there to activate your account.");
					return "register/success";
				} else {
					model.addAttribute("addressError", "Please fill out all address fields or leave them all empty.");
				}
			}
		}
		lecturer.setPassword("");
		return "register/lecturer";
	}

	@RequestMapping(value = "/username", method = RequestMethod.GET)
	public ResponseEntity getUsername(@RequestParam("username") String username) {
		if (!userRepo.existsByUsername(username)) {
			return new ResponseEntity(HttpStatus.OK);
		} else {
			return new ResponseEntity(HttpStatus.BAD_REQUEST);
		}
	}

	@RequestMapping(value = "/email", method = RequestMethod.GET)
	public ResponseEntity getEmail(@RequestParam("email") String email) {
		if (!userRepo.existsByEmail(email)) {
			return new ResponseEntity(HttpStatus.OK);
		} else {
			return new ResponseEntity(HttpStatus.BAD_REQUEST);
		}
	}

	@ResponseBody
	@RequestMapping(value = "/keyConfirm", method = RequestMethod.POST)
	public String keyConfirm(HttpSession session, HttpServletResponse response, @RequestParam("key") String key) {
		User user = (User) session.getAttribute("auth");
		if ((GoogleAuthHandler.getTOTPCode(user.getSecretKey())).equals(key)) {
			user.setStatus(Status.Authorised);
			// for lecturer
			if (user.getRole().equals("lecturer")) {
				if (user.getStatus() == Status.Approved){
					user.setActivated(true);
				}
				else {
					session.setAttribute("lecturer",userRepo.save(user));
					return "/register/lecturer/upload";
				}
			} else {
				// for learner or Admin
				user.setActivated(true);
			}
			userRepo.save(user);
			session.removeAttribute("auth");
			response.setStatus(HttpServletResponse.SC_OK);
		} else {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		}
		return null;
	}

	@RequestMapping(value = "/lecturer/upload")
	public String uploadCvView(HttpSession session, Model model) {
		Lecturer lecturer = (Lecturer) session.getAttribute("lecturer");
		if (lecturer != null) {
			model.addAttribute("lecturer", lecturer);
			return "register/upload";
		} else {
			return "index";
		}
	}

	@RequestMapping(value = "/lecturer/upload", method = RequestMethod.POST)
	public String uploadCv(@RequestParam("file") MultipartFile file, HttpSession session, Model model) {
		Lecturer lecturer = (Lecturer) session.getAttribute("lecturer");
		try {
			File outFile = File.createTempFile("application", ".pdf");
			FileOutputStream fs = new FileOutputStream(outFile);
			fs.write(file.getBytes());
			fs.close();
			StorageHandler.upload(outFile, "administrator/application/" + lecturer.getUsername() + ".pdf");
			outFile.deleteOnExit();
			lecturer.setApplicationDate(new Date());
			lecturerRepo.save(lecturer);
		} catch (IOException e) {
			model.addAttribute("lecturer", lecturer);
			model.addAttribute("fromVerify", true);
			return "register/upload";
		}
		session.removeAttribute("lecturer");
		model.addAttribute("title", "Application Submitted");
		model.addAttribute("text",
				"Your application has successfully been submitted, you'll receive an email when your application is processed.");
		return "register/success";
	}

	@RequestMapping(value = "/verify", method = RequestMethod.GET)
	public String verifyEmail(@RequestParam("token") String token, HttpSession session, Model model) {
		VerificationToken verificationToken = verificationTokenRepo.findByToken(token);
		if (verificationToken != null) {
			if (!verificationToken.getExpiryDate().after(new Date())) {
				model.addAttribute("title", "Verification Key Expired");
				model.addAttribute("text", "Your verification key has expired, please request a new link");
				model.addAttribute("button", true);
				model.addAttribute("linkUrl", "/register/verify/new");
				model.addAttribute("linkText", "Resend Email");
				User user = verificationToken.getUser();
				session.setAttribute("token-user", user);
				return "register/success";
			}
			User user = verificationToken.getUser();
			user.setStatus(Status.Verified);
			if (user.getRole().equals("lecturer")) {
				session.setAttribute("lecturer", lecturerRepo.findById(user.getId()));
				model.addAttribute("lecturer", user);
				model.addAttribute("fromVerify", true);
				return "register/upload";
			}
			model.addAttribute("title", "Account Verified");
			model.addAttribute("text",
					"Your account has been successfully verified, please authenticate your account.");
			model.addAttribute("button", true);
			model.addAttribute("linkUrl", "/register/authenticate");
			model.addAttribute("linkText", "Authenticate Account");
			session.setAttribute("auth", user);
			userRepo.save(user);
			return "register/success";
		}
		model.addAttribute("title", "Verification Key Expired");
		model.addAttribute("text", "The verification key is invalid");
		return "register/success";
	}

	@RequestMapping(value = "/verify/new")
	public String newVerification(HttpServletRequest request, HttpSession session, Model model) {
		User user = (User) session.getAttribute("token-user");
		session.removeAttribute("token-user");
		if (user == null) {
			return "index";
		}
		try {
			sendVerificationEmail(user, request.getRequestURL().toString());
		} catch (Exception e) {
			e.printStackTrace();
			return "index";
		}
		userRepo.save(user);
		model.addAttribute("title", "Verification Resent");
		model.addAttribute("text",
				"An email has been sent to your email address follow the instructions there to activate your account.");
		return "register/success";
	}

	@RequestMapping(value = "/authenticate", method = RequestMethod.GET)
	public String authenticate(HttpSession session, Model model) {
		if (session.getAttribute("auth") == null) {
			return "redirect:/";
		}
		User user = (User) session.getAttribute("auth");
		if (user.getStatus() == Status.Authorised || user.getStatus() == Status.Approved) {
			model.addAttribute("title", "Account already authenticated");
			model.addAttribute("text", "You have already authenticated this account.");
			return "register/success";
		}
		model.addAttribute("title", "Authenticate");
		model.addAttribute("image", true);
		model.addAttribute("authImg", "https://learnist.s3.amazonaws.com/" + System.getProperty("name") + "/"
				+ user.getRole() + "/user/" + user.getUsername() + "/barcode.png");
		return "register/success";
	}

	private void sendVerificationEmail(User user, String url) throws Exception {
		VerificationToken verificationToken = new VerificationToken(user);
		while (verificationTokenRepo.findUserByToken(verificationToken.getToken()) != null) {
			verificationToken = new VerificationToken();
		}
		user.setVerificationToken(verificationToken);
		userRepo.save(user);
		MailHandler mail = new MailHandler("no-reply@learnist.cf", user, MailHandler.VERIFY, url);
		mail.sendMail();
	}
}
