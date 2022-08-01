package com.nhn.pojo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.Date;
import java.util.Collection;

@Entity
@Table(name = "user")
public class User {

    public static final String ADMIN = "ROLE_ADMIN";
    public static final String NTD = "ROLE_NTD";
    public static final String USER = "ROLE_UV";

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;
    @Basic
    @Column(name = "username")
    private String username;

    @Basic
    @Column(name = "password")
    private String password;

    @Basic
    @Column(name = "avatar")
    private String avatar;

    @Basic
    @Column(name = "user_type")
    private String userType;

    @Basic
    @Column(name = "active")
    private int active;

    @Basic
    @Column(name = "full_name")
    private String fullName;

    @Basic
    @Column(name = "email")
    private String email;

    @Basic
    @Column(name = "phone")
    private String phone;

    @Basic
    @Column(name = "dob")
    private Date dob;

    @Basic
    @Column(name = "gender")
    private Byte gender;

    @Basic
    @Column(name = "address")
    private String address;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "candidate_id", referencedColumnName = "id")
    private Candidate candidate;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "employer_id", referencedColumnName = "id")
    private Employer employer;

//    @OneToMany(mappedBy = "candidateUser", fetch = FetchType.LAZY)
//    private Collection<ApplyJob> applyJobs;
//
//    @OneToMany(mappedBy = "employerUser", fetch = FetchType.LAZY)
//    private Collection<Comment> comments;
//
//    @OneToMany(mappedBy = "candidateUser", fetch = FetchType.LAZY)
//    private Collection<Comment> comments_0;
//
//    @OneToMany(mappedBy = "postedByEmployerUser", fetch = FetchType.LAZY)
//    private Collection<JobPost> jobPosts;

    @Transient
    @JsonIgnore
    private int day;
    @Transient
    @JsonIgnore
    private int month;
    @Transient
    @JsonIgnore
    private int year;
    @Transient
    @JsonIgnore
    private int candidateId;
    @Transient
    @JsonIgnore
    private int employerId;
    @Transient
    @JsonIgnore
    private String confirmPassword;
    @Transient
    @JsonIgnore
    private MultipartFile file;

    {
        userType = USER;
    }

    public int getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }

    public int getEmployerId() {
        return employerId;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public Byte getGender() {
        return gender;
    }

    public void setGender(Byte gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

//    public Collection<ApplyJob> getApplyJobs() {
//        return applyJobs;
//    }
//
//    public void setApplyJobs(Collection<ApplyJob> applyJobsById) {
//        this.applyJobs = applyJobsById;
//    }
//
//    public Collection<Comment> getComments() {
//        return comments;
//    }
//
//    public void setComments(Collection<Comment> commentsById) {
//        this.comments = commentsById;
//    }
//
//    public Collection<Comment> getComments_0() {
//        return comments_0;
//    }
//
//    public void setComments_0(Collection<Comment> commentsById_0) {
//        this.comments_0 = commentsById_0;
//    }
//
//    public Collection<JobPost> getJobPosts() {
//        return jobPosts;
//    }
//
//    public void setJobPosts(Collection<JobPost> jobPostsById) {
//        this.jobPosts = jobPostsById;
//    }

    public Candidate getCandidate() {
        return candidate;
    }

    public void setCandidate(Candidate candidate) {
        this.candidate = candidate;
    }

    public Employer getEmployer() {
        return employer;
    }

    public void setEmployer(Employer employer) {
        this.employer = employer;
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

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
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

}
