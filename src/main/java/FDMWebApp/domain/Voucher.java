package FDMWebApp.domain;

import javax.persistence.*;

/**
 * Created by Dan B on 15/04/2017.
 */
@Entity
@Table(name = "voucher")
public class Voucher {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(name = "code")
	private String code;

	@Column(name = "value")
	private double value;

	// Indicates if voucher code is for a set value or for a free course of any
	// value on signup
	@Column(name = "signup")
	private boolean signup;

	@OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(nullable = true, name = "user")
	private User user;

	public Voucher() {
	}

	public Voucher(User user) {
		code = generateCode();
		signup = true;
		value = -1;
		this.user = user;
	}

	public Voucher(Double value) {
		code = generateCode();
		signup = false;
		this.value = value;
		user = null;
	}

	public Voucher(Double value, User user) {
		code = generateCode();
		signup = false;
		this.value = value;
		this.user = user;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String generateCode() {
		// Write code generation logic
		return "";
	}

	public void setCode(String code) {
		this.code = code;
	}

	public boolean getSignup() {
		return signup;
	}

	public void setSignup(boolean signup) {
		this.signup = signup;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
