package com.nhn.repository.impl;

import com.nhn.pojo.Candidate;
import com.nhn.pojo.Employer;
import com.nhn.pojo.User;
import com.nhn.repository.EmployerRepository;
import com.nhn.service.JobPostService;
import com.nhn.utils.utils;
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
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
public class EmployerRepositoryImpl implements EmployerRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactory;

    private final int maxItemsInPage = 5;

    public int getMaxItemsInPage() {
        return maxItemsInPage;
    }

    @Override
    public Employer getById(int id) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        return session.get(Employer.class, id);
    }

    @Override
    public Employer getByUserId(int userId) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Employer> query = builder.createQuery(Employer.class);
        Root root = query.from(Employer.class);
        query = query.select(root);

        query = query.where(builder.equal(root.join("user").get("id").as(Integer.class), userId));

        org.hibernate.query.Query q = session.createQuery(query);
        return (Employer) q.getSingleResult();
    }

    @Override
    public List<Employer> getUsersMultiCondition(Map<String, String> params, int page) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Employer> q = builder.createQuery(Employer.class);
        Root root = q.from(Employer.class);
        q.select(root);
        q = q.orderBy(builder.asc(root.get("id")));

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();
            if (params.containsKey("name")) {
                Predicate p1 = builder.like(root.get("name").as(String.class),
                        String.format("%%%s%%", params.get("name")));
                predicates.add(p1);
            }

            if (params.containsKey("location")) {
                Predicate p2 = builder.like(root.get("location").as(String.class),
                        String.format("%%%s%%", params.get("location")));
                predicates.add(p2);
            }

            if (params.containsKey("majoring")) {
                Predicate p3 = builder.like(root.get("majoring").as(String.class),
                        String.format("%%%s%%", params.get("majoring")));
                predicates.add(p3);
            }

            if (params.containsKey("majoring")) {
                Predicate p4 = builder.like(root.get("majoring").as(String.class),
                        String.format("%%%s%%", params.get("majoring")));
                predicates.add(p4);
            }

            q = q.where(predicates.toArray(new Predicate[]{}));
        }

        Query query = session.createQuery(q);

        if (page != 0) {
            int max = maxItemsInPage;
            query.setMaxResults(max);
            query.setFirstResult((page - 1) * max);
        }

        return query.getResultList();
    }

    @Override
    public boolean addOrUpdate(Employer employer) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            if (employer.getId() > 0)
                session.update(employer);
            else
                session.save(employer);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }

        return false;
    }

    @Override
    public Employer getByName(String name) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Employer> query = builder.createQuery(Employer.class);
        Root root = query.from(Employer.class);
        query = query.select(root);

        if (!name.isEmpty()) {
            Predicate p = builder.equal(root.get("name").as(String.class), name.trim());
            query = query.where(p);
        }

        Query q = session.createQuery(query);
        return (Employer) q.getResultList().get(0);
    }

    @Override
    public List<Employer> getCompanies(Map<String, String> params, int page) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Employer> q = builder.createQuery(Employer.class);
        Root root = q.from(Employer.class);
        q.select(root);

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();
            if (params.containsKey("name")) {
                Predicate p1 = builder.like(root.get("name").as(String.class),
                        String.format("%%%s%%", params.get("name")));
                predicates.add(p1);
            }

            if (params.containsKey("contact")) {
                Predicate p2 = builder.like(root.get("contact").as(String.class),
                        String.format("%%%s%%", params.get("contact")));
                predicates.add(p2);
            }

            if (params.containsKey("email")) {
                Predicate p3 = builder.like(root.get("email").as(String.class),
                        String.format("%%%s%%", params.get("email")));
                predicates.add(p3);
            }

            if (params.containsKey("location")) {
                Predicate p4 = builder.like(root.get("location").as(String.class),
                        String.format("%%%s%%", params.get("location")));
                predicates.add(p4);
            }

            if (params.containsKey("website")) {
                Predicate p5 = builder.like(root.get("website").as(String.class),
                        String.format("%%%s%%", params.get("website")));
                predicates.add(p5);
            }

            q = q.where(predicates.toArray(new Predicate[]{}));
        }

        q = q.orderBy(builder.asc(root.get("id")));

        Query query = session.createQuery(q);

        if (page != 0) {
            int max = maxItemsInPage;
            query.setMaxResults(max);
            query.setFirstResult((page - 1) * max);
        }
        return query.getResultList();
    }

    @Override
    public boolean delete(Employer employer) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            session.delete(employer);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public long count() {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        Query q = session.createQuery("Select Count(*) From Employer ");

        return Long.parseLong(q.getSingleResult().toString());
    }

}
