package com.nhn.pojo;

import com.nhn.pojo.Candidate;
import com.nhn.pojo.Comment;
import com.nhn.pojo.Employer;
import com.nhn.pojo.JobPost;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SetAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2022-07-23T14:43:42")
@StaticMetamodel(User.class)
public class User_ { 

    public static volatile SetAttribute<User, Employer> employers;
    public static volatile SingularAttribute<User, String> address;
    public static volatile SetAttribute<User, Comment> comments;
    public static volatile SingularAttribute<User, Short> gender;
    public static volatile SingularAttribute<User, Integer> active;
    public static volatile SingularAttribute<User, String> fullName;
    public static volatile SingularAttribute<User, String> avatar;
    public static volatile SetAttribute<User, JobPost> jobPosts;
    public static volatile SetAttribute<User, Candidate> candidates;
    public static volatile SingularAttribute<User, String> password;
    public static volatile SingularAttribute<User, String> phone;
    public static volatile SingularAttribute<User, Date> dob;
    public static volatile SingularAttribute<User, Integer> id;
    public static volatile SingularAttribute<User, String> userType;
    public static volatile SingularAttribute<User, String> email;
    public static volatile SingularAttribute<User, String> username;

}