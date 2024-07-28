package com.ctrl;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.entities.Todo;
import jakarta.servlet.ServletContext;

@Controller
public class BtnCtrl {
	
	@Autowired
	ServletContext context;
	
	@PostMapping("/edit")
	public String update(@RequestParam("id") long id, @RequestParam("title") String title, @RequestParam("description") String description) {
		List<Todo> list = (List<Todo>) context.getAttribute("list");
        if (list != null) {
            for (Todo t : list) {
                if (t.getId() == id) {
                    t.setTodoTitle(title);
                    t.setTodoContent(description);
                    break;
                }
            }
        }
        context.setAttribute("list", list); 
        return "redirect:/home";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam("id") long id, RedirectAttributes redirectAttributes) {
		List<Todo> list = (List<Todo>) context.getAttribute("list");
		if(list != null) {
			//System.out.println("Not null & id= " + id);
			Iterator<Todo> i = list.iterator();
			while(i.hasNext()) {
				Todo t = i.next();
				//System.out.println("t.getId() = " + t.getId());
				if(t.getId() == id) {
					//System.out.println("t.getId() = "+t.getId() + " id = " + id);
					i.remove();
					break;
				}
			}
		}
		redirectAttributes.addFlashAttribute("msg", "DELETE");
		context.setAttribute("list", list);
		return "redirect:/home";
	}
    
}
