package com.nhn.repository.impl;

import com.nhn.pojo.Candidate;
import com.nhn.repository.CandidateRepository;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

@Repository
@Transactional
public class CandidateRepositoryImpl implements CandidateRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactory;

    @Override
    public Candidate getByUserId(int userId) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Candidate> query = builder.createQuery(Candidate.class);
        Root root = query.from(Candidate.class);
        query = query.select(root);

        query = query.where(builder.equal(root.join("user").get("id").as(Integer.class), userId));

        org.hibernate.query.Query q = session.createQuery(query);
        return (Candidate) q.getSingleResult();
    }

    @Override
    public boolean addOrUpdate(Candidate candidate) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            if (candidate.getId() > 0)
                session.update(candidate);
            else
                session.save(candidate);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }

        return false;
    }
}
