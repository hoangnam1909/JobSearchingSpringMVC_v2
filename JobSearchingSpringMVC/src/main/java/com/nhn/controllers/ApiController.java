package com.nhn.controllers;

import com.nhn.pojo.ApplyJob;
import com.nhn.pojo.Comment;
import com.nhn.pojo.JobPost;
import com.nhn.service.ApplyJobService;
import com.nhn.service.CommentService;
import com.nhn.service.JobPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class ApiController {

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

    @RequestMapping(value = "/api/apply-job/delete/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteUser(@PathVariable("id") int id) {
        try {
            ApplyJob applyJob = applyJobService.getById(id);
            if (applyJob == null) {
                return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        applyJobService.delete(id);
        return new ResponseEntity<>(HttpStatus.ACCEPTED);
    }

    @RequestMapping(value = "/api/load-jobs", method = RequestMethod.POST, produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<List<JobPost>> listAllUsers(@RequestBody (required = false) Map<String, String> params) {
        List<JobPost> jobPosts = jobPostService.getPosts(params, Integer.parseInt(params.getOrDefault("page", "1")),
                Integer.parseInt(params.getOrDefault("maxItems", "0")));

        if (jobPosts.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);//You many decide to return HttpStatus.NOT_FOUND
        }

        return new ResponseEntity<>(jobPosts, HttpStatus.OK);
    }

}
