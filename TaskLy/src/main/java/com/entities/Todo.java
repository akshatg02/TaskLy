package com.entities;

import java.util.Date;

public class Todo {
	
	private String todoTitle;
	private String todoContent;
	private Date TodoDate;
	private Long Id;
	
	public Todo() {
		super();
	}
	public Todo(String todoTitle, String todoContent, Date todoDate) {
		super();
		this.todoTitle = todoTitle;
		this.todoContent = todoContent;
		TodoDate = todoDate;
	}
	public Long getId() {
		return Id;
	}
	public void setId(Long id) {
		Id = id;
	}
	public String getTodoTitle() {
		return todoTitle;
	}
	public void setTodoTitle(String todoTitle) {
		this.todoTitle = todoTitle;
	}
	public String getTodoContent() {
		return todoContent;
	}
	public void setTodoContent(String todoContent) {
		this.todoContent = todoContent;
	}
	public Date getTodoDate() {
		return TodoDate;
	}
	public void setTodoDate(Date todoDate) {
		TodoDate = todoDate;
	}
	@Override
	public String toString() {
		return "Title: " + this.getTodoTitle() + "|| Content: " + this.getTodoContent() + "|| Date: " + this.getTodoDate() + "|| ID: " + this.Id;
	}
	
}
