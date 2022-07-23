package com.nhn.repository.impl;

import com.nhn.pojo.JobPost;
import com.nhn.repository.JobPostRepository;
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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
public class JobPostRepositoryImpl implements JobPostRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactory;

    private final int maxItemsInPage = 10;

    public int getMaxItemsInPage() {
        return maxItemsInPage;
    }

    @Override
    public JobPost getById(int id) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        return session.get(JobPost.class, id);
    }

    @Override
    public Boolean addOrUpdate(JobPost post) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            if (post.getId() > 0)
                session.update(post);
            else
                session.save(post);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }

        return false;
    }

    @Override
    public List<JobPost> getPosts(Map<String, String> params, int page, int maxItems) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<JobPost> q = builder.createQuery(JobPost.class);
        Root root = q.from(JobPost.class);
        q.select(root);
        q = q.orderBy(builder.desc(root.get("createdDate")));

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();
            if (params.containsKey("title")) {
                Predicate p1 = builder.like(root.get("title").as(String.class),
                        String.format("%%%s%%", params.get("title")));
                predicates.add(p1);
            }

            if (params.containsKey("description")) {
                Predicate p2 = builder.like(root.get("description").as(String.class),
                        String.format("%%%s%%", params.get("description")));
                predicates.add(p2);
            }

            if (params.containsKey("fromDate")) {
                try {
                    Date fromDate = new SimpleDateFormat("dd/MM/yyyy").parse(params.get("fromDate"));
                    Predicate p3 = builder.greaterThanOrEqualTo(root.get("createdDate").as(Date.class), fromDate);
                    predicates.add(p3);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }

            if (params.containsKey("toDate")) {
                try {
                    Date toDate = new SimpleDateFormat("dd/MM/yyyy").parse(params.get("toDate"));
                    Predicate p4 = builder.lessThanOrEqualTo(root.get("createdDate").as(Date.class), toDate);
                    predicates.add(p4);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }

            if (params.containsKey("postedByUserId")) {
                Predicate p5 = builder.equal(root.join("postedByUser").get("id").as(String.class), params.get("postedByUserId"));
                predicates.add(p5);
            }

            if (params.containsKey("beginningSalary")) {
                Predicate p6 = builder.greaterThanOrEqualTo(root.get("beginningSalary").as(Integer.class), params.get("beginningSalary"));
                predicates.add(p6);
            }

            if (params.containsKey("endingSalary")) {
                Predicate p7 = builder.lessThanOrEqualTo(root.get("endingSalary").as(Integer.class), params.get("endingSalary"));
                predicates.add(p7);
            }

            if (params.containsKey("location")) {
                Predicate p8 = builder.like(root.get("location").as(String.class),
                        String.format("%%%s%%", params.get("location")));
                predicates.add(p8);
            }

            q = q.where(predicates.toArray(new Predicate[]{}));

            if (params.containsKey("sort")) {
                if (params.get("sort").equals("asc")) {
                    q = q.orderBy(builder.asc(root.get("createdDate")));
                } else {
                    q = q.orderBy(builder.desc(root.get("createdDate")));
                }
            }
        }

        Query query = session.createQuery(q);

        if (page != 0) {
            int index;
            if (maxItems == 0) {
                index = (page - 1) * maxItemsInPage;
                query.setFirstResult(index);
                query.setMaxResults(maxItemsInPage);
            } else {
                index = (page - 1) * maxItems;
                query.setFirstResult(index);
                query.setMaxResults(maxItems);
            }
        }

        return query.getResultList();
    }

    @Override
    public boolean delete(JobPost post) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            session.delete(post);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public long count() {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        Query q = session.createQuery("Select Count(*) From JobPost");

        return Long.parseLong(q.getSingleResult().toString());
    }

}
