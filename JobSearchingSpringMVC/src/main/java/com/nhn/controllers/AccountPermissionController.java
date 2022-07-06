package com.nhn.controllers;

import com.nhn.pojo.User;
import com.nhn.service.UserService;
import com.nhn.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@Transactional
public class AccountPermissionController {

    @Autowired
    private UserService userService;

    @RequestMapping("/admin/account-permission")
    public String index(Model model,
                        @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));

        List<User> users = userService.getByRole(User.NTD, page, 0);
        List<User> usersSize = userService.getByRole(User.NTD, 0, 0);
        model.addAttribute("users", users);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", usersSize.size());
        model.addAttribute("userService", userService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "admin-account-permission";
    }

    @RequestMapping(path = "/admin/account-permission/accept")
    public String acceptAccount(Model model,
                                @RequestParam(name = "id", defaultValue = "0") int id,
                                final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        User user = new User();
        if (id != 0) {
            user = this.userService.getById(id);
            user.setActive(1);
        }

        if (user.getActive() == 1) {
            sucMsg = String.format("Xác nhận nhà tuyển dụng '%s' thành công", user.getUsername());
        } else {
            errMsg = String.format("Xác nhận nhà tuyển dụng '%s' không thành công", user.getUsername());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/account-permission";
    }

    @RequestMapping(path = "/admin/account-permission/accept-all")
    public String acceptAllAccount(Model model,
                                   final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        List<User> users = userService.getByRole(User.NTD, 0, 0);
        users.forEach(user -> user.setActive(1));

        int numberCheck = userService.getByRole(User.NTD, 0, 0).size();

        if (numberCheck == 0) {
            sucMsg = "Đã xác nhận tất cả nhà tuyển dụng thành công";
        } else {
            errMsg = "Có lỗi khi xác nhận tất cả nhà tuyển dụng";
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/account-permission";
    }

}
