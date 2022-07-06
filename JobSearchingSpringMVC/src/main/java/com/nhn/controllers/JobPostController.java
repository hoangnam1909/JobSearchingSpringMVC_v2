package com.nhn.controllers;

import com.nhn.pojo.Employer;
import com.nhn.pojo.JobPost;
import com.nhn.pojo.JobType;
import com.nhn.pojo.User;
import com.nhn.service.EmployerService;
import com.nhn.service.JobPostService;
import com.nhn.service.JobTypeService;
import com.nhn.service.UserService;
import com.nhn.utils.utils;
import com.nhn.validator.JobPostValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@ControllerAdvice
public class JobPostController {

    @Autowired
    UserService userService;

    @Autowired
    JobPostService jobPostService;

    @Autowired
    JobTypeService jobTypeService;

    @Autowired
    EmployerService employerService;

    @Autowired
    JobPostValidator jobPostValidator;

    private void loadAllList(Model model) {
        List<User> users = userService.getByRole(User.NTD, 0, 1);
        model.addAttribute("users", users);
        List<JobType> jobTypes = jobTypeService.getJobTypes("", 0);
        model.addAttribute("jobTypes", jobTypes);
    }

    @RequestMapping(value = "/admin/job-post")
    public String index(Model model,
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

        List<JobPost> jobPosts = jobPostService.getPosts(pre, page, 0);
        List<JobPost> jobPostsSize = jobPostService.getPosts(pre, 0, 0);
        model.addAttribute("jobPosts", jobPosts);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", jobPostsSize.size());
        model.addAttribute("jobPostService", jobPostService);

        // another
        model.addAttribute("userService", userService);
        model.addAttribute("jobTypeService", jobTypeService);
        model.addAttribute("employerService", employerService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "admin-job-post";
    }

    @GetMapping("/admin/job-post/view")
    public String viewJobPost(Model model,
                              @RequestParam(name = "id", defaultValue = "0") int id) {
        if (id > 0) {
            model.addAttribute("jobPost", this.jobPostService.getById(id));
            model.addAttribute("userService", userService);
            model.addAttribute("jobTypeService", jobTypeService);
            model.addAttribute("employerService", employerService);
        } else {
            return "redirect:/admin/job-post";
        }
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "view-job-post";
    }

    @GetMapping("/admin/job-post/add-or-update")
    public String addOrUpdateJobPostView(Model model,
                                         @RequestParam(name = "id", defaultValue = "0") int id) {

        if (id > 0)
            model.addAttribute("jobPost", this.jobPostService.getById(id));
        else {
            JobPost jobPost = new JobPost();
            jobPost.setId(0);
            model.addAttribute("jobPost", jobPost);
        }

        loadAllList(model);
        model.addAttribute("employerService", employerService);
        return "add-job-post";
    }

    @PostMapping(value = "/admin/job-post/add-or-update")
    public String addOrUpdateJobPost(Model model,
                                     @ModelAttribute(value = "jobPost") @Valid JobPost jobPost,
                                     BindingResult result,
                                     final RedirectAttributes redirectAttrs) throws ParseException {
        String errMsg = null;
        String sucMsg = null;

        loadAllList(model);

        jobPostValidator.validate(jobPost, result);
        if (result.hasErrors())
            return "add-job-post";

        jobPost.setPostedByUser(userService.getById(jobPost.getPostedByUserId()));
        jobPost.setJobType(jobTypeService.getById(jobPost.getJobTypeId()));
        jobPost.setCreatedDate(new Date());

        if (!jobPost.getExpiredDateStr().equals(""))
            jobPost.setExpiredDate(new SimpleDateFormat("yyyy-MM-dd").parse(jobPost.getExpiredDateStr()));

        boolean jobPostAddedCheck = this.jobPostService.addOrUpdate(jobPost);
        if (jobPostAddedCheck) {
            if (jobPost.getId() == 0)
                sucMsg = String.format("Thêm thành công bài viết '%s'", jobPost.getTitle());
            else
                sucMsg = String.format("Sửa thành công bài viết '%s'", jobPost.getTitle());
        } else {
            if (jobPost.getId() == 0)
                errMsg = String.format("Thêm bài viết '%s' thất bại", jobPost.getTitle());
            else
                errMsg = String.format("Sửa bài viết '%s' thất bại", jobPost.getTitle());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/job-post";
    }

    @GetMapping(path = "/admin/job-post/delete")
    public String deleteJobPostById(Model model,
                                    @RequestParam(name = "id", defaultValue = "0") int id,
                                    final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;
        JobPost jobPost = new JobPost();

        if (id > 0)
            jobPost = this.jobPostService.getById(id);

        boolean deleteCheck = jobPostService.delete(jobPost);
        if (jobPost != null && deleteCheck) {
            sucMsg = String.format("Xoá thành công tin tuyển dụng '%s'", jobPost.getTitle());
        } else {
            assert jobPost != null;
            errMsg = String.format("Xoá không thành công tin tuyển dụng '%s'", jobPost.getTitle());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/job-post";
    }

}
