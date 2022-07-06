package com.nhn.controllers;

import com.nhn.pojo.Candidate;
import com.nhn.pojo.User;
import com.nhn.service.CandidateService;
import com.nhn.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.NoResultException;

@Controller
public class AdminCandidate {

    @Autowired
    private UserService userService;

    @Autowired
    private CandidateService candidateService;

    @RequestMapping("/admin/candidate/view")
    public String viewCandidate(Model model,
                                @RequestParam(name = "userId", defaultValue = "0") int userId) {
        Candidate candidate = this.candidateService.getByUserId(userId);
        if (candidate != null)
            model.addAttribute("candidate", candidate);
        else
            return "redirect:/admin/account";

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "view-candidate";
    }

    @GetMapping("/admin/account/candidate-info/update")
    public String updateCandidateView(Model model,
                                      @RequestParam(name = "userId", defaultValue = "0") int userId,
                                      final RedirectAttributes redirectAttrs) {
        Candidate candidate;
        try {
            candidate = candidateService.getByUserId(userId);
        } catch (NoResultException nre){
            redirectAttrs.addFlashAttribute("userId", userId);
            return "redirect:/admin/account/candidate-info/add";
        }
        model.addAttribute("candidate", candidate);
        model.addAttribute("userId", userId);
        return "add-candidate";
    }

    @GetMapping("/admin/account/candidate-info/add")
    public String addCandidateView(Model model) {
        Candidate candidate = new Candidate();
        candidate.setId(0);
        model.addAttribute("candidate", candidate);
        model.addAttribute("userId", model.asMap().get("userId"));
        return "add-candidate";
    }

    @PostMapping("/admin/account/candidate-info/add-or-update")
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
                sucMsg = String.format("Thêm thông tin ứng viên '%s' thành công", candidateUser.getUsername());
            else
                sucMsg = "Sửa thông tin ứng viên thành công";
        } else {
            if (checkMsg == 0)
                errMsg = String.format("Thêm thông tin ứng viên '%s' không thành công", candidateUser.getUsername());
            else
                errMsg = "Sửa thông tin ứng viên không thành công";

            redirectAttrs.addFlashAttribute("errMsg", errMsg);
            return "add-candidate";
        }

        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/account";
    }

}
