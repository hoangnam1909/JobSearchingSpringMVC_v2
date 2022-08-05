package com.nhn.pojo;

import com.nhn.pojo.ApplyJob;
import com.nhn.pojo.JobType;
import com.nhn.pojo.User;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2022-08-05T15:09:38")
@StaticMetamodel(JobPost.class)
public class JobPost_ { 

    public static volatile SingularAttribute<JobPost, Integer> beginningSalary;
    public static volatile SingularAttribute<JobPost, User> postedByEmployerUser;
    public static volatile SingularAttribute<JobPost, Date> createdDate;
    public static volatile SingularAttribute<JobPost, Date> expiredDate;
    public static volatile CollectionAttribute<JobPost, ApplyJob> applyJobs;
    public static volatile SingularAttribute<JobPost, Date> modifiedDate;
    public static volatile SingularAttribute<JobPost, String> description;
    public static volatile SingularAttribute<JobPost, Integer> endingSalary;
    public static volatile SingularAttribute<JobPost, String> location;
    public static volatile SingularAttribute<JobPost, Integer> id;
    public static volatile SingularAttribute<JobPost, String> title;
    public static volatile SingularAttribute<JobPost, JobType> jobType;

}