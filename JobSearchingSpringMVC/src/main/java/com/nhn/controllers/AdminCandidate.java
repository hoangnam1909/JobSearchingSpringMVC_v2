package com.nhn.controllers;

import com.nhn.pojo.Candidate;
import com.nhn.pojo.Employer;
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

    @GetMapping("/admin/account/candidate/add-or-update")
    public String addOrUpdateCandidateView(Model model,
                                         @RequestParam(name = "userId", defaultValue = "0") int userId) {
        if (userId > 0)
            model.addAttribute("candidate", this.userService.getById(userId).getCandidate());
        else
            model.addAttribute("candidate", new Candidate());

        model.addAttribute("user", userService.getById(userId));
        model.addAttribute("errMsg", model.asMap().get("errMsg"));

        return "admin-add-candidate";
    }

//    @GetMapping("/admin/account/candidate-info/update")
//    public String updateCandidateView(Model model,
//                                      @RequestParam(name = "userId", defaultValue = "0") int userId,
//                                      final RedirectAttributes redirectAttrs) {
//        Candidate candidate;
//        try {
//            candidate = candidateService.getByUserId(userId);
//        } catch (NoResultException nre){
//            redirectAttrs.addFlashAttribute("userId", userId);
//            return "redirect:/admin/account/candidate-info/add";
//        }
//        model.addAttribute("candidate", candidate);
//        model.addAttribute("userId", userId);
//        return "admin-add-candidate";
//    }
//
//    @GetMapping("/admin/account/candidate-info/add")
//    public String addCandidateView(Model model) {
//        Candidate candidate = new Candidate();
//        candidate.setId(0);
//        model.addAttribute("candidate", candidate);
//        model.addAttribute("userId", model.asMap().get("userId"));
//        return "admin-add-candidate";
//    }

    @PostMapping("/admin/account/candidate/add-or-update")
    public String addOrUpdateCandidate(Model model,
                                       @RequestParam(name = "userId", defaultValue = "0") int userId,
                                       @ModelAttribute(value = "candidate") Candidate candidate,
                                       final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        if (this.candidateService.addOrUpdate(candidate)) {
            sucMsg = "Cập nhật thông tin ứng viên thành công";
        } else {
            errMsg = "Cập nhật thông tin ứng viên không thành công";
        }

        model.addAttribute("errMsg", errMsg);
        model.addAttribute("sucMsg", sucMsg);
        redirectAttrs.addFlashAttribute("userId", candidate.getUserId());
        return "redirect:/admin/account/view";
    }

}
