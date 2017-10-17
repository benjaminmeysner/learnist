package FDMWebApp.domain;

import javax.persistence.*;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

/**
 * Created by Rusty on 05/03/2017.
 */
@Entity
@Table(name = "verification_token")
public class VerificationToken {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(name = "`token`")
	private String token;

	@OneToOne(mappedBy = "verificationToken")
	private User user;

	@Column(name = "`created-on`")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createdOn = new Date();

	public VerificationToken() {

	}

	public VerificationToken(User user) {
		this.user = user;
		this.token = UUID.randomUUID().toString();
	}

	public Date getExpiryDate() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(this.createdOn);
		cal.add(Calendar.DAY_OF_YEAR, 1);
		return cal.getTime();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	@Override
	public String toString() {
		return token;
	}

}
