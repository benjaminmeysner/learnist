package FDMWebApp;

import FDMWebApp.config.DbConfig;
import FDMWebApp.config.WebConfig;
import FDMWebApp.domain.Administrator;
import FDMWebApp.domain.Learner;
import FDMWebApp.domain.Lecturer;
import FDMWebApp.repository.AddressRepo;
import FDMWebApp.repository.AdministratorRepo;
import FDMWebApp.repository.LearnerRepo;
import FDMWebApp.repository.LecturerRepo;
import FDMWebApp.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;


@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ContextConfiguration(classes = {Application.class, WebConfig.class, DbConfig.class})
public class State {

	@Autowired
	WebApplicationContext wac;

	static MockMvc mockMvc;
	static ResultActions result;
	static String server;

	@Autowired
	UserRepo userRepo;
	@Autowired
	AddressRepo addressRepo;
	@Autowired
	LearnerRepo learnerRepo;
	@Autowired
	LecturerRepo lecturerRepo;
	@Autowired
	AdministratorRepo administratorRepo;

	static Learner learner;
	static Lecturer lecturer;
	static Administrator administrator;

	static UsernamePasswordAuthenticationToken auth;

	static String username, password, email, firstname, surname, confirm;

	static Integer accessLevel;

	static Boolean activated;

	void setServer() {
		try {
			server = "http://" + this.mockMvc.perform(get("/")).andReturn().getRequest().getLocalName();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
