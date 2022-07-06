package com.nhn.service.impl;

import com.nhn.pojo.JobType;
import com.nhn.repository.JobTypeRepository;
import com.nhn.service.JobTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class JobTypeServiceImpl implements JobTypeService {

    @Autowired
    JobTypeRepository jobTypeRepository;

    @Override
    public JobType getById(int id) {
        return this.jobTypeRepository.getById(id);
    }

    @Override
    public boolean addOrUpdate(JobType jobType) {
        return this.jobTypeRepository.addOrUpdate(jobType);
    }

    @Override
    public JobType getByName(String name) {
        return this.jobTypeRepository.getByName(name);
    }

    @Override
    public List<JobType> getJobTypes(String name, int page) {
        return this.jobTypeRepository.getJobTypes(name, page);
    }

    @Override
    public boolean delete(JobType jobType) {
        return this.jobTypeRepository.delete(jobType);
    }

    @Override
    public long count() {
        return this.jobTypeRepository.count();
    }

    @Override
    public int getMaxItemsInPage() {
        return this.jobTypeRepository.getMaxItemsInPage();
    }

}
