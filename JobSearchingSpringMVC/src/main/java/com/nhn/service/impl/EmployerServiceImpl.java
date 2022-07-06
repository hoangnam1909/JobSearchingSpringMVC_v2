package com.nhn.service.impl;

import com.nhn.pojo.Employer;
import com.nhn.pojo.User;
import com.nhn.repository.EmployerRepository;
import com.nhn.service.EmployerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class EmployerServiceImpl implements EmployerService {

    @Autowired
    EmployerRepository employerRepository;

    @Override
    public Employer getById(int id) {
        return this.employerRepository.getById(id);
    }

    @Override
    public Employer getByUserId(int userId) {
        return this.employerRepository.getByUserId(userId);
    }

    @Override
    public List<Employer> getUsersMultiCondition(Map<String, String> params, int page) {
        return this.employerRepository.getUsersMultiCondition(params, page);
    }

    @Override
    public boolean addOrUpdate(Employer employer) {
        return this.employerRepository.addOrUpdate(employer);
    }

    @Override
    public Employer getByName(String name) {
        return this.employerRepository.getByName(name);
    }

    @Override
    public List<Employer> getCompanies(Map<String, String> params, int page) {
        return this.employerRepository.getCompanies(params, page);
    }

    @Override
    public boolean delete(Employer employer) {
        return this.employerRepository.delete(employer);
    }

    @Override
    public long count() {
        return this.employerRepository.count();
    }

    @Override
    public int getMaxItemsInPage() {
        return this.employerRepository.getMaxItemsInPage();
    }

}
