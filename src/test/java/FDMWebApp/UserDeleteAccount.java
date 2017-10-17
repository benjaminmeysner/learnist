package FDMWebApp;

import FDMWebApp.domain.Learner;
import FDMWebApp.repository.LearnerRepo;
import cucumber.api.PendingException;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.junit.Assert.assertEquals;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;

/**
 * Created by dani1 on 29/04/2017.
 */
public class UserDeleteAccount extends State {
	@Autowired
	LearnerRepo learnerRepo;

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).apply(springSecurity()).build();
		setServer();
		userRepo.deleteAll();
	}

	@Given("^a registered learner with username \"([^\"]*)\", email \"([^\"]*)\" and password \"([^\"]*)\", firstname \"([^\"]*)\" and surname \"([^\"]*)\"$")
	public void aRegisteredLearnerWithUsernameEmailAndPasswordFirstnameAndSurname(String username, String email, String
			password, String firstname, String surname) throws Throwable {
		Learner learner = new Learner();
		learner.setUsername(username);
		learner.setEmail(email);
		learner.setPassword(password);
		learnerRepo.save(learner);
	}

	@When("^the learner clicks the delete account button$")
	public void theLearnerClicksTheDeleteAccountButton() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		throw new PendingException();
	}

	@And("^the learner clicks the No button$")
	public void theLearnerClicksTheNoButton() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		throw new PendingException();
	}

	@Then("^the learner's account is not deleted$")
	public void theLearnerSAccountIsNotDeleted() throws Throwable {
		assertEquals(1, learnerRepo.countByUsername(username));
	}

	@And("^the learner clicks the Yes button$")
	public void theLearnerClicksTheYesButton() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		throw new PendingException();
	}

	@Then("^an email is sent to \"([^\"]*)\"$")
	public void anEmailIsSentTo(String arg0) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		throw new PendingException();
	}

	@Given("^learner with username \"([^\"]*)\"$")
	public void learnerWithUsername(String arg0) throws Throwable {
		this.username = username;
	}
}
