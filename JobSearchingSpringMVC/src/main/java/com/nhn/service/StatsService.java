package com.nhn.service;

import java.util.List;

public interface StatsService {

    List<Object[]> userStats();

    List<Object[]> jobPostStatsByCreatedDate();

    List<Object[]> jobPostStatsByJobType();

}
