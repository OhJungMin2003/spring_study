drop user c##testweb cascade;
CREATE USER c##testweb IDENTIFIED BY testweb;
GRANT CONNECT, RESOURCE TO c##testweb;
GRANT CREATE VIEW TO c##testweb;
ALTER USER c##testweb
QUOTA 1024M ON USERS;