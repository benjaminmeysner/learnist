package FDMWebApp;

import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.authentication;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

/**
 * Created by erustus on 15/04/17.
 */
public class AdminDeactivatesAccount extends State {

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).apply(springSecurity()).build();
		setServer();
		userRepo.deleteAll();
	}

	@Given("^\"([^\"]*)\"\'s account is being viewed.$")
	public void account_viewed(String username) throws Throwable {
		this.username = username;
	}

	@Given("^the user's account is set to deactivated.$")
	public void account_deactivated() throws Throwable {
		this.activated = false;
	}

	@When("^the administrator clicks the user edit submit button.$")
	public void user_edit_submit() throws Throwable {
		String role = userRepo.findByUsername(username).getRole();
		result = mockMvc.perform(post("/administrator/user/" + role + "/edit")
				.with(csrf())
				.with(authentication(auth))
				.sessionAttr("viewUser", userRepo.findByUsername(username))
				.param("username", username)
				.param("activated", activated.toString()));
	}
}
