package com.nhn.service;

import com.nhn.pojo.Comment;

public interface CommentService {

    Comment addComment(String content, int employerId, int userId);

}
