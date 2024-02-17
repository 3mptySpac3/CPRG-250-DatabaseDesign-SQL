alter session set "_ORACLE_SCRIPT"=true; 
DROP USER hollywood CASCADE;

CREATE USER hollywood IDENTIFIED BY password
      DEFAULT TABLESPACE users;
ALTER USER hollywood quota unlimited on users;
GRANT RESOURCE, CONNECT, CREATE VIEW TO hollywood;