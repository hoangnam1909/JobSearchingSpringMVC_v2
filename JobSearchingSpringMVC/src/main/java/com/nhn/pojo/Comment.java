package com.nhn.pojo;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;

@Entity
public class Comment {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;

    @Basic
    @Column(name = "content")
    private String content;

    @Basic
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

    @ManyToOne
    @JoinColumn(name = "employer_user_id", referencedColumnName = "id", nullable = false)
    private User employerUser;

    @ManyToOne
    @JoinColumn(name = "candidate_user_id", referencedColumnName = "id", nullable = false)
    private User candidateUser;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

        Comment comment = (Comment) o;

        if (id != comment.id) return false;
        if (content != null ? !content.equals(comment.content) : comment.content != null) return false;
        if (createdDate != null ? !createdDate.equals(comment.createdDate) : comment.createdDate != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (createdDate != null ? createdDate.hashCode() : 0);
        return result;
    }

    public User getEmployerUser() {
        return employerUser;
    }

    public void setEmployerUser(User userByEmployerUserId) {
        this.employerUser = userByEmployerUserId;
    }

    public User getCandidateUser() {
        return candidateUser;
    }

    public void setCandidateUser(User userByCandidateUserId) {
        this.candidateUser = userByCandidateUserId;
    }
}
