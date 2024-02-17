rem 
rem Creating the Hollywood North tables with constraints
rem - Step 1 - remove child tables first and then parent tables
-- rem client might be shared with mutual_fund_client, watch for this
set echo on
spool c:/cprg250s/hollywoodcreateoutput.txt
rem set language to english to avoid problems with non-english machines
alter session set NLS_LANGUAGE = ENGLISH;

DROP TABLE hn_entertainerGig;
DROP TABLE hn_entertainerMusicalStyles;
DROP TABLE hn_entertainer;
DROP TABLE hn_client;
DROP TABLE hn_agent;
DROP TABLE hn_manager;
DROP TABLE hn_type;
DROP TABLE hn_musicalStyles;
REM Question 2 CREATE TABLE at column level
CREATE TABLE hn_type
(entertainerTypeID NUMBER CONSTRAINT SYS_TYPE_PK PRIMARY KEY,
 description VARCHAR2(50) CONSTRAINT SYS_TYPE_DESC_NN NOT NULL);

 CREATE TABLE hn_manager
(managerID NUMBER CONSTRAINT SYS_MGR_PK PRIMARY KEY,
 firstname VARCHAR2(25) NOT NULL,
 lastname VARCHAR2(25) NOT NULL,
 busname VARCHAR2(50) NOT NULL,
 homephone CHAR(12) CONSTRAINT SYS_MGT_HOME_PHONE_CK 
     CHECK ( REGEXP_LIKE (homePhone, '[1-9]([0-9]){2}[.]([0-9]){3}[.]([0-9]){4}')),
 busphone CHAR(12) NOT NULL
   CONSTRAINT SYS_MGT_BUS_PHONE_CK 
     CHECK ( REGEXP_LIKE (busPhone, '[1-9]([0-9]){2}[.]([0-9]){3}[.]([0-9]){4}')),
 email VARCHAR2(60) NOT NULL
    CONSTRAINT SYS_MGR_EMAIL_UK UNIQUE
);

rem create table at table level

CREATE TABLE hn_entertainer
(entertainerID NUMBER CONSTRAINT SYS_ENTERTAIN_PK PRIMARY KEY,
 entertainerTypeID NUMBER CONSTRAINT SYS_ENTERTAIN_TYPE_FK REFERENCES hn_TYPE(entertainerTypeID)
	NOT NULL,
 managerID NUMBER CONSTRAINT SYS_ENTERTAIN_MGR_FK REFERENCES hn_manager(managerID)
	NOT NULL,
 firstName VARCHAR2(25) NOT NULL,
 lastName VARCHAR2(25)  NOT NULL,
 stageName VARCHAR2(50) NOT NULL,
 eventType VARCHAR2(50),
 homePhone CHAR(12) CONSTRAINT SYS_ENT_HOME_PHONE_CK 
     CHECK ( REGEXP_LIKE (homePhone, '[1-9]([0-9]){2}[.]([0-9]){3}[.]([0-9]){4}')),
 busPhone CHAR(12)  CONSTRAINT SYS_ENTERTAIN_BPHONE_NN NOT NULL
     CONSTRAINT SYS_ENT_BUS_PHONE_CK 
       CHECK ( REGEXP_LIKE (busPhone, '[1-9]([0-9]){2}[.]([0-9]){3}[.]([0-9]){4}')),
 email VARCHAR2(60)  NOT NULL
    CONSTRAINT SYS_ENTERTAIN_EMAIL_UK UNIQUE
);

CREATE TABLE hn_musicalStyles
(styleID NUMBER CONSTRAINT SYS_MS_PK PRIMARY KEY,
 description VARCHAR2(50) NOT NULL);
 
 CREATE TABLE hn_entertainerMusicalStyles
(styleID NUMBER,
 entertainerID NUMBER,
 CONSTRAINT SYS_ENTSTYLES_PK PRIMARY KEY (styleid, entertainerID),
 CONSTRAINT SYS_MSTYLE_ENTMSTYLE_FK FOREIGN KEY (styleID) REFERENCES hn_musicalStyles(styleID),
 CONSTRAINT SYS_ENT_ENTMSTYLE_FK FOREIGN KEY (entertainerID) REFERENCES hn_entertainer(entertainerID)
);
 
rem basic create table, add constraints afterwards using alter table

-- agent table
CREATE TABLE hn_agent
(agentID NUMBER,
 firstName VARCHAR2(25), 
 lastName VARCHAR2(25),
 hireDate DATE,
 busPhone CHAR(12),
 homePhone CHAR(12),
 email VARCHAR2(60));


ALTER TABLE hn_agent 
 MODIFY firstName NOT NULL
 MODIFY lastName  NOT NULL
 MODIFY busPhone NOT NULL
 MODIFY email NOT NULL;
 
ALTER TABLE hn_agent
 ADD CONSTRAINT SYS_AGT_BUS_PHONE_CK 
       CHECK ( REGEXP_LIKE (busPhone, '[1-9]([0-9]){2}[.]([0-9]){3}[.]([0-9]){4}'))
 ADD CONSTRAINT SYS_AGT_HOME_PHONE_CK 
       CHECK ( REGEXP_LIKE (homePhone, '[1-9]([0-9]){2}[.]([0-9]){3}[.]([0-9]){4}'))
 ADD CONSTRAINT SYS_AGT_PK PRIMARY KEY (agentid)
 ADD CONSTRAINT SYS_AGT_EMAIL_UK UNIQUE (email);
 
-- client table

CREATE TABLE hn_client
(clientID NUMBER,
 agentID NUMBER,
 firstName VARCHAR2(25),
 lastName VARCHAR2(25),
 homePhone CHAR(12), 
 busPhone CHAR(12),
 email VARCHAR2(60)
);

ALTER TABLE hn_client
 MODIFY firstName NOT NULL
 MODIFY agentID NOT NULL
 MODIFY lastName NOT NULL
 MODIFY busPhone NOT NULL
 MODIFY email NOT NULL;

ALTER TABLE hn_client
 ADD CONSTRAINT SYS_CLIENT_HOME_PHONE_CK 
       CHECK ( REGEXP_LIKE (homePhone, '[1-9]([0-9]){2}[.]([0-9]){3}[.]([0-9]){4}'))
 ADD CONSTRAINT SYS_CLIENT_BUS_PHONE_CK 
       CHECK ( REGEXP_LIKE (busPhone, '[1-9]([0-9]){2}[.]([0-9]){3}[.]([0-9]){4}'))
 ADD CONSTRAINT SYS_CLIENT_PK PRIMARY KEY (clientID)
 ADD CONSTRAINT SYS_CLIENT_AGT_FK FOREIGN KEY (agentID)
   REFERENCES hn_agent(agentid)
 ADD CONSTRAINT SYS_CLIENT_EMAIL_UK UNIQUE (email);

CREATE TABLE hn_entertainerGig
(entertainerID NUMBER,
 clientID NUMBER,
 startDate DATE,
 clientFee NUMBER(7,2),
 entertainerFee NUMBER(7,2),
 street VARCHAR2(50) NOT NULL,
 city VARCHAR2(25) NOT NULL,
 prov CHAR(2) NOT NULL,
 postalCode CHAR(6) NOT NULL,
 CONSTRAINT SYS_ENTGIG_PK PRIMARY KEY (entertainerID, clientID, startDate),
 CONSTRAINT SYS_ENTGIG_ENT_FK FOREIGN KEY (entertainerID)
  REFERENCES hn_entertainer(entertainerID),
 CONSTRAINT SYS_ENTGIG_CLT_FK FOREIGN KEY (clientID)
  REFERENCES hn_client(clientID),
 CONSTRAINT SYS_ENTGIG_FEES_CK CHECK (clientFee >= entertainerFee),
 CONSTRAINT SYS_ENTGIG_PROV_CK CHECK (UPPER(prov) in ('AB',
   'BC', 'MB', 'NB', 'NL', 'NS', 'NT', 'NU', 'ON', 'PE', 'QC',
   'SK', 'YT')),
 CONSTRAINT SYS_EG_POSTAL_CK 
    CHECK (REGEXP_LIKE (postalCode, '([A-Z][0-9]){3}'))
);

spool off

