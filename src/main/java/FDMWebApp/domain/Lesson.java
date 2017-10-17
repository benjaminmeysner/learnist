package FDMWebApp.domain;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Rusty on 23/04/2017.
 */
@Entity
@Table(name = "lesson")
public class Lesson implements Comparable<Lesson> {

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "`id`")
	private long id;


	@ManyToOne(cascade = CascadeType.MERGE)
	private Course course;

	@Column(name = "`order`", nullable = false)
	private Integer order;

	@Column(name = "`name`", nullable = false)
	@Size(min = 3, max = 30)
	private String name;

	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
	@JoinColumn(name = "`mainFile`", nullable = false)
	private SupportingFile mainFile;

	@JoinTable(name = "`lesson_files`", joinColumns = @JoinColumn(name = "`lesson_id`"), inverseJoinColumns = @JoinColumn(name = "`file_id`"))
	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST, orphanRemoval = true)
	@Size(max = 5)
	private List<SupportingFile> files = new ArrayList<>();

	public Lesson() {

	}

	public Lesson(Course course) {
		this.course = course;
		order = course.getLessons().size() + 1;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public long getId() {
		return id;
	}

	public int getOrder() {
		return order;
	}

	public void setOrder() {
		this.order = course.getLessons().size() + 1;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public SupportingFile getMainFile() {
		return mainFile;
	}

	public void setMainFile(SupportingFile mainFile) {
		this.mainFile = mainFile;
	}

	public List<SupportingFile> getFiles() {
		return files;
	}

	public void setFiles(List<SupportingFile> files) {
		this.files = files;
	}


	@Override
	public int compareTo(Lesson lesson) {
		return order.compareTo(lesson.getOrder());
	}
}