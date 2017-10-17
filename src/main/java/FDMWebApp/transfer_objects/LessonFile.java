package FDMWebApp.transfer_objects;

import FDMWebApp.domain.Course;
import FDMWebApp.domain.Lesson;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by Rusty on 24/04/2017.
 */
public class LessonFile {

	Lesson lesson;
	MultipartFile file;

	public LessonFile() {

	}

	public LessonFile(Course course) {
		this.lesson = new Lesson(course);
	}

	public Lesson getLesson() {
		return lesson;
	}

	public void setLesson(Lesson lesson) {
		this.lesson = lesson;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

}
