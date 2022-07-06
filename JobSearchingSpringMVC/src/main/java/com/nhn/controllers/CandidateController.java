package com.nhn.controllers;

import com.nhn.pojo.*;
import com.nhn.service.*;
import com.nhn.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.NoResultException;
import java.util.*;

@Controller
public class CandidateController {

    @Autowired
    private UserService userService;

    @Autowired
    private CandidateService candidateService;

    @Autowired
    private EmployerService employerService;

    @Autowired
    private JobPostService jobPostService;

    @Autowired
    private JobTypeService jobTypeService;

    @Autowired
    UserValidator userValidator;

    @RequestMapping("/candidate")
    public String index(Model model) {
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));
        return "candidate";
    }

    @GetMapping("/candidate/candidate-info/add-or-update")
    public String updateCandidateView(Model model,
                                      Authentication authentication) {

        int userId = this.userService.getByUsername(authentication.getName()).getId();

        Candidate candidate;
        try {
            candidate = candidateService.getByUserId(userId);
        } catch (NoResultException nre) {
            candidate = new Candidate();
            candidate.setId(0);
        }
        model.addAttribute("candidate", candidate);
        model.addAttribute("userId", userId);
        model.addAttribute("actionUrl", "/candidate/candidate-info/add-or-update");
        return "add-candidate";
    }

    @PostMapping("/candidate/candidate-info/add-or-update")
    public String addOrUpdateCandidate(Model model,
                                       @ModelAttribute(value = "candidate") Candidate candidate,
                                       final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        User candidateUser = userService.getById(candidate.getUserId());
        candidate.setUser(candidateUser);
        int checkMsg = candidate.getId();
        if (this.candidateService.addOrUpdate(candidate)) {
            if (checkMsg == 0)
                sucMsg = String.format("Thêm thông tin user và ứng viên '%s' thành công", candidateUser.getUsername());
            else
                sucMsg = "Cập nhật thông tin user và ứng viên thành công";
        } else {
            if (checkMsg == 0)
                errMsg = String.format("Thêm thông tin user và ứng viên '%s' không thành công", candidateUser.getUsername());
            else
                errMsg = "Cập nhật thông tin user và ứng viên không thành công";

            model.addAttribute("errMsg", errMsg);
        }

        model.addAttribute("actionUrl", "/candidate/candidate-info/update");
        model.addAttribute("sucMsg", sucMsg);
        return "add-candidate";
    }

    @RequestMapping("/candidate/find-employer")
    public String findEmployers(Model model,
                                @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        String name = params.getOrDefault("name", null);
        String location = params.getOrDefault("location", null);
        String majoring = params.getOrDefault("majoring", null);

        Map<String, String> pre = new HashMap<>();
        if (name != null) {
            pre.put("name", name);
            model.addAttribute("name", name);
        }
        if (location != null) {
            pre.put("location", location);
            model.addAttribute("location", location);
        }
        if (majoring != null) {
            pre.put("majoring", majoring);
            model.addAttribute("majoring", majoring);
        }

        List<Employer> employers = employerService.getUsersMultiCondition(pre, page);
        List<Employer> employersSize = employerService.getUsersMultiCondition(pre, 0);
        model.addAttribute("employers", employers);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", employersSize.size());
        model.addAttribute("maxItems", employerService.getMaxItemsInPage());
        model.addAttribute("userService", userService);
        return "candidate-find-employer";
    }

    @RequestMapping("/candidate/view-employer")
    public String viewEmployer(Model model,
                               @RequestParam(name = "employerId", defaultValue = "0") int employerId) {
        if (employerId > 0) {
            model.addAttribute("employer", this.employerService.getById(employerId));
        } else {
            return "candidate-find-employer";
        }

        model.addAttribute("userService", userService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "candidate-view-employer";
    }

    @RequestMapping("/candidate/find-job")
    public String findJob(Model model,
                          @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        String title = params.getOrDefault("title", null);
        String beginningSalary = params.getOrDefault("beginningSalary", null);
        String endingSalary = params.getOrDefault("endingSalary", null);
        String location = params.getOrDefault("location", null);
        String sort = params.getOrDefault("sort", null);

        Map<String, String> pre = new HashMap<>();
        if (title != null) {
            pre.put("title", title);
            model.addAttribute("title", title);
        }
        if (beginningSalary != null) {
            pre.put("beginningSalary", beginningSalary);
            model.addAttribute("beginningSalary", beginningSalary);
        }
        if (endingSalary != null) {
            pre.put("endingSalary", endingSalary);
            model.addAttribute("endingSalary", endingSalary);
        }
        if (location != null) {
            pre.put("location", location);
            model.addAttribute("location", location);
        }
        if (sort != null) {
            pre.put("sort", sort);
            model.addAttribute("sort", sort);
        }

        int maxItems = 20;
        model.addAttribute("maxItems", maxItems);

        List<JobPost> jobPosts = jobPostService.getPosts(pre, page, maxItems);
        List<JobPost> jobPostsSize = jobPostService.getPosts(pre, 0, 0);
        model.addAttribute("jobPosts", jobPosts);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", jobPostsSize.size());
        model.addAttribute("jobPostService", jobPostService);
        model.addAttribute("userService", userService);
        model.addAttribute("employerService", employerService);
        return "candidate-find-job";
    }

    @RequestMapping("/candidate/suggest-employer")
    public String suggestJob(Model model,
                             Authentication authentication,
                             @RequestParam(required = false) Map<String, String> params) {
        int maxItems = 3;
        model.addAttribute("maxItems", maxItems);

        int userId = this.userService.getByUsername(authentication.getName()).getId();
        Candidate candidate = candidateService.getByUserId(userId);

        Set<Employer> employers = new HashSet<>();
        List<Employer> subEmployers;

        if (candidate.getMajoringDetail() != null) {
            String[] majoringDetailEach = candidate.getMajoringDetail().split(" ");
            Map<String, String> pre = new HashMap<>();

            for (String str : majoringDetailEach) {
                pre.put("majoring", str);
                subEmployers = employerService.getUsersMultiCondition(pre, 0);
                employers.addAll(subEmployers);
            }
        }

        model.addAttribute("employers", employers);

        model.addAttribute("jobPostService", jobPostService);
        model.addAttribute("userService", userService);
        model.addAttribute("employerService", employerService);
        return "candidate-suggest-employer";
    }

    @RequestMapping("/candidate/view-post")
    public String viewPost(Model model,
                           @RequestParam(name = "id", defaultValue = "0") int id) {
        try {
            JobPost jobPost = this.jobPostService.getById(id);
            model.addAttribute("jobPost", jobPost);

            Employer postedByEmployer = this.employerService.getByUserId(jobPost.getPostedByUser().getId());
            model.addAttribute("postedByEmployer", postedByEmployer);

            JobType jobType = this.jobTypeService.getById(jobPost.getJobType().getId());
            model.addAttribute("jobType", jobType);
        } catch (NoResultException nre) {
            return "redirect:/candidate/find-job";
        }
        return "candidate-view-post";
    }

}
