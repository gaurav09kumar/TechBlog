package com.tech.blog.entities;

public class Message {
	private String messageContent;
	private String type;
	private String cssClass;

	/**
	 * @param messageContent
	 * @param type
	 * @param cssClass
	 */
	public Message(String messageContent, String type, String cssClass) {
		super();
		this.messageContent = messageContent;
		this.type = type;
		this.cssClass = cssClass;
	}

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCssClass() {
		return cssClass;
	}

	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}

	// getters & setters

}