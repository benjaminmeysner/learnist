package FDMWebApp.aws;

import FDMWebApp.controller.error.InvalidTypeException;
import FDMWebApp.domain.User;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * Created by Rusty on 05/03/2017.
 */
public class MailHandler {

	private String from;
	private User user;
	private int type;
	private String path;

	public static final int VERIFY = 0;
	public static final int RESETPASS = 1;
	public static final int NEWADMIN = 2;

	static final String SMTP_USERNAME = "AKIAJRX4LWCDEE5CLJ5Q";
	static final String SMTP_PASSWORD = "Ajv3qxRkMT0RuJqkZbeV+0BFZa5klTGCOGu1J99uMxiF";
	static final String HOST = "email-smtp.eu-west-1.amazonaws.com";
	static final int PORT = 25;

	public MailHandler(String from, User user, int type, String path) {
		this.from = from;
		this.user = user;
		this.type = type;
		int index = 0;
		for (int i = 9; i < path.length(); i++) {
			if (path.charAt(i) == '/') {
				index = i;
				break;
			}
		}
		this.path = path.substring(0, index);
	}

	private String getSubject(int type) throws InvalidTypeException {
		String subject;
		switch (type) {
			case VERIFY:
				subject = "Learnist Email Verification Request";
				break;
			case RESETPASS:
				subject = "Learnist Password Reset Request";
				break;
			case NEWADMIN:
				subject = "Learnist Set Password";
				break;
			default:
				subject = null;
		}
		if (subject == null) {
			throw new InvalidTypeException(type);
		}
		return subject;
	}

	private String getBody(int type) throws InvalidTypeException {
		String body = "Dear " + user.getUsername() + ",\n\n";
		String link = path + "/register/verify?token=" + user.getVerificationToken();
		switch (type) {
			case VERIFY:
				body += "We have received a request to activate this email address for the site learnist.cf. If this wasn\'t you please ignore this email, if it was select the verification link below.\n\n"
						+ link;
				break;
			case RESETPASS:
				body += "We have received a request to reset the password for your Learnist account. If this wasn't you please ignore this email, if it was select the link below.\n\n"
						+ link;
				break;
			case NEWADMIN:
				body += "We have received a request to create a password for your Learnist account. If this wasn't you please ignore this email, if it was select the link below.\n\n"
						+ link;
				break;
			default:
				body = null;
		}
		if (body == null) {
			throw new InvalidTypeException(type);
		} else {
			body += "\n\n" + "Sincerely,\nThe Learnist Team";
			return body;
		}
	}

	public void sendMail() throws Exception {
		Properties props = System.getProperties();
		props.put("mail.transport.protocol", "smtps");
		props.put("mail.smtp.port", PORT);

		// Set properties indicating that we want to use STARTTLS to encrypt the
		// connection.
		// The SMTP session will begin on an unencrypted connection, and then
		// the client
		// will issue a STARTTLS command to upgrade to an encrypted connection.
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.starttls.required", "true");

		// Create a Session object to represent a aws session with the specified
		// properties.
		Session session = Session.getDefaultInstance(props);

		// Create a message with the specified information.
		MimeMessage msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress(from));
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(user.getEmail()));
		msg.setSubject(this.getSubject(type));
		msg.setContent(this.getBody(type), "text/plain");
		// Create a transport.
		Transport transport = session.getTransport();
		// Send the message.
		try {
			// Connect to Amazon SES using the SMTP username and password you
			// specified above.
			transport.connect(HOST, SMTP_USERNAME, SMTP_PASSWORD);

			// Send the email.
			transport.sendMessage(msg, msg.getAllRecipients());
		} catch (Exception ex) {
			System.out.println("Error message: " + ex.getMessage());
		} finally {
			// Close and terminate the connection.
			transport.close();
		}
	}
}