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
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.NoResultException;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Lightning
 */
@Controller
public class AccountController {

    @Autowired
    private UserService userService;

    @Autowired
    private CandidateService candidateService;

    @Autowired
    private EmployerService employerService;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping("/admin/account")
    public String index(Model model,
                        @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        String username = params.getOrDefault("username", null);
        String phone = params.getOrDefault("phone", null);
        String email = params.getOrDefault("email", null);
        String userType = params.getOrDefault("userType", null);

        Map<String, String> pre = new HashMap<>();
        if (username != null) {
            pre.put("username", username);
            model.addAttribute("usernameSearch", username);
        }
        if (phone != null) {
            pre.put("phone", phone);
            model.addAttribute("phoneSearch", phone);
        }
        if (email != null) {
            pre.put("email", email);
            model.addAttribute("emailSearch", email);
        }
        if (userType != null) {
            pre.put("userType", userType);
            model.addAttribute("userTypeSearch", userType);
        }

        List<User> users = userService.getUsersMultiCondition(pre, page);
        List<User> usersSize = userService.getUsersMultiCondition(pre, 0);
        model.addAttribute("users", users);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", usersSize.size());
        model.addAttribute("userService", userService);
        model.addAttribute("employerService", employerService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "admin-account";
    }

    // XEM CHI TIET TAI KHOAN
    @GetMapping("/admin/account/view")
    public String viewAccount(Model model,
                              @RequestParam(name = "id", defaultValue = "0") int id) {
        User user = this.userService.getById(id);
        if (user != null) {
            model.addAttribute("user", user);
            Candidate candidate = null;
            try {
                candidate = candidateService.getByUserId(user.getId());
            } catch (NoResultException nre) {
                System.err.println(nre.getMessage());
            }
            if (candidate != null) {
                model.addAttribute("candidate", candidate);
            }

            Employer employer = null;
            try {
                employer = employerService.getByUserId(user.getId());
            } catch (NoResultException nre) {
                System.err.println(nre.getMessage());
            }
            if (employer != null) {
                model.addAttribute("employer", employer);
            }
        } else
            return "redirect:/admin/account";

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "view-account";
    }

    // THEM HOAC CAP NHAT TAI KHOAN
    @GetMapping("/admin/account/add-or-update")
    public String addOrUpdateAccountView(Model model,
                                         @RequestParam(name = "id", defaultValue = "0") int id) {
        if (id > 0)
            model.addAttribute("user", this.userService.getById(id));
        else
            model.addAttribute("user", new User());

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "add-account";
    }

    @PostMapping("/admin/account/add-or-update")
    public String addOrUpdateAccount(Model model,
                                     @ModelAttribute(value = "user") @Valid User user,
                                     BindingResult result,
                                     final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        if (user.getId() == 0) {
            userValidator.validate(user, result);
            if (result.hasErrors())
                return "add-account";
        }

        int rawId = user.getId();

        boolean addOrUpdateCheck = this.userService.addOrUpdate(user);
        if (addOrUpdateCheck) {
            if (rawId == 0) {
                if (user.getUserType().equals(User.USER)) {
                    redirectAttrs.addFlashAttribute("userId",
                            userService.getByUsername(user.getUsername()).getId());
                    return "redirect:/admin/account/candidate-info/add";
                } else if (user.getUserType().equals(User.NTD)) {
                    Employer employer = new Employer();
                    employer.setId(0);
                    employer.setName("n/a");
                    employer.setUser(userService.getById(user.getId()));
                    employerService.addOrUpdate(employer);
                    sucMsg = String.format("Thêm thông tin nhà tuyển dụng '%s' thành công", user.getUsername());
                }
            } else {
                sucMsg = String.format("Sửa thông tin user '%s' thành công", user.getUsername());
            }

            redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
            return "redirect:/admin/account";
        } else {
            errMsg = "Thêm thông tin tài khoản không thành công";
        }
        model.addAttribute("errMsg", errMsg);
        return "add-account";
    }

    @RequestMapping(path = "/admin/account/delete")
    @Transactional
    public String deleteAccountById(Model model,
                                    @RequestParam(name = "id", defaultValue = "0") int id,
                                    final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;
        User user = new User();

        if (id > 0) {
            user = this.userService.getById(id);

            boolean deleteCheck = userService.delete(user);
            if (user != null && deleteCheck) {
                sucMsg = String.format("Xoá thành công user '%s'", user.getUsername());
            } else {
                assert user != null;
                errMsg = String.format("Xoá không thành công user '%s'", user.getUsername());
            }
        } else {
            errMsg = String.format("Xoá không thành công user '%s'", user.getUsername());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/account";
    }

}
