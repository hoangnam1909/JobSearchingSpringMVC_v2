package com.nhn.service.impl;

import com.nhn.pojo.ApplyJob;
import com.nhn.pojo.Candidate;
import com.nhn.pojo.JobPost;
import com.nhn.repository.ApplyJobRepository;
import com.nhn.service.ApplyJobService;
import com.nhn.service.CandidateService;
import com.nhn.service.JobPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ApplyJobServiceImpl implements ApplyJobService {

    @Autowired
    private ApplyJobRepository applyJobRepository;

    @Autowired
    private JobPostService jobPostService;

    @Autowired
    private CandidateService candidateService;

    @Override
    public ApplyJob getById(int id) {
        return this.applyJobRepository.getById(id);
    }

    @Override
    public boolean add(int candidate_id, int job_id) {
        Candidate candidate = this.candidateService.getById(candidate_id);
        JobPost jobPost = this.jobPostService.getById(job_id);

        ApplyJob applyJob = new ApplyJob();
        applyJob.setCandidate(candidate);
        applyJob.setJob(jobPost);

        return this.applyJobRepository.add(applyJob);
    }

    @Override
    public boolean delete(ApplyJob applyJob) {
        return this.applyJobRepository.delete(applyJob);
    }
}
