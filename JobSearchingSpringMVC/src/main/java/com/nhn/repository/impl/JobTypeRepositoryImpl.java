package com.nhn.repository.impl;

import com.nhn.pojo.JobType;
import com.nhn.repository.JobTypeRepository;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;

@Repository
@Transactional
public class JobTypeRepositoryImpl implements JobTypeRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactory;

    private final int maxItemsInPage = 10;

    public int getMaxItemsInPage() {
        return maxItemsInPage;
    }

    @Override
    public JobType getById(int id) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        return session.get(JobType.class, id);
    }

    @Override
    public boolean addOrUpdate(JobType jobType) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            if (jobType.getId() > 0)
                session.update(jobType);
            else
                session.save(jobType);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public JobType getByName(String name) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<JobType> query = builder.createQuery(JobType.class);
        Root root = query.from(JobType.class);
        query = query.select(root);

        if (!name.isEmpty()) {
            Predicate p = builder.equal(root.get("name").as(String.class), name.trim());
            query = query.where(p);
        }

        Query q = session.createQuery(query);
        return (JobType) q.getResultList().get(0);
    }

    @Override
    public List<JobType> getJobTypes(String name, int page) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<JobType> query = builder.createQuery(JobType.class);
        Root root = query.from(JobType.class);
        query = query.select(root);

        if (!name.isEmpty()) {
            Predicate p = builder.equal(root.get("name").as(String.class), name.trim());
            query = query.where(p);
        }

        Query q = session.createQuery(query);

        if (page != 0) {
            int max = maxItemsInPage;
            q.setMaxResults(max);
            q.setFirstResult((page - 1) * max);
        }
        return q.getResultList();
    }

    @Override
    public boolean delete(JobType jobType) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            session.delete(jobType);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public long count() {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        Query q = session.createQuery("Select Count(*) From JobType");

        return Long.parseLong(q.getSingleResult().toString());
    }

}
