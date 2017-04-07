CREATE TABLE users (
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    PRIMARY KEY (username)
);

CREATE TABLE user_roles (
    user_role_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    username VARCHAR(50) NOT NULL,
    userrole VARCHAR(50) NOT NULL,
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


