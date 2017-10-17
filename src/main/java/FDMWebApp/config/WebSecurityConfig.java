package FDMWebApp.config;

import FDMWebApp.auth.CustomAuthenticationFailureHandler;
import FDMWebApp.auth.CustomAuthenticationHandler;
import FDMWebApp.auth.CustomAuthenticationProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

/**
 * Created by Rusty on 01/03/2017.
 */
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private CustomAuthenticationProvider authProvider;

	@Autowired
	private CustomAuthenticationHandler authHandler;

	@Autowired
	private CustomAuthenticationFailureHandler failureHandler;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(authProvider);
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests().antMatchers("/", "/register/**", "/login/**", "/public/**", "/webjars/**").permitAll()
				.antMatchers("/learner/**").hasRole("LEARNER").antMatchers("/lecturer/**").hasRole("LECTURER")
				.antMatchers("/administrator/**").hasRole("ADMINISTRATOR").antMatchers("/user/**", "/course/**")
				.hasRole("USER").and().formLogin().loginProcessingUrl("/login-request").loginPage("/login")
				.successHandler(authHandler).failureHandler(failureHandler).and().logout().logoutUrl("/logout")
				.logoutSuccessUrl("/").permitAll().and().exceptionHandling().accessDeniedPage("/404").and().headers()
				.frameOptions().sameOrigin();
	}
}
