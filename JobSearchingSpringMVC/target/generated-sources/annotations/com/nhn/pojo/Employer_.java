package com.nhn.pojo;

import com.nhn.pojo.Comment;
import com.nhn.pojo.User;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2022-07-15T12:26:34")
@StaticMetamodel(Employer.class)
public class Employer_ { 

    public static volatile SingularAttribute<Employer, String> website;
    public static volatile CollectionAttribute<Employer, Comment> comments;
    public static volatile SingularAttribute<Employer, String> majoring;
    public static volatile SingularAttribute<Employer, String> contact;
    public static volatile SingularAttribute<Employer, String> name;
    public static volatile SingularAttribute<Employer, String> description;
    public static volatile SingularAttribute<Employer, String> location;
    public static volatile SingularAttribute<Employer, Integer> id;
    public static volatile SingularAttribute<Employer, User> user;

}