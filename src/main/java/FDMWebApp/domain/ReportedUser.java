package FDMWebApp.domain;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by dani1 on 30/04/2017.
 */
@Entity
@DiscriminatorValue("user")
@Table(name = "reported_user")
public class ReportedUser extends SupportTicket{

	public ReportedUser() {
		super();
	}

	@Column(name = "`username`")
	private String username;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
}
