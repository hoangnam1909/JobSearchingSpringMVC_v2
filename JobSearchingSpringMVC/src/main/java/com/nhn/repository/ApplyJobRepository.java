package com.nhn.repository;

import com.nhn.pojo.ApplyJob;

public interface ApplyJobRepository {

    ApplyJob getById(int id);

    boolean add(ApplyJob applyJob);

    boolean delete(ApplyJob applyJob);

}
