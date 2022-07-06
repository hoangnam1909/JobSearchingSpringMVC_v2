package com.nhn.configs;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.nhn.handlers.LoginHandler;
import com.nhn.handlers.LogoutHandler;
import com.nhn.handlers.MyAccessDenied;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableWebSecurity
@EnableTransactionManagement
@ComponentScan(basePackages = {
        "com.nhn.service",
        "com.nhn.repository",
        "com.nhn.controllers",
        "com.nhn.handlers",
        "com.nhn.validator"
})
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private UserDetailsService userDetailsService;
    @Autowired
    private LoginHandler loginHandler;
    @Autowired
    private LogoutHandler logoutHandler;
    @Autowired
    private MyAccessDenied accessDenied;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new  BCryptPasswordEncoder();
    }

    @Bean
    public Cloudinary cloudinary() {
        Cloudinary c = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dxorabap0",
                "api_key", "249227552583173",
                "api_secret", "T4aMw9N8UUkaSkcpDA-vgORB_Qg",
                "secure", true
        ));

        return c;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.formLogin().permitAll()
                .loginPage("/login")
                .usernameParameter("username")
                .passwordParameter("password");

        http.formLogin().successHandler(this.loginHandler)
                .failureUrl("/login?error");

        http.logout().logoutSuccessHandler(this.logoutHandler);

        http.exceptionHandling().accessDeniedHandler(this.accessDenied);

        http.authorizeRequests()
                .antMatchers("/").permitAll()
                .antMatchers("/me/**").authenticated()
//                .antMatchers("/api/**").authenticated()
                .antMatchers("/candidate/**").access("hasAnyRole('ROLE_UV')")
                .antMatchers("/employer/**").access("hasAnyRole('ROLE_NTD')")
                .antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')");

        http.csrf().disable();
    }

}

