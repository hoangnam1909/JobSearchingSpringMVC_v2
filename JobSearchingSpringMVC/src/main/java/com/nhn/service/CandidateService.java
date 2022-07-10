package com.nhn.service;

import com.nhn.pojo.ApplyJob;
import com.nhn.pojo.Candidate;

public interface CandidateService {

    Candidate getById(int id);

    Candidate getByUserId(int userId);

    boolean addOrUpdate(Candidate candidate);

}
