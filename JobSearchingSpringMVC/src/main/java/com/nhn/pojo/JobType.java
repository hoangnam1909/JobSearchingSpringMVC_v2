package com.nhn.pojo;

import javax.persistence.*;
import java.util.Collection;

@Entity
@Table(name = "job_type")
public class JobType {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;

    @Basic
    @Column(name = "name")
    private String name;

    @OneToMany(mappedBy = "jobType")
    private Collection<JobPost> jobPosts;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        JobType jobType = (JobType) o;

        if (id != jobType.id) return false;
        if (name != null ? !name.equals(jobType.name) : jobType.name != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        return result;
    }

    public Collection<JobPost> getJobPosts() {
        return jobPosts;
    }

    public void setJobPosts(Collection<JobPost> jobPostsById) {
        this.jobPosts = jobPostsById;
    }
}
