package com.nhn.service.impl;

import com.nhn.repository.StatsRepository;
import com.nhn.service.StatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StatsServiceImpl implements StatsService {

    @Autowired
    private StatsRepository statsRepository;

    @Override
    public List<Object[]> userStats() {
        return this.statsRepository.userStats();
    }

    @Override
    public List<Object[]> jobPostStatsByCreatedDate() {
        return this.statsRepository.jobPostStatsByCreatedDate();
    }

    @Override
    public List<Object[]> jobPostStatsByJobType() {
        return this.statsRepository.jobPostStatsByJobType();
    }

}
