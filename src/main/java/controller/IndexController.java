/* 
    Created on  : Mar 29, 2017, 10:32:48 PM
    Author      : Ho Kin Fai, Wong Tak Ming, Chow wa wai
    Project     : comps380f
    Purpose     : Index Router
 */
package controller;

import dao.TopicRepository;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Attachment;
import model.Message;
import model.PollAnswer;
import model.Reply;
import model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.multipart.MultipartFile;
import view.DownloadingView;

@Controller
public class IndexController {

    private JdbcTemplate jdbcTemplate;
    private Map<Long, List<Attachment>> ticketDatabase = new LinkedHashMap<>();
    private Map<Long, List<Attachment>> messageDatabase = new LinkedHashMap<>();
    @Autowired
    TopicRepository topicRepo;

    @RequestMapping({"/", "home"})
    public String index(ModelMap model, Principal principal) {
        model.addAttribute("lectures", topicRepo.findTopics("lecture"));
        model.addAttribute("labs", topicRepo.findTopics("lab"));
        model.addAttribute("others", topicRepo.findTopics("other"));
        model.addAttribute("poll", topicRepo.findPoll());
        if (SecurityContextHolder.getContext().getAuthentication() != null
                && SecurityContextHolder.getContext().getAuthentication().isAuthenticated()
                && //when Anonymous Authentication is enabled
                !(SecurityContextHolder.getContext().getAuthentication() instanceof AnonymousAuthenticationToken)) {
            model.addAttribute("user", principal.getName());

            List<PollAnswer> answerList = topicRepo.yourAnswer();
            if (answerList.size() > 0) {
                for (PollAnswer pa : answerList) {
                    if (pa.getUsername().equals(principal.getName())
                            && pa.getPoll_id() == topicRepo.findPoll().getId()) {
                        model.addAttribute("pollAnswered", pa);
                    }
                }
            }
        }
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
            user.addRole("ROLE_USER");
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

    @RequestMapping(value = "editUser", method = RequestMethod.POST)
    public View adminCommitEditUser(WebRequest request, ModelMap model) {

        User user = new User();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String[] roles = request.getParameterValues("role");

        user.setName(username);
        user.setPassword(password);

        for (String role : roles) {
            user.addRole(role);
        }

        topicRepo.editUser(user);
        return new RedirectView("admin", true);
    }

    @RequestMapping(value = "editUser", method = RequestMethod.GET)
    public ModelAndView adminEditUser(WebRequest request, ModelMap model) {
        String username = request.getParameter("name");
        model.addAttribute("user", topicRepo.findOneUser(username));
        return new ModelAndView("editUser", "command", new User());
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

    @RequestMapping(value = "vote", method = RequestMethod.POST)
    public View commitVote(WebRequest request, ModelMap model, Principal principal) {
        int poll_id = Integer.parseInt(request.getParameter("poll_id"));
        String username = principal.getName();
        String answer = request.getParameter("answer");
        topicRepo.CommitVote(username, poll_id, answer);

        model.addAttribute("lectures", topicRepo.findTopics("lecture"));
        model.addAttribute("labs", topicRepo.findTopics("lab"));
        model.addAttribute("others", topicRepo.findTopics("other"));
        model.addAttribute("poll", topicRepo.findPoll());
        List<PollAnswer> answerList = topicRepo.yourAnswer();
        if (answerList.size() > 0) {
            for (PollAnswer pa : answerList) {
                if (pa.getUsername().equals(principal.getName())
                        && pa.getPoll_id() == topicRepo.findPoll().getId()) {
                    model.addAttribute("pollAnswered", pa);
                }
            }
        }
        return new RedirectView("/", true);
    }

    @RequestMapping(value = "pollHistory", method = RequestMethod.GET)
    public String pollHistory(ModelMap model) {
        model.addAttribute("pollList", topicRepo.pollHistory());
        return "pollHistory";
    }

    @RequestMapping("createPoll")
    public String createPoll() {
        return "createPoll";
    }

    @RequestMapping(value = "createPoll", method = RequestMethod.POST)
    public View CommitCreatePoll(WebRequest request) {
        String title = request.getParameter("title");
        String a = request.getParameter("a");
        String b = request.getParameter("b");
        String c = request.getParameter("c");
        String d = request.getParameter("d");

        topicRepo.CreatePoll(title, a, b, c, d);
        return new RedirectView("createPoll?status=ok", true);

    }

    @RequestMapping(value = "discussion", method = RequestMethod.GET)
    public ModelAndView ShowReply(WebRequest request, ModelMap model) {
        int id = Integer.parseInt(request.getParameter("id"));
        model.addAttribute("replys", topicRepo.listReply(id));
        model.addAttribute("users", topicRepo.listUser());
        model.addAttribute("attachmentDatabase", ticketDatabase);
        return new ModelAndView("allReply", "replyForm", new ReplyForm());
    }

    @RequestMapping(value = "discussion", method = RequestMethod.POST)
    public View create(ReplyForm form, Principal principal) throws IOException {
        Reply reply = new Reply();
        reply.setUsername(principal.getName());
        reply.setMessage_id(form.getMsg_id());
        reply.setContent(form.getContent());
        topicRepo.addReply(reply);
        long i = 1;
        List<Attachment> attList = new ArrayList<Attachment>();
        for (MultipartFile filePart : form.getAttachments()) {
            Attachment attachment = new Attachment();
            attachment.setName(filePart.getOriginalFilename());
            attachment.setMimeContentType(filePart.getContentType());
            attachment.setContents(filePart.getBytes());
            attachment.setId(i);
            if (attachment.getName() != null && attachment.getName().length() > 0
                    && attachment.getContents() != null && attachment.getContents().length > 0) {

                attList.add(attachment);
                i++;
            }
            this.ticketDatabase.put(new Long(topicRepo.findReply()), attList);
        }

        return new RedirectView("discussion?id=" + reply.getMessage_id(), true);
    }

    @RequestMapping(value = "attachment", method = RequestMethod.GET)
    public View download(WebRequest request) {
        long attachmentID = (long) Integer.parseInt(request.getParameter("attachmentID"));
        int reply_id = Integer.parseInt(request.getParameter("reply_id"));
        long id = (long) Integer.parseInt(request.getParameter("reply_id"));

        List<Attachment> attList = this.ticketDatabase.get(id);
        Attachment attachment = new Attachment();

        if (attList != null) {
            for (Attachment att : attList) {
                System.out.println("" + attachmentID + "loop: " + att.getId());
                if (att.getId() == attachmentID) {
                    return new DownloadingView(att.getName(),
                            att.getMimeContentType(), att.getContents());
                }
            }

        }

        return new RedirectView("discussion?id=" + reply_id, true);
    }

    public static class ReplyForm {

        private int msg_id;

        private String title;
        private String content;
        private List<MultipartFile> attachments;

        public int getMsg_id() {
            return msg_id;
        }

        public void setMsg_id(int topic_id) {
            this.msg_id = topic_id;
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

        public List<MultipartFile> getAttachments() {
            return attachments;
        }

        public void setAttachments(List<MultipartFile> attachments) {
            this.attachments = attachments;
        }
    }

    @RequestMapping(value = "viewMessage", method = RequestMethod.GET)
    public ModelAndView ShowMessage(WebRequest request, ModelMap model) {
        int id = Integer.parseInt(request.getParameter("id"));
        model.addAttribute("messages", topicRepo.listMessage(id));
        model.addAttribute("users", topicRepo.listUser());
        model.addAttribute("attachmentDatabase", messageDatabase);
        return new ModelAndView("allMessage", "messageForm", new MessageForm());
    }

    @RequestMapping(value = "viewMessage", method = RequestMethod.POST)
    public View adminAddMessage(MessageForm form, Principal principal, ModelMap model)  throws IOException{

        Message message = new Message();
        message.setTitle(form.getTitle());
        message.setContent(form.getContent());
        message.setTopic_id(form.getTopic_id());
        message.setUsername(principal.getName());
        
        System.out.println(form.getTopic_id());
        topicRepo.addMessage(message);
        
        long i = 1;
        
        List<Attachment> attList = new ArrayList<Attachment>();
        for (MultipartFile filePart : form.getAttachments()) {
            Attachment attachment = new Attachment();
            attachment.setName(filePart.getOriginalFilename());
            attachment.setMimeContentType(filePart.getContentType());
            attachment.setContents(filePart.getBytes());
            attachment.setId(i);
            if (attachment.getName() != null && attachment.getName().length() > 0
                    && attachment.getContents() != null && attachment.getContents().length > 0) {

                attList.add(attachment);
                i++;
            }
            this.messageDatabase.put(new Long(topicRepo.findMsg()), attList);
        }

        String path = "viewMessage?id=" + form.getTopic_id();
        model.addAttribute("messages", topicRepo.listMessage(form.getTopic_id()));
        return new RedirectView(path, true);
    }

    @RequestMapping(value = "Msgattachment", method = RequestMethod.GET)
    public View Msgdownload(WebRequest request) {
        long attachmentID = (long) Integer.parseInt(request.getParameter("attachmentID"));
        int message_id = Integer.parseInt(request.getParameter("message_id"));
        long id = (long) Integer.parseInt(request.getParameter("message_id"));

        List<Attachment> attList = this.messageDatabase.get(id);
        Attachment attachment = new Attachment();

        if (attList != null) {
            for (Attachment att : attList) {
                System.out.println("" + attachmentID + "loop: " + att.getId());
                if (att.getId() == attachmentID) {
                    return new DownloadingView(att.getName(),
                            att.getMimeContentType(), att.getContents());
                }
            }

        }

        return new RedirectView("viewMessage?id=" + message_id, true);
    }
    
    public static class MessageForm {

        private int topic_id;
        private String title;
        private String content;
        private List<MultipartFile> attachments;

        public int getTopic_id() {
            return topic_id;
        }

        public void setTopic_id(int topic_id) {
            this.topic_id = topic_id;
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

        public List<MultipartFile> getAttachments() {
            return attachments;
        }

        public void setAttachments(List<MultipartFile> attachments) {
            this.attachments = attachments;
        }
    }

}
