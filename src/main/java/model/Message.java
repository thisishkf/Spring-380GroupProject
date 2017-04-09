package model;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Message {

    private int id;
    private int topic_id;
    private String username;
    private String title;
    private String content;
    private Map<String, Attachment> attachments = new LinkedHashMap<>();

    public int getTopic_id() {
        return topic_id;
    }

    public void setTopic_id(int topic_id) {
        this.topic_id = topic_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Attachment getAttachment(String name) {
        return this.attachments.get(name);
    }

    public Collection<Attachment> getAttachments() {
        return this.attachments.values();
    }

    public void addAttachment(Attachment attachment) {
        this.attachments.put(attachment.getName(), attachment);
    }

    public int getNumberOfAttachments() {
        return this.attachments.size();
    }

    public boolean hasAttachment(String name) {
        return this.attachments.containsKey(name);
    }

    public Attachment deleteAttachment(String name) {
        return this.attachments.remove(name);
    }
}
