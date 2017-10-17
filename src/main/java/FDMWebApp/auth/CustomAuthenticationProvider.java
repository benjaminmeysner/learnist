package FDMWebApp.auth;

import FDMWebApp.domain.User;
import FDMWebApp.repository.UserRepo;
import googleAuthenticatorHandler.GoogleAuthHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collection;

/**
 * Created by Rusty on 06/03/2017.
 */
@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	private UserRepo userRepo;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		User user = userRepo.findByUsername(authentication.getName());
		String key = authentication.getCredentials().toString();
		if (key.equals(GoogleAuthHandler.getTOTPCode(user.getSecretKey()))) {
			return new UsernamePasswordAuthenticationToken(user.getUsername(), key, getAuthorities(user));
		} else {
			throw new BadCredentialsException("Invalid Key: " + key, new
					Throwable(user.getUsername()));

		}

	}

	public static Collection<GrantedAuthority> getAuthorities(User user) {
		// make everyone ROLE_USER
		Collection<GrantedAuthority> grantedAuthorities = new ArrayList<GrantedAuthority>();
		GrantedAuthority grantedAuthority = new GrantedAuthority() {
			@Override
			public String getAuthority() {
				if (user.getRole().equals("learner"))
					return "ROLE_LEARNER";
				else if (user.getRole().equals("lecturer"))
					return "ROLE_LECTURER";
				else
					return "ROLE_ADMINISTRATOR";
			}
		};
		grantedAuthorities.add(grantedAuthority);
		grantedAuthority = new GrantedAuthority() {
			@Override
			public String getAuthority() {
				return "ROLE_USER";
			}
		};
		grantedAuthorities.add(grantedAuthority);
		return grantedAuthorities;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
}
