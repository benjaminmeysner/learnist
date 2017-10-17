package FDMWebApp.domain;

import FDMWebApp.transfer.pagination.Pagination;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.persistence.CascadeType;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by Dani on 01/03/2017.
 */
@Entity
@DiscriminatorValue("learner")
@Table(name = "learner")
public class Learner extends User {

	@ManyToMany(cascade = CascadeType.ALL, mappedBy = "learners", fetch = FetchType.EAGER)
	private Set<Course> courses = new HashSet<>();

	public Learner() {
		super();
	}

	@Override
	public String getRole() {
		return (role == null) ? "learner" : role;
	}

	public Set<Course> getCourses() {
		return courses;
	}

	public boolean isEnrolled(Course course) {
		return courses.contains(course);
	}

	public Pagination getCoursePagination() {
		List<Course> courseList = new ArrayList<>();
		courseList.addAll(courses);
		return new Pagination("/course/user" + getUsername(), new PageImpl(courseList, new PageRequest(0, Pagination.SIZE), courses.size()));
	}

}
