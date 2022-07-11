package com.nhn.service;

import com.nhn.pojo.ApplyJob;

import java.util.List;

public interface ApplyJobService {

    ApplyJob getById(int id);

    boolean add(int candidate_id, int job_id);

    boolean delete(ApplyJob applyJob);

    boolean delete(int applyJobId);

    List<ApplyJob> getApplyJob(int jobId);

}
