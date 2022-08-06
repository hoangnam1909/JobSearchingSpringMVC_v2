package com.nhn.controllers;

import com.nhn.pojo.*;
import com.nhn.service.*;
import org.cloudinary.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
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

    @Autowired
    private JobTypeService jobTypeService;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private CandidateService candidateService;

    @Autowired
    private UserService userService;

    @Autowired
    private StatsService statsService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

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

    @GetMapping(value = "/api/candidate-info/{candidateId}", produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<Candidate> candidateInfo(@PathVariable("candidateId") int candidateId) {
        try {
            Candidate candidate = this.candidateService.getById(candidateId);

            return new ResponseEntity<>(candidate, HttpStatus.OK);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }

    @RequestMapping(value = "/api/apply-job/delete/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteApplyJob(@PathVariable("id") int id) {
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


    //    JOB POST API
    @RequestMapping(value = "/api/job-post/delete/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteJobPost(@PathVariable("id") int id) {
        try {
            JobPost jobPost = jobPostService.getById(id);
            if (jobPost == null) {
                return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        jobPostService.delete(id);
        return new ResponseEntity<>(HttpStatus.ACCEPTED);
    }

    @RequestMapping(value = "/api/load-jobs", method = RequestMethod.POST, produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<List<JobPost>> loadJobs(@RequestBody(required = false) Map<String, String> params) {
        List<JobPost> jobPosts = jobPostService.getPosts(params, Integer.parseInt(params.getOrDefault("page", "1")),
                Integer.parseInt(params.getOrDefault("maxItems", "0")));

        if (jobPosts.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);//You many decide to return HttpStatus.NOT_FOUND
        }

        return new ResponseEntity<>(jobPosts, HttpStatus.OK);
    }

    //    JOB TYPE API
    @RequestMapping(value = "/api/job-type/delete/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteJobType(@PathVariable("id") int id) {
        try {
            JobType jobType = jobTypeService.getById(id);
            if (jobType == null) {
                return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        jobTypeService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @RequestMapping(value = "/api/load-job-type", method = RequestMethod.POST, produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<List<JobType>> loadJobType(@RequestBody(required = false) Map<String, String> params) {
        List<JobType> jobTypes = jobTypeService.getJobTypes(params.getOrDefault("name", ""),
                Integer.parseInt(params.getOrDefault("page", "1")),
                Integer.parseInt(params.getOrDefault("maxItems", "0")));

        if (jobTypes.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);//You many decide to return HttpStatus.NOT_FOUND
        }

        return new ResponseEntity<>(jobTypes, HttpStatus.OK);
    }

    // USER
    @RequestMapping(value = "/api/load-users", method = RequestMethod.POST, produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<List<User>> loadUsers(@RequestBody(required = false) Map<String, String> params) {
        List<User> users = userService.getUsersMultiCondition(params, Integer.parseInt(params.getOrDefault("page", "1")));

        if (users.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }

        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    @RequestMapping(value = "/api/account/delete/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteAccount(@PathVariable("id") int id) {
        try {
            User user = userService.getById(id);
            if (user == null) {
                return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        userService.delete(id);
        return new ResponseEntity<>(HttpStatus.ACCEPTED);
    }

    @RequestMapping(value = "/api/number-of-users", method = RequestMethod.GET, produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<Long> numberOfUser() {
        return new ResponseEntity<>(userService.count(), HttpStatus.OK);
    }

    @RequestMapping(value = "/api/account/active/{id}", method = RequestMethod.PUT)
    public ResponseEntity<Void> activeUser(@PathVariable("id") int id) {
        try {
            userService.activate(id);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(HttpStatus.ACCEPTED);
    }

    @RequestMapping(value = "/api/check-password", method = RequestMethod.POST, produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<Map<String, String>> checkPassword(@RequestBody(required = false) Map<String, String> params) {
        HashMap<String, String> map = new HashMap<>();
        boolean check;

        User user = userService.getById(Integer.parseInt(params.getOrDefault("id", "0")));
        String rawPassword = params.get("rawPassword");

        if (user == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        check = passwordEncoder.matches(rawPassword, user.getPassword());
        map.put("status", Boolean.toString(check));

        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @RequestMapping(value = "/api/change-password", method = RequestMethod.POST, produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<Map<String, String>> changePassword(@RequestBody(required = false) Map<String, String> params) {
        HashMap<String, String> map = new HashMap<>();
        boolean check = false;

        int id = Integer.parseInt(params.getOrDefault("id", "0"));
        String rawPassword = params.get("newPassword");

        try {
            check = userService.changePassword(id, rawPassword);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        map.put("status", Boolean.toString(check));
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    // SEND EMAIL
    @PostMapping(value = "/api/send-email", produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<Void> sendEmail(@RequestBody Map<String, String> params) {
        try {
            String sendTo = params.get("sendTo");
            String subject = params.get("subject");
            String content = params.get("content");

            SimpleMailMessage newEmail = new SimpleMailMessage();
            newEmail.setTo(sendTo);
            newEmail.setSubject(subject);
            newEmail.setText(content);

            mailSender.send(newEmail);

            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }

    // STATS
    @RequestMapping(value = "/api/stat-job-post-by-job-type", method = RequestMethod.GET, produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<List<HashMap<String, String>>> statsJobPostByJobType() {
        List<Object[]> result;
        List<HashMap<String, String>> mapList = new ArrayList<>();

        try {
            result = this.statsService.jobPostStatsByJobType();

            for (Object[] objects : result) {
                HashMap<String, String> map = new HashMap<>();

                map.put("label", String.valueOf(objects[1]));
                map.put("value", String.valueOf(objects[2]));
                mapList.add(map);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(mapList, HttpStatus.OK);
    }

    @RequestMapping(value = "/api/stat-employer-activated", method = RequestMethod.GET, produces = {
            MediaType.APPLICATION_JSON_VALUE
    })
    public ResponseEntity<Map<String, String>> statsEmployerActivated() {
        Map<String, String> mapResult = new HashMap<>();

        Map<String, String> paramActivated = new HashMap<>();
        paramActivated.put("userType", "ROLE_NTD");
        paramActivated.put("active", "1");

        Map<String, String> paramUnactivated = new HashMap<>();
        paramUnactivated.put("userType", "ROLE_NTD");
        paramUnactivated.put("active", "0");

        try {
            List<User> employersActivated = userService.getUsersMultiCondition(paramActivated, 0);
            List<User> employersUnactivated = userService.getUsersMultiCondition(paramUnactivated, 0);
            mapResult.put("activated", String.valueOf(employersActivated.size()));
            mapResult.put("unActivated", String.valueOf(employersUnactivated.size()));
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(mapResult, HttpStatus.OK);
    }

}
