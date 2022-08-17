package com.example.events.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.events.models.Comment;
import com.example.events.models.Event;
import com.example.events.repositories.CommentRepository;


@Service
public class CommentService {
	@Autowired
	CommentRepository commentRepository;
	
	public Comment createComment(Comment comment) {
		return commentRepository.save(comment);
	}
	
	public List<Comment> getComments(Event event){
	      return event.getComment();
	}
}
