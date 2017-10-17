package FDMWebApp.domain;

import FDMWebApp.transfer.pagination.Pagination;
import org.hashids.Hashids;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * Created by Dan B on 24/02/17.
 */
@Entity
@Table(name = "course")
public class Course {

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "`id`")
	private long id;

	@Column(name = "`status`", nullable = false)
	@Enumerated(EnumType.STRING)
	private Status status = Status.Unverified;

	@Column(name = "`name`")
	@NotEmpty
	@Size(min = 6, max = 30)
	private String name;

	@OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
	@JoinColumn(name = "`image`")
	private SupportingFile image;

	@Column(name = "`difficulty`")
	private int difficulty;

	@Column(name = "`description`", nullable = false)
	@Size(max = 255)
	private String description = "";

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.DETACH)
	@JoinColumn(nullable = false)
	private Lecturer lecturer;

	@Fetch(value = FetchMode.SUBSELECT)
	@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "course")
	private List<Review> reviews = new ArrayList<>();

	@Column(name = "`rating`", nullable = false)
	private BigDecimal rating = BigDecimal.ZERO;

	@Column(name = "`subject`", nullable = false)
	private String subject;

	@Column(name = "`current-lesson`", nullable = false)
	private int currentLesson = 0;

	@Size(max = 5)
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<Tag> tags = new ArrayList<>();

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "course")
	private List<Lesson> lessons = new ArrayList<>();

	@Fetch(value = FetchMode.SELECT)
	@JoinTable(name = "`course_learners`", joinColumns = @JoinColumn(name = "id"), inverseJoinColumns = @JoinColumn(referencedColumnName = "id"))
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	private List<Learner> learners = new ArrayList<>();

	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
	@JoinColumn(name = "`meetup`")
	private Meetup meetup;

	public Course() {

	}

	public Course(Lecturer lecturer) {
		this.lecturer = lecturer;
	}

	public Course(String name, int difficulty, String description, Lecturer lecturer, String subject, List<Tag> tags) {
		this.name = name;
		this.difficulty = difficulty;
		this.description = description;
		this.lecturer = lecturer;
		this.subject = subject;
		this.tags = tags;
	}

	public long getId() {
		return id;
	}

	public String getCode() {
		Hashids hashids = new Hashids("learnist", 5);
		return hashids.encode(id);
	}

	public static long getIdFromCode(String code) {
		Hashids hashids = new Hashids("learnist", 5);
		Long id = -1L;
		try {
			id = hashids.decode(code)[0];
		} catch (ArrayIndexOutOfBoundsException ignored) {
		}
		return id;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public void setStatus(String status) {
		this.status = Status.valueOf(status);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public SupportingFile getImage() {
		return image;
	}

	public void setImage(SupportingFile image) {
		this.image = image;
	}

	public int getDifficulty() {
		return difficulty;
	}

	public void setDifficulty(int difficulty) {
		this.difficulty = difficulty;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Lecturer getLecturer() {
		return lecturer;
	}

	public void setLecturer(Lecturer lecturer) {
		this.lecturer = lecturer;
	}

	public List<Review> getReviews() {
		Collections.sort(reviews);
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public BigDecimal getRating() {
		return rating;
	}

	public void setRating(int reviewRating) {
		int count = reviews.size();
		//noinspection BigDecimalMethodWithoutRoundingCalled
		rating = ((rating.multiply(new BigDecimal(count)).add(new BigDecimal(reviewRating))).divide(new BigDecimal(count + 1)));
	}

	public void addReview(Review review) {
		setRating(review.getRating());
		reviews.add(review);
	}

	public boolean reviewedBy(Learner learner) {
		for (Review review : reviews) {
			if (review.getLearner() == learner)
				return true;
		}
		return false;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public Integer getCurrentLesson() {
		return currentLesson;
	}

	public void setCurrentLesson(Integer currentLesson) {
		this.currentLesson = currentLesson;
	}

	public void nextLesson() {
		currentLesson++;
	}

	public static List<String> getSubjects() {
		List<String> subjects = Arrays.asList("Computer Hardware", "Film and Video", "Music", "Networks", "Security", "Office Essentials", "Operating Systems", "Photography", "Software Development", "Web Development");

		Collections.sort(subjects);
		return subjects;
	}

	public List<Tag> getTags() {
		return tags;
	}

	public void setTags(List<Tag> tags) {
		this.tags = tags;
	}

	public void addLesson(Lesson lesson) {
		lessons.add(lesson);
	}

	public List<Lesson> getLessons() {
		Collections.sort(lessons);

		return lessons;
	}

	public void deleteLesson(Lesson lesson) {
		lessons.remove(lesson);
	}

	public List<Learner> getLearners() {
		return learners;
	}


	public void setLearners(List<Learner> learners){
		this.learners = learners;
	}

	public Meetup getMeetup(){
		return meetup;
	}

	public void setMeetup(Meetup meetup){
		this.meetup = meetup;
	}

	public boolean hasUser(User user){
		List<User> users = new ArrayList<>();
		users.addAll(learners);
		users.add(lecturer);
		return users.contains(user) || user.getRole().equals("administrator");
	}

	public Pagination getLearnerPagination(){
		return new Pagination("/course/"+getCode()+"/users",new PageImpl(learners, new PageRequest(0, Pagination.SIZE), learners.size()));
	}

	public Pagination getLessonPagination() {
		return new Pagination("/course/" + getCode() + "/lessons",
				new PageImpl<>(lessons, new PageRequest(0, Pagination.SIZE), lessons.size()));
	}

	@Override
	public String toString() {
		return "Course{" + "id=" + id + "\n name='" + name + '\'' + "\n difficulty=" + difficulty + "\n description='"
				+ description + '\'' + "\n lecturer=" + lecturer + "\n subject='" + subject
				+ '\'' + "\n tags=" + tags.toString() + "\n " + '}';
	}

}
