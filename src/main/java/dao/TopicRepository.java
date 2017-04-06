package dao;

import java.util.List;
import model.Message;
import model.Poll;
import model.Reply;
import model.Topic;
import model.User;

public interface TopicRepository {

    //index
    public List<Topic> findTopics(String category);
    public Poll findPoll();
    public void publicRegister(User user);
    
    //admin
    public List<User> listUser();
    public User findOneUser(String username);
    public void deleteUser(String username);
    public void editUser(User user);
    public void banUser(String username);
    public void unbanUser(String username);
    
    //message
    public List<Message> listMessage(int topic_id);
    public void deleteMsg(int msg_id);
    public void addMessage(Message message);
    
    public List<Reply> listReply(int message_id);
    public void addReply(Reply reply);
    public void deleteReply(int msg_id);
}
