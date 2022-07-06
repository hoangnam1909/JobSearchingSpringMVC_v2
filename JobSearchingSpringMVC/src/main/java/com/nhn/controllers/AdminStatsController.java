package com.nhn.controllers;

import com.nhn.service.StatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminStatsController {

    @Autowired
    private StatsService statsService;

    @RequestMapping("/admin/stats/user")
    public String userStats(Model model){
        model.addAttribute("userStats", this.statsService.userStats());
        return "stats-user";
    }

    @RequestMapping("/admin/stats/jobPostDate")
    public String jobPostDateStats(Model model){
        model.addAttribute("jobPostStatsByCreatedDate", this.statsService.jobPostStatsByCreatedDate());
        return "stats-job-post-date";
    }

    @RequestMapping("/admin/stats/jobPostByJobType")
    public String jobPostByJobTypeStats(Model model){
        model.addAttribute("jobPostStatsByJobType", this.statsService.jobPostStatsByJobType());
        return "stats-job-post-by-job-type";
    }

}
