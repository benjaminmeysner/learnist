package FDMWebApp.domain;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Date;

/**
 * Created by Rusty on 28/04/2017.
 */
@Entity
@Table(name = "review")
public class Review implements Comparable<Review> {

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "`id`")
	private long id;

    @ManyToOne()
    @JoinColumn(name ="`course`", nullable = false)
    private Course course;

    @OneToOne
    @JoinColumn(name = "`learner`", nullable = false)
    private Learner learner;


	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date")
	private Date date = new Date();

	@Column(name = "`review`")
	@Size(max = 255)
	private String review;

    @Column(name = "`rating`", nullable = false)
    private int rating;

	public Review() {

	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public Learner getLearner() {
		return learner;
	}

	public void setLearner(Learner learner) {
		this.learner = learner;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public long getId() {
		return id;
	}

	@Override
	public int compareTo(Review review) {
		return this.date.compareTo(review.date);
	}
}
