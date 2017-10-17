package FDMWebApp.transfer;

import FDMWebApp.domain.Course;
import FDMWebApp.domain.Status;
import FDMWebApp.domain.Tag;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Rusty on 23/04/2017.
 */
public class CourseSearch {

    private String name;

    private BigDecimal rating;
    private String subject;
    private List<String> subjects;
    private List<Status> status;
    private List<Tag> tags;

    public CourseSearch(){
        name = "";
        subject = "";
        subjects = Course.getSubjects();
        this.status = Arrays.asList(Status.Unverified, Status.Submitted, Status.Approved);
    }

    public CourseSearch(List<Tag> tags){
        name = "";
        subject = "";
        subjects = Course.getSubjects();
        this.tags = tags;
        this.status = Arrays.asList(Status.Unverified, Status.Submitted, Status.Approved);
    }


    public CourseSearch(String name, String subject, List<Tag> tags){
        this.name = name;
        this.subject = subject;
        this.tags = tags;
        this.status = Arrays.asList(Status.Unverified, Status.Submitted, Status.Approved);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getRating() {
        return rating;
    }

    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }

    public List<String> getSubjects() {
        return subjects;
    }

    public void setSubjects(List<String> subjects) {
        this.subjects = subjects;
    }

    public List<Tag> getTags() {
        return tags;
    }

    public void setTags(List<Tag> tags) {
        this.tags = tags;
    }

    public List<Status> getStatus() {
        return status;
    }

    public void setStatus(List<Status> status) {
        this.status = status;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }
}
