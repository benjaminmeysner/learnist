package FDMWebApp.domain;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Rusty on 30/04/2017.
 */
@Entity
@Table(name = "meetup")
public class Meetup {

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    @Column(name = "`id`")
    private long id;

    @JoinColumn(name = "`location`", nullable = false)
    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Address location;

    @Column(name = "date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date date;

    @OneToOne(fetch = FetchType.EAGER, mappedBy = "meetup")
    private Course course;

    public Meetup(){

    }

    public Meetup(Course course){
        this.course = course;
    }

    public long getId() {
        return id;
    }

    public Address getLocation() {
        return location;
    }

    public void setLocation(Address location) {
        this.location = location;
    }

    public Date getDate() {
        return date;
    }

    public String getLocalDate(){
        return new SimpleDateFormat("dd/MM/yyyy HH:mm").format(date);
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setDate(String date) {
        try {
            this.date = new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(date);
        }
        catch (Exception e){

        }
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

}
