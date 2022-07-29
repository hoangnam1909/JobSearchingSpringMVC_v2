package com.nhn.service.impl;

import com.nhn.pojo.ApplyJob;
import com.nhn.pojo.Candidate;
import com.nhn.pojo.JobPost;
import com.nhn.pojo.User;
import com.nhn.repository.ApplyJobRepository;
import com.nhn.service.ApplyJobService;
import com.nhn.service.CandidateService;
import com.nhn.service.JobPostService;
import com.nhn.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ApplyJobServiceImpl implements ApplyJobService {

    @Autowired
    private ApplyJobRepository applyJobRepository;

    @Autowired
    private JobPostService jobPostService;

    @Autowired
    private CandidateService candidateService;

    @Autowired
    private UserService userService;

    @Override
    public ApplyJob getById(int id) {
        return this.applyJobRepository.getById(id);
    }

    @Override
    public boolean add(int candidate_user_id, int job_id) {
        User candidateUser = this.userService.getById(candidate_user_id);
        JobPost jobPost = this.jobPostService.getById(job_id);

        ApplyJob applyJob = new ApplyJob();
        applyJob.setCandidateUser(candidateUser);
        applyJob.setJobPost(jobPost);

        return this.applyJobRepository.add(applyJob);
    }

    @Override
    public boolean delete(ApplyJob applyJob) {
        return this.applyJobRepository.delete(applyJob);
    }

    @Override
    public boolean delete(int applyJobId) {
        ApplyJob applyJob =  applyJobRepository.getById(applyJobId);

        if (applyJob == null)
            return false;

        return applyJobRepository.delete(applyJob);
    }

    @Override
    public List<ApplyJob> getApplyJob(int jobId) {
        return this.applyJobRepository.getApplyJob(jobId);
    }

}
