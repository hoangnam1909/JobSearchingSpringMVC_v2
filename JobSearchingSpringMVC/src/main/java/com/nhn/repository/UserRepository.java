package com.nhn.repository;

import com.nhn.pojo.User;

import java.util.List;
import java.util.Map;

public interface UserRepository {

    User getById(int id);

    boolean addOrUpdate(User user);

    User getByUsername(String username);

    List<User> getByRole(String role, int page, int active);

    List<User> getUsers(String username, int page);

    List<User> getUsersMultiCondition(Map<String, String> params, int page);

    List<User> getByEmail(String email);

    List<User> getByPhone(String phone);

    boolean delete(User user);

    long count();

    int getMaxItemsInPage();

}
