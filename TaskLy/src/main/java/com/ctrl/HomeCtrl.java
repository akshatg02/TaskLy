package com.ctrl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.entities.Todo;

import jakarta.servlet.ServletContext;


@Controller
public class HomeCtrl {
	
	@Autowired
	ServletContext context;
	
	@RequestMapping("/home")
	public String home(Model model) {
		model.addAttribute("page", "home");
		
		List<Todo> list = (List<Todo>) context.getAttribute("list");
		if (list == null) {
	        list = new ArrayList<>();
	    }
		model.addAttribute("todos", list);
		return "home";
	}

	@RequestMapping("/add")
	public String addTodo(Model model) {
		
		Todo t = new Todo();
		model.addAttribute("page", "add");
		model.addAttribute("todo",t);
		return "home";
	}
	
	@RequestMapping(value="/saveTodo", method=RequestMethod.POST)
	public String saveTodo(@ModelAttribute("todo") Todo t, RedirectAttributes redirectAttributes) {
		if (t.getTodoTitle() == null || t.getTodoTitle().isEmpty()) {
			redirectAttributes.addFlashAttribute("msg", "EMPTY");
			return "redirect:/add";
		}
		t.setTodoDate(new Date());
		t.setId(generateRandomLongId());
		System.out.println(t);
		
		List<Todo> list = (List<Todo>) context.getAttribute("list");
		if (list == null) {
			list = new ArrayList<>();
			context.setAttribute("list", list);
		}
		list.add(t);
		redirectAttributes.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/home";
	}
	
	public static long generateRandomLongId() {
        UUID uuid = UUID.randomUUID();
        long longId = uuid.getMostSignificantBits() & Long.MAX_VALUE; // For +ve value
        return longId;
    }
}

