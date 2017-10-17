package FDMWebApp.domain;

import FDMWebApp.transfer.pagination.Pagination;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Dani on 01/03/2017.
 */
@Entity
@DiscriminatorValue("lecturer")
@Table(name = "lecturer")
public class Lecturer extends User {

	@Column(name = "`firstName`")
	@NotEmpty
	@Size(max = 30)
	private String firstName;

	@Column(name = "`surname`")
	@NotEmpty
	@Size(max = 50)
	private String surname;

	@Column(name = "`application`")
	@Temporal(TemporalType.DATE)
	private Date applicationDate = new Date();

	@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, mappedBy = "lecturer")
	private List<Course> courses = new ArrayList<>();

	public Lecturer() {
		super();
	}

	public Lecturer(String username, String email, String password, Address address, Status status, String firstName,
	                String surname) {
		super(username, email, password, address, status);
		this.firstName = firstName;
		this.surname = surname;
	}

	public Lecturer(String username, String email, String password, Address address, Status status, String firstName,
	                String surname, List<Course> courses) {
		super(username, email, password, address, status);
		this.firstName = firstName;
		this.surname = surname;
		this.courses = courses;
	}

	public Lecturer(long id, String username, String email, String password, Address address, Status status,
	                String firstName, String surname) {
		super(id, username, email, password, address, status);
		this.firstName = firstName;
		this.surname = surname;
	}

	public Lecturer(long id, String username, String email, String password, Address address, Status status,
	                String firstName, String surname, List<Course> courses) {
		super(id, username, email, password, address, status);
		this.firstName = firstName;
		this.surname = surname;
		this.courses = courses;
	}

	@Override
	public String getRole() {
		return (role == null) ? "lecturer" : role;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public Date getApplicationDate() {
		return applicationDate;
	}

	public void setApplicationDate(Date applicationDate) {
		this.applicationDate = applicationDate;
	}

	public List<Course> getCourses() {
		return courses;
	}

	public void setCourses(List<Course> courses) {
		this.courses = courses;
	}

	public void addCourse(Course course) {
		courses.add(course);
	}

	public Pagination getCoursePagination() {
		return new Pagination("/course/user/" + getUsername(),
				new PageImpl(courses, new PageRequest(0, Pagination.SIZE), courses.size()));
	}

}
