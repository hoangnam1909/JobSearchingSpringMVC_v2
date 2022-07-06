/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nhn.validator;

import com.nhn.pojo.JobType;
import com.nhn.pojo.User;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 *
 * @author Admin
 */
@Component
public class JobTypeValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return JobType.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        JobType jobType = (JobType) target;
        if (jobType.getName().isEmpty())
            errors.rejectValue("name", "", "Tên không được bỏ trống");
    }

}