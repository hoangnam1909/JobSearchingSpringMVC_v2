package com.nhn.controllers;

import com.nhn.pojo.Comment;
import com.nhn.pojo.JobPost;
import com.nhn.pojo.User;
import com.nhn.service.ApplyJobService;
import com.nhn.service.CommentService;
import com.nhn.service.JobPostService;
import com.nhn.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
public class ApiCommentController {

    @Autowired
    private CommentService commentService;

    @Autowired
    private ApplyJobService applyJobService;

    @Autowired
    private JobPostService jobPostService;

    @PostMapping(value = "/api/add-comment", produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<Comment> addComment(@RequestBody Map<String, String> params) {
        try {
            String content = params.get("content");
            int employerId = Integer.parseInt(params.get("employerId"));
            int userId = Integer.parseInt(params.get("userId"));

            System.out.println("employerId " + employerId);
            System.out.println("userId " + userId);

            Comment comment = this.commentService.addComment(content, employerId, userId);

            return new ResponseEntity<>(comment, HttpStatus.CREATED);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }

    @PostMapping(value = "/api/apply-job", produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<Void> applyJob(@RequestBody Map<String, String> params) {
        try {
            int candidate_user_id = Integer.parseInt(params.get("candidate_id"));
            int job_id = Integer.parseInt(params.get("job_id"));

            applyJobService.add(candidate_user_id, job_id);

            return new ResponseEntity<Void>(HttpStatus.CREATED);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }

    @GetMapping(value = "/api/view-info/{postID}", produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<JobPost> viewInfo(@PathVariable("postID") int postID) {
        try {
            JobPost jobPost = this.jobPostService.getById(postID);

            return new ResponseEntity<>(jobPost, HttpStatus.CREATED);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }

}
