package com.nhn.configs;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@PropertySource("classpath:databases.properties")
public class HibernateConfig {
    @Autowired
    private Environment env;

    @Bean
    public LocalSessionFactoryBean getSessionFactory() {
        LocalSessionFactoryBean factory = new LocalSessionFactoryBean();

        factory.setPackagesToScan("com.nhn.pojo");

        factory.setDataSource(dataSource());
        factory.setHibernateProperties(hibernateProperties());

        return factory;
    }

    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource d = new DriverManagerDataSource();

        d.setDriverClassName(env.getProperty("hibernate.connection.driverClass"));
        d.setUrl(env.getProperty("hibernate.connection.url"));
        d.setUsername(env.getProperty("hibernate.connection.username"));
        d.setPassword(env.getProperty("hibernate.connection.password"));

        return d;
    }

    private Properties hibernateProperties() {
        Properties props = new Properties();
        props.setProperty(org.hibernate.cfg.Environment.DIALECT,
                env.getProperty("hibernate.dialect"));
        props.setProperty(org.hibernate.cfg.Environment.SHOW_SQL,
                env.getProperty("hibernate.showSql"));

        return props;
    }

    @Bean
    public HibernateTransactionManager transactionManager() {
        HibernateTransactionManager manager = new HibernateTransactionManager();

        manager.setSessionFactory(getSessionFactory().getObject());

        return manager;
    }
}
