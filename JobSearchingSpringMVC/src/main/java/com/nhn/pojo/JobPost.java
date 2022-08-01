package com.nhn.pojo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.Collection;
import java.util.Date;

@Entity
@Table(name = "job_post")
public class JobPost {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;

    @Basic
    @Column(name = "title")
    private String title;

    @Basic
    @Column(name = "description")
    private String description;

    @Basic
    @Column(name = "beginningSalary")
    private int beginningSalary;

    @Basic
    @Column(name = "endingSalary")
    private int endingSalary;

    @Basic
    @Column(name = "location")
    private String location;

    @Basic
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

    @Transient
    @JsonIgnore
    private String expiredDateStr;

    @Basic
    @Column(name = "expired_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date expiredDate;

    @JsonIgnore
    @OneToMany(mappedBy = "jobPost", fetch = FetchType.LAZY)
    private Collection<ApplyJob> applyJobs;

    @Transient
    @JsonIgnore
    private int postedByEmployerUserId;

//    @Fetch(FetchMode.JOIN)
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "posted_by_employer_user", referencedColumnName = "id", nullable = false)
    private User postedByEmployerUser;

    @Transient
    @JsonIgnore
    private int jobTypeId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "job_type_id", referencedColumnName = "id", nullable = false)
    private JobType jobType;

    @Transient
    @JsonIgnore
    private int day;
    @Transient
    @JsonIgnore
    private int month;
    @Transient
    @JsonIgnore
    private int year;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getBeginningSalary() {
        return beginningSalary;
    }

    public void setBeginningSalary(int beginningSalary) {
        this.beginningSalary = beginningSalary;
    }

    public int getEndingSalary() {
        return endingSalary;
    }

    public void setEndingSalary(int endingSalary) {
        this.endingSalary = endingSalary;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public Collection<ApplyJob> getApplyJobs() {
        return applyJobs;
    }

    public void setApplyJobs(Collection<ApplyJob> applyJobsById) {
        this.applyJobs = applyJobsById;
    }

    public User getPostedByEmployerUser() {
        return postedByEmployerUser;
    }

    public void setPostedByEmployerUser(User userByPostedByEmployerUser) {
        this.postedByEmployerUser = userByPostedByEmployerUser;
    }

    public JobType getJobType() {
        return jobType;
    }

    public void setJobType(JobType jobTypeByJobTypeId) {
        this.jobType = jobTypeByJobTypeId;
    }

    public int getPostedByEmployerUserId() {
        return postedByEmployerUserId;
    }

    public void setPostedByEmployerUserId(int postedByEmployerUserId) {
        this.postedByEmployerUserId = postedByEmployerUserId;
    }

    public int getJobTypeId() {
        return jobTypeId;
    }

    public void setJobTypeId(int jobTypeId) {
        this.jobTypeId = jobTypeId;
    }

    public String getExpiredDateStr() {
        return expiredDateStr;
    }

    public void setExpiredDateStr(String expiredDateStr) {
        this.expiredDateStr = expiredDateStr;
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
}
