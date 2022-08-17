package com.example.events.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;
import com.example.events.models.Event;
import com.example.events.models.User;
import com.example.events.repositories.EventRepository;
import com.example.events.repositories.UserRepository;

import java.util.*;


@Service
public class EventService {
	
	@Autowired
	EventRepository eventRepository;
	
	@Autowired
	UserRepository userRepository;
	
	public Event createEvent(Event event,User user) {
		
		return eventRepository.save(event);
		
	}
	
	public Event findById(Long id) {
		Optional<Event> optionalEvent = eventRepository.findById(id);
		if (optionalEvent.isPresent()) {
			return optionalEvent.get();
		} else {
			return null;
		}
	}
	
	
	public Event updateEvent(Long id, @ModelAttribute("event") Event event) {
		if(findById(id) == null) {
			return null;
		}else{
			Optional<Event> optionalEvent = eventRepository.findById(id);
			Event event2 = optionalEvent.get();
			event2.setName(event.getName());
			event2.setEventdate(event.getEventdate());
			event2.setLocation(event.getLocation());
			event2.setState(event.getState());
			
			return eventRepository.save(event2);
		}
		
		
	
	}
	
	public void deleteEvent(Long id) {
		eventRepository.deleteById(id);
	}

	public List<Event> findAll() {
		return eventRepository.findAll();
	}

	public List<Event> findByState(String stateString) {
		return eventRepository.findByState(stateString);
	}
	
	public List<Event> findByStateIsNot(String stateString) {
		return eventRepository.findByStateIsNot(stateString);
	}

	public void join(Event event, User user) {
		// add user to event
   	   event.getUsers().add(user);
   	   // save
   	   eventRepository.save(event);
	}
	
	public void unjoin(Event event, User user) {
		// add user to event
   	   event.getUsers().remove(user);
   	   // save
   	   eventRepository.save(event);
	}
	
	public List<Event> getEventsCreatedByUserId(Long userId) {
		// 1.fetch the user by its id
		userRepository.findById(userId).get();
		// 2.filter by host id
		return eventRepository.findByCreatedById(userId);
	}
	
	public List<Event> getUserJoiningEvents(Long userId) {
		User user = userRepository.findById(userId).get();
		return user.getEvents();
	}
	
	// 1.fetch events of other states 2.check logged in user is not the host
	public List<Event> getEventsOfOtherStatesNotJoined(Long userId){
		User user = userRepository.findById(userId).get();	
		List<Event> events = new ArrayList<Event>();		
		for (Event event : eventRepository.findByStateIsNot(user.getState())) {
			Boolean userInEvent = false;
			// check if user joined then pass
			for (User userEvent : event.getUsers()) {
				if(userEvent.getId() == user.getId()) {
					userInEvent = true;
					break;
				}
			}
			if(!userInEvent) {
				events.add(event);
			}
		}
		
		return events;
	}
	
	

// fetch events 1. in the same state (in jsp) 2. not joined (here)
	public List<Event> getUserNotJoiningEvents(Long userId) {
		User user = userRepository.findById(userId).get();	
		// enent.getUsers => joined so, findByUsersIsNot means unjoined
		// fetch unjoined events
		List<Event> eventsList = eventRepository.findByUsersIsNot(user);
		
		// check if user is the host 
		List<Event> events = new ArrayList<Event>();
		for (Event event : eventsList) {
			Boolean userInEvent = false;
			for (User userEvent : event.getUsers()) {
				if(userEvent.getId() == user.getId()) {
					userInEvent = true;
					break;
				}
			}
			if(!userInEvent) {
				events.add(event);
			}
		}
		
		return events;
	}

}