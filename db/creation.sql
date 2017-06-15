DROP TABLE IF EXISTS AUTHORITY;
DROP TABLE IF EXISTS AUTH_USER;
DROP TABLE IF EXISTS AUTH_USER_AUTHORITY;
DROP TABLE IF EXISTS CONNECTION;
DROP TABLE IF EXISTS DRIVER;
DROP TABLE IF EXISTS TEST_TABLE;
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
  ADD CONSTRAINT FK_CONNECTION_ON_AUTH_DRIVER FOREIGN KEY (DRIVER) REFERENCES DRIVER(CODE);

--=========================================================================================================
--============================================TEST_TABLE===================================================
--=========================================================================================================
CREATE TABLE TEST_TABLE (
  IDENTITY                      BIGINT AUTO_INCREMENT				  PRIMARY KEY,
  SALARY                        BIGINT
);
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
  'H2', 'h2 database driver'
);

INSERT INTO CONNECTION VALUES(
  1,'jdbc:h2:D:\VEBDLC-pilot\target\dac-veb\db', 'H2', 'sa', '', 'PUBLIC', 1
);
INSERT INTO TEST_TABLE VALUES
  (1, 3820),
  (2, 9470),
  (3, 3490),
  (4, 7790),
  (5, 4210),
  (6, 3870),
  (7, 4490),
  (8, 9620),
  (9, 6200),
  (10, 6350),
  (11, 7430),
  (12, 7670),
  (13, 6660),
  (14, 5490),
  (15, 5980),
  (16, 6250),
  (17, 8390),
  (18, 3630),
  (19, 6090),
  (20, 10450),
  (21, 6800),
  (22, 6470),
  (23, 9160),
  (24, 5110)
;
INSERT INTO TEST_TABLE (SALARY) VALUES
(6626),
(3416),
(9788),
(9290),
(3088),
(3463),
(6884),
(485),
(1727),
(5465),
(7527),
(2682),
(5565),
(6259),
(8434),
(7537),
(8220),
(5619),
(93),
(7883),
(7133),
(7502),
(4132),
(4703),
(9179),
(6741),
(256),
(3317),
(9557),
(5859),
(2053),
(7021),
(5267),
(8710),
(2500),
(1677),
(4426),
(6823),
(3297),
(7286),
(6378),
(8504),
(6879),
(9425),
(2100),
(2601),
(7847),
(8748),
(8009),
(3542);