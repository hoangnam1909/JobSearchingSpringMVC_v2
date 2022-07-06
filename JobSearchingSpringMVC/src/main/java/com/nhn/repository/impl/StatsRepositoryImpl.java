package com.nhn.repository.impl;

import com.nhn.pojo.JobPost;
import com.nhn.pojo.JobType;
import com.nhn.pojo.User;
import com.nhn.repository.StatsRepository;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

@Repository
@Transactional
public class StatsRepositoryImpl implements StatsRepository {

    @Autowired
    private LocalSessionFactoryBean localSessionFactoryBean;

    @Override
    public List<Object[]> userStats() {
        Session session = this.localSessionFactoryBean.getObject().getCurrentSession();

        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = criteriaBuilder.createQuery(Object[].class);
        Root rootUser = q.from(User.class);

        q.multiselect(rootUser.get("userType"), criteriaBuilder.count(rootUser.get("id")));

        q.groupBy(rootUser.get("userType"));

        Query query = session.createQuery(q);

        return query.getResultList();
    }

    @Override
    public List<Object[]> jobPostStatsByCreatedDate() {
        Session session = this.localSessionFactoryBean.getObject().getCurrentSession();

        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = criteriaBuilder.createQuery(Object[].class);
        Root rootJP = q.from(JobPost.class);

        q.multiselect(rootJP.get("createdDate"), criteriaBuilder.count(rootJP.get("id")));

        q.groupBy(criteriaBuilder.function("MONTH", Integer.class, rootJP.get("createdDate")));

        q = q.orderBy(criteriaBuilder.desc(rootJP.get("createdDate")));

        Query query = session.createQuery(q);

        return query.getResultList();
    }

    @Override
    public List<Object[]> jobPostStatsByJobType() {
        Session session = this.localSessionFactoryBean.getObject().getCurrentSession();

        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = criteriaBuilder.createQuery(Object[].class);

        Root rootJP = q.from(JobPost.class);
        Root rootJT = q.from(JobType.class);

        q.where(criteriaBuilder.equal(rootJP.get("jobType"), rootJT.get("id")));

        q.multiselect(rootJT.get("id"), rootJT.get("name"), criteriaBuilder.count(rootJP.get("id")));

        q.groupBy(rootJT.get("id"));

        q = q.orderBy(criteriaBuilder.asc(rootJT.get("id")));

        Query query = session.createQuery(q);

        return query.getResultList();
    }

}
