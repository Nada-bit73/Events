package com.example.events.repositories;

import java.util.*;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.events.models.Event;
import com.example.events.models.User;


@Repository
public interface EventRepository extends CrudRepository<Event, Long>{
	List<Event> findAll();
	List<Event> findByState(String stateString);
	List<Event> findByStateIsNot(String stateString);
	List<Event> findByCreatedById(Long id);
	List<Event> findByUsersIn(List<User> users);
	List<Event> findByUsersIsNot(User user);
}
