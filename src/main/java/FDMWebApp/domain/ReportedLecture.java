package FDMWebApp.domain;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * Created by dani1 on 30/04/2017.
 */
@Entity
@DiscriminatorValue("lecture")
@Table(name = "reported_lecture")
public class ReportedLecture extends SupportTicket {

	@OneToOne
	private Course course;

	@OneToOne
	private Lesson lesson;

	public ReportedLecture() {
		super();
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public Lesson getLesson() {
		return lesson;
	}

	public void setLesson(Lesson lesson) {
		this.lesson = lesson;
	}
}
