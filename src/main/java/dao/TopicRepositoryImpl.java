package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import model.Message;
import model.Poll;
import model.PollAnswer;
import model.Reply;
import model.Topic;
import model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcOperations;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class TopicRepositoryImpl implements TopicRepository {

    DataSource dataSource;
    private final JdbcOperations jdbcOp;

    @Autowired
    public TopicRepositoryImpl(DataSource dataSource) {
        this.dataSource = dataSource;
        jdbcOp = new JdbcTemplate(this.dataSource);
    }

    //index
    public List<Topic> findTopics(String category) {
        String SQL_SELECT_ALL_TOPIC = "select * from topic where category = ?";

        List<Topic> topicList = new ArrayList<Topic>();
        List<Map<String, Object>> rows = jdbcOp.queryForList(SQL_SELECT_ALL_TOPIC, category);
        for (Map<String, Object> row : rows) {
            Topic topic = new Topic();
            topic.setId((int) row.get("topic_id"));
            topic.setName((String) row.get("topic_name"));
            topicList.add(topic);
        }
        return topicList;
    }

    public Poll findPoll() {
        Poll poll = new Poll();

        String SQL_FIND_POLL = "select * from poll where poll_id = (select max(poll_id) from poll)";
        poll = jdbcOp.queryForObject(SQL_FIND_POLL, new PollMapper());

        String SQL_COUNTA = "select count(*) from poll_answer where answer='A' and poll_id = ?";
        String SQL_COUNTB = "select count(*) from poll_answer where answer='B' and poll_id = ?";
        String SQL_COUNTC = "select count(*) from poll_answer where answer='C' and poll_id = ?";
        String SQL_COUNTD = "select count(*) from poll_answer where answer='D' and poll_id = ?";
        int countA = jdbcOp.queryForObject(SQL_COUNTA, new Object[]{poll.getId()}, Integer.class);
        int countB = jdbcOp.queryForObject(SQL_COUNTB, new Object[]{poll.getId()}, Integer.class);
        int countC = jdbcOp.queryForObject(SQL_COUNTC, new Object[]{poll.getId()}, Integer.class);
        int countD = jdbcOp.queryForObject(SQL_COUNTD, new Object[]{poll.getId()}, Integer.class);

        poll.setCountA(countA);
        poll.setCountB(countB);
        poll.setCountC(countC);
        poll.setCountD(countD);

        return poll;
    }

    public List<PollAnswer> yourAnswer() {
    String SQL_SELECT_ALL_TOPIC = "select * from poll_answer";

        List<PollAnswer> answerList = new ArrayList<PollAnswer>();
        List<Map<String, Object>> rows = jdbcOp.queryForList(SQL_SELECT_ALL_TOPIC);
        for (Map<String, Object> row : rows) {
            PollAnswer answer = new PollAnswer();
            answer.setPoll_id((int) row.get("poll_id"));
            answer.setUsername((String) row.get("username"));
            answer.setAnswer((String) row.get("answer"));
            answerList.add(answer);
        }
        return answerList;
    }

    //Mapper
    private static final class PollMapper implements RowMapper<Poll> {

        @Override
        public Poll mapRow(ResultSet rs, int i) throws SQLException {
            Poll poll = new Poll();
            poll.setId(rs.getInt("poll_id"));
            poll.setTitle(rs.getString("poll_title"));
            poll.setA(rs.getString("a"));
            poll.setB(rs.getString("b"));
            poll.setC(rs.getString("c"));
            poll.setD(rs.getString("d"));
            return poll;
        }
    }

    private static final class PollAnsMapper implements RowMapper<PollAnswer> {

        @Override
        public PollAnswer mapRow(ResultSet rs, int i) throws SQLException {
            PollAnswer poll = new PollAnswer();
            poll.setUsername(rs.getString("username"));
            poll.setPoll_id(rs.getInt("poll_id"));
            poll.setAnswer(rs.getString("answer"));
            return poll;
        }
    }

    public void publicRegister(User user) {
        String SQL_INSERT_USER = "insert into users (username, password) values ( ?, ?)";
        jdbcOp.update(SQL_INSERT_USER, user.getName(), user.getPassword());

        String SQL_CREATE_USERROLE = "insert into user_roles (username, userrole) values ( ?, ?)";
        jdbcOp.update(SQL_CREATE_USERROLE, user.getName(), user.getRole());
    }

    //admin
    public List<User> listUser() {
        String SQL_find_USER = "select * from users";
        List<User> users = new ArrayList<User>();
        List<Map<String, Object>> rows = jdbcOp.queryForList(SQL_find_USER);
        for (Map<String, Object> row : rows) {
            User user = new User();
            user.setName((String) row.get("username"));
            user.setPassword((String) row.get("password"));
            user.setStatus((String) row.get("status"));
            users.add(user);
        }
        return users;
    }

    public void deleteUser(String username) {
        String SQL_delete_USER = "DELETE FROM user_roles WHERE username = ?";
        jdbcOp.update(SQL_delete_USER, username);

        String SQL_delete_USER_mcreply = "DELETE FROM poll_answer WHERE username = ?";
        jdbcOp.update(SQL_delete_USER_mcreply, username);

        String SQL_delete_USER_messagetopic = "DELETE FROM message WHERE username = ?";
        jdbcOp.update(SQL_delete_USER_messagetopic, username);

        String SQL_delete_USER_replies = "DELETE FROM reply WHERE username = ?";
        jdbcOp.update(SQL_delete_USER_replies, username);

        String SQL_delete_USER_main = "DELETE FROM users WHERE username = ?";
        jdbcOp.update(SQL_delete_USER_main, username);
    }

    public void editUser(User user) {
        String SQL_edit_USER = "update users set password = ? where username = ?";
        jdbcOp.update(SQL_edit_USER, user.getPassword(), user.getName());

        String SQL_delete_USER = "DELETE FROM user_roles WHERE username = ?";
        jdbcOp.update(SQL_delete_USER, user.getName());

        for (String a : user.getCheck()) {
            String SQL_edit_USERROLE = "update user_roles set userrole =? where username = ?";
            jdbcOp.update(SQL_edit_USER, a, user.getName());
        }
    }

    public void banUser(String username) {
        String SQL_ban_USER = "update users set status = ? where username = ?";
        jdbcOp.update(SQL_ban_USER, new String("banned"), username);
    }

    public void unbanUser(String username) {
        String SQL_ban_USER = "update users set status = ? where username = ?";
        jdbcOp.update(SQL_ban_USER, new String("active"), username);
    }

    public User findOneUser(String username) {
        String SQL_find_one_USER = "select * from users where username = ?";
        User user = new User();
        user = jdbcOp.queryForObject(SQL_find_one_USER, new UserRowMapper(), username);
        String SQL_find_ROLE = "select username, userrole from user_roles where username =?";

        return user;
    }

    private static final class UserRowMapper implements RowMapper<User> {

        @Override
        public User mapRow(ResultSet rs, int i) throws SQLException {
            User user = new User();
            user.setName(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setStatus(rs.getString("status"));
            return user;
        }
    }

    private static final class UserRoleMapper implements RowMapper<User> {

        @Override
        public User mapRow(ResultSet rs, int i) throws SQLException {
            User user = new User();
            user.addRole(rs.getString("role"));
            return user;
        }
    }

    //message
    public List<Message> listMessage(int topic_id) {
        String SQL_find_MESSAGE = "select * from message where topic_id =?";
        List<Message> messages = new ArrayList<Message>();
        List<Map<String, Object>> rows = jdbcOp.queryForList(SQL_find_MESSAGE, 1);
        for (Map<String, Object> row : rows) {
            Message msg = new Message();
            msg.setId((int) row.get("msg_id"));

            msg.setTitle((String) row.get("msg_title"));
            msg.setContent((String) row.get("msg_content"));
            msg.setTopic_id((int) row.get("topic_id"));
            msg.setUsername((String) row.get("username"));
            messages.add(msg);
        }
        return messages;
    }

    public List<Reply> listReply(int message_id) {
        String SQL_find_MESSAGE = "select * from reply where msg_id =?";
        List<Reply> replyList = new ArrayList<Reply>();
        List<Map<String, Object>> rows = jdbcOp.queryForList(SQL_find_MESSAGE, message_id);
        for (Map<String, Object> row : rows) {
            Reply reply = new Reply();
            reply.setId((int) row.get("reply_id"));
            reply.setMessage_id((int) row.get("msg_id"));
            reply.setContent((String) row.get("reply_content"));
            reply.setUsername((String) row.get("username"));
            replyList.add(reply);
        }
        return replyList;
    }

    public void addReply(Reply reply) {
        String SQL_add_reply = "insert into reply (reply_content, msg_id, username) values (?,?,?)";
        jdbcOp.update(SQL_add_reply, reply.getContent(), reply.getMessage_id(), reply.getUsername());
    }

    public void addMessage(Message message) {
        String SQL_add_reply = "insert into message (msg_title, msg_content, topic_id, username) values (?, ?,?,?)";
        jdbcOp.update(SQL_add_reply, message.getTitle(), message.getContent(), message.getTopic_id(), message.getUsername());
    }

    public void deleteReply(int reply_id) {
        String SQL_delete_reply = "delete from reply where reply_id =?";
        jdbcOp.update(SQL_delete_reply, reply_id);
    }

    public void deleteMsg(int msg_id) {
        String SQL_delete_reply = "delete from reply where msg_id =?";
        jdbcOp.update(SQL_delete_reply, msg_id);
        String SQL_delete_msg = "delete from message where msg_id =?";
        jdbcOp.update(SQL_delete_msg, msg_id);
    }

    public boolean voted(String username, int poll_id) {
        String SQL_CHECK_VOTE = "select count(*) from poll_answer where username =? and poll_id = ?";
        int count = jdbcOp.queryForObject(SQL_CHECK_VOTE, Integer.class, username, poll_id);
        if (count >= 1) {
            return true;
        } else {
            return false;
        }
    }

    public void CommitVote(String username, int poll_id, String answer) {
        boolean voted = voted(username, poll_id);
        if (voted == false) {
            String SQL_add_poll = "insert into poll_answer (poll_id, username, answer) values (?, ?,?)";
            jdbcOp.update(SQL_add_poll, poll_id, username, answer);
        }
    }

    public List<Poll> pollHistory() {
        String SQL_find_pollHistroy = "select * from poll where poll_id <> (select max(poll_id) from poll)";
        List<Poll> pollList = new ArrayList<Poll>();
        List<Map<String, Object>> rows = jdbcOp.queryForList(SQL_find_pollHistroy);
        for (Map<String, Object> row : rows) {
            Poll poll = new Poll();
            poll.setId((int) row.get("poll_id"));
            poll = findOnePoll(poll.getId());
            pollList.add(poll);
        }
        return pollList;
    }

    public Poll findOnePoll(int id) {
        Poll poll = new Poll();

        String SQL_FIND_POLL = "select * from poll where poll_id = ?";
        poll = jdbcOp.queryForObject(SQL_FIND_POLL, new PollMapper(), id);

        String SQL_COUNTA = "select count(*) from poll_answer where answer='A' and poll_id = ?";
        String SQL_COUNTB = "select count(*) from poll_answer where answer='B' and poll_id = ?";
        String SQL_COUNTC = "select count(*) from poll_answer where answer='C' and poll_id = ?";
        String SQL_COUNTD = "select count(*) from poll_answer where answer='D' and poll_id = ?";
        int countA = jdbcOp.queryForObject(SQL_COUNTA, new Object[]{poll.getId()}, Integer.class);
        int countB = jdbcOp.queryForObject(SQL_COUNTB, new Object[]{poll.getId()}, Integer.class);
        int countC = jdbcOp.queryForObject(SQL_COUNTC, new Object[]{poll.getId()}, Integer.class);
        int countD = jdbcOp.queryForObject(SQL_COUNTD, new Object[]{poll.getId()}, Integer.class);

        poll.setCountA(countA);
        poll.setCountB(countB);
        poll.setCountC(countC);
        poll.setCountD(countD);

        return poll;
    }
    
    public void CreatePoll(String title, String a,String b,String c,String d){
        String SQL_INSERT_POLL = "insert into poll (poll_title, a,b,c,d) values ( ?, ?,?,?,?)";
        jdbcOp.update(SQL_INSERT_POLL, title,a,b,c,d);
    }
}
