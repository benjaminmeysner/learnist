package FDMWebApp.domain;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by dani1 on 30/04/2017.
 */
@Entity@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "reported")
@Table(name = "ticket")
public class SupportTicket {
	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "`id`")
	private long id;

	@Column(name = "`code`")
	private Timestamp code;

	@Column(name = "`description`", nullable = false)
	private String description;

	@Column(name = "`reason`")
	private SupportCategory supportReason;

	@Column(name = "`status`")
	private Status status;

	public SupportTicket() {
		this.code = new Timestamp(System.currentTimeMillis());
		this.status = Status.Unverified;
	}

	public long getId() {
		return id;
	}

	public Timestamp getCode() {
		return code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public SupportCategory getSupportReason() {
		return supportReason;
	}

	public void setSupportReason(SupportCategory supportReason) {
		this.supportReason = supportReason;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}
}
