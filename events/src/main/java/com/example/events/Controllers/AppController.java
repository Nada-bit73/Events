package com.example.events.Controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.example.events.models.Comment;
import com.example.events.models.Event;
import com.example.events.models.LoginUser;
import com.example.events.models.User;
import com.example.events.services.CommentService;
import com.example.events.services.EventService;
import com.example.events.services.UserService;
import java.util.*;



@Controller
public class AppController {
	
	@Autowired
    private UserService userServ;
	
	@Autowired
    private EventService eventService;
       
	@Autowired
    private CommentService commentService;
	
    // display Registration page
    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "user/loginReg.jsp";
    }
    
    // process the registration data
    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") User newUser, 
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes
            ) {
    	// send the instance and the result 
        userServ.register(newUser, result);
        if(result.hasErrors()) {
            model.addAttribute("newLogin", new LoginUser());
            return "user/loginReg.jsp";
        }
        redirectAttributes.addFlashAttribute("success", "Your account has been created successfully!");
        return "redirect:/";
    }
    
    // process login data
    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, 
            BindingResult result,
            Model model,
            HttpSession session) {
        User user = userServ.login(newLogin, result);
        if(result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "user/loginReg.jsp";
        }
        session.setAttribute("userFirstName", user.getFirstName());
        session.setAttribute("userId", user.getId());
        return "redirect:/dashboard";
    }
    
    @GetMapping("/dashboard")
    public String displayDashboard(HttpSession session,Model model) {
         Long idLong = (Long) session.getAttribute("userId");
         String state = userServ.findById(idLong).getState();
         model.addAttribute("state",state);
        //--------------------------------
		List<Event> myCreatedEvents = eventService.getEventsCreatedByUserId(idLong);
		List<Event> myJoiningEvents = eventService.getUserJoiningEvents(idLong);
		List<Event> notJoiningEvents = eventService.getUserNotJoiningEvents(idLong);
		List<Event> otherSatesEventsNotJoined = eventService.getEventsOfOtherStatesNotJoined(idLong);
		model.addAttribute("myCreatedEvents", myCreatedEvents);
		model.addAttribute("myJoiningEvents", myJoiningEvents);
		model.addAttribute("notJoiningEvents", notJoiningEvents);
		model.addAttribute("otherSatesEventsNotJoined", otherSatesEventsNotJoined);
        //------------------------------        
    	return "user/dashboard.jsp";
    }
    
    @GetMapping("/add")
    public String displayaddTemplate(@ModelAttribute("newEvent") Event newEvent,
    		Model model,HttpSession session) {
    	model.addAttribute("newEvent",newEvent);
    	Long idLong = (Long) session.getAttribute("userId");
    	String stateString = userServ.findById(idLong).getState();  
    	model.addAttribute("stateString",stateString);
    	session.getAttribute("userFirstName");   	
        return "event/createEvent.jsp";
    }
    
    @RequestMapping(value="/addEvent", method=RequestMethod.POST)
	public String createEvent(@Valid @ModelAttribute("newEvent") Event newEvent,
			BindingResult result,
			RedirectAttributes redirectAttributes,
			HttpSession session,
			Model model
			) {
    	 Long idLong = (Long) session.getAttribute("userId");
    	 session.getAttribute("userFirstName");
		 if(result.hasErrors()) {			 
			 return "event/createEvent.jsp";
		 }else {
			  Event event = eventService.createEvent(newEvent,userServ.findById(idLong));
			  Long eventIdLong = event.getId();
			  System.out.println(eventIdLong);
			  model.addAttribute("eventIdLong",eventIdLong);
			  redirectAttributes.addFlashAttribute("success", "Event Created !");
			 return "redirect:/join/"+event.getId();
		}
		
	}
    
    @GetMapping("/editEvent/{id}")
    public String displayEditTemplate(Model model,
    		@PathVariable("id") Long id,HttpSession session) {
        if(!model.containsAttribute("event")) {
        	Event event = eventService.findById(id);
        	model.addAttribute("event",event);
        	session.getAttribute("userId");
        }
    	model.addAttribute("eventId",id);
        return "event/editEvent.jsp";
    }
    
    @RequestMapping(value="/process/{id}", method=RequestMethod.PUT)
   	public String processEditData(@Valid @ModelAttribute("event") Event event,
   			BindingResult result,
   			Model model,@PathVariable("id") Long id,
   			RedirectAttributes redirectAttributes,HttpSession session
   			) {
   		 if(result.hasErrors()) {
   			 session.getAttribute("userId");
   			 model.addAttribute("event",event);
   			 model.addAttribute("eventId",id);
   			 return "event/editEvent.jsp";
   		 }else{
   			 eventService.updateEvent(id,event);
			 redirectAttributes.addFlashAttribute("success", "Event Updated !");
   			return "redirect:/editEvent/{id}";
   		}
   		
   	}
    
    @RequestMapping(value="/deleteEvent/{id}", method=RequestMethod.GET)
    public String destroy(@PathVariable("id") Long id) {
        eventService.deleteEvent(id);
        return "redirect:/dashboard";
    
}
    
    @RequestMapping(value="/join/{id}", method=RequestMethod.GET)
	public String joinEvent(@PathVariable("id") Long id,
			HttpSession session,
			Model model
			) {
    	 // fetch event
    	 Event event = eventService.findById(id);
    	 
    	 // fetch user
    	 Long idOfUser = (Long) session.getAttribute("userId");
    	 User user = userServ.findById(idOfUser);
    	 
    	 // add user to event
    	 eventService.join(event, user);
    	 System.out.println("*************************");
		 return "redirect:/dashboard";
		
	}
    
    @RequestMapping(value="/unjoin/{id}", method=RequestMethod.GET)
	public String unjoinEvent(@PathVariable("id") Long id,
			HttpSession session,
			Model model
			) {
    	 // fetch event
    	 Event event = eventService.findById(id);
    	 
    	 // fetch user
    	 Long idOfUser = (Long) session.getAttribute("userId");
    	 User user = userServ.findById(idOfUser);
    	 
    	 eventService.unjoin(event,user);
    	 
		 return "redirect:/dashboard";
		
	}
    
    @GetMapping("/view/{id}")
    public String displayEventDetails(HttpSession session,Model model,
    		@PathVariable("id") Long id,@ModelAttribute("comment") Comment comment) {
    	Event event = eventService.findById(id);
    	model.addAttribute("event",event);
    	int num = event.getUsers().size();
    	Long idOfUser = (Long) session.getAttribute("userId");
    	model.addAttribute("id", idOfUser);
    	model.addAttribute("num",num);
    	List<User> eventList = event.getUsers();
    	model.addAttribute("eventList", eventList);
    	List<Comment> comments = commentService.getComments(event);
    	model.addAttribute("commtnts", comments);
    	return "event/viewEvent.jsp";
    	
    }
    
    @RequestMapping(value="/comment/{id}", method=RequestMethod.POST)
	public String addComment(@PathVariable("id") Long id,
			@Valid @ModelAttribute("comment") Comment comment,
			BindingResult result,
			RedirectAttributes redirectAttributes,
			HttpSession session,
			Model model
			) {
    	 session.getAttribute("userId");
    	 model.addAttribute("id", id);
    	 Event event = eventService.findById(id);
    	 List<Comment> comments = commentService.getComments(event);
	    	model.addAttribute("commtnts", comments);
		 if(result.hasErrors()) {	
			 return "event/viewEvent.jsp";
		 }else{			  
			 commentService.createComment(comment);
			 redirectAttributes.addFlashAttribute("success", "Comment Created !");
		     return "redirect:/view/{id}";	
	}
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("userId");
    session.removeAttribute("userFirstName");
        return "redirect:/";
    }
}
