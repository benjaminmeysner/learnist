package FDMWebApp.domain;

public enum Status {
	/*
	 * Unverified is when the account is created but there is not email verified
	 * for the same. Verified means that the email has been verified Authorised
	 * means that user has set up the 2FA Approved means that the lecturer has
	 * been approved by the administrator. only for lecturer
	 * Submitted is in case of lessons for a particular course when they have been submitted but not approved by
	 * admins, or in case a ticket has been submit by a user.
	 * In_process is for tickets that user have submitted and are being checked by admin, Closed is when a ticket has
	  * been closed and nobody is working on it anymore.
	 */
	Unverified, Verified, Authorised, Approved, Submitted, In_Process, Closed;
}
