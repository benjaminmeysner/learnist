package FDMWebApp.transfer_objects;

import FDMWebApp.domain.Course;
import FDMWebApp.domain.Lecturer;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotNull;

/**
 * Created by Rusty on 23/04/2017.
 */
public class CourseFile {

	@NotNull
	private MultipartFile multipartFile;

	private Course course;

	public CourseFile() {

	}

	public CourseFile(Lecturer lecturer) {
		course = new Course(lecturer);
	}

	public MultipartFile getFile() {
		return multipartFile;
	}

	public void setFile(MultipartFile image) {
		this.multipartFile = image;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}
}
