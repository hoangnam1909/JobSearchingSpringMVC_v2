package com.nhn.service;

import com.nhn.pojo.JobPost;

import java.util.List;
import java.util.Map;

public interface JobPostService {

    JobPost getById(int id);

    Boolean addOrUpdate(JobPost post);

    List<JobPost> getPosts(Map<String, String> params, int page, int maxItems);

    boolean delete(JobPost post);

    boolean delete(int id);

    long count();

    int getMaxItemsInPage();

}
