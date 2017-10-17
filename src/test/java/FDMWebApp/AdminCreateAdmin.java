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
 * Created by erustus on 16/04/17.
 */
public class AdminCreateAdmin extends State {

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).apply(springSecurity()).build();
		setServer();
		userRepo.deleteAll();
	}

	@Given("^an access level of \"([^\"]*)\".$")
	public void access_level(Integer accessLevel) throws Throwable {
		this.accessLevel = accessLevel;
	}

	@When("^the user clicks the add administrator submit button.$")
	public void register_admin() throws Throwable {
		String accessLevel = (this.accessLevel == null) ? "" : this.accessLevel.toString();
		result = mockMvc.perform(post("/administrator/user/administrator/add")
				.with(csrf())
				.with(authentication(auth))
				.param("username", username)
				.param("email", email)
				.param("password", password)
				.param("accessLevel", accessLevel));
	}
}
