package com.nhn.validator;

import com.nhn.pojo.JobPost;
import com.nhn.utils.utils;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.text.ParseException;

@Component
public class JobPostValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return JobPost.class.equals(aClass);
    }

    @Override
    public void validate(Object target, Errors errors) {
        JobPost jobPost = (JobPost) target;

        // validate title
        if (jobPost.getTitle().length() > 100)
            errors.rejectValue("title", "", "Tiêu đề bài viết không quá 100 ký tự");

        // validate salary
        if (Integer.parseInt(jobPost.getBeginningSalary().toString()) < 0)
            errors.rejectValue("beginningSalary", "", "Lương tối thiểu không được âm");

        if (Integer.parseInt(jobPost.getBeginningSalary().toString()) >= Integer.parseInt(jobPost.getEndingSalary().toString()))
            errors.rejectValue("beginningSalary", "", "Lương tối thiểu không được lớn hơn lương tối đa");

        // validate location
        if (jobPost.getLocation().length() > 100)
            errors.rejectValue("title", "", "Tên địa điểm không quá 100 ký tự");

        // validate upload date
        if (jobPost.getExpiredDate() != null) {
            if (jobPost.getCreatedDate().after(jobPost.getExpiredDate()))
                errors.rejectValue("createdDate", "", "Ngày đăng bài không muộn hơn ngày hết hạn");
        }
    }
}
