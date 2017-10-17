package FDMWebApp;

import FDMWebApp.domain.Administrator;
import FDMWebApp.domain.Status;
import FDMWebApp.domain.User;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import googleAuthenticatorHandler.GoogleAuthHandler;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.junit.Assert.assertEquals;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;

public class TwoFactorAuthentication extends State {

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).apply(springSecurity()).build();
		setServer();
		userRepo.deleteAll();
	}

	@Given("^an activated learner with username \"([^\"]*)\", email \"([^\"]*)\" and password \"([^\"]*)\"$")
	public void activated_registered_learner(String arg1, String arg2, String arg3) throws Throwable {
		result = this.mockMvc.perform(post("/register/learner").with(csrf())
				.param("username", arg1)
				.param("email", arg2)
				.param("password", arg3));
		learner = learnerRepo.findByUsername(arg1);
		learner.setStatus(Status.Authorised);
		learner.setActivated(true);
		learnerRepo.save(learner);
	}

	@Given("^an activated lecturer with username \"([^\"]*)\", email \"([^\"]*)\", password \"([^\"]*)\", firstname \"([^\"]*)\" and surname \"([^\"]*)\"$")
	public void activated_registered_lecturer(String arg1, String arg2, String arg3, String arg4, String arg5)
			throws Throwable {
		result = this.mockMvc.perform(post("/register/lecturer").with(csrf()).param("username", arg1)
				.param("email", arg2).param("password", arg3).param("firstName", arg4).param("surname", arg5));
		lecturer = lecturerRepo.findByUsername(arg1);
		lecturer.setStatus(Status.Approved);
		lecturer.setActivated(true);
		lecturerRepo.save(lecturer);
	}

	@Given("^an activated administrator with username \"([^\"]*)\", email \"([^\"]*)\", password \"([^\"]*)\" and access level \"([^\"]*)\"$")
	public void activated_registered_administrator(String arg1, String arg2, String arg3, Integer arg4) throws Throwable {
		administrator = new Administrator();
		administrator.setUsername(arg1);
		administrator.setEmail(arg2);
		administrator.setPassword(BCrypt.hashpw(arg3, BCrypt.gensalt()));
		administrator.setStatus(Status.Authorised);
		administrator.setActivated(true);
		administrator.setAccessLevel(arg4);
		administrator.setBarcode();
		administratorRepo.save(administrator);
	}

	@Given("^the user enters the key \"([^\"]*)\"$")
	public void user_enters_key(String key) throws Throwable {
		username = learner.getUsername();
		this.password = key;
	}

	@Given("^\"([^\"]*)\" enters the correct key")
	public void learner_enters_correct_key(String username) throws Throwable {
		this.username = username;
		User user = userRepo.findByUsername(username);
		this.password = GoogleAuthHandler.getTOTPCode(user.getSecretKey());
	}

	@When("^the user clicks the 2FA submit button$")
	public void user_2fa_submit() throws Throwable {
		result = mockMvc.perform(post("/login-request").with(csrf())
				.param("username", username)
				.param("password", password));
	}

	@Then("^the user will not be logged in$")
	public void user_not_logged_in() throws Throwable {
		result.andExpect(redirectedUrl("/login"));
	}

	@Then("^the user will be logged in$")
	public void user_logged_in() throws Throwable {
		User user = userRepo.findByUsername(username);
		assertEquals(user.getId(), ((User) result.andReturn().getRequest().getSession().getAttribute("user")).getId());
	}

	@Then("^the session will have an error message saying \"([^\"]*)\".$")
	public void the_user_will_receive_an_error_message_saying(String arg1) throws Throwable {
		assertEquals(arg1, result.andReturn().getRequest().getSession().getAttribute("error"), arg1);
	}
}

