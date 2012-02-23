CREATE TABLE todos (id INTEGER PRIMARY KEY, description VARCHAR(255), done INTEGER, user_id INTEGER);
INSERT INTO "todos" VALUES(1,'Foo Bar Baz',0,1);
INSERT INTO "todos" VALUES(2,'Buy Milk',0,1);
INSERT INTO "todos" VALUES(3,'Make some Coffee',0,1);
INSERT INTO "todos" VALUES(4,'Read SICP',0,1);
INSERT INTO "todos" VALUES(5,'Go to the gym',0,1);
INSERT INTO "todos" VALUES(6,'Run in the marathon',0,1);
CREATE TABLE users (id INTEGER PRIMARY KEY);
INSERT INTO "users" VALUES(1);
