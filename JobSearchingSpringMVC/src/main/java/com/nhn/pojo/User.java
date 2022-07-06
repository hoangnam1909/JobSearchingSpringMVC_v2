package com.nhn.pojo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "user")
public class User {
    public static final String ADMIN = "ROLE_ADMIN";
    public static final String NTD = "ROLE_NTD";
    public static final String USER = "ROLE_UV";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;

    @Column(name = "username", nullable = false, length = 45)
    private String username;

    @NotEmpty(message = "Không đc để trống")
    @Column(name = "password", nullable = false, length = 100)
    private String password;

    @Column(name = "avatar", length = 300)
    private String avatar;

    @Column(name = "user_type", nullable = false, length = 45)
    private String userType;

    @Column(name = "active", nullable = false)
    private int active;

    @Column(name = "full_name", length = 100)
    private String fullName;

    @Column(name = "email", length = 100)
    private String email;

    @Column(name = "phone", length = 15)
    private String phone;

    @Column(name = "dob")
    private Date dob;

    @Transient
    @JsonIgnore
    private int day;
    @Transient
    @JsonIgnore
    private int month;
    @Transient
    @JsonIgnore
    private int year;

    @Column(name = "gender")
    private int gender;

    @Column(name = "address", length = 100)
    private String address;

    @Transient
    @JsonIgnore
    private String confirmPassword;

    @Transient
    @JsonIgnore
    private MultipartFile file;

    @OneToMany(mappedBy = "postedByUser")
    @JsonIgnore
    private Set<JobPost> jobPosts = new LinkedHashSet<>();

    @OneToMany(mappedBy = "user")
    @JsonIgnore
    private Set<Candidate> candidates = new LinkedHashSet<>();

    @OneToMany(mappedBy = "user")
    @JsonIgnore
    private Set<Employer> employers = new LinkedHashSet<>();

    @OneToMany(mappedBy = "user")
    @JsonIgnore
    private Set<Comment> comments = new LinkedHashSet<>();

    public Set<Comment> getComments() {
        return comments;
    }

    public void setComments(Set<Comment> comments) {
        this.comments = comments;
    }

    public Set<Employer> getEmployers() {
        return employers;
    }

    public void setEmployers(Set<Employer> employers) {
        this.employers = employers;
    }

    public Set<Candidate> getCandidates() {
        return candidates;
    }

    public void setCandidates(Set<Candidate> candidates) {
        this.candidates = candidates;
    }

    public Set<JobPost> getJobPosts() {
        return jobPosts;
    }

    public void setJobPosts(Set<JobPost> jobPosts) {
        this.jobPosts = jobPosts;
    }

    {
        userType = USER;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                '}';
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

}