package FDMWebApp.transfer;

import FDMWebApp.domain.Status;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by erustus on 09/04/17.
 */
public class UserSearch {

	private String username;
	private String role;
	private Set<Status> status = new HashSet<>();
	private Boolean activated;

	public UserSearch() {
		status.addAll(Arrays.asList(Status.values()));
		status.remove(Status.Submitted);
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Set<Status> getStatus() {
		return status;
	}

	public void setStatus(Set<Status> status) {
		this.status = status;
	}

	public Boolean getActivated() {
		return activated;
	}

	public void setActivated(Boolean activated) {
		this.activated = activated;
	}

}
