package FDMWebApp;

import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.junit.Assert.assertEquals;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

public class ViewHomePage extends State {

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).apply(springSecurity()).build();
		setServer();
	}

	@Given("^user is not logged in$")
	public void user_is_not_logged_in() throws Throwable {
		mockMvc.perform(post("/logout").with(csrf()));
	}

	@When("^the user navigates to \"([^\"]*)\"$")
	public void the_user_navigates_to(String request) throws Throwable {
		result = this.mockMvc.perform(get(request));
	}

	@Then("^the user is redirected to \"([^\"]*)\"$")
	public void user_is_sent_to(String url) throws Throwable {
		String redirect = result.andReturn().getResponse().getRedirectedUrl();
		try {
			assertEquals(server + url, redirect);
		} catch (AssertionError e) {
			assertEquals(url, redirect);
		}
	}

}
