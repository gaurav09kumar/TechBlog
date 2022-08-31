package com.tech.blog.entities;

public class Category {
	private int categoriesId;
	private String name;
	private String description;

	public Category() {
	}

	public Category(int categoriesId, String name, String description) {
		this.categoriesId = categoriesId;
		this.name = name;
		this.description = description;
	}

	public Category(String name, String description) {
		this.name = name;
		this.description = description;
	}

	public int getCategoriesId() {
		return categoriesId;
	}

	public void setCategoriesId(int categoriesId) {
		this.categoriesId = categoriesId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
