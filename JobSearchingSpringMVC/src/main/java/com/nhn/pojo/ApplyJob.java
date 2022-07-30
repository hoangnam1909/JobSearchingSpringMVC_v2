package com.nhn.pojo;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;

@Entity
@Table(name = "apply_job")
public class ApplyJob {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;

    @Basic
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

    @ManyToOne
    @JoinColumn(name = "candidate_user_id", referencedColumnName = "id", nullable = false)
    private User candidateUser;

    @ManyToOne
    @JoinColumn(name = "job_id", referencedColumnName = "id", nullable = false)
    private JobPost jobPost;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ApplyJob applyJob = (ApplyJob) o;

        if (id != applyJob.id) return false;
        if (createdDate != null ? !createdDate.equals(applyJob.createdDate) : applyJob.createdDate != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (createdDate != null ? createdDate.hashCode() : 0);
        return result;
    }

    public User getCandidateUser() {
        return candidateUser;
    }

    public void setCandidateUser(User userByCandidateUserId) {
        this.candidateUser = userByCandidateUserId;
    }

    public JobPost getJobPost() {
        return jobPost;
    }

    public void setJobPost(JobPost jobPostByJobId) {
        this.jobPost = jobPostByJobId;
    }
}
