CREATE TABLE users (
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    PRIMARY KEY (username)
);

CREATE TABLE user_roles (
    user_role_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    username VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_role_id),
    FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE poll(
    poll_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    poll_title VARCHAR(255),
    a VARCHAR(100),
    b VARCHAR(100),
    c VARCHAR(100),
    d VARCHAR(100),
    PRIMARY KEY (poll_id)
);


CREATE TABLE poll_answer(
    answer_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    poll_id INTEGER NOT NULL,
    username VARCHAR(50) NOT NULL,
    answer VARCHAR(50) NOT NULL,
    PRIMARY KEY (answer_id, answer),
    FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE topic(
    topic_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    topic_name VARCHAR(50),
    category VARCHAR(50),
    PRIMARY KEY (topic_id)
);

CREATE TABLE message(
    msg_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    msg_title VARCHAR(50),
    msg_content VARCHAR(255),
    topic_id INTEGER,
    username VARCHAR(50) NOT NULL,
    PRIMARY KEY (msg_id),
    FOREIGN KEY (topic_id) REFERENCES topic(topic_id),
    FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE reply(
    reply_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    reply_content VARCHAR(255),
    msg_id INTEGER,
    username VARCHAR(50) NOT NULL,
    PRIMARY KEY (reply_id),
    FOREIGN KEY (msg_id) REFERENCES message(msg_id),
    FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE msg_attachments(
    att_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    msg_id int NOT NULL,
    att_name VARCHAR(60) NOT NULL,
    username VARCHAR(50) NOT NULL,
    att_mimetype VARCHAR(60) NOT NULL,
    att_data VARCHAR(8000) NOT NULL,
    PRIMARY KEY (att_id),
    FOREIGN KEY (username) REFERENCES users(username),
    FOREIGN KEY (msg_id) REFERENCES message(msg_id)
);

CREATE TABLE reply_attachments(
    att_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    reply_id int NOT NULL,
    att_name VARCHAR(60) NOT NULL,
    username VARCHAR(50) NOT NULL,
    att_mimetype VARCHAR(60) NOT NULL,
    att_data VARCHAR(8000) NOT NULL,
    PRIMARY KEY (att_id),
    FOREIGN KEY (reply_id) REFERENCES reply(reply_id)
);

INSERT INTO users(username, password) VALUES ('admin', 'admin');
INSERT INTO user_roles (username,role) VALUES ('admin', 'ROLE_ADMIN');

INSERT INTO users(username, password) VALUES ('user', 'user');
INSERT INTO user_roles (username,role) VALUES ('user', 'ROLE_USER');
INSERT INTO users(username, password) VALUES ('samuel', 'sameul');
INSERT INTO user_roles (username,role) VALUES ('samuel', 'ROLE_USER');
INSERT INTO users(username, password) VALUES ('ming', 'ming');
INSERT INTO user_roles (username,role) VALUES ('ming', 'ROLE_USER');

INSERT INTO poll (poll_title,a,b,c,d) VALUES ('Sam is handsome?' , 'Very agree', 'cant agree more', 'ofcoz handsome' , 'agree');
INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'user', 'B');
INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'samuel', 'C');
INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'ming', 'D');

INSERT INTO poll (poll_title,a,b,c,d) VALUES ('Ted is multi-threading?' , 'Very agree', 'cant agree more', 'ofcoz handsome' , 'agree');
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


INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'user', 'B');
INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'samuel', 'C');
INSERT INTO poll_answer (poll_id, username, answer) VALUES (1, 'ming', 'D');