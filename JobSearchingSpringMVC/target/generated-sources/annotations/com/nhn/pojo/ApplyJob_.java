package com.nhn.pojo;

import com.nhn.pojo.JobPost;
import com.nhn.pojo.User;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2022-08-05T20:38:06")
@StaticMetamodel(ApplyJob.class)
public class ApplyJob_ { 

    public static volatile SingularAttribute<ApplyJob, Date> createdDate;
    public static volatile SingularAttribute<ApplyJob, User> candidateUser;
    public static volatile SingularAttribute<ApplyJob, JobPost> jobPost;
    public static volatile SingularAttribute<ApplyJob, Integer> id;

}