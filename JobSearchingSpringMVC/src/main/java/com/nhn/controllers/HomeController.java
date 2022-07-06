/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nhn.controllers;

import com.nhn.pojo.Candidate;
import com.nhn.pojo.Employer;
import com.nhn.service.CandidateService;
import com.nhn.service.EmployerService;
import com.nhn.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.persistence.NoResultException;

/**
 * @author Lightning
 */
@Controller
@ControllerAdvice
public class HomeController {

    @Autowired
    private UserService userService;

    @Autowired
    private EmployerService employerService;

    @Autowired
    private CandidateService candidateService;

    @ModelAttribute
    public void addAttributes(Model model, Authentication authentication) {
        if (authentication != null)
            model.addAttribute("currentUser", this.userService.getByUsername(authentication.getName()));
        model.addAttribute("employerService", employerService);
    }

    @RequestMapping("/")
    public String index(Model model) {
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));
        return "index";
    }

    @RequestMapping("/me/view")
    public String aboutMeView(Model model, Authentication authentication) {
        Candidate candidate;

        try {
            candidate = candidateService.getByUserId(userService.getByUsername(authentication.getName()).getId());
            model.addAttribute("candidate", candidate);
        } catch (NoResultException nre){
            System.out.println(nre.getMessage());
        }

        Employer employer;

        try {
            employer = employerService.getByUserId(userService.getByUsername(authentication.getName()).getId());
            model.addAttribute("employer", employer);
        } catch (NoResultException nre){
            System.out.println(nre.getMessage());
        }

        return "me-view";
    }

    @RequestMapping("/me/edit")
    public String aboutMeEditView(Model model) {
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));
        return "index";
    }

    @PostMapping("/me/edit")
    public String aboutMeEdit(Model model) {
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));
        return "index";
    }

}
