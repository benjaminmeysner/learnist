package FDMWebApp;

import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.junit.Assert.assertEquals;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

/**
 * Created by Dani on 02/03/2017.
 */

public class RegisterNewUser extends State {

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).apply(springSecurity()).build();
		setServer();
	}

	@Given("^there are no users.")
	public void no_users() {
		userRepo.deleteAll();
	}

	@Given("^firstname \"([^\"]*)\" and surname \"([^\"]*)\"$")
	public void a_user_with_details(String firstname, String lastname) throws Throwable {
		this.firstname = firstname;
		this.surname = lastname;
	}

	@Given("^a user with username \"([^\"]*)\", email \"([^\"]*)\" and password \"([^\"]*)\".$")
	public void a_user_with_details(String username, String email, String password) throws Throwable {
		this.username = username;
		this.email = email;
		this.password = password;
	}

	@When("^the user clicks the register \"([^\"]*)\" submit button$")
	public void the_user_clicks_the_register_learner_submit_button(String url) throws Throwable {
		result = this.mockMvc
				.perform(post("/register/" + url).with(csrf())
						.param("username", username)
						.param("email", email)
						.param("password", password)
						.param("firstName", firstname)
						.param("surname", surname));

	}

	@Then("^there is an account with the username \"([^\"]*)\" and email \"([^\"]*)\" in the db.$")
	public void an_account_in_db(String username, String email) throws Throwable {

	}

	@Then("^the returned view is (.+)$")
	public void the_returned_view(String view) throws Throwable {
		result.andExpect(status().isOk()).andExpect(view().name(view));
	}

	@Then("^there [\\w]{2,3} ([\\d]) [\\w]{7,8} in the db.$")
	public void accounts_in_db(int i) throws Throwable {
		assertEquals(i, userRepo.count());
	}
}
