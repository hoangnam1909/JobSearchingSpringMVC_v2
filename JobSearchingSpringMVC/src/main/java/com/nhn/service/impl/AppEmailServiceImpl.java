package com.nhn.service.impl;

import com.nhn.service.AppEmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class AppEmailServiceImpl implements AppEmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Override
    public void sendEmail(Map<String, String> params) {
        String sendTo = params.getOrDefault("sendTo", null);
        String subject = params.getOrDefault("subject", null);
        String content = params.getOrDefault("content", null);

        if (!(sendTo == null || subject == null || content == null)) {
            SimpleMailMessage newEmail = new SimpleMailMessage();

            newEmail.setTo(sendTo);
            newEmail.setSubject(subject);
            newEmail.setText(content);

            mailSender.send(newEmail);
        }
    }

}
