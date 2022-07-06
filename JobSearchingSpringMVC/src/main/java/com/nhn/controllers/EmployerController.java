package com.nhn.controllers;

import com.nhn.pojo.Employer;
import com.nhn.pojo.JobPost;
import com.nhn.pojo.JobType;
import com.nhn.pojo.User;
import com.nhn.service.*;
import com.nhn.utils.utils;
import com.nhn.validator.JobPostValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.NoResultException;
import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class EmployerController {

    @Autowired
    private UserService userService;

    @Autowired
    private JobPostService jobPostService;

    @Autowired
    private JobTypeService jobTypeService;

    @Autowired
    private EmployerService employerService;

    @Autowired
    private CandidateService candidateService;

    @Autowired
    private JobPostValidator jobPostValidator;

    private void loadAllList(Model model) {
        List<JobType> jobTypes = jobTypeService.getJobTypes("", 0);
        model.addAttribute("jobTypes", jobTypes);
    }

    private void loadAllService(Model model) {
        model.addAttribute("jobTypeService", jobTypeService);
        model.addAttribute("employerService", employerService);
    }

    @RequestMapping("/employer")
    public String index() {
        return "employer";
    }

    @RequestMapping("/employer/management")
    public String management(Model model,
                             Authentication authentication,
                             @RequestParam(required = false) Map<String, String> params) {

        if (this.userService.getByUsername(authentication.getName()).getActive() == 0)
            return "employer";

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

        pre.put("postedByUserId", String.valueOf(this.userService.getByUsername(authentication.getName()).getId()));
        List<JobPost> jobPosts = jobPostService.getPosts(pre, page, maxItems);
        List<JobPost> jobPostsSize = jobPostService.getPosts(pre, 0, 0);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", jobPostsSize.size());
        model.addAttribute("jobPostService", jobPostService);

        loadAllService(model);
        model.addAttribute("jobPosts", jobPosts);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "employer-management";
    }

    @GetMapping("/employer/post/view")
    public String viewJobPost(Model model,
                              Authentication authentication,
                              @RequestParam(name = "id", defaultValue = "0") int id) {

        if (this.userService.getByUsername(authentication.getName()).getActive() == 0)
            return "employer";

        int userId = this.userService.getByUsername(authentication.getName()).getId();

        if (id > 0) {
            JobPost jobPost = this.jobPostService.getById(id);
            if (jobPost != null && jobPost.getPostedByUser().getId() == userId) {
                model.addAttribute("jobPost", jobPost);

                JobType jobType = this.jobTypeService.getById(jobPost.getJobType().getId());
                model.addAttribute("jobType", jobType);
            } else {
                return "redirect:/access-denied";
            }
        } else {
            return "employer-management";
        }

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "employer-view-post";
    }

    @GetMapping("/employer/post/add-or-update")
    public String addOrUpdateJobPostView(Model model,
                                         Authentication authentication,
                                         @RequestParam(name = "id", defaultValue = "0") int id) {

        if (this.userService.getByUsername(authentication.getName()).getActive() == 0)
            return "employer";

        int userId = this.userService.getByUsername(authentication.getName()).getId();

        if (id > 0) {
            JobPost jobPost = this.jobPostService.getById(id);
            if (jobPost != null && jobPost.getPostedByUser().getId() == userId) {
                model.addAttribute("jobPost", jobPost);
            } else {
                return "redirect:/access-denied";
            }
        } else {
            JobPost jobPost = new JobPost();
            jobPost.setId(0);
            model.addAttribute("jobPost", jobPost);
        }

        loadAllList(model);

        return "employer-add-post";
    }

    @PostMapping(value = "/employer/post/add-or-update")
    public String addOrUpdateJobPost(Model model,
                                     Authentication authentication,
                                     @ModelAttribute(value = "jobPost") @Valid JobPost jobPost,
                                     BindingResult result,
                                     final RedirectAttributes redirectAttrs) throws ParseException {

        if (this.userService.getByUsername(authentication.getName()).getActive() == 0)
            return "employer";

        String errMsg = null;
        String sucMsg = null;

        loadAllList(model);

        jobPostValidator.validate(jobPost, result);
        if (result.hasErrors())
            return "employer-add-post";

        jobPost.setPostedByUser(userService.getById(jobPost.getPostedByUserId()));
        jobPost.setJobType(jobTypeService.getById(jobPost.getJobTypeId()));
        jobPost.setCreatedDate(new Date());

        if (!jobPost.getExpiredDateStr().equals(""))
            jobPost.setExpiredDate(new SimpleDateFormat("yyyy-MM-dd").parse(jobPost.getExpiredDateStr()));

        boolean jobPostAddedCheck = this.jobPostService.addOrUpdate(jobPost);
        if (jobPostAddedCheck) {
            if (jobPost.getId() == 0)
                sucMsg = String.format("Thêm thành công tin tuyển dụng '%s'", jobPost.getTitle());
            else
                sucMsg = String.format("Chỉnh sửa thành công tin tuyển dụng '%s'", jobPost.getTitle());
        } else {
            if (jobPost.getId() == 0)
                errMsg = String.format("Thêm tin tuyển dụng '%s' thất bại", jobPost.getTitle());
            else
                errMsg = String.format("Chỉnh sửa tin tuyển dụng '%s' thất bại", jobPost.getTitle());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/employer/management";
    }

    @RequestMapping("/employer/find")
    public String find(Model model,
                       Authentication authentication,
                       @RequestParam(required = false) Map<String, String> params) {

        if (this.userService.getByUsername(authentication.getName()).getActive() == 0)
            return "employer";

        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        String fullname = params.getOrDefault("fullname", null);
        String gender = params.getOrDefault("gender", "-1");
        String fromAge = params.getOrDefault("fromAge", null);
        String toAge = params.getOrDefault("toAge", null);
        String address = params.getOrDefault("address", null);

        int nowYear = Calendar.getInstance().get(Calendar.YEAR);

        Map<String, String> pre = new HashMap<>();
        pre.put("userType", "ROLE_UV");
        pre.put("active", "1");

        if (fromAge != null) {
            int fromYear = nowYear - Integer.parseInt(fromAge);
            String fromDate = String.format("31/12/%d", fromYear);
            System.out.println("fromAge >= " + fromDate);
            pre.put("fromAge", fromDate);
        }
        if (toAge != null) {
            int toYear = nowYear - Integer.parseInt(toAge);
            String toDate = String.format("01/01/%d", toYear);
            System.out.println("toDate <= " + toDate);
            pre.put("toAge", toDate);
        }
        if (fullname != null) {
            pre.put("fullname", fullname);
        }
        if (!gender.equals("-1")) {
            pre.put("gender", gender);
        }
        if (address != null) {
            pre.put("address", address);
        }

        List<User> users = userService.getUsersMultiCondition(pre, page);
        List<User> usersSize = userService.getUsersMultiCondition(pre, 0);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", usersSize.size());
        model.addAttribute("users", users);
        model.addAttribute("userService", userService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));
        return "employer-find";
    }

    @RequestMapping("/employer/find/view")
    public String viewFoundUser(Model model,
                                Authentication authentication,
                                @RequestParam(name = "id", defaultValue = "0") int id) {
        if (this.userService.getByUsername(authentication.getName()).getActive() == 0)
            return "employer";

        try {
            model.addAttribute("user", this.userService.getById(id));
            model.addAttribute("candidate", this.candidateService.getByUserId(id));
        } catch (NoResultException nre) {
            return "redirect:/employer/find";
        }

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "employer-view-candidate";
    }

    @GetMapping(path = "/employer/post/delete")
    public String deleteJobPostById(Model model,
                                    Authentication authentication,
                                    @RequestParam(name = "id", defaultValue = "0") int id,
                                    final RedirectAttributes redirectAttrs) {
        if (this.userService.getByUsername(authentication.getName()).getActive() == 0)
            return "employer";

        int userId = this.userService.getByUsername(authentication.getName()).getId();

        String errMsg = null;
        String sucMsg = null;
        JobPost jobPost = new JobPost();

        if (id > 0) {
            jobPost = this.jobPostService.getById(id);
            if (!(jobPost != null && jobPost.getPostedByUser().getId() == userId)) {
                return "redirect:/access-denied";
            }
        }

        boolean deleteCheck = jobPostService.delete(jobPost);
        if (deleteCheck) {
            sucMsg = String.format("Xoá thành công tin tuyển dụng '%s'", jobPost.getTitle());
        } else {
            errMsg = String.format("Xoá không thành công tin tuyển dụng '%s'", jobPost.getTitle());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/employer/management";
    }

    @GetMapping("/employer/employer-info/add-or-update")
    public String updateEmployerView(Model model,
                                     Authentication authentication) {
        if (this.userService.getByUsername(authentication.getName()).getActive() == 0)
            return "employer";

        int userId = this.userService.getByUsername(authentication.getName()).getId();

        Employer employer;
        try {
            employer = employerService.getByUserId(userId);
        } catch (NoResultException nre) {
            employer = new Employer();
            employer.setId(0);
        }
        model.addAttribute("employer", employer);
        model.addAttribute("userId", userId);
        model.addAttribute("actionUrl", "/employer/employer-info/add-or-update");
        return "add-employer";
    }

    @PostMapping("/employer/employer-info/add-or-update")
    public String addOrUpdateEmployer(Model model,
                                      Authentication authentication,
                                      @ModelAttribute(value = "employer") Employer employer) {
        if (this.userService.getByUsername(authentication.getName()).getActive() == 0)
            return "employer";

        String errMsg = null;
        String sucMsg = null;

        User employerUser = userService.getById(employer.getUserId());
        employer.setUser(employerUser);
        int checkMsg = employer.getId();
        if (this.employerService.addOrUpdate(employer)) {
            if (checkMsg == 0)
                sucMsg = String.format("Thêm thông tin user và thông tin nhà tuyển dụng '%s' thành công", employerUser.getUsername());
            else
                sucMsg = "Cập nhật thông tin user và thông tin nhà tuyển dụng thành công";
        } else {
            if (checkMsg == 0)
                errMsg = String.format("Thêm thông tin user và thông tin nhà tuyển dụng '%s' không thành công", employerUser.getUsername());
            else
                errMsg = "Cập nhật thông tin user và thông tin nhà tuyển dụng không thành công";

            model.addAttribute("errMsg", errMsg);
        }

        model.addAttribute("actionUrl", "/employer/employer-info/add-or-update");
        model.addAttribute("sucMsg", sucMsg);
        return "add-employer";
    }

}
