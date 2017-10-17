package FDMWebApp;

import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.junit.Assert.assertTrue;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

/**
 * Created by Rusty on 31/03/2017.
 */
public class ResetPassword extends State {
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).apply(springSecurity()).build();
		setServer();
		userRepo.deleteAll();
	}

	@Given("^the user enters a password \"([^\"]*)\" and confirmation \"([^\"]*)\".")
	public void user_enters_password_and_confirm(String password, String confirm) {
		learner = learnerRepo.findByUsername("learner");
		this.password = password;
		this.confirm = confirm;
	}

	@When("^the user clicks the password reset submit button$")
	public void the_user_clicks_the_login_submit_button() throws Throwable {
		result = this.mockMvc
				.perform(post("/login/new-password")
						.with(csrf())
						.sessionAttr("reset", learner)
						.param("password", password)
						.param("confirm", confirm));

	}

	@Then("^the user's password is \"([^\"]*)\".")
	public void users_password_is(String password) {
		learner = learnerRepo.findByUsername("learner");
		assertTrue(BCrypt.checkpw(password, learner.getPassword()));
	}

}
