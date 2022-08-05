package com.nhn.service.impl;

import com.nhn.pojo.JobPost;
import com.nhn.repository.JobPostRepository;
import com.nhn.service.JobPostService;
import com.nhn.utils.utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class JobPostServiceImpl implements JobPostService {

    @Autowired
    JobPostRepository jobPostRepository;

    @Override
    public JobPost getById(int id) {
        return this.jobPostRepository.getById(id);
    }

    @Override
    public Boolean addOrUpdate(JobPost post) {
        if (!(post.getDay() == 0 || post.getMonth() == 0 || post.getYear() == 0)) {
            String sDate = String.format("%02d/%02d/%04d", post.getDay(), post.getMonth(), post.getYear());

            try {
                post.setExpiredDate(utils.stringToDate(sDate, "dd/MM/yyyy"));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        post.setModifiedDate(new Date());
        return this.jobPostRepository.addOrUpdate(post);
    }

    @Override
    public List<JobPost> getPosts(Map<String, String> params, int page, int maxItems) {
        return this.jobPostRepository.getPosts(params, page, maxItems);
    }

    @Override
    public boolean delete(JobPost post) {
        return this.jobPostRepository.delete(post);
    }

    @Override
    public boolean delete(int id) {
        JobPost jobPost = getById(id);
        return this.jobPostRepository.delete(jobPost);
    }

    @Override
    public long count() {
        return this.jobPostRepository.count();
    }

    @Override
    public int getMaxItemsInPage() {
        return this.jobPostRepository.getMaxItemsInPage();
    }

}
