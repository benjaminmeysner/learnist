package FDMWebApp;

import FDMWebApp.domain.Administrator;
import FDMWebApp.domain.Lecturer;
import FDMWebApp.domain.Status;
import FDMWebApp.domain.User;
import FDMWebApp.domain.VerificationToken;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

/**
 * Created by Dan B on 10/03/2017.
 */

public class Login extends State {

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).apply(springSecurity()).build();
		setServer();
		userRepo.deleteAll();
	}

	@Given("^a registered learner with username \"([^\"]*)\", email \"([^\"]*)\" and password \"([^\"]*)\"$")
	public void a_registered_learner(String arg1, String arg2, String arg3) throws Throwable {
		username = arg1;
		result = this.mockMvc.perform(post("/register/learner").with(csrf()).param("username", arg1)
				.param("email", arg2).param("password", arg3));
	}

	@Given("^a registered lecturer with username \"([^\"]*)\", email \"([^\"]*)\", password \"([^\"]*)\", firstname \"([^\"]*)\" and surname \"([^\"]*)\"$")
	public void a_registered_lecturer(String arg1, String arg2, String arg3, String arg4, String arg5)
			throws Throwable {
		username = arg1;
		result = this.mockMvc.perform(post("/register/lecturer").with(csrf()).param("username", arg1)
				.param("email", arg2).param("password", arg3).param("firstName", arg4).param("surname", arg5));
	}

	@Given("^a registered administrator with username \"([^\"]*)\", email \"([^\"]*)\" and password \"([^\"]*)\"$")
	public void a_registered_administrator(String arg1, String arg2, String arg3) throws Throwable {
		administrator = new Administrator();
		administrator.setUsername(arg1);
		administrator.setEmail(arg2);
		administrator.setPassword(BCrypt.hashpw(arg3, BCrypt.gensalt()));
		administrator.setStatus(Status.Authorised);
		administrator.setActivated(false);
		administrator.setAccessLevel(0);
		userRepo.save(administrator);
		administrator.setVerificationToken(new VerificationToken(administrator));
		userRepo.save(administrator);
	}

	@Given("^the user enters a username \"([^\"]*)\" and password \"([^\"]*)\"$")
	public void user_enters_username_and_password(String username, String password) throws Throwable {
		this.username = username;
		this.password = password;
	}

	@When("^the user clicks the login submit button$")
	public void the_user_clicks_the_login_submit_button() throws Throwable {
		result = this.mockMvc
				.perform(post("/login").with(csrf()).param("username", username).param("password", password));

	}

	@Then("^the user will receive an error message \"([^\"]*)\", saying \"([^\"]*)\"\\.$")
	public void the_user_will_receive_an_error_message_saying(String messageName, String message) throws Throwable {
		result.andExpect(model().attribute(messageName, message));
	}

	@Given("^the user's account is not activated$")
	public void the_user_s_account_is_not_activated() throws Throwable {
		User user = userRepo.findByUsername(username);
		user.setActivated(false);
		userRepo.save(user);
	}

	@Given("^the user's account is activated$")
	public void the_learner_s_account_is_activated() throws Throwable {
		User user = userRepo.findByUsername(username);
		user.setActivated(true);
		userRepo.save(user);
	}

	@Given("^the user's account is \"([^\"]*)\"$")
	public void the_user_s_account_is_(String status) throws Throwable {
		User user = userRepo.findByUsername(username);
		user.setStatus(status);
		userRepo.save(user);
	}

	@Given("^the lecturer's account is approved$")
	public void th_lecturers_account_is_approved() throws Throwable {
		Lecturer user = lecturerRepo.findByUsername(username);
		user.setStatus(Status.Approved);
		userRepo.save(user);
	}

}
