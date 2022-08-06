package com.nhn.service;

import com.nhn.pojo.User;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;
import java.util.Map;

public interface UserService extends UserDetailsService {

    User getById(int userId);

    boolean addOrUpdate(User user);

    boolean addOrUpdateNoPassword(User user);

    User getByUsername(String username);

    List<User> getByRole(String role, int page, int active);

    List<User> getUsers(String username, int page);

    List<User> getUsersMultiCondition(Map<String, String> params, int page);

    List<User> getByEmail(String email);

    List<User> getByPhone(String phone);

    boolean delete(User user);

    boolean delete(int id);

    boolean activate(int id);

    boolean changePassword(int id, String rawPassword);

    boolean deactivate(int id);

    long count();

    int getMaxItemsInPage();

}
