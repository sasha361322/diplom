DROP TABLE IF EXISTS AUTHORITY;
DROP TABLE IF EXISTS AUTH_USER;
DROP TABLE IF EXISTS AUTH_USER_AUTHORITY;
DROP TABLE IF EXISTS CONNECTION;
--=========================================================================================================
--============================================AUTHORITY====================================================
--=========================================================================================================
CREATE TABLE AUTHORITY(
  CODE 						            VARCHAR(50) 		PRIMARY KEY,
  DESCRIPTION 				        VARCHAR(256)		DEFAULT NULL
);
--=========================================================================================================
--============================================AUTH_USER====================================================
--=========================================================================================================
CREATE TABLE AUTH_USER(
  AUTH_USER_ID 				        BIGINT 				  PRIMARY KEY AUTO_INCREMENT,
  EMAIL 						          VARCHAR(256)		NOT NULL,
  FIRST_NAME 					        VARCHAR(256)		DEFAULT NULL,
  LAST_NAME 					        VARCHAR(256)		DEFAULT NULL,
  PASSWORD 					          VARCHAR(256)		NOT NULL,
  ACTIVE 						          BOOLEAN				  DEFAULT NULL,
  LAST_PASSWORD_RESET_DATE 	  TIMESTAMP			  NOT NULL,
);
CREATE UNIQUE INDEX IDX_AUTH_USER ON AUTH_USER(EMAIL);
--=========================================================================================================
--======================================AUTH_USER_AUTHORITY================================================
--=========================================================================================================
CREATE TABLE AUTH_USER_AUTHORITY(
  AUTH_USER 					        BIGINT				  NOT NULL,
  AUTHORITY 					        VARCHAR(50)			NOT NULL
);
CREATE UNIQUE INDEX IDX_AUTH_USER_AUTHORITY ON AUTH_USER_AUTHORITY (AUTH_USER, AUTHORITY);
--FK AUTH_USER_AUTHORITY.AUTH_USER -> AUTH_USER.AUTH_USER_ID
ALTER TABLE AUTH_USER_AUTHORITY
  ADD CONSTRAINT FK_AUTH_USER_AUTHORITY_ON_AUTH_USER FOREIGN KEY (AUTH_USER) REFERENCES AUTH_USER (AUTH_USER_ID);
--FK AUTH_USER_AUTHORITY.AUTHORITY -> AUTHORITY.CODE
ALTER TABLE AUTH_USER_AUTHORITY
  ADD CONSTRAINT FK_AUTH_USER_AUTHORITY_ON_AUTHORITY FOREIGN KEY (AUTHORITY) REFERENCES AUTHORITY (CODE);
--=========================================================================================================
--============================================DRIVER===================================================
--=========================================================================================================
CREATE TABLE DRIVER(
  CODE                            VARCHAR(50)                   PRIMARY KEY,
  DESCRIPTION                     VARCHAR(256)                  DEFAULT NULL
);
--=========================================================================================================
--============================================CONNECTION===================================================
--=========================================================================================================
CREATE TABLE CONNECTION(
  CONNECTION_ID 					        BIGINT AUTO_INCREMENT				  PRIMARY KEY,
  URL 						                VARCHAR(256)			            NOT NULL,
  DRIVER 				                  VARCHAR(50)		                NOT NULL,
  USER 				                    VARCHAR(256)		              NOT NULL,
  PASSWORD 				                VARCHAR(256)		              NOT NULL,
  SCHEMA 				                  VARCHAR(256)		              NOT NULL,
  AUTH_USER 					            BIGINT				                NOT NULL
);
--FK CONNECTION.AUTH_USER -> AUTH_USER.AUTH_USER_ID
ALTER TABLE CONNECTION
  ADD CONSTRAINT FK_CONNECTION_ON_AUTH_USER FOREIGN KEY (AUTH_USER) REFERENCES AUTH_USER(AUTH_USER_ID);
--FK CONNECTION.DRIVER -> DRIVER.CODE
ALTER TABLE CONNECTION
  ADD CONSTRAINT FK_CONNECTION_ON_AUTH_USER FOREIGN KEY (DRIVER) REFERENCES DRIVER(CODE);

INSERT INTO AUTHORITY VALUES(
  'ROLE_ADMIN', 'Администратор приложения'
);

INSERT INTO AUTH_USER VALUES(
  1, 'sasha361322@gmail.com', 'Александр', 'Шипилов', '$2y$10$rdO4GaqZ.K3I8JZRpM6I3.Xy7mxqk/KMljGpNnVhm55l80MD5aPCq', TRUE, PARSEDATETIME('01-01-2017','dd-MM-yyyy')
);

INSERT INTO AUTH_USER_AUTHORITY VALUES(
  1, 'ROLE_ADMIN'
);

INSERT INTO DRIVER VALUES(
  1, 'H2'
);

INSERT INTO CONNECTION VALUES(
  'jdbc:h2:D:\VEBDLC-pilot\target\dac-veb\db', 'H2', 'sa', '', 'PUBLIC', 1
);