INSERT INTO users(username, password) VALUES ('admin', 'admin');
INSERT INTO user_roles (username,role) VALUES ('admin', 'ROLE_ADMIN');

INSERT INTO users(username, password) VALUES ('user', 'user');
INSERT INTO user_roles (username,role) VALUES ('user', 'ROLE_USER');
INSERT INTO users(username, password) VALUES ('samuel', 'sameul');
INSERT INTO user_roles (username,role) VALUES ('samuel', 'ROLE_USER');
INSERT INTO users(username, password) VALUES ('ming', 'ming');
INSERT INTO user_roles (username,role) VALUES ('ming', 'ROLE_USER');

INSERT INTO poll (poll_title,a,b,c,d) VALUES ('Sam is handsome' , 'Very agree', 'cant agree more', 'ofcoz handsome' , 'agree');
INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'user', 'B');
INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'samuel', 'C');
INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'ming', 'D');

INSERT INTO poll (poll_title,a,b,c,d) VALUES ('Ted is multi-threading' , 'Very agree', 'cant agree more', 'ofcoz handsome' , 'agree');
INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'user', 'B');
INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'samuel', 'C');
INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'ming', 'D');

INSERT INTO topic (topic_name, category) VALUES ('Lecture 01', 'lecture');
INSERT INTO topic (topic_name, category) VALUES ('Lab 01', 'lab');
INSERT INTO topic (topic_name, category) VALUES ('Other 01', 'other');

INSERT INTO message (msg_title, msg_content, topic_id, username) 
VALUES ('Lecture 01 is now available' , 'Go to Discussion to leave you first comment' , 1, 'admin');

INSERT INTO reply (reply_content, msg_id, username ) 
VALUES ('first reply to hello world' , 1 , 'admin');
