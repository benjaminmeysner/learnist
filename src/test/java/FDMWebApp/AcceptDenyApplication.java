package FDMWebApp;

import FDMWebApp.auth.CustomAuthenticationProvider;
import FDMWebApp.domain.Status;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.authentication;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

/**
 * Created by erustus on 15/04/17.
 */
public class AcceptDenyApplication extends State {

	Boolean accepted;

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).apply(springSecurity()).build();
		setServer();
		userRepo.deleteAll();
	}

	@Given("^\"([^\"]*)\" is logged in.$")
	public void user_is_logged_in(String username) throws Throwable {
		auth = new UsernamePasswordAuthenticationToken(username, "", CustomAuthenticationProvider.getAuthorities(userRepo.findByUsername(username)));
	}

	@Given("^\"([^\"]*)\"\'s application is being viewed.$")
	public void application_viewed(String username) throws Throwable {
		this.username = username;
	}

	@When("^the administrator clicks the (\\w+) button.$")
	public void application_accepted(String accept) throws Throwable {
		accepted = accept.equals("accept");
		result = mockMvc.perform(post("/administrator/users/lecturers/application")
				.with(csrf())
				.with(authentication(auth))
				.param("username", username)
				.param("approve", accepted.toString()));
	}

	@Then("^\"([^\"]*)\"\'s status is \"([^\"]*)\".$")
	public void user_status(String username, Status status) throws Throwable {
		assertEquals(status, userRepo.findByUsername(username).getStatus());
	}

	@Then("^\"([^\"]*)\"\'s account is activated.$")
	public void user_activated(String username) throws Throwable {
		assertTrue(userRepo.findByUsername(username).isActivated());
	}

	@Then("^\"([^\"]*)\"\'s account is not activated.$")
	public void user_not_activated(String username) throws Throwable {
		assertFalse(userRepo.findByUsername(username).isActivated());
	}

}