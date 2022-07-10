package com.nhn.repository.impl;

import com.nhn.pojo.ApplyJob;
import com.nhn.repository.ApplyJobRepository;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class ApplyJobRepositoryImpl implements ApplyJobRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactory;

    @Override
    public ApplyJob getById(int id) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        return session.get(ApplyJob.class, id);
    }

    @Override
    public boolean add(ApplyJob applyJob) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            session.save(applyJob);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean delete(ApplyJob applyJob) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            session.delete(applyJob);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

}
