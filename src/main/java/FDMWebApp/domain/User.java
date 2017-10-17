package FDMWebApp.domain;

import FDMWebApp.aws.StorageHandler;
import googleAuthenticatorHandler.GoogleAuthHandler;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static javax.persistence.CascadeType.ALL;

/**
 * Created by Dani on 21/02/17.
 */
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "role")
@Table(name = "user")
public class User implements Comparable<User> {

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "`id`")
	private long id;

	@Column(name = "role", insertable = false, updatable = false)
	String role;

	@Column(name = "`username`", unique = true)
	@NotEmpty
	@Size(min = 6, max = 16)
	private String username;

	@Column(name = "`email`", unique = true)
	@NotEmpty
	@Email
	private String email;

	@Column(name = "`password`")
	@NotEmpty
	@Size(min = 6)
	private String password;

	@ManyToOne(fetch = FetchType.LAZY, cascade = ALL)
	@JoinColumn(name = "`address`")
	@NotFound(action = NotFoundAction.IGNORE)
	private Address address;

	@Column(name = "`status`", nullable = false)
	@Enumerated(EnumType.STRING)
	private Status status;

	@OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
	@NotFound(action = NotFoundAction.IGNORE)
	@JoinColumn(name = "`token`")
	private VerificationToken verificationToken;

	@Column(name = "`secret-key`")
	private String secretKey;

	@Column(name = "`activated`")
	private boolean activated;

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "id")
	private Set<SupportTicket> supportTicket = new HashSet<>();

	@Fetch(value = FetchMode.SUBSELECT)
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "users")
	private List<Notification> notifications = new ArrayList<>();

	public User() {
		status = Status.Unverified;
	}

	public User(String username, String email, String password, Address address, Status status) {

		this.username = username;
		this.email = email;
		this.password = password;
		this.address = address;
		this.status = status;
	}

	public User(long id, String username, String email, String password, Address address, Status status) {

		this.id = id;
		this.username = username;
		this.email = email;
		this.password = password;
		this.address = address;
		this.status = status;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public void setStatus(String status) {
		this.status = Status.valueOf(status);
	}

	public VerificationToken getVerificationToken() {
		return verificationToken;
	}

	public void setVerificationToken(VerificationToken verificationToken) {
		this.verificationToken = verificationToken;
	}

	public String getSecretKey() {
		return secretKey;
	}

	public void setSecretKey(String secretKey) {
		this.secretKey = secretKey;
	}

	public boolean isActivated() {
		return activated;
	}

	public void setActivated(boolean activated) {
		this.activated = activated;
	}

	public void setBarcode() {
		String key = (this.getSecretKey() == null) ? GoogleAuthHandler.getRandomSecretKey() : this.getSecretKey();
		this.setSecretKey(key);
		String barcode = GoogleAuthHandler.getGoogleAuthenticatorBarCode(this.secretKey, this.email);
		try {
			File outFile = File.createTempFile(this.getUsername(), ".png");
			GoogleAuthHandler.createQRCode(barcode, outFile.getAbsolutePath());
			StorageHandler.upload(outFile, getRole() + "/user/" + this.getUsername() + "/barcode.png");
			outFile.deleteOnExit();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Set<SupportTicket> getSupportTickets() {
		return supportTicket;
	}

	public void setSupportTickets(Set<SupportTicket> supportTickets) {
		this.supportTicket = supportTickets;
	}

	public List<Notification> getNotifications() {
		Collections.sort(notifications);
		return notifications;
	}

	public void setNotifications(List<Notification> notifications) {
		this.notifications = notifications;
	}

	public User removeNotification(Notification notification){
		notifications.remove(notification);
		return this;
	}
	@Override
	public String toString() {
		return "User{" + "id=" + id + "\n username='" + username + '\'' + "\n email='" + email + '\'' + "\n password='"
				+ password + '\'' + ((address == null) ? ", address= null" : address.toString()) + "\n status=" + status
				+ '}';
	}

	@Override
	public int compareTo(User user) {
		return username.compareTo(user.getUsername());
	}
}
