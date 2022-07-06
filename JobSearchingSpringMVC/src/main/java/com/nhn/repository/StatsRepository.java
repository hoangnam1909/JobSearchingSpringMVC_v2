package com.nhn.repository;

import java.util.List;

public interface StatsRepository {

    List<Object[]> userStats();

    List<Object[]> jobPostStatsByCreatedDate();

    List<Object[]> jobPostStatsByJobType();

}
