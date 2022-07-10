package com.nhn.pojo;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.annotation.Nullable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.Date;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "job_post")
public class JobPost {

    @Basic(optional = false)
    @NotNull
    @Column(name = "beginningSalary")
    private BigDecimal  beginningSalary;
    @Basic(optional = false)
    @NotNull
    @Column(name = "endingSalary")
    private BigDecimal  endingSalary;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "job")
    private Collection<ApplyJob> applyJobCollection;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "title", nullable = false, length = 100)
    private String title;

    @Lob
    @Column(name = "description", nullable = false)
    private String description;


    @Column(name = "location", nullable = false, length = 45)
    private String location;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date")
    private Date createdDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "expired_date")
    private Date expiredDate;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "posted_by_user", nullable = false)
    @JsonIgnore
    private User postedByUser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "job_type_id")
    @JsonIgnore
    private JobType jobType;

    @Transient
    private int postedByUserId;
    @Transient
    private int jobTypeId;
    @Transient
    private int companyId;
    @Transient
    private String createdDateStr;
    @Transient
    private String expiredDateStr;

    public String getCreatedDateStr() {
        return createdDateStr;
    }

    public void setCreatedDateStr(String createdDateStr) {
        this.createdDateStr = createdDateStr;
    }

    public String getExpiredDateStr() {
        return expiredDateStr;
    }

    public void setExpiredDateStr(String expiredDateStr) {
        this.expiredDateStr = expiredDateStr;
    }

    public int getPostedByUserId() {
        return postedByUserId;
    }

    public void setPostedByUserId(int postedByUserId) {
        this.postedByUserId = postedByUserId;
    }

    public int getJobTypeId() {
        return jobTypeId;
    }

    public void setJobTypeId(int jobTypeId) {
        this.jobTypeId = jobTypeId;
    }

    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public JobType getJobType() {
        return jobType;
    }

    public void setJobType(JobType jobType) {
        this.jobType = jobType;
    }

    public User getPostedByUser() {
        return postedByUser;
    }

    public void setPostedByUser(User postedByUser) {
        this.postedByUser = postedByUser;
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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }


    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public JobPost() {
    }

    public BigDecimal getBeginningSalary() {
        return beginningSalary;
    }

    public void setBeginningSalary(BigDecimal beginningSalary) {
        this.beginningSalary = beginningSalary;
    }

    public BigDecimal getEndingSalary() {
        return endingSalary;
    }

    public void setEndingSalary(BigDecimal endingSalary) {
        this.endingSalary = endingSalary;
    }

    @XmlTransient
    public Collection<ApplyJob> getApplyJobCollection() {
        return applyJobCollection;
    }

    public void setApplyJobCollection(Collection<ApplyJob> applyJobCollection) {
        this.applyJobCollection = applyJobCollection;
    }
}