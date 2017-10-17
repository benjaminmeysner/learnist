package FDMWebApp.domain;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Rusty on 29/04/2017.
 */
@Entity
@Table(name = "notification")
public class Notification implements Comparable<Notification>{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "`id`")
    private long id;

    @Column(name = "`message`", nullable = false)
    private String message;

    @Column(name = "`url`")
    private String url = "#";

    @Column(name = "`date`")
    @Temporal(TemporalType.TIMESTAMP)
    private Date date = new Date();

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(name = "`user_notifications`",
            joinColumns = @JoinColumn(name = "notifications_id"),
            inverseJoinColumns = @JoinColumn(name = "id", referencedColumnName = "id"))
    private List<User> users = new ArrayList<>();

    public Notification(){

    }

    public Notification(String message, User user){
        this.message = message;
        this.users = new ArrayList<>(Arrays.asList(user));
    }

    public Notification(String message, List<User> users){
        this.message = message;
        this.users = users;
    }

    public Notification(String message, User user, String url){
        this.message = message;
        this.users = new ArrayList<>(Arrays.asList(user));
        this.url = url;
    }

    public Notification(String message, List<User> users, String url){
        this.message = message;
        this.users = users;
        this.url = url;
    }

    public long getId() {
        return id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
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

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public Notification removeUser(User user){
        users.remove(user);
        return this;
    }

    @Override
    public int compareTo(Notification notification){
        return notification.getDate().compareTo(date);
    }
}
