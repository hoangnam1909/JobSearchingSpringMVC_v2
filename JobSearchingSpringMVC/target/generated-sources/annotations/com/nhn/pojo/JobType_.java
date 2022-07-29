package com.nhn.pojo;

import com.nhn.pojo.JobPost;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2022-07-29T16:22:35")
@StaticMetamodel(JobType.class)
public class JobType_ { 

    public static volatile CollectionAttribute<JobType, JobPost> jobPosts;
    public static volatile SingularAttribute<JobType, String> name;
    public static volatile SingularAttribute<JobType, Integer> id;

}