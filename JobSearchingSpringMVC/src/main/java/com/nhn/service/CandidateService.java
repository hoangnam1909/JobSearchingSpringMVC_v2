package com.nhn.service;

import com.nhn.pojo.Candidate;

public interface CandidateService {

    Candidate getByUserId(int userId);

    boolean addOrUpdate(Candidate candidate);

}
