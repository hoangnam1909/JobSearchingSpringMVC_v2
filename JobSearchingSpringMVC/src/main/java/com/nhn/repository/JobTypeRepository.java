package com.nhn.repository;

import com.nhn.pojo.JobType;

import java.util.List;

public interface JobTypeRepository {

    JobType getById(int id);

    boolean addOrUpdate(JobType jobType);

    JobType getByName(String name);

    List<JobType> getJobTypes(String name, int page);

    boolean delete(JobType jobType);

    long count();

    int getMaxItemsInPage();

}
