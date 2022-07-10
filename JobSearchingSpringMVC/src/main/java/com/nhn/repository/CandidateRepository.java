package com.nhn.repository;

import com.nhn.pojo.Candidate;

public interface CandidateRepository {

    Candidate getById(int id);

    Candidate getByUserId(int userId);

    boolean addOrUpdate(Candidate candidate);

}
