package com.nhn.pojo;

import com.nhn.pojo.JobPost;
import javax.annotation.Generated;
import javax.persistence.metamodel.SetAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2022-07-12T16:15:14")
@StaticMetamodel(JobType.class)
public class JobType_ { 

    public static volatile SetAttribute<JobType, JobPost> jobPosts;
    public static volatile SingularAttribute<JobType, String> name;
    public static volatile SingularAttribute<JobType, Integer> id;

}