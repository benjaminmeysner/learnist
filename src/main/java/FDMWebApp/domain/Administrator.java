package FDMWebApp.domain;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 * Created by Dani on 01/03/2017.
 */

@Entity
@DiscriminatorValue("administrator")
@Table(name = "administrator")
public class Administrator extends User {

	@Column(name = "`access-level`")
	@NotNull
	private Integer accessLevel;

	public Administrator() {
		super();
	}

	@Override
	public String getRole() {
		return (role == null) ? "administrator" : role;
	}

	public Administrator(Integer accessLevel) {
		this.accessLevel = accessLevel;
	}

	public Integer getAccessLevel() {
		return accessLevel;
	}

	public void setAccessLevel(Integer accessLevel) {
		this.accessLevel = accessLevel;
	}

}