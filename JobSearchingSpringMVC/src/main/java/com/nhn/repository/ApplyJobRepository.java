package com.nhn.repository;

import com.nhn.pojo.ApplyJob;
import com.nhn.pojo.Candidate;
import com.nhn.pojo.JobPost;
import com.nhn.pojo.User;

import java.util.List;

public interface ApplyJobRepository {

    ApplyJob getById(int id);

    boolean add(ApplyJob applyJob);

    boolean delete(ApplyJob applyJob);

    List<ApplyJob> getApplyJob(int jobId);

}
