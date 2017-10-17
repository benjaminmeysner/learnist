package FDMWebApp.controller.error;

import org.springframework.security.core.AuthenticationException;

/**
 * Created by Rusty on 18/03/2017.
 */
public class AccountNotVerifiedException extends AuthenticationException {

	public AccountNotVerifiedException(String msg) {
		super(msg);
	}

	public AccountNotVerifiedException(String msg, Throwable t) {
		super(msg, t);
	}
}
