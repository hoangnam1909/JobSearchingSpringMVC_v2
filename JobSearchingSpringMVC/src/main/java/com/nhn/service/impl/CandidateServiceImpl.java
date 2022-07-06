package com.nhn.service.impl;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.nhn.pojo.Candidate;
import com.nhn.repository.CandidateRepository;
import com.nhn.service.CandidateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.Map;

@Service
public class CandidateServiceImpl implements CandidateService {

    @Autowired
    private CandidateRepository candidateRepository;

    @Autowired
    private Cloudinary cloudinary;

    @Override
    public Candidate getByUserId(int userId) {
        return this.candidateRepository.getByUserId(userId);
    }

    @Override
    @Transactional
    public boolean addOrUpdate(Candidate candidate) {
        String cv = candidate.getCv();

        if (!candidate.getFile().isEmpty()) {
            Map r = null;
            try {
                r = this.cloudinary.uploader().upload(candidate.getFile().getBytes(),
                        ObjectUtils.asMap("resource_type", "auto"));
            } catch (IOException e) {
                e.printStackTrace();
            }

            if (r != null)
                candidate.setCv((String) r.get("secure_url"));
            else
                candidate.setCv(cv);
        }

        return this.candidateRepository.addOrUpdate(candidate);
    }
}
