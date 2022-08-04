package com.nhn.service;

import com.nhn.pojo.JobType;

import java.util.List;

public interface JobTypeService {

    JobType getById(int id);

    boolean addOrUpdate(JobType jobType);

    JobType getByName(String name);

    List<JobType> getJobTypes(String name, int page, int maxItems);

    boolean delete(JobType jobType);

    boolean delete(int id);

    long count();

    int getMaxItemsInPage();

}
