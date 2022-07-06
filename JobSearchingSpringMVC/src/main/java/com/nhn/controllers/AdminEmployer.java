package com.nhn.controllers;

import com.nhn.pojo.Employer;
import com.nhn.pojo.User;
import com.nhn.service.EmployerService;
import com.nhn.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.NoResultException;

@Controller
public class AdminEmployer {

    @Autowired
    private UserService userService;

    @Autowired
    private EmployerService employerService;

    // UNG VIEN
    @RequestMapping("/admin/employer/view")
    public String viewEmployer(Model model,
                               @RequestParam(name = "userId", defaultValue = "0") int userId) {
        Employer employer = this.employerService.getByUserId(userId);
        if (employer != null)
            model.addAttribute("employer", employer);
        else
            return "redirect:/admin/account";

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "view-employer";
    }

    @GetMapping("/admin/account/employer-info/update")
    public String updateEmployerView(Model model,
                                     @RequestParam(name = "userId", defaultValue = "0") int userId,
                                     final RedirectAttributes redirectAttrs) {
        Employer employer;
        try {
            employer = employerService.getByUserId(userId);
        } catch (NoResultException nre){
            redirectAttrs.addFlashAttribute("userId", userId);
            return "redirect:/admin/account/employer-info/add";
        }
        model.addAttribute("employer", employer);
        model.addAttribute("userId", userId);
        return "add-employer";
    }

    @GetMapping("/admin/account/employer-info/add")
    public String addEmployerView(Model model) {
        Employer employer = new Employer();
        employer.setId(0);
        model.addAttribute("employer", employer);
        model.addAttribute("userId", model.asMap().get("userId"));
        return "add-employer";
    }

    @PostMapping("/admin/account/employer-info/add-or-update")
    public String addOrUpdateEmployer(Model model,
                                      @ModelAttribute(value = "candidate") Employer employer,
                                      final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        User employerUser = userService.getById(employer.getUserId());
        employer.setUser(employerUser);
        int checkMsg = employer.getId();
        if (this.employerService.addOrUpdate(employer)) {
            if (checkMsg == 0)
                sucMsg = String.format("Thêm thông tin nhà tuyển dụng '%s' thành công", employerUser.getUsername());
            else
                sucMsg = "Sửa thông tin nhà tuyển dụng thành công";
        } else {
            if (checkMsg == 0)
                errMsg = String.format("Thêm thông tin nhà tuyển dụng '%s' không thành công", employerUser.getUsername());
            else
                errMsg = "Sửa thông tin nhà tuyển dụng không thành công";

            redirectAttrs.addFlashAttribute("errMsg", errMsg);
            return "add-employer";
        }

        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/account";
    }

}
