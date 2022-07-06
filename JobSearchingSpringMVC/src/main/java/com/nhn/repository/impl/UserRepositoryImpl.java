package com.nhn.repository.impl;

import com.nhn.pojo.JobPost;
import com.nhn.pojo.User;
import com.nhn.repository.UserRepository;
import com.nhn.utils.utils;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
public class UserRepositoryImpl implements UserRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactory;

    private final int maxItemsInPage = 10;

    public int getMaxItemsInPage() {
        return maxItemsInPage;
    }

    @Override
    public User getById(int id) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        return session.get(User.class, id);
    }

    @Override
    public boolean addOrUpdate(User user) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            if (user.getId() > 0)
                session.update(user);
            else
                session.save(user);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public User getByUsername(String username) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<User> query = builder.createQuery(User.class);
        Root root = query.from(User.class);
        query = query.select(root);

        query = query.where(builder.equal(root.get("username").as(String.class), username));

        org.hibernate.query.Query q = session.createQuery(query);
        return (User) q.getSingleResult();
    }

    @Override
    public List<User> getByRole(String role, int page, int active) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<User> query = builder.createQuery(User.class);
        Root root = query.from(User.class);
        query = query.select(root);

        Predicate p1 = builder.equal(root.get("userType").as(String.class), role.trim());
        Predicate p2 = builder.equal(root.get("active").as(Integer.class), active);

        query = query.where(p1, p2);

        query = query.orderBy(builder.desc(root.get("id")));

        Query q = session.createQuery(query);

        if (page != 0) {
            int max = maxItemsInPage;
            q.setMaxResults(max);
            q.setFirstResult((page - 1) * max);
        }
        return q.getResultList();
    }

    @Override
    public List<User> getUsers(String username, int page) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<User> query = builder.createQuery(User.class);
        Root root = query.from(User.class);
        query = query.select(root);

        if (!username.isEmpty()) {
            Predicate p = builder.equal(root.get("username").as(String.class), username.trim());
            query = query.where(p);
        }

        query = query.orderBy(builder.desc(root.get("id")));

        Query q = session.createQuery(query);

        if (page != 0) {
            int max = maxItemsInPage;
            q.setMaxResults(max);
            q.setFirstResult((page - 1) * max);
        }
        return q.getResultList();
    }

    @Override
    public List<User> getUsersMultiCondition(Map<String, String> params, int page) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<User> q = builder.createQuery(User.class);
        Root root = q.from(User.class);
        q.select(root);
        q = q.orderBy(builder.desc(root.get("id")));

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();
            if (params.containsKey("fullname")) {
                Predicate p1 = builder.like(root.get("fullName").as(String.class),
                        String.format("%%%s%%", params.get("fullname")));
                predicates.add(p1);
            }

            if (params.containsKey("gender")) {
                Predicate p2 = builder.equal(root.get("gender").as(String.class), params.get("gender"));
                predicates.add(p2);
            }

            if (params.containsKey("userType")) {
                Predicate p3 = builder.equal(root.get("userType").as(String.class), params.get("userType"));
                predicates.add(p3);
            }

            if (params.containsKey("active")) {
                int activeStt = Integer.parseInt(params.get("active"));
                Predicate p4 = builder.equal(root.get("active").as(Integer.class), activeStt);
                predicates.add(p4);
            }

            if (params.containsKey("fromAge")) {
                Date fromAgeDate = null;
                try {
                    fromAgeDate = utils.stringToDate(params.get("fromAge"), "dd/MM/yyyy");
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                Predicate p5 = builder.lessThanOrEqualTo(root.get("dob").as(Date.class), fromAgeDate);
                predicates.add(p5);
            }

            if (params.containsKey("toAge")) {
                Date toAgeDate = null;
                try {
                    toAgeDate = utils.stringToDate(params.get("toAge"), "dd/MM/yyyy");
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                Predicate p6 = builder.greaterThanOrEqualTo(root.get("dob").as(Date.class), toAgeDate);
                predicates.add(p6);
            }

            if (params.containsKey("address")) {
                Predicate p7 = builder.like(root.get("address").as(String.class),
                        String.format("%%%s%%", params.get("address").trim().toLowerCase()));
                predicates.add(p7);
            }

            if (params.containsKey("username")) {
                Predicate p8 = builder.like(root.get("username").as(String.class),
                        String.format("%%%s%%", params.get("username")));
                predicates.add(p8);
            }

            if (params.containsKey("phone")) {
                Predicate p9 = builder.like(root.get("phone").as(String.class),
                        String.format("%%%s%%", params.get("phone")));
                predicates.add(p9);
            }

            if (params.containsKey("email")) {
                Predicate p10 = builder.like(root.get("email").as(String.class),
                        String.format("%%%s%%", params.get("email")));
                predicates.add(p10);
            }

            if (params.containsKey("userType")) {
                Predicate p11 = builder.like(root.get("userType").as(String.class),
                        String.format("%%%s%%", params.get("userType")));
                predicates.add(p11);
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
    public List<User> getByEmail(String email) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<User> query = builder.createQuery(User.class);
        Root root = query.from(User.class);
        query = query.select(root);

        if (!email.isEmpty()) {
            Predicate p = builder.equal(root.get("email").as(String.class), email.trim());
            query = query.where(p);
        }

        query = query.orderBy(builder.desc(root.get("id")));

        Query q = session.createQuery(query);

        return q.getResultList();
    }

    @Override
    public List<User> getByPhone(String phone) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<User> query = builder.createQuery(User.class);
        Root root = query.from(User.class);
        query = query.select(root);

        if (!phone.isEmpty()) {
            Predicate p = builder.equal(root.get("phone").as(String.class), phone.trim());
            query = query.where(p);
        }

        query = query.orderBy(builder.desc(root.get("id")));

        Query q = session.createQuery(query);

        return q.getResultList();
    }

    @Override
    public boolean delete(User user) {
        if (user.getJobPosts().size() == 0) {
            Session session = this.sessionFactory.getObject().getCurrentSession();
            try {
                session.delete(user);
                return true;
            } catch (HibernateException ex) {
                System.err.println(ex.getMessage());
            }
        }
        return false;
    }

    @Override
    public long count() {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        Query q = session.createQuery("Select Count(*) From User");

        return Long.parseLong(q.getSingleResult().toString());
    }

}
