package com.nhn.pojo;

import com.nhn.pojo.Candidate;
import com.nhn.pojo.JobPost;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2022-07-14T22:43:43")
@StaticMetamodel(ApplyJob.class)
public class ApplyJob_ { 

    public static volatile SingularAttribute<ApplyJob, Candidate> candidate;
    public static volatile SingularAttribute<ApplyJob, Integer> id;
    public static volatile SingularAttribute<ApplyJob, JobPost> job;

}