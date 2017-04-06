/* 
    Created on  : Mar 29, 2017, 10:32:48 PM
    Author      : Ho Kin Fai, Wong Tak Ming, Chow wa wai
    Project     : comps380f
    Purpose     : Index Router
 */
package controller;

import dao.TopicRepository;
import java.security.Principal;
import model.Message;
import model.Reply;
import model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class IndexController {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    TopicRepository topicRepo;

    @RequestMapping("/")
    public String index(ModelMap model, Principal principal) {
        model.addAttribute("lectures", topicRepo.findTopics("lecture"));
        model.addAttribute("labs", topicRepo.findTopics("lab"));
        model.addAttribute("others", topicRepo.findTopics("other"));
        model.addAttribute("poll", topicRepo.findPoll());
        return "index";
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("register")
    public String register() {
        return "register";
    }

    @RequestMapping(value = "register", method = RequestMethod.POST)
    public View CommitRegister(WebRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        if (confirmPassword.equals(password)) {
            User user = new User();
            user.setName(username);
            user.setPassword(password);
            user.addRole("user");
            topicRepo.publicRegister(user);
            return new RedirectView("register?status=ok", true);
        }
        return new RedirectView("register?status=error", true);
    }

    //admin
    @RequestMapping(value = "admin", method = RequestMethod.GET)
    public String adminPanel(ModelMap model) {
        model.addAttribute("users", topicRepo.listUser());
        return "admin";
    }

    @RequestMapping(value = "deleteUser", method = RequestMethod.GET)
    public String adminDeleteUser(WebRequest request, ModelMap model) {
        String username = request.getParameter("name");
        topicRepo.deleteUser(username);
        model.addAttribute("users", topicRepo.listUser());
        return "admin";
    }

    @RequestMapping(value = "banUser", method = RequestMethod.GET)
    public String adminBanUser(WebRequest request, ModelMap model) {
        String username = request.getParameter("name");
        topicRepo.banUser(username);
        model.addAttribute("users", topicRepo.listUser());
        return "admin";
    }

    @RequestMapping(value = "unbanUser", method = RequestMethod.GET)
    public String adminUnbanUser(WebRequest request, ModelMap model) {
        String username = request.getParameter("name");
        topicRepo.unbanUser(username);
        model.addAttribute("users", topicRepo.listUser());
        return "admin";
    }

    /*public String adminEditUser(WebRequest request,ModelMap model) {
        String username = request.getParameter("name");  
        model.addAttribute("user",topicRepo.findOneUser(username));
        return "editUser";
    }*/
    @RequestMapping(value = "editUser", method = RequestMethod.GET)
    public ModelAndView adminEditUser(WebRequest request, ModelMap model) {
        String username = request.getParameter("name");
        model.addAttribute("user", topicRepo.findOneUser(username));
        return new ModelAndView("editUser", "command", new User());
    }

    @RequestMapping(value = "/editUser", method = RequestMethod.POST)
    public String adminCommitEditUser(@ModelAttribute("SpringWeb") User user,
            ModelMap model) {
        topicRepo.editUser(user);
        model.addAttribute("users", topicRepo.listUser());
        return "admin";
    }

    /*@RequestMapping(value = "editUser", method = RequestMethod.POST)
    public String adminCommitEditUser(WebRequest request, ModelMap model) {
        String name = request.getParameter("username");
        String password = request.getParameter("password");
        String status = request.getParameter("status");
        User user = new User();
        user.setName(name);
        user.setPassword(password);
        user.setStatus(status);
        topicRepo.editUser(user);
        model.addAttribute("users", topicRepo.listUser());
        return "admin";
    }*/
    @RequestMapping(value = "viewMessage", method = RequestMethod.GET)
    public String ShowMessage(WebRequest request, ModelMap model) {
        int id = Integer.parseInt(request.getParameter("id"));
        model.addAttribute("messages", topicRepo.listMessage(id));
        return "allMessage";
    }

    @RequestMapping(value = "discussion", method = RequestMethod.GET)
    public String ShowReply(WebRequest request, ModelMap model) {
        int id = Integer.parseInt(request.getParameter("id"));
        model.addAttribute("replys", topicRepo.listReply(id));
        model.addAttribute("users", topicRepo.listUser());
        return "allReply";
    }

    @RequestMapping(value = "AddCommit", method = RequestMethod.POST)
    public View commitReply(WebRequest request, ModelMap model, Principal principal) {
        int msg_id = Integer.parseInt(request.getParameter("msg_id"));
        String content = request.getParameter("comment");
        String username = principal.getName();

        Reply reply = new Reply();
        reply.setMessage_id(msg_id);
        reply.setContent(content);
        reply.setUsername(username);
        topicRepo.addReply(reply);
        String path = "discussion?id=" + msg_id;
        model.addAttribute("replys", topicRepo.listReply(msg_id));
        model.addAttribute("users", topicRepo.listUser());
        return new RedirectView(path, true);
    }

    @RequestMapping(value = "deleteMsg", method = RequestMethod.GET)
    public View adminDeleteMsg(WebRequest request, ModelMap model) {
        int msg_id = Integer.parseInt(request.getParameter("id"));
        topicRepo.deleteMsg(msg_id);
        int topic_id = Integer.parseInt(request.getParameter("topic_id"));
        String path = "viewMessage?id=" + topic_id;
        model.addAttribute("messages", topicRepo.listMessage(topic_id));
        return new RedirectView(path, true);
    }

    @RequestMapping(value = "deleteReply", method = RequestMethod.GET)
    public View adminDeleteReply(WebRequest request, ModelMap model) {
        int reply_id = Integer.parseInt(request.getParameter("id"));
        int msg_id = Integer.parseInt(request.getParameter("msg_id"));
        topicRepo.deleteReply(reply_id);
        String path = "discussion?id=" + msg_id;
        model.addAttribute("replys", topicRepo.listReply(msg_id));
        model.addAttribute("users", topicRepo.listUser());
        return new RedirectView(path, true);
    }

    @RequestMapping(value = "AddMessage", method = RequestMethod.POST)
    public View adminAddMessage(WebRequest request, ModelMap model, Principal principal) {
        int topic_id = Integer.parseInt(request.getParameter("topic_id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Message message = new Message();
        message.setTitle(title);
        message.setContent(content);
        message.setTopic_id(topic_id);
        message.setUsername(principal.getName());
        topicRepo.addMessage(message);
        String path = "viewMessage?id=" + topic_id;
        model.addAttribute("messages", topicRepo.listMessage(topic_id));
        return new RedirectView(path, true);
    }

}
