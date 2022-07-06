/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nhn.controllers;

import com.nhn.pojo.Candidate;
import com.nhn.pojo.Employer;
import com.nhn.pojo.User;
import com.nhn.service.CandidateService;
import com.nhn.service.EmployerService;
import com.nhn.service.UserService;
import com.nhn.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.NoResultException;
import javax.validation.Valid;

/**
 * @author Lightning
 */
@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @Autowired
    private CandidateService candidateService;

    @Autowired
    private EmployerService employerService;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping("/login")
    public String index(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
            return "login";
        }

        return "redirect:/";
    }

    // THEM HOAC CAP NHAT TAI KHOAN
    @GetMapping("/register")
    public String registerView(Model model) {
        User user = new User();
        user.setId(0);

        model.addAttribute("user", user);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "register";
    }

    @PostMapping("/register")
    public String register(Model model,
                           @ModelAttribute(value = "user") @Valid User user,
                           BindingResult result,
                           final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        userValidator.validate(user, result);
        if (result.hasErrors())
            return "register";

        int rawId = user.getId();

        if (user.getUserType().equals("ROLE_NTD"))
            user.setActive(0);
        else
            user.setActive(1);

        boolean addOrUpdateCheck = this.userService.addOrUpdate(user);
        if (addOrUpdateCheck) {
            if (user.getUserType().equals(User.USER)) {
                redirectAttrs.addFlashAttribute("userId",
                        userService.getByUsername(user.getUsername()).getId());
                return "redirect:/register/candidate-info/add";
            } else if (user.getUserType().equals(User.NTD)) {
                Employer employer = new Employer();
                employer.setId(0);
                employer.setName("n/a");
                employer.setUser(userService.getById(user.getId()));
                employerService.addOrUpdate(employer);
            }

            sucMsg = String.format("Đăng ký thành công tài khoản '%s' với vai trò %s",
                    user.getUsername(),
                    user.getUserType().equals("ROLE_UV") ? "Ứng viên" : "Nhà tuyển dụng");
        } else {
            errMsg = String.format("Thêm thông tin user '%s' không thành công", user.getUsername());
            redirectAttrs.addFlashAttribute("errMsg", errMsg);
            return "register";
        }

        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/";
    }

    @GetMapping("/register/candidate-info/add")
    public String addRegisterCandidateView(Model model) {
        Candidate candidate = new Candidate();
        candidate.setId(0);
        model.addAttribute("candidate", candidate);
        model.addAttribute("userId", model.asMap().get("userId"));
        model.addAttribute("actionUrl", "/register/candidate-info/add-or-update");
        return "add-candidate";
    }

    @PostMapping("/register/candidate-info/add-or-update")
    public String registerAddOrUpdateCandidate(Model model,
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
                sucMsg = "Sửa thông tin user và ứng viên thành công";
        } else {
            if (checkMsg == 0)
                errMsg = String.format("Thêm thông tin user và ứng viên '%s' không thành công", candidateUser.getUsername());
            else
                errMsg = "Sửa thông tin user và ứng viên không thành công";

            redirectAttrs.addFlashAttribute("errMsg", errMsg);
            return "add-candidate";
        }

        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/";
    }

    @GetMapping("/register/employer-info/add")
    public String addEmployerView(Model model) {
        Employer employer = new Employer();
        employer.setId(0);
        model.addAttribute("employer", employer);
        model.addAttribute("userId", model.asMap().get("userId"));
        model.addAttribute("actionUrl", "/register/employer-info/add-or-update");
        return "add-employer";
    }

    @PostMapping("/register/employer-info/add-or-update")
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
                sucMsg = String.format("Thêm thông tin user và nhà tuyển dụng '%s' thành công", employerUser.getUsername());
            else
                sucMsg = "Sửa thông tin user và nhà tuyển dụng thành công";
        } else {
            if (checkMsg == 0)
                errMsg = String.format("Thêm thông tin user và nhà tuyển dụng '%s' không thành công", employerUser.getUsername());
            else
                errMsg = "Sửa thông tin user và nhà tuyển dụng không thành công";

            redirectAttrs.addFlashAttribute("errMsg", errMsg);
            return "add-employer";
        }

        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/";
    }

}
