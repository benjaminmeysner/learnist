package FDMWebApp;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;
import org.springframework.test.context.web.WebAppConfiguration;

/**
 * Created by dani1 on 06/12/2016.
 */

@WebAppConfiguration
@RunWith(Cucumber.class)
@CucumberOptions(plugin = {"pretty",
		"html:build/cucumber-html-report"}, features = "src/test/resources", glue = "FDMWebApp")
public class CucumberTestRunner {
}
