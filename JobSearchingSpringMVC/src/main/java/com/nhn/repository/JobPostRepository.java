package com.nhn.repository;

import com.nhn.pojo.JobPost;

import java.util.List;
import java.util.Map;

public interface JobPostRepository {

    JobPost getById(int id);

    Boolean addOrUpdate(JobPost post);

    List<JobPost> getPosts(Map<String, String> params, int page, int maxItems);

    boolean delete(JobPost post);

    long count();

    int getMaxItemsInPage();

}
