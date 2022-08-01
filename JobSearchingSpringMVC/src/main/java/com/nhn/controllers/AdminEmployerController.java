package com.nhn.controllers;

import com.nhn.pojo.Employer;
import com.nhn.service.EmployerService;
import com.nhn.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AdminEmployerController {

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

//    @GetMapping("/admin/account/employer-info/update")
//    public String updateEmployerView(Model model,
//                                     @RequestParam(name = "userId", defaultValue = "0") int userId,
//                                     final RedirectAttributes redirectAttrs) {
//        Employer employer;
//        try {
//            employer = employerService.getByUserId(userId);
//        } catch (NoResultException nre){
//            redirectAttrs.addFlashAttribute("userId", userId);
//            return "redirect:/admin/account/employer-info/add";
//        }
//        model.addAttribute("employer", employer);
//        model.addAttribute("userId", userId);
//        return "admin-add-employer";
//    }
//
//    @GetMapping("/admin/account/employer-info/add")
//    public String addEmployerView(Model model) {
//        Employer employer = new Employer();
//        employer.setId(0);
//        model.addAttribute("employer", employer);
//        model.addAttribute("userId", model.asMap().get("userId"));
//        return "admin-add-employer";
//    }

    // THEM HOAC CAP NHAT TAI KHOAN
    @GetMapping("/admin/account/employer/add-or-update")
    public String addOrUpdateAccountView(Model model,
                                         @RequestParam(name = "userId", defaultValue = "0") int userId) {
        if (userId > 0)
            model.addAttribute("employer", this.userService.getById(userId).getEmployer());
        else
            model.addAttribute("employer", new Employer());

        model.addAttribute("user", userService.getById(userId));
        model.addAttribute("errMsg", model.asMap().get("errMsg"));

        return "admin-add-employer";
    }

    @PostMapping("/admin/account/employer-info/add-or-update")
    public String addOrUpdateEmployer(Model model,
                                      @ModelAttribute(value = "employer") Employer employer) {
        String errMsg = null;
        String sucMsg = null;

        if (this.employerService.addOrUpdate(employer)) {
            sucMsg = "Cập nhật thông tin nhà tuyển dụng thành công";
        } else {
            errMsg = "Cập nhật thông tin nhà tuyển dụng không thành công";
        }

        model.addAttribute("errMsg", errMsg);
        model.addAttribute("sucMsg", sucMsg);
        return "admin-add-employer";
    }

}
