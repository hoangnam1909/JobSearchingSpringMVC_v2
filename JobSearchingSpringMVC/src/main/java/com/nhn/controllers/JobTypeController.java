package com.nhn.controllers;

import com.nhn.pojo.JobType;
import com.nhn.pojo.User;
import com.nhn.service.JobTypeService;
import com.nhn.validator.JobTypeValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
public class JobTypeController {

    @Autowired
    private JobTypeService jobTypeService;

    @Autowired
    private JobTypeValidator jobTypeValidator;

    @RequestMapping("/admin/job-type")
    public String indexDefault(Model model,
                               @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));

        List<JobType> jobTypes = this.jobTypeService.getJobTypes("", page);
        model.addAttribute("jobTypes", jobTypes);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", jobTypeService.count());
        model.addAttribute("jobTypeService", jobTypeService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "admin-job-type";
    }

    @GetMapping("/admin/job-type/view")
    public String viewJobType(Model model,
                              @RequestParam(name = "id", defaultValue = "0") int id) {
        if (id > 0)
            model.addAttribute("jobType", this.jobTypeService.getById(id));
        else
            return "redirect:/admin/job-type";

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "view-job-type";
    }

    @GetMapping("/admin/job-type/add-or-update")
    public String addOrUpdateJobTypeView(Model model,
                                         @RequestParam(name = "id", defaultValue = "0") int id) {


        if (id > 0) {
            model.addAttribute("jobType", this.jobTypeService.getById(id));
        } else {
            JobType jobType = new JobType();
            jobType.setId(0);
            model.addAttribute("jobType", jobType);
        }

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "add-job-type";
    }

    @PostMapping("/admin/job-type/add-or-update")
    public String addOrUpdateJobType(Model model,
                                     @ModelAttribute(value = "jobType") @Valid JobType jobType,
                                     BindingResult result,
                                     final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        jobTypeValidator.validate(jobType, result);
        if (result.hasErrors())
            return "add-job-type";

        boolean jobTypeAddedCheck = this.jobTypeService.addOrUpdate(jobType);
        if (jobTypeAddedCheck) {
            if (jobType.getId() == 0)
                sucMsg = String.format("Thêm thông tin loại việc làm '%s' thành công", jobType.getName());
            else
                sucMsg = String.format("Sửa thông tin loại việc làm '%s' thành công", jobType.getName());
        } else {
            if (jobType.getId() == 0)
                errMsg = String.format("Thêm thông tin loại việc làm '%s' không thành công", jobType.getName());
            else
                errMsg = String.format("Sửa thông tin loại việc làm '%s' không thành công", jobType.getName());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/job-type";
    }

    @RequestMapping("/admin/job-type/delete")
    public String deleteJobType() {
        return "redirect:/admin/job-type";
    }

    @RequestMapping(path = "/admin/job-type/delete/{id}")
    public String deleteJobTypeById(Model model,
                                    @PathVariable(value = "id") int id,
                                    final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        JobType jobType = new JobType();
        if (id != 0) {
            jobType = this.jobTypeService.getById(id);
        }

        boolean deleteCheck = jobTypeService.delete(jobType);

        if (jobType != null && deleteCheck)
            sucMsg = String.format("Xoá loại việc làm '%s' thành công", jobType.getName());
        else
            errMsg = String.format("Xoá loại việc làm '%s' không thành công", jobType.getName());


        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/job-type";
    }

}
