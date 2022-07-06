package com.nhn.service.impl;

import com.nhn.pojo.Candidate;
import com.nhn.pojo.Comment;
import com.nhn.pojo.Employer;
import com.nhn.pojo.User;
import com.nhn.repository.CommentRepository;
import com.nhn.service.CandidateService;
import com.nhn.service.CommentService;
import com.nhn.service.EmployerService;
import com.nhn.service.UserService;
import com.nhn.utils.utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private EmployerService employerService;

    @Autowired
    private UserService userService;

    @Override
    public Comment addComment(String content, int employerId, int userId) {
        Employer employer = this.employerService.getById(employerId);
        User user = this.userService.getById(userId);

        Comment comment = new Comment();
        comment.setContent(content);
        comment.setEmployer(employer);
        comment.setUser(user);
        comment.setCreatedDate(new Date());

        return this.commentRepository.addComment(comment);
    }

}
