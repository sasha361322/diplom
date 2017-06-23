DROP TABLE IF EXISTS AUTHORITY;
DROP TABLE IF EXISTS AUTH_USER;
DROP TABLE IF EXISTS AUTH_USER_AUTHORITY;
DROP TABLE IF EXISTS CONNECTION;
DROP TABLE IF EXISTS DRIVER;
DROP TABLE IF EXISTS TEST_TABLE;
DROP TABLE IF EXISTS NUMERIC_TEST;
DROP TABLE IF EXISTS ORGANIZATIONS;
DROP TABLE IF EXISTS PERSONS;
DROP TABLE IF EXISTS USER_AUTHORITY;
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
-- CREATE TABLE DRIVER(
--   CODE                            VARCHAR(50)                   PRIMARY KEY,
--   DESCRIPTION                     VARCHAR(256)                  DEFAULT NULL
-- );
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
-- ALTER TABLE CONNECTION
--   ADD CONSTRAINT FK_CONNECTION_ON_AUTH_DRIVER FOREIGN KEY (DRIVER) REFERENCES DRIVER(CODE);

--=========================================================================================================
--============================================TEST_TABLE===================================================
--=========================================================================================================
CREATE TABLE TEST_TABLE (
  IDENTITY                      BIGINT AUTO_INCREMENT				  PRIMARY KEY,
  SALARY                        BIGINT
);
--=========================================================================================================
--===========================================NUMERIC_TEST==================================================
--=========================================================================================================
CREATE TABLE NUMERIC_TEST(
	ID 		BIGINT 		AUTO_INCREMENT 		PRIMARY KEY,
	DATA 	DOUBLE
);
/*==============================================================*/
/* Справочник организаций                                       */
/*==============================================================*/
CREATE TABLE ORGANIZATIONS (
    GUID                VARCHAR(36)     PRIMARY KEY,    -- 8-4-4-4-12 hex digits - java UUID
    NAME                VARCHAR(64)     NOT NULL,
    ADRESS              TEXT            DEFAULT NULL
);

CREATE UNIQUE INDEX IDX_ORGANIZATIONS_ON_NAME ON ORGANIZATIONS (NAME);
/*==============================================================*/
/* Справочник сотрудников организаций                           */
/*==============================================================*/
CREATE TABLE PERSONS (
    GUID                VARCHAR(36)     PRIMARY KEY,    -- 8-4-4-4-12 hex digits - java UUID
    FIO                 VARCHAR(64)     NOT NULL,
    EMAIL               VARCHAR(64)     DEFAULT NULL,
    ORGANIZATION        VARCHAR(36)     DEFAULT NULL    -- ref ORGANIZATIONS
);

CREATE UNIQUE INDEX IDX_PERSONS_ON_FIO ON PERSONS (FIO);

ALTER TABLE PERSONS
  ADD CONSTRAINT FK_PERSONS_ON_ORGANIZATION FOREIGN KEY (ORGANIZATION) REFERENCES ORGANIZATIONS (GUID);

INSERT INTO AUTHORITY VALUES(
  'ADMIN', 'Администратор приложения'
);

INSERT INTO AUTH_USER VALUES(
  1, 'sasha361322@gmail.com', 'Александр', 'Шипилов', '$2a$10$IVf/eoW0s57abL2bIP0oVeFrGUyEl4I54Odu/.RlWXOGv.zNwmGzK', TRUE, PARSEDATETIME('01-01-2017','dd-MM-yyyy')
);

INSERT INTO AUTH_USER_AUTHORITY VALUES(
  1, 'ROLE_ADMIN'
);

-- INSERT INTO DRIVER VALUES(
--   'H2', 'h2 database driver'
-- );

INSERT INTO CONNECTION VALUES(
  1,'jdbc:h2:.\\db\\db', 'H2', 'sa', '', 'PUBLIC', 1
);

INSERT INTO TEST_TABLE (SALARY) VALUES
  (6626),(3416),(9788),(9290),(3088),(3463),(6884),(485),(1727),(5465),(7527),(2682),(5565),(6259),(8434),(7537),(8220),
  (5619),(93),(7883),(7133),(7502),(4132),(4703),(9179),(6741),(256),(3317),(9557),(5859),(2053),(7021),(5267),(8710),
  (2500),(1677),(4426),(6823),(3297),(7286),(6378),(8504),(6879),(9425),(2100),(2601),(7847),(8748),(8009),(3542),
  (6626),(3416),(9788),(9290),(3088),(3463),(6884),(485),(1727),(5465),(7527),(2682),(5565),(6259),(8434),(7537),(8220),
  (5619),(93),(7883),(7133),(7502),(4132),(4703),(9179),(6741),(256),(3317),(9557),(5859),(2053),(7021),(5267),(8710),
  (2500),(1677),(4426),(6823),(3297),(7286),(6378),(8504),(6879),(9425),(2100),(2601),(7847),(8748),(8009),(3542),
  (6626),(3416),(9788),(9290),(3088),(3463),(6884),(485),(1727),(5465),(7527),(2682),(5565),(6259),(8434),(7537),(8220),
  (5619),(93),(7883),(7133),(7502),(4132),(4703),(9179),(6741),(256),(3317),(9557),(5859),(2053),(7021),(5267),(8710),
  (2500),(1677),(4426),(6823),(3297),(7286),(6378),(8504),(6879),(9425),(2100),(2601),(7847),(8748),(8009),(3542),
  (6626),(3416),(9788),(9290),(3088),(3463),(6884),(485),(1727),(5465),(7527),(2682),(5565),(6259),(8434),(7537),(8220),
  (5619),(93),(7883),(7133),(7502),(4132),(4703),(9179),(6741),(256),(3317),(9557),(5859),(2053),(7021),(5267),(8710),
  (2500),(1677),(4426),(6823),(3297),(7286),(6378),(8504),(6879),(9425),(2100),(2601),(7847),(8748),(8009),(3542),
  (6626),(3416),(9788),(9290),(3088),(3463),(6884),(485),(1727),(5465),(7527),(2682),(5565),(6259),(8434),(7537),(8220),
  (5619),(93),(7883),(7133),(7502),(4132),(4703),(9179),(6741),(256),(3317),(9557),(5859),(2053),(7021),(5267),(8710),
  (2500),(1677),(4426),(6823),(3297),(7286),(6378),(8504),(6879),(9425),(2100),(2601),(7847),(8748),(8009),(3542),
  (1);

INSERT INTO NUMERIC_TEST (DATA) VALUES
(-2.25), (-2.25), (-2.25), (-2.25), (-1.75), (-1.75), (-1.75), (-1.75), (-1.75), (-1.75), (-1.75), (-1.75), (-1.25), (-1.25), (-1.25),
(-1.25), (-1.25), (-1.25), (-1.25), (-1.25), (-1.25), (-1.25), (-1.25), (-1.25), (-1.25), (-1.25), (-1.25), (-1.25), (-1.25), (-1.25),
(-1.25), (-1.25), (-1.25), (-1.25), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75),
(-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75),
(-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.75), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25),
(-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25),
(-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25),
(-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25), (-0.25),
(-0.25), (-0.25), (-0.25), (-0.25), (0.25), (0.25), (0.25), (0.25), (0.25), (0.25), (0.25), (0.25), (0.25), (0.25), (0.25), (0.25),
(0.25), (0.25), (0.25), (0.25), (0.25), (0.25),(0.25), (0.25),(0.25), (0.25), (0.25), (0.25), (0.25), (0.25), (0.25), (0.25), (0.25),
(0.25), (0.25),(0.25), (0.75), (0.75), (0.75), (0.75), (0.75), (0.75), (0.75), (0.75), (0.75), (0.75), (0.75), (0.75), (0.75), (0.75),
(0.75), (0.75), (0.75), (0.75), (0.75), (0.75), (1.25), (1.25), (1.25), (1.25), (1.25), (1.25), (1.25), (1.25), (1.25), (1.25), (1.25),
(1.25), (1.25), (1.25), (1.75), (1.75), (1.75), (1.75), (1.75), (1.75), (2.25), (2.25), (2.25), (2.25);

INSERT INTO ORGANIZATIONS VALUES
	('2dec7326-f2c1-4d80-9aa2-454f30151b76','Организация dec','Courtland Cir');
INSERT INTO PERSONS VALUES
	('82e371f7-4ffc-4fe8-8266-0168d23f2747','Cynthia Hill','Cynthia_Hill@CynthiaHill.ru','2dec7326-f2c1-4d80-9aa2-454f30151b76');
INSERT INTO PERSONS VALUES
	('f3a8e004-9f89-470c-aa6d-78633043e179','Cynthia Bradley','Cynthia_Bradley@CynthiaBradley.ru','2dec7326-f2c1-4d80-9aa2-454f30151b76');
INSERT INTO PERSONS VALUES
	('5be4897e-de1b-419c-aa90-75432eb1fbde','Andrew Porter','Andrew_Porter@AndrewPorter.ru','2dec7326-f2c1-4d80-9aa2-454f30151b76');
INSERT INTO PERSONS VALUES
	('fbf3783d-15bd-412e-be33-9ae11b54f985','Pedro Reyes','Pedro_Reyes@PedroReyes.ru','2dec7326-f2c1-4d80-9aa2-454f30151b76');
INSERT INTO PERSONS VALUES
	('aec24b1e-fc28-49dd-b8f5-67857e49d12a','Tyler Knight','Tyler_Knight@TylerKnight.ru','2dec7326-f2c1-4d80-9aa2-454f30151b76');
INSERT INTO PERSONS VALUES
	('db7c0809-541a-4d20-95fb-57b5f6cd7e00','Lloyd Rodriguez','Lloyd_Rodriguez@LloydRodriguez.ru','2dec7326-f2c1-4d80-9aa2-454f30151b76');
INSERT INTO PERSONS VALUES
	('2315a604-2f98-4340-bf7d-8e2577aaedd1','Timothy Martin','Timothy_Martin@TimothyMartin.ru','2dec7326-f2c1-4d80-9aa2-454f30151b76');
INSERT INTO PERSONS VALUES
	('981fb5e6-0a1e-49d3-97f1-52312fc892dc','Jack Carroll','Jack_Carroll@JackCarroll.ru','2dec7326-f2c1-4d80-9aa2-454f30151b76');
INSERT INTO PERSONS VALUES
	('67851baf-047f-41f7-bbf6-a103096a3ff3','Alexander Owens','Alexander_Owens@AlexanderOwens.ru','2dec7326-f2c1-4d80-9aa2-454f30151b76');
INSERT INTO PERSONS VALUES
	('6ce1e3f8-3245-4992-94b0-c0ef79a0d4e5','William Young','William_Young@WilliamYoung.ru','2dec7326-f2c1-4d80-9aa2-454f30151b76');
INSERT INTO ORGANIZATIONS VALUES
	('af275f0f-01bb-4f10-9e24-f3bb16f80880','Организация f27','Main Way');
INSERT INTO PERSONS VALUES
	('2e973a75-be47-4f6c-b80d-50dcf4002900','Norma Moore','Norma_Moore@NormaMoore.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('84d157bb-2e76-40c9-b1f9-9ac7bd4bffb4','Marjorie Porter','Marjorie_Porter@MarjoriePorter.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('af40e2aa-416a-421a-9a6b-d190d8e33fbd','Adam Myers','Adam_Myers@AdamMyers.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('7c3f0b9d-4835-44a8-8b4a-6d0149fecf4d','Ralph Morales','Ralph_Morales@RalphMorales.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('02ccf831-ee37-4cfc-adc0-375b5615552f','Benjamin Anderson','Benjamin_Anderson@BenjaminAnderson.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('af7c9e63-72e0-4441-8e37-cfa9fec4e97e','Jerome Bryant','Jerome_Bryant@JeromeBryant.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('05be861c-6169-4545-a6df-6cfae4c47103','Greg Flores','Greg_Flores@GregFlores.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('e71e8b5b-a601-4638-8eab-0c042e0fd50a','Bernard Lopez','Bernard_Lopez@BernardLopez.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('ece9b78f-53b5-4ac0-ae30-86dc7d8ca63e','Willie Ferguson','Willie_Ferguson@WillieFerguson.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('ecd2dd88-d9b7-4118-a5f2-95248a98fb29','Edwin Hughes','Edwin_Hughes@EdwinHughes.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('a05ce622-44a1-42cf-9737-d2e4e8f38c4e','Phillip Morgan','Phillip_Morgan@PhillipMorgan.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('0e0c85df-974d-4b23-b311-a3f678e5254b','Herbert Cooper','Herbert_Cooper@HerbertCooper.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('089343dd-28d8-49f7-ade5-4d68a06e8d59','Lawrence Smith','Lawrence_Smith@LawrenceSmith.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('9b729ae3-9431-4773-9f37-3fa72ac59833','Jeff Snyder','Jeff_Snyder@JeffSnyder.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('10b7594b-9808-4388-b8cc-b3ed4fe69525','Fred Wright','Fred_Wright@FredWright.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO PERSONS VALUES
	('8ffc50b7-e4e7-4efe-aee7-944854779700','Antonio Cox','Antonio_Cox@AntonioCox.ru','af275f0f-01bb-4f10-9e24-f3bb16f80880');
INSERT INTO ORGANIZATIONS VALUES
	('c95d8a08-842f-4ccf-8563-9d39859768ab','Организация 95d','Juniper Way');
INSERT INTO PERSONS VALUES
	('a195e01a-be08-49b4-83b1-28cebd338360','Ana Mills','Ana_Mills@AnaMills.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('3ea9a9e3-4338-4b44-b39c-3c8dcd895d82','Connie Ward','Connie_Ward@ConnieWard.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('abfd324f-b603-45ac-a6c4-1af84f8980f6','Joe Gardner','Joe_Gardner@JoeGardner.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('efd6a7f6-ca2e-46c2-bb92-5acc7e5c6c32','Derrick Campbell','Derrick_Campbell@DerrickCampbell.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('e84b569d-eb22-4d65-9ad4-9290984ae601','Wayne White','Wayne_White@WayneWhite.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('356a2378-8bae-444c-8080-6b9c8b819815','Jeremy Butler','Jeremy_Butler@JeremyButler.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('780fd045-c756-41c3-ba3b-a61197911d7e','Howard Thomas','Howard_Thomas@HowardThomas.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('160f28e0-5cf7-476e-b874-47f4ddbcf567','Roberto Moore','Roberto_Moore@RobertoMoore.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('e7b42f83-c20d-4c8c-9c38-f26e61a6df33','Philip Jones','Philip_Jones@PhilipJones.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('2df820b4-98e6-46a6-8774-2dceabf09fb7','Louis Daniels','Louis_Daniels@LouisDaniels.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('c20fb764-9b02-4890-a63b-2ba1138cad6a','Barry Russell','Barry_Russell@BarryRussell.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('3eed85c4-dcb5-4e9f-92fd-d8341aa98517','Bryan Bennett','Bryan_Bennett@BryanBennett.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('c1c67e04-3a31-4270-b9c4-9c0b97f1238a','Roberto Green','Roberto_Green@RobertoGreen.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('ba6761be-2b2a-4c1a-8258-45d86b27c278','Lee Ray','Lee_Ray@LeeRay.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO PERSONS VALUES
	('c5b8573c-23fe-430f-a6fe-e8383e97e46d','Raymond Webb','Raymond_Webb@RaymondWebb.ru','c95d8a08-842f-4ccf-8563-9d39859768ab');
INSERT INTO ORGANIZATIONS VALUES
	('87cdce87-16e0-4f3b-b0b4-9acc92aafb83','Организация 7cd','Juniper Pkwy');
INSERT INTO PERSONS VALUES
	('39b5feb9-48ed-49cd-b887-a9d0a96923ce','Edith Lane','Edith_Lane@EdithLane.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('6336c3f4-a7ad-4232-851b-05d10dd5e880','Elizabeth Berry','Elizabeth_Berry@ElizabethBerry.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('746026db-5698-427c-bcf1-5cecc5aa8b8d','Joseph Hill','Joseph_Hill@JosephHill.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('c670b2e1-0594-4064-a1c5-fa3b95f05405','Albert Hamilton','Albert_Hamilton@AlbertHamilton.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('98785c5d-d7d5-4c47-ae49-356ca8c3c9b9','Frederick Franklin','Frederick_Franklin@FrederickFranklin.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('b9ec3332-8110-450e-a2db-d5956f6ed667','Clyde Allen','Clyde_Allen@ClydeAllen.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('9b86c2bc-c9e2-4ff7-9dd1-7f39e8222c2a','Craig Ross','Craig_Ross@CraigRoss.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('35bcbef4-62fc-4687-bef5-49f634d203f9','Corey Martin','Corey_Martin@CoreyMartin.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('fdfb70d4-8bc7-4a3c-a3e1-e023695ab5c2','Joseph Mcdonald','Joseph_Mcdonald@JosephMcdonald.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('b2efdafd-000a-4855-94ec-e32488e38a97','Gregory Cole','Gregory_Cole@GregoryCole.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('67faf90f-bd69-4ae1-8dc9-03135c7fc5dc','Jeff Black','Jeff_Black@JeffBlack.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('32e69a3f-227b-479f-91ab-add10493ed6e','Dan Alexander','Dan_Alexander@DanAlexander.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('a92b0717-85a3-4ef7-ad40-6d9e9b526543','Philip Stewart','Philip_Stewart@PhilipStewart.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('bb65a6d5-4cb9-4ada-9d4b-c502236ae297','Harry Reynolds','Harry_Reynolds@HarryReynolds.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('508ad3cf-3d6e-4055-b3c1-a979052414cf','Ralph Boyd','Ralph_Boyd@RalphBoyd.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('575f41c1-151a-4aa2-b8ac-6f0eb0fb992d','Randall Hunt','Randall_Hunt@RandallHunt.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO PERSONS VALUES
	('8b139094-5fba-46fa-a3f1-bf4c81e77c56','Zachary Gomez','Zachary_Gomez@ZacharyGomez.ru','87cdce87-16e0-4f3b-b0b4-9acc92aafb83');
INSERT INTO ORGANIZATIONS VALUES
	('7f51f94e-9e9a-4c67-9013-69f75168d43f','Организация f51','West Peachtree St');
INSERT INTO PERSONS VALUES
	('4449cc99-67df-4d94-905e-a8d3870b82da','Danielle Wagner','Danielle_Wagner@DanielleWagner.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('51162fbc-97bd-4801-b94b-4e081b876d0a','Cynthia Kennedy','Cynthia_Kennedy@CynthiaKennedy.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('183356b0-a992-42f1-af6e-eb49c8a7e73f','Donald Evans','Donald_Evans@DonaldEvans.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('c2be0718-57c8-4881-8a55-378d1c78e4e6','Bryan Ellis','Bryan_Ellis@BryanEllis.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('714379f9-6436-4cdc-9400-29335cf7ce53','Edward Kennedy','Edward_Kennedy@EdwardKennedy.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('003d6c36-c066-47ac-8e47-03b30cb687b8','Roger Rice','Roger_Rice@RogerRice.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('5ec6fe5b-ed6b-4fb2-a5ad-f711863f88d3','John Wright','John_Wright@JohnWright.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('954d788a-6c24-48d7-b9e1-5958a39f0cfa','Brian Thomas','Brian_Thomas@BrianThomas.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('3bfe1e8f-4d37-41ef-bb67-0cf715dcfde1','Tim Reed','Tim_Reed@TimReed.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('ff24a548-978f-4480-ac51-464744ebace6','Johnny King','Johnny_King@JohnnyKing.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('55662d82-c788-4090-b3d9-eefd7ac35813','Floyd Harris','Floyd_Harris@FloydHarris.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('57e6521a-8719-4a5e-a0e2-655d4b2157de','Philip Bennett','Philip_Bennett@PhilipBennett.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO PERSONS VALUES
	('e72dccd9-6d11-4e31-9ab1-de4f053554ca','Francis Hawkins','Francis_Hawkins@FrancisHawkins.ru','7f51f94e-9e9a-4c67-9013-69f75168d43f');
INSERT INTO ORGANIZATIONS VALUES
	('dba90beb-7d6a-46c1-a58a-26711b39e71c','Организация ba9','Second Ave');
INSERT INTO PERSONS VALUES
	('f1db129f-2a5b-4f56-86f1-625b3084f7e7','Eleanor Parker','Eleanor_Parker@EleanorParker.ru','dba90beb-7d6a-46c1-a58a-26711b39e71c');
INSERT INTO PERSONS VALUES
	('5bb1d248-b958-42bd-9ac0-73fc68aaa669','Thelma Ortiz','Thelma_Ortiz@ThelmaOrtiz.ru','dba90beb-7d6a-46c1-a58a-26711b39e71c');
INSERT INTO PERSONS VALUES
	('c1396420-07ac-4e89-b783-eb8d22d5b95f','Antonio Hernandez','Antonio_Hernandez@AntonioHernandez.ru','dba90beb-7d6a-46c1-a58a-26711b39e71c');
INSERT INTO PERSONS VALUES
	('0e97e87f-bbb2-420f-b95e-a54cbab94b5c','Martin Dunn','Martin_Dunn@MartinDunn.ru','dba90beb-7d6a-46c1-a58a-26711b39e71c');
INSERT INTO PERSONS VALUES
	('21a19afd-b7e6-4338-bf82-e14dd311d641','Alvin Ford','Alvin_Ford@AlvinFord.ru','dba90beb-7d6a-46c1-a58a-26711b39e71c');
INSERT INTO PERSONS VALUES
	('8b4167d7-ac25-4a95-9040-f23fecc01cbf','Ryan Parker','Ryan_Parker@RyanParker.ru','dba90beb-7d6a-46c1-a58a-26711b39e71c');
INSERT INTO PERSONS VALUES
	('0f29b858-e30a-42b3-935a-9ca92720e6d5','Travis Anderson','Travis_Anderson@TravisAnderson.ru','dba90beb-7d6a-46c1-a58a-26711b39e71c');
INSERT INTO PERSONS VALUES
	('80fc2069-9d10-4f91-8d98-0ef10262928e','Gene Grant','Gene_Grant@GeneGrant.ru','dba90beb-7d6a-46c1-a58a-26711b39e71c');
INSERT INTO PERSONS VALUES
	('a8bde092-2cfb-4f69-ac41-e166ddcc32f1','Nathan Gonzalez','Nathan_Gonzalez@NathanGonzalez.ru','dba90beb-7d6a-46c1-a58a-26711b39e71c');
INSERT INTO ORGANIZATIONS VALUES
	('1e01ff74-4f6b-44e6-98ed-8526156a23d6','Организация e01','Peachtree Way');
INSERT INTO PERSONS VALUES
	('eff9cea1-b53d-45bc-9f32-71e19acfd722','Kim Taylor','Kim_Taylor@KimTaylor.ru','1e01ff74-4f6b-44e6-98ed-8526156a23d6');
INSERT INTO PERSONS VALUES
	('9390df11-e026-4a96-8e47-23f904511c99','Christina Bailey','Christina_Bailey@ChristinaBailey.ru','1e01ff74-4f6b-44e6-98ed-8526156a23d6');
INSERT INTO PERSONS VALUES
	('12d45bc7-e0f4-47c6-bb68-58f7fe1ff34d','Bruce Mcdonald','Bruce_Mcdonald@BruceMcdonald.ru','1e01ff74-4f6b-44e6-98ed-8526156a23d6');
INSERT INTO PERSONS VALUES
	('62dc642f-8bbb-458d-94a2-2c6c20971e7c','Allen Moore','Allen_Moore@AllenMoore.ru','1e01ff74-4f6b-44e6-98ed-8526156a23d6');
INSERT INTO PERSONS VALUES
	('07aa4a9f-bfe8-4e7f-b8c3-8374e1811ff5','Clarence Hernandez','Clarence_Hernandez@ClarenceHernandez.ru','1e01ff74-4f6b-44e6-98ed-8526156a23d6');
INSERT INTO PERSONS VALUES
	('1911cb22-125c-4ca7-a62c-473bfa2cdcab','Dennis Berry','Dennis_Berry@DennisBerry.ru','1e01ff74-4f6b-44e6-98ed-8526156a23d6');
INSERT INTO PERSONS VALUES
	('3cc84fb2-a82f-4798-b804-836b59f1a1c8','Ricardo Taylor','Ricardo_Taylor@RicardoTaylor.ru','1e01ff74-4f6b-44e6-98ed-8526156a23d6');
INSERT INTO PERSONS VALUES
	('1f0c2257-f53b-4f63-8753-8c64eb22baef','Lawrence Nelson','Lawrence_Nelson@LawrenceNelson.ru','1e01ff74-4f6b-44e6-98ed-8526156a23d6');
INSERT INTO PERSONS VALUES
	('a63150b2-49da-49e4-aac1-8354e0f6902d','David Boyd','David_Boyd@DavidBoyd.ru','1e01ff74-4f6b-44e6-98ed-8526156a23d6');
INSERT INTO PERSONS VALUES
	('52df400c-ae4e-4296-8717-c141c0f4d1a2','Christopher Lawrence','Christopher_Lawrence@ChristopherLawrence.ru','1e01ff74-4f6b-44e6-98ed-8526156a23d6');
INSERT INTO ORGANIZATIONS VALUES
	('cfcbe116-d138-4fc0-989a-7b457a9bcc5e','Организация fcb','Fifth St');
INSERT INTO PERSONS VALUES
	('9aa45783-cda1-40f8-aa95-6be7bc040229','Irene Morris','Irene_Morris@IreneMorris.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('e823135a-48de-4d95-8653-e2fb1369f8bb','Susan Myers','Susan_Myers@SusanMyers.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('17bdce7f-bcd5-462f-92a1-7e79df602225','Howard Shaw','Howard_Shaw@HowardShaw.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('97eeb398-a4fe-4761-bebe-46994ce4ae80','Jerome Walker','Jerome_Walker@JeromeWalker.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('c7e78d11-9e6b-4916-ae4d-0e072618bcdd','Gerald Johnson','Gerald_Johnson@GeraldJohnson.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('eb0ba087-0ba2-4165-9ef6-bb0012ba82f7','Barry Cunningham','Barry_Cunningham@BarryCunningham.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('d5d384e0-f46b-4ae7-bf26-a2cca4166a0c','Albert Grant','Albert_Grant@AlbertGrant.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('b507d5f7-5187-4ee2-9340-c1300bc54c8b','Richard Burns','Richard_Burns@RichardBurns.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('6db038a0-2f36-4cdb-9951-c826df8acd53','Frank Harper','Frank_Harper@FrankHarper.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('652d8f8e-d5a4-4601-8f81-8e57d5f86f67','Harry Willis','Harry_Willis@HarryWillis.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('1b2c32e8-d05a-494d-acc1-1996015d727f','Sean Ross','Sean_Ross@SeanRoss.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('9dc27e55-899c-454a-bb31-13d510a7bbec','William Price','William_Price@WilliamPrice.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('482808d4-ec62-4a96-b094-0c0a5566837b','Vernon Bailey','Vernon_Bailey@VernonBailey.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('07715366-72cd-4b98-86c9-29ed1e472263','Shane Woods','Shane_Woods@ShaneWoods.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('ce08f353-74f6-4192-aa31-333cfc985c5d','Ralph Green','Ralph_Green@RalphGreen.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('af4c7986-b089-4f2a-8182-7d93ccf7e125','Kyle Miller','Kyle_Miller@KyleMiller.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('873f7049-522f-4be1-b073-61b7995baedc','Leonard Nelson','Leonard_Nelson@LeonardNelson.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('09725199-7950-4384-86c1-37bec12c16e0','Dustin Myers','Dustin_Myers@DustinMyers.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('8ebfd387-f211-49e4-9f57-b5877dd46a8c','Chris Riley','Chris_Riley@ChrisRiley.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('ac38444a-848e-4ee5-b7cc-92278cc79f7c','Ray Ramirez','Ray_Ramirez@RayRamirez.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('45413ebb-63bb-4616-a7af-c59292b3f29b','Paul Peters','Paul_Peters@PaulPeters.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('a0bca3b6-2f28-426a-90fd-1303b0414c7f','Curtis Diaz','Curtis_Diaz@CurtisDiaz.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('6a5c5f88-d0ff-4091-937c-e1414a5d08c0','Ernest Perkins','Ernest_Perkins@ErnestPerkins.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('73ba558d-6d4c-44f0-9992-3e9beb386202','Keith Ward','Keith_Ward@KeithWard.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('937a2994-802e-45fa-82ce-63b9f9e6aed1','Wayne Griffin','Wayne_Griffin@WayneGriffin.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('cd790a2a-1852-4aa8-8936-6baf792fa381','Gary Sims','Gary_Sims@GarySims.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('9f3f9527-f1a7-466a-a649-21f553078cbe','Charlie Parker','Charlie_Parker@CharlieParker.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('d3765833-a1fc-4cf0-8dcb-39148dcc5803','Vincent Richardson','Vincent_Richardson@VincentRichardson.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('43358884-f421-4f7f-9950-ba6b065dbef1','Marcus Jordan','Marcus_Jordan@MarcusJordan.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('3728a770-08dc-449f-ba19-c02319240779','Hector Scott','Hector_Scott@HectorScott.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO PERSONS VALUES
	('d3e07ee7-d743-4ae4-a888-a331f4a96e2b','Charlie Cole','Charlie_Cole@CharlieCole.ru','cfcbe116-d138-4fc0-989a-7b457a9bcc5e');
INSERT INTO ORGANIZATIONS VALUES
	('38168760-97b1-4243-b457-b56979340490','Организация 816','West Peachtree Ave');
INSERT INTO PERSONS VALUES
	('7333331a-1a72-44a8-a8f2-22ea64f1a0d9','Norma Ramirez','Norma_Ramirez@NormaRamirez.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('edeedfed-92e9-4867-8d4e-6f92da9d7acb','Theresa Lee','Theresa_Lee@TheresaLee.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('b9ddc6c9-9f2c-464e-a26a-e6cdfab778b8','Darrell Snyder','Darrell_Snyder@DarrellSnyder.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('23e0718b-2135-41e3-baa9-1169a14145df','Billy Thomas','Billy_Thomas@BillyThomas.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('af34ab81-d4e6-4510-b94a-75cbc7411fc7','Marcus Bryant','Marcus_Bryant@MarcusBryant.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('174a3bb2-a85c-4fdf-a3c3-adce69009bf4','Louis Bell','Louis_Bell@LouisBell.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('9e0dc918-cf36-4060-87d4-17eed0f5b415','Jack Simpson','Jack_Simpson@JackSimpson.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('851228e8-0053-4e69-89a5-705427ed5c5b','Roger Willis','Roger_Willis@RogerWillis.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('1ac4e9e4-bec8-43d2-9c34-b505e0511357','Norman Moore','Norman_Moore@NormanMoore.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('4807666a-ef41-4595-9253-95ebb37ee462','Ernest Gonzales','Ernest_Gonzales@ErnestGonzales.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('6907290d-765b-4919-8581-09d1917ed7d7','Ronnie Bryant','Ronnie_Bryant@RonnieBryant.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('b213e3f5-4689-41f5-a78c-9584da4e2d04','Benjamin Reed','Benjamin_Reed@BenjaminReed.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('4eb40e9f-32ff-4d02-b266-b411d544a1b9','Bruce Scott','Bruce_Scott@BruceScott.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('3601024c-d4c5-4c9e-b769-1c14dd50f1da','Vernon Shaw','Vernon_Shaw@VernonShaw.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('ef71d949-d4c6-480a-8d36-af8b4ec09abe','Kevin Henry','Kevin_Henry@KevinHenry.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('0a8ce355-9d53-49d8-b685-ef4bbea3779f','Jeffery Howard','Jeffery_Howard@JefferyHoward.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('f6ba4b30-64f2-4a84-9121-9697746de7fb','Lloyd Smith','Lloyd_Smith@LloydSmith.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('8f7cac38-23e6-4bb5-b9a4-a3d07223fce4','Clifford Reed','Clifford_Reed@CliffordReed.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO PERSONS VALUES
	('0923849d-893d-4c83-9648-e33b79a48662','Miguel Morris','Miguel_Morris@MiguelMorris.ru','38168760-97b1-4243-b457-b56979340490');
INSERT INTO ORGANIZATIONS VALUES
	('2317828a-c533-4e6a-9587-8406dcc0ede0','Организация 317','Forsyth Ave');
INSERT INTO PERSONS VALUES
	('4802aa85-2bee-4a01-b0be-7af425e68efc','Judith Baker','Judith_Baker@JudithBaker.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('e1bafdb9-9dc2-4f28-9a17-0dbb000776f8','Rebecca Rose','Rebecca_Rose@RebeccaRose.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('b50210b6-da83-42c5-8822-1c08eb20f318','Roberto Bell','Roberto_Bell@RobertoBell.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('16ab9ba5-3dd4-4176-a559-3241c2ae081d','Stephen Burns','Stephen_Burns@StephenBurns.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('878d51e0-0f8f-4705-9154-5065d2fd3102','Zachary Rice','Zachary_Rice@ZacharyRice.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('55c071d1-2119-4016-a4f4-ef8ceb5f18b9','Charlie Patterson','Charlie_Patterson@CharliePatterson.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('6c894bf1-6007-44a1-a9a4-4477a3cbcd34','Brandon Watson','Brandon_Watson@BrandonWatson.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('0face9cd-6444-472a-a40f-9b27eae66ce9','Francisco Armstrong','Francisco_Armstrong@FranciscoArmstrong.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('2a5e8bcb-a3a6-47ef-81c1-f577a60b602a','Benjamin Morales','Benjamin_Morales@BenjaminMorales.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('d81992ae-453c-4a7b-b8b9-c3ac58376720','Patrick Cooper','Patrick_Cooper@PatrickCooper.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('787c4480-38e4-4705-8561-d98dde8edcda','Calvin Palmer','Calvin_Palmer@CalvinPalmer.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('aa558e8f-dc7b-47d2-b5ab-13b30f39a7d6','Jeremy Edwards','Jeremy_Edwards@JeremyEdwards.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('fb9f4ca7-7091-4ca6-8ad5-220b9f9f8f4a','Bill Tucker','Bill_Tucker@BillTucker.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('39310612-5a59-4b38-8ea6-4199b5a6e7d0','Adam Collins','Adam_Collins@AdamCollins.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('0ac69dbf-04a1-496c-a098-7f98f5153fd4','Larry Moore','Larry_Moore@LarryMoore.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('114f9efd-2139-496c-b2f7-1d203559c5ba','Arthur Spencer','Arthur_Spencer@ArthurSpencer.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('757f1758-bd91-447e-b05b-a1266aa1dbfc','Terry Holmes','Terry_Holmes@TerryHolmes.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('41ff54a7-4cd2-4f70-87c4-3b409af909f9','Antonio Mcdonald','Antonio_Mcdonald@AntonioMcdonald.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('767faf37-c8b0-4e44-a223-ba9f427dce5c','Todd Daniels','Todd_Daniels@ToddDaniels.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('a3aeb4fe-40ea-4837-9ba5-7b47d2a38bfb','Howard Pierce','Howard_Pierce@HowardPierce.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('1381c269-675b-4854-89c3-347b18807bf0','Stanley Ruiz','Stanley_Ruiz@StanleyRuiz.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('124eb744-f546-40f5-9766-ae33adc0b608','Charles Daniels','Charles_Daniels@CharlesDaniels.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('372628d1-5fd1-4118-aeb4-a1962f24054f','Bruce Mason','Bruce_Mason@BruceMason.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('9be8b88f-4b6d-4c3d-9f81-13af5fc701db','Bobby Diaz','Bobby_Diaz@BobbyDiaz.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO PERSONS VALUES
	('097638a5-eea8-4768-832d-fd4d2628f540','James Ferguson','James_Ferguson@JamesFerguson.ru','2317828a-c533-4e6a-9587-8406dcc0ede0');
INSERT INTO ORGANIZATIONS VALUES
	('d0bf7dff-14a6-4549-9f7a-03f7e8e23551','Организация 0bf','Forsyth Rd');
INSERT INTO PERSONS VALUES
	('1b1fe2e8-780a-438d-b49c-0303001547a7','Monica Phillips','Monica_Phillips@MonicaPhillips.ru','d0bf7dff-14a6-4549-9f7a-03f7e8e23551');
INSERT INTO PERSONS VALUES
	('2ca8184d-514c-4987-86e9-3e7ac539b4ba','Mary Young','Mary_Young@MaryYoung.ru','d0bf7dff-14a6-4549-9f7a-03f7e8e23551');
INSERT INTO PERSONS VALUES
	('45f446cd-a259-4cba-8bd9-b945acf4b643','Leroy Fisher','Leroy_Fisher@LeroyFisher.ru','d0bf7dff-14a6-4549-9f7a-03f7e8e23551');
INSERT INTO PERSONS VALUES
	('b1d47e42-736e-47d6-ad47-f113775d73f7','Wesley Kelley','Wesley_Kelley@WesleyKelley.ru','d0bf7dff-14a6-4549-9f7a-03f7e8e23551');
INSERT INTO PERSONS VALUES
	('abfd4e08-8379-4e24-ad27-9e094be2d714','Darrell Evans','Darrell_Evans@DarrellEvans.ru','d0bf7dff-14a6-4549-9f7a-03f7e8e23551');
INSERT INTO ORGANIZATIONS VALUES
	('e2b7424d-e23b-42e6-a14d-d89f71149170','Организация 2b7','Fourteenth Ln');
INSERT INTO PERSONS VALUES
	('189d419c-9587-48f0-9a3a-bbdec9c13758','Lorraine Washington','Lorraine_Washington@LorraineWashington.ru','e2b7424d-e23b-42e6-a14d-d89f71149170');
INSERT INTO PERSONS VALUES
	('398d18e9-8c75-451c-9968-ea978df793c1','Ethel Fox','Ethel_Fox@EthelFox.ru','e2b7424d-e23b-42e6-a14d-d89f71149170');
INSERT INTO PERSONS VALUES
	('c49dbf6c-62bd-48ca-af2d-8bafd81d0213','Jose Thompson','Jose_Thompson@JoseThompson.ru','e2b7424d-e23b-42e6-a14d-d89f71149170');
INSERT INTO PERSONS VALUES
	('990d8025-2fa5-4a04-ab65-9bb31bcd7514','Alfred Anderson','Alfred_Anderson@AlfredAnderson.ru','e2b7424d-e23b-42e6-a14d-d89f71149170');
INSERT INTO PERSONS VALUES
	('3b3d5584-9aae-4fca-8ead-79150e8bdad7','Brian Gonzalez','Brian_Gonzalez@BrianGonzalez.ru','e2b7424d-e23b-42e6-a14d-d89f71149170');
INSERT INTO PERSONS VALUES
	('3d865492-b938-4c03-8a7c-4ad4385e6bb9','Travis Spencer','Travis_Spencer@TravisSpencer.ru','e2b7424d-e23b-42e6-a14d-d89f71149170');
INSERT INTO PERSONS VALUES
	('e5aee923-19db-445d-8af8-4ee0b39e89a5','Paul Freeman','Paul_Freeman@PaulFreeman.ru','e2b7424d-e23b-42e6-a14d-d89f71149170');
INSERT INTO PERSONS VALUES
	('f46f61c8-da42-474c-a356-3332a94f8555','Alan Perry','Alan_Perry@AlanPerry.ru','e2b7424d-e23b-42e6-a14d-d89f71149170');
INSERT INTO ORGANIZATIONS VALUES
	('cebb16e7-98f6-4d41-9442-a0a86408a364','Организация ebb','Spring Pkwy');
INSERT INTO PERSONS VALUES
	('5dce0baf-de19-42d7-90fc-b9f0c306fa5d','Tracy Butler','Tracy_Butler@TracyButler.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('e168bbe5-2bbd-4d48-bac1-5d43d54e22e6','Norma Wells','Norma_Wells@NormaWells.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('d2b16843-8958-454d-ac15-18508546656c','Scott Duncan','Scott_Duncan@ScottDuncan.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('121ef740-9f3e-4804-85ab-6aec849b5908','Victor Burns','Victor_Burns@VictorBurns.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('6e2506f0-c5f1-4025-a191-7a44b66b5501','Jeremy Shaw','Jeremy_Shaw@JeremyShaw.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('fde8c9c4-6e89-4849-b0dc-cd135ec2dd52','Stanley Stewart','Stanley_Stewart@StanleyStewart.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('46b84163-3b4c-451a-be28-595b5fca4c15','Eric Kelley','Eric_Kelley@EricKelley.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('7a1aa40b-71a9-48ba-b236-2c0d9863a446','Harry White','Harry_White@HarryWhite.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('cee9ea57-9215-4a3a-93f9-64a57d9f73d9','Tom Morris','Tom_Morris@TomMorris.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('4e96219c-ff68-4c4f-aaef-645d363645fa','Stanley Woods','Stanley_Woods@StanleyWoods.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('240dfdc3-3717-4ed9-ade5-59f973709042','Tony Bennett','Tony_Bennett@TonyBennett.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('4f8b3492-82cb-4cc9-adba-225b1de2dfdc','Alex Allen','Alex_Allen@AlexAllen.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('45bd17ec-1c7e-4bc0-94ac-a55aaef81fa4','Joe Collins','Joe_Collins@JoeCollins.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('e1180092-7eac-4711-b06d-eec54e2db42c','Jack Kelly','Jack_Kelly@JackKelly.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('8c3ae75d-8341-4302-b3e8-0c1f1b9702be','Jose Adams','Jose_Adams@JoseAdams.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('b7c638e5-2763-484a-a1c3-6313daf1289e','Ray Ford','Ray_Ford@RayFord.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('d1177ecf-6063-4756-8b0c-74d21ae73dd0','Brandon Lee','Brandon_Lee@BrandonLee.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('f2660cbc-2806-48ab-8781-39c6c6bca67b','Lewis Ford','Lewis_Ford@LewisFord.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('7abc395c-0f42-454a-867d-fe03fa6f0cef','Jay Adams','Jay_Adams@JayAdams.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('de1852ae-a83d-4ccf-80e0-f86733953126','Jeffrey Sanders','Jeffrey_Sanders@JeffreySanders.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('9944cdfc-8768-4674-af59-765fdf4fd866','Michael Jordan','Michael_Jordan@MichaelJordan.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('98145575-8aa2-497d-b44d-de7edf8971e1','Charles Campbell','Charles_Campbell@CharlesCampbell.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('d6b3dfb8-5faf-4cce-aa67-c8f436bcd186','Aaron Stevens','Aaron_Stevens@AaronStevens.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('277f7bef-acd5-49f3-b574-6980d980abee','Fred Gardner','Fred_Gardner@FredGardner.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('e7228487-952c-4f8a-b76f-5ba1a2310ea0','Kyle Gonzales','Kyle_Gonzales@KyleGonzales.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('73599dfb-5d94-4a58-adec-110a8469e48a','Howard Armstrong','Howard_Armstrong@HowardArmstrong.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('7e975697-29ce-4b1a-815a-ddd86b54a152','Theodore Burns','Theodore_Burns@TheodoreBurns.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('487fa393-95de-4b6c-9605-701c18f08d8d','Miguel Hall','Miguel_Hall@MiguelHall.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('55277888-cf56-4e29-853c-1c2a967879cc','Lee Martinez','Lee_Martinez@LeeMartinez.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('7b9c9834-4b4b-48c8-a189-ab816d625de0','Matthew Greene','Matthew_Greene@MatthewGreene.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('1f6ea358-e3f9-4226-9547-f775ede91c9e','Alex Black','Alex_Black@AlexBlack.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO PERSONS VALUES
	('eb050ef7-2b3c-447d-bf24-cca2aae4c912','Mark Hall','Mark_Hall@MarkHall.ru','cebb16e7-98f6-4d41-9442-a0a86408a364');
INSERT INTO ORGANIZATIONS VALUES
	('c9fc6686-f7af-41bf-b20d-5c8dfae10dd1','Организация 9fc','Fourth Blvd');
INSERT INTO PERSONS VALUES
	('b3e89dd7-3577-484f-8bc7-c3ed812cde31','Beverly Ramirez','Beverly_Ramirez@BeverlyRamirez.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('a9e29cb3-583b-49b0-a019-0fee3a4fab74','Tracy Black','Tracy_Black@TracyBlack.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('d42442b3-0ab5-4dd1-86d0-189bf14b124e','Carl Holmes','Carl_Holmes@CarlHolmes.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('5adf5e30-18ee-4a73-ab0f-b42a420e01b1','Jeremy Wright','Jeremy_Wright@JeremyWright.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('d895e93e-d3c5-4913-acd6-ff0a19c4577d','Nicholas Ward','Nicholas_Ward@NicholasWard.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('d19df18f-16ec-4c99-a783-6305e25e976e','Harry Lawson','Harry_Lawson@HarryLawson.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('a89727c0-5611-4fcd-9e96-35ae8ae9aedd','Patrick Daniels','Patrick_Daniels@PatrickDaniels.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('53a18cb7-48b2-491d-a1c7-a787eeb9a9a3','Roberto Armstrong','Roberto_Armstrong@RobertoArmstrong.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('62762e73-f414-4722-b532-9e0753ae071a','Jason Watkins','Jason_Watkins@JasonWatkins.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('2b24ad21-3041-4d67-85d9-51230f0f6f77','Henry Rice','Henry_Rice@HenryRice.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('9834694c-5d94-4da7-92af-6251deae66fe','Terry Perez','Terry_Perez@TerryPerez.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('e3c41321-e669-4cf9-9d49-c835b121bc66','Ray Alexander','Ray_Alexander@RayAlexander.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('9be71bc5-24df-4994-b3e4-e240c901dc29','David Perry','David_Perry@DavidPerry.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('74e96a9a-ff1f-4360-8177-f1f5ec179483','Donald Ortiz','Donald_Ortiz@DonaldOrtiz.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('ab5c7438-9f1b-4f9f-943e-897507935dbd','Derek Hamilton','Derek_Hamilton@DerekHamilton.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('c7280860-4db3-44ab-a3d1-46f8ba3fbeae','Anthony Morales','Anthony_Morales@AnthonyMorales.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('70203b4d-a03e-407b-91d2-c469fabe846c','Ray Hayes','Ray_Hayes@RayHayes.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('18c6e06d-b733-4fc3-889c-70a969a295e1','Don Reynolds','Don_Reynolds@DonReynolds.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('f85f83cb-30d7-4d6d-9fdb-62cee6bd49d7','Rick Edwards','Rick_Edwards@RickEdwards.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('9eb14aae-7d69-4a12-acab-7218c96f2d63','Phillip Long','Phillip_Long@PhillipLong.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('98f64c0b-8e7f-46d8-906f-9b1515eed1db','Scott Arnold','Scott_Arnold@ScottArnold.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('492977b8-631e-4f64-b452-37aac69234f3','Louis Woods','Louis_Woods@LouisWoods.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('de817e73-0d8d-4682-8c6a-b764f0e6ba80','Ralph Knight','Ralph_Knight@RalphKnight.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('6ef26be1-dd12-4bc6-8216-00ef32f1e2c0','Tim Hawkins','Tim_Hawkins@TimHawkins.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('1db50897-955a-48bb-a283-75e5a4539b19','Edwin Fox','Edwin_Fox@EdwinFox.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('c8ec81dc-4426-48b7-b72f-07bce7971168','Joseph Collins','Joseph_Collins@JosephCollins.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('102bec3d-a014-423a-a99f-eca8f97e9996','Glen Armstrong','Glen_Armstrong@GlenArmstrong.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO PERSONS VALUES
	('1c79eaeb-f85f-4e11-9e76-313b06cf0783','Ray Simpson','Ray_Simpson@RaySimpson.ru','c9fc6686-f7af-41bf-b20d-5c8dfae10dd1');
INSERT INTO ORGANIZATIONS VALUES
	('714d8f4d-e78d-4e08-8b28-56741d01fea1','Организация 14d','Central Blvd');
INSERT INTO PERSONS VALUES
	('dd8bf9c5-8510-4114-814d-016e8d6be34f','Florence Rivera','Florence_Rivera@FlorenceRivera.ru','714d8f4d-e78d-4e08-8b28-56741d01fea1');
INSERT INTO PERSONS VALUES
	('8c32937b-f2a4-438d-8750-8a43df17a120','Eleanor Murphy','Eleanor_Murphy@EleanorMurphy.ru','714d8f4d-e78d-4e08-8b28-56741d01fea1');
INSERT INTO PERSONS VALUES
	('e0824f1a-99f1-479a-8d34-0e7732bb84b1','Steven Lawson','Steven_Lawson@StevenLawson.ru','714d8f4d-e78d-4e08-8b28-56741d01fea1');
INSERT INTO PERSONS VALUES
	('d9ec579f-e028-48d4-9474-4ecd090ee040','Douglas Hicks','Douglas_Hicks@DouglasHicks.ru','714d8f4d-e78d-4e08-8b28-56741d01fea1');
INSERT INTO PERSONS VALUES
	('75b780a7-3094-4a60-b0ab-cf37753ca007','Alan Olson','Alan_Olson@AlanOlson.ru','714d8f4d-e78d-4e08-8b28-56741d01fea1');
INSERT INTO ORGANIZATIONS VALUES
	('7cc6bc2a-d450-4882-b0cc-8dc9ae27e7ab','Организация cc6','Peachtree Way');
INSERT INTO PERSONS VALUES
	('7fcaa79f-5110-42b2-b4df-f3a685db5d7a','Evelyn Gonzalez','Evelyn_Gonzalez@EvelynGonzalez.ru','7cc6bc2a-d450-4882-b0cc-8dc9ae27e7ab');
INSERT INTO PERSONS VALUES
	('8207e9af-5126-4355-a71e-ef5a028d7b83','Judy Ferguson','Judy_Ferguson@JudyFerguson.ru','7cc6bc2a-d450-4882-b0cc-8dc9ae27e7ab');
INSERT INTO PERSONS VALUES
	('2a3dd81a-0da9-4fbc-ad17-f673d8005ec9','Frank Henderson','Frank_Henderson@FrankHenderson.ru','7cc6bc2a-d450-4882-b0cc-8dc9ae27e7ab');
INSERT INTO PERSONS VALUES
	('044f022f-5e39-4635-b049-23b833d59513','Barry Hall','Barry_Hall@BarryHall.ru','7cc6bc2a-d450-4882-b0cc-8dc9ae27e7ab');
INSERT INTO PERSONS VALUES
	('4da279b2-bd20-4ad8-997b-6dd53a9cf3e7','Troy Rose','Troy_Rose@TroyRose.ru','7cc6bc2a-d450-4882-b0cc-8dc9ae27e7ab');
INSERT INTO ORGANIZATIONS VALUES
	('ae5eb0a1-aa6b-4680-a1b2-ae5c63e2bf79','Организация e5e','Fowler Pkwy');
INSERT INTO PERSONS VALUES
	('fd1d87c0-0ed1-4b55-8985-deced1ba4bc1','Ellen Cruz','Ellen_Cruz@EllenCruz.ru','ae5eb0a1-aa6b-4680-a1b2-ae5c63e2bf79');
INSERT INTO PERSONS VALUES
	('bce7334f-fa25-450b-8111-7f3d398d3275','Susan Patterson','Susan_Patterson@SusanPatterson.ru','ae5eb0a1-aa6b-4680-a1b2-ae5c63e2bf79');
INSERT INTO PERSONS VALUES
	('7a550060-1d5e-4a6f-8b2f-0d636787595d','Ronnie Hill','Ronnie_Hill@RonnieHill.ru','ae5eb0a1-aa6b-4680-a1b2-ae5c63e2bf79');
INSERT INTO PERSONS VALUES
	('c9d36516-7a12-4bb4-abfc-3844c1d50529','Louis Hayes','Louis_Hayes@LouisHayes.ru','ae5eb0a1-aa6b-4680-a1b2-ae5c63e2bf79');
INSERT INTO PERSONS VALUES
	('ab740fd0-a1a9-4cb4-8baf-f3f62235f37c','Eddie Fisher','Eddie_Fisher@EddieFisher.ru','ae5eb0a1-aa6b-4680-a1b2-ae5c63e2bf79');
INSERT INTO PERSONS VALUES
	('9a6b7e79-a355-427c-a34e-dd90ab3c3702','Clifford Myers','Clifford_Myers@CliffordMyers.ru','ae5eb0a1-aa6b-4680-a1b2-ae5c63e2bf79');
INSERT INTO PERSONS VALUES
	('56ec3814-0b0d-4c51-a67d-3a7e8fcc1c1f','Roberto Freeman','Roberto_Freeman@RobertoFreeman.ru','ae5eb0a1-aa6b-4680-a1b2-ae5c63e2bf79');
INSERT INTO PERSONS VALUES
	('972512d2-ee42-4452-bb50-31a36648e05f','Joel Lewis','Joel_Lewis@JoelLewis.ru','ae5eb0a1-aa6b-4680-a1b2-ae5c63e2bf79');
INSERT INTO ORGANIZATIONS VALUES
	('a588ed5a-db05-47fb-a162-bc8ae80cb9ad','Организация 588','Fowler Way');
INSERT INTO PERSONS VALUES
	('58e77a10-adde-4994-8dd5-05926c3b1228','Ida Sims','Ida_Sims@IdaSims.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('d0de897c-20d2-45fc-a864-8392dcd1cfe4','Christine Henderson','Christine_Henderson@ChristineHenderson.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('d0bce965-78a6-4f24-9fde-e72e8fd4db9b','Ryan Morales','Ryan_Morales@RyanMorales.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('d919ca84-7f43-4fae-9e3a-736149258ec6','Troy Reynolds','Troy_Reynolds@TroyReynolds.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('ec7b0d4e-9092-416b-bc2b-4ef8bb44241d','Frank Lane','Frank_Lane@FrankLane.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('768a47d8-3011-43be-bc27-4a55cef8eb9d','Phillip Lee','Phillip_Lee@PhillipLee.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('c1ce8b41-b6c7-4bb5-bba9-f2b3017edd8e','Stephen Gonzalez','Stephen_Gonzalez@StephenGonzalez.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('883acca7-00a4-4aaf-8e5a-7ac7b8556776','Wayne Cruz','Wayne_Cruz@WayneCruz.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('12558bbb-06b3-49d7-aa55-c1ea875d9bfb','Aaron Lee','Aaron_Lee@AaronLee.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('3633f93e-d392-4054-bc39-a72debafbdc7','Curtis Sanders','Curtis_Sanders@CurtisSanders.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('9f9d7ddd-7b49-44b2-adbc-0ea6be4fd38c','Bryan Lawson','Bryan_Lawson@BryanLawson.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('e28fb08c-56ea-499a-9f1b-1feb4da2990a','Henry Scott','Henry_Scott@HenryScott.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('7272f7e0-e3a6-4304-88c3-2e44dc9a62ff','Corey Campbell','Corey_Campbell@CoreyCampbell.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('8606b937-9d01-4fd7-b63f-c72e987ef0ed','Mike Harris','Mike_Harris@MikeHarris.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO PERSONS VALUES
	('d48ab21b-0a51-470d-b53e-f844c74f5f27','Lee Collins','Lee_Collins@LeeCollins.ru','a588ed5a-db05-47fb-a162-bc8ae80cb9ad');
INSERT INTO ORGANIZATIONS VALUES
	('6f6d244e-84da-499a-b751-f639bb946d72','Организация f6d','Fowler Cir');
INSERT INTO PERSONS VALUES
	('a3fcc723-edee-4ecb-837e-f9b61861d8de','Jessica Watson','Jessica_Watson@JessicaWatson.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('08f8e44a-31cb-40d6-8c5b-a6ba566fb0e5','Susan Morgan','Susan_Morgan@SusanMorgan.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('a6cef78f-5245-435d-b143-6b78815c0e39','Scott Rice','Scott_Rice@ScottRice.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('34133c78-8b90-46a7-ad1f-1572563c0237','Francisco Lopez','Francisco_Lopez@FranciscoLopez.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('cda776b2-57b7-4bef-9360-8e7ee6a3c2c7','Ronald Ward','Ronald_Ward@RonaldWard.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('5a18edc9-97d8-4822-9bac-6f7930c1470d','Dean Jones','Dean_Jones@DeanJones.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('8caeb75f-fd64-4caa-bdef-cf4b991e7f79','Brent Hamilton','Brent_Hamilton@BrentHamilton.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('f19680e0-3ce5-4747-84a0-012cbbb581a7','Keith Wright','Keith_Wright@KeithWright.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('3c2671d5-a1e1-4f6b-a442-9644297fd8d2','Alexander Webb','Alexander_Webb@AlexanderWebb.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('ffc09327-6ad2-45d3-9f21-3908d0dfa1ec','Sean Flores','Sean_Flores@SeanFlores.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('1897bc6e-9c3e-4cb2-b3a9-efd92c901208','Frederick Butler','Frederick_Butler@FrederickButler.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('27f02d8c-fc4a-45ed-8c2c-8cd7161977ee','Corey Griffin','Corey_Griffin@CoreyGriffin.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('5730f58b-976a-49fc-a1d3-31fac2001616','Barry Lawson','Barry_Lawson@BarryLawson.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('23b5492e-a2aa-4305-8065-aa364259220d','Jeff Rivera','Jeff_Rivera@JeffRivera.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('a55296ca-3071-4c8d-b2ec-2facbdbf8d41','Carl Harper','Carl_Harper@CarlHarper.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('2e2567d2-e22f-43b6-b25e-011b25e92e70','Pedro Williams','Pedro_Williams@PedroWilliams.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('b831f285-f01b-452a-b004-7e523dee0262','Terry Miller','Terry_Miller@TerryMiller.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('8ef59be9-cacb-4ef0-91d0-7f8aeb2846ad','Jay Smith','Jay_Smith@JaySmith.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('127cda8d-4e92-4334-a801-5242848ab176','Theodore Rose','Theodore_Rose@TheodoreRose.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('a5fd398a-0254-4ce1-9fa7-400bf611e02c','Vernon Evans','Vernon_Evans@VernonEvans.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('8a395614-5d8f-4c87-b7c9-73eba1c3d8aa','Wayne Perkins','Wayne_Perkins@WaynePerkins.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('f84e495d-0d46-4ebd-8659-851d64049fbc','Alvin Lopez','Alvin_Lopez@AlvinLopez.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('5d825547-b7b0-4eef-893c-19b14e1949a4','Bryan Arnold','Bryan_Arnold@BryanArnold.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('f039fcd5-ce06-41cb-b89d-935a5ba57909','Shawn Murphy','Shawn_Murphy@ShawnMurphy.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO PERSONS VALUES
	('aece8fb3-59e2-474f-994a-f2257dd75e11','Wesley Alexander','Wesley_Alexander@WesleyAlexander.ru','6f6d244e-84da-499a-b751-f639bb946d72');
INSERT INTO ORGANIZATIONS VALUES
	('bdd64cfc-f5d4-41d0-91a8-9bee4453871f','Организация dd6','Third Ln');
INSERT INTO PERSONS VALUES
	('99c30a6d-8ffa-417a-afec-f1a5bf627201','Marion Russell','Marion_Russell@MarionRussell.ru','bdd64cfc-f5d4-41d0-91a8-9bee4453871f');
INSERT INTO PERSONS VALUES
	('8bb3a902-3ec2-4991-bf05-a328f01badc2','Sherry Simpson','Sherry_Simpson@SherrySimpson.ru','bdd64cfc-f5d4-41d0-91a8-9bee4453871f');
INSERT INTO PERSONS VALUES
	('61a94775-fc1a-48b6-8ed9-f3452811fd16','Paul Henderson','Paul_Henderson@PaulHenderson.ru','bdd64cfc-f5d4-41d0-91a8-9bee4453871f');
INSERT INTO PERSONS VALUES
	('f0e74589-e4dd-4e83-abbf-6d41566d35b1','Henry Young','Henry_Young@HenryYoung.ru','bdd64cfc-f5d4-41d0-91a8-9bee4453871f');
INSERT INTO PERSONS VALUES
	('b0bb958d-5a8f-4b18-8c45-778c95c1935e','Lee Alexander','Lee_Alexander@LeeAlexander.ru','bdd64cfc-f5d4-41d0-91a8-9bee4453871f');
INSERT INTO PERSONS VALUES
	('86a5cbdf-3d8f-4272-a9aa-9bc3b79763b6','Herbert Johnson','Herbert_Johnson@HerbertJohnson.ru','bdd64cfc-f5d4-41d0-91a8-9bee4453871f');
INSERT INTO PERSONS VALUES
	('3d9da259-97db-4e0a-bfec-30958c19dc3d','Charles Hunter','Charles_Hunter@CharlesHunter.ru','bdd64cfc-f5d4-41d0-91a8-9bee4453871f');
INSERT INTO PERSONS VALUES
	('22b24aeb-6899-4137-a2e1-cb01ea8a2105','Brandon Gonzalez','Brandon_Gonzalez@BrandonGonzalez.ru','bdd64cfc-f5d4-41d0-91a8-9bee4453871f');
INSERT INTO ORGANIZATIONS VALUES
	('e7b7ad0b-cf8a-493c-a9fe-05b65a79622f','Организация 7b7','Capital Ln');
INSERT INTO PERSONS VALUES
	('6e4de2e9-aaad-4020-93bc-723c0101428e','Beverly Dixon','Beverly_Dixon@BeverlyDixon.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('f4b2ac33-0424-4ff7-a93a-5256f0bfd50c','Donna Martinez','Donna_Martinez@DonnaMartinez.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('5cb29e47-55de-4f1a-b72f-0e98c95c0d26','Oscar Woods','Oscar_Woods@OscarWoods.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('3c4b13f9-5873-4a53-957d-c364fcedd6bd','Sean Gray','Sean_Gray@SeanGray.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('07a9898e-3a6d-4ccc-993d-a6c9e8dc0ade','Jesus Campbell','Jesus_Campbell@JesusCampbell.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('b7edc2ba-1efb-4d1c-aeda-0f34c6c6245f','Peter Gonzalez','Peter_Gonzalez@PeterGonzalez.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('b1181999-1993-40e9-86d3-e35aef7d8b68','Manuel Gordon','Manuel_Gordon@ManuelGordon.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('a147396b-c195-4971-b5d9-7a75a30a26f2','Joshua Hayes','Joshua_Hayes@JoshuaHayes.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('e3ab8ff1-0027-477c-b7b9-087582e8de03','Greg Snyder','Greg_Snyder@GregSnyder.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('7807efe4-6254-4b97-a580-24db2463e92a','Roger Elliott','Roger_Elliott@RogerElliott.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('2672b70f-52e0-44cf-82d2-55ac784bcc08','Ricardo Cook','Ricardo_Cook@RicardoCook.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('5f850cc4-b456-419e-aacd-2d98639010a3','Douglas Jordan','Douglas_Jordan@DouglasJordan.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('6be17fdb-a1b3-4ad0-88e9-e88729f6a111','Alexander Kennedy','Alexander_Kennedy@AlexanderKennedy.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('fa511a14-d87e-4ca3-9229-06a9c9d3bdde','Wesley Stewart','Wesley_Stewart@WesleyStewart.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('09139a8e-4a0e-4ace-ae7a-0755605c1117','George Reyes','George_Reyes@GeorgeReyes.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('5275f79e-81dc-44e6-ad0a-3f67ee943d84','Brian Reyes','Brian_Reyes@BrianReyes.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('d9221689-44c3-4b9a-987d-69a53be3d636','Stephen Owens','Stephen_Owens@StephenOwens.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('cfa89474-a8f8-4b08-8bb7-e07eca5e8b60','Joseph Cooper','Joseph_Cooper@JosephCooper.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO PERSONS VALUES
	('997c0e93-9034-4cc4-8dc3-d0d0c326fc1b','Ronald Owens','Ronald_Owens@RonaldOwens.ru','e7b7ad0b-cf8a-493c-a9fe-05b65a79622f');
INSERT INTO ORGANIZATIONS VALUES
	('3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f','Организация dc4','Spring Rd');
INSERT INTO PERSONS VALUES
	('8745b889-0717-48b8-9acd-c9cf01beca5f','Joanne King','Joanne_King@JoanneKing.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('282bb4fc-e8bd-492a-ab61-b3c1ada475bc','Pauline Turner','Pauline_Turner@PaulineTurner.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('f46fc2e1-5153-49fa-9f18-7e700f843ea0','Timothy Kelly','Timothy_Kelly@TimothyKelly.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('a0a1313f-6dab-4528-8092-7642fdca38e9','Roberto Hamilton','Roberto_Hamilton@RobertoHamilton.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('39b4fae0-7dfc-4436-82b5-da93249524cc','Jose Evans','Jose_Evans@JoseEvans.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('823cb46c-ea5d-4958-a5bf-041fab92e5a9','Joseph Patterson','Joseph_Patterson@JosephPatterson.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('c385db06-bedd-4576-b943-03af073e339e','Norman Harris','Norman_Harris@NormanHarris.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('99aea3e8-82c7-4976-b741-f6aa64d8e05c','Ricky White','Ricky_White@RickyWhite.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('a1ea3ac9-ef26-43ea-9d49-9ec5e80aaecd','Anthony Knight','Anthony_Knight@AnthonyKnight.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('6b5760c8-ce24-49f4-b18f-9ac69980c427','Benjamin Crawford','Benjamin_Crawford@BenjaminCrawford.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('670e93e4-e411-4789-b544-2384aaeb0054','Steven Carter','Steven_Carter@StevenCarter.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('67db05ed-0920-4bc6-ac7c-f9850f7b79e9','Craig Hamilton','Craig_Hamilton@CraigHamilton.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('345f7952-c862-4245-9cf6-393ab4fa558c','Jason Ross','Jason_Ross@JasonRoss.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO PERSONS VALUES
	('98158341-cf4a-4a4f-8bfd-3d0a38b1c47b','Hector Pierce','Hector_Pierce@HectorPierce.ru','3dc497a3-0026-4ba2-9a3a-43c0c5dfaa9f');
INSERT INTO ORGANIZATIONS VALUES
	('428b0d72-84b1-48ea-8063-a3cfd88ee2d4','Организация 28b','Central Way');
INSERT INTO PERSONS VALUES
	('ff7dc3e2-c833-4183-9175-c57869ab38ac','Florence Foster','Florence_Foster@FlorenceFoster.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('37ab580e-9b1c-4d6f-afc9-495b94d90451','Erica Franklin','Erica_Franklin@EricaFranklin.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('6eb397dc-d245-4826-a990-578e3830db10','Dean Simpson','Dean_Simpson@DeanSimpson.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('f7c9d5fe-a80f-423c-9a93-0ddc3142733e','Eric Mills','Eric_Mills@EricMills.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('600cfc5f-089b-4761-a00a-fc07a4fac630','Joel Mitchell','Joel_Mitchell@JoelMitchell.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('2ae3959d-970a-4318-8d9a-4ec06403e27c','Anthony Dunn','Anthony_Dunn@AnthonyDunn.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('760aafb3-472a-4a7a-a335-e5484e45cf84','Jacob Clark','Jacob_Clark@JacobClark.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('14bc75ca-4d89-492d-9c63-2f34c82e1d83','Lee Mitchell','Lee_Mitchell@LeeMitchell.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('822c9179-b764-4cd9-be6e-fafb313720c9','Benjamin Alexander','Benjamin_Alexander@BenjaminAlexander.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('e39dfe65-a0ae-4d4f-b555-356714185af7','Jeremy Harper','Jeremy_Harper@JeremyHarper.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('1c5e9d81-7c7a-48b5-bd7a-195badc42aa7','Lawrence Perez','Lawrence_Perez@LawrencePerez.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('f9d324ef-e66f-4e61-8762-466333553b38','Edward Patterson','Edward_Patterson@EdwardPatterson.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('82886dd5-592e-4cad-90a5-9af642512a97','Dennis Wilson','Dennis_Wilson@DennisWilson.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('a0b168e7-41fd-42d0-8521-0b5fd3840a5a','Ernest Rice','Ernest_Rice@ErnestRice.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('16704814-1b16-441e-a6e1-050a39df8759','Ronnie Howard','Ronnie_Howard@RonnieHoward.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('a1b2962d-05bd-459b-9572-cd87e9800978','Leroy Jordan','Leroy_Jordan@LeroyJordan.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('9648aabe-29c0-4f88-a2e0-ce008458a74a','Ricky Ray','Ricky_Ray@RickyRay.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('e81ccfba-05a1-4171-9961-e0f0ab1339ce','Edward Cunningham','Edward_Cunningham@EdwardCunningham.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('4ce10147-7086-4095-8847-50a1c4179a83','Randy Crawford','Randy_Crawford@RandyCrawford.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('fb10cd29-32af-4442-9124-7cb67c6115d0','Calvin Ward','Calvin_Ward@CalvinWard.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('686af819-e821-44c4-af96-7d5cce0c465d','Martin Thompson','Martin_Thompson@MartinThompson.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('146872e9-65f9-48dd-a49a-bb9e53220a5c','Clifford Ramos','Clifford_Ramos@CliffordRamos.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('72c0fb6a-4cb2-4433-8370-45d7efdc73fa','Larry Lopez','Larry_Lopez@LarryLopez.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('5d8092f4-1a3c-423a-aeff-a5492c22bccc','Henry Jordan','Henry_Jordan@HenryJordan.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('745fd3fa-baea-43fa-80e9-7b4957c2e136','Adam Sanchez','Adam_Sanchez@AdamSanchez.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('2554af05-1e02-409e-9d26-781cb217e66f','Brian Harris','Brian_Harris@BrianHarris.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('a2d1662a-8fea-46b3-8fa8-bdb6e7f0cb53','Rick Ross','Rick_Ross@RickRoss.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('3a110383-895e-4b06-8220-7f4433cebff9','Leonard Campbell','Leonard_Campbell@LeonardCampbell.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO PERSONS VALUES
	('ced2a4a7-676a-4159-b9fa-42933256e55b','Gene Weaver','Gene_Weaver@GeneWeaver.ru','428b0d72-84b1-48ea-8063-a3cfd88ee2d4');
INSERT INTO ORGANIZATIONS VALUES
	('d2168f04-9381-46ac-b4a1-1c7967962dfa','Организация 216','Sixth Ave');
INSERT INTO PERSONS VALUES
	('1c9ba9e0-936a-42ea-b371-039437fbe827','Ellen Hawkins','Ellen_Hawkins@EllenHawkins.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('c124bfea-f35a-4d78-9e8c-6833688de68a','Theresa Hall','Theresa_Hall@TheresaHall.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('fa8d5c3f-bc3a-4bc0-bc24-67778f54f406','Bobby Shaw','Bobby_Shaw@BobbyShaw.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('bc708d71-cf4b-483f-80b2-e50981f03c10','Bobby Allen','Bobby_Allen@BobbyAllen.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('27d2bcb9-d35b-444a-8ee8-df1b9218d6ce','Mike Freeman','Mike_Freeman@MikeFreeman.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('97d866c2-b4dd-42bf-bdd5-d3a09839a72b','Barry Willis','Barry_Willis@BarryWillis.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('da11421e-2286-4024-ba9f-7588258bad54','Justin Dixon','Justin_Dixon@JustinDixon.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('a0c89334-96ac-4183-b541-9073a7905e6e','Jesus Edwards','Jesus_Edwards@JesusEdwards.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('9b8cdac2-0ea8-4373-b827-c0fc5915c486','Jesse Knight','Jesse_Knight@JesseKnight.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('2a2ceccb-4e50-4f9c-b7a5-98447a3b6d2c','Jose Stevens','Jose_Stevens@JoseStevens.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('b45547ec-2511-42b6-9abe-e382cfc4908b','Kenneth Campbell','Kenneth_Campbell@KennethCampbell.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('586d1118-2d17-464a-b825-2bcda4275b7e','Steve Evans','Steve_Evans@SteveEvans.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('b007de46-f9e5-4d86-bf33-9af14045903e','Francisco Gibson','Francisco_Gibson@FranciscoGibson.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('9e7425d9-4617-43da-af22-1b1d23bd65d4','Lee Payne','Lee_Payne@LeePayne.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('c5740bc0-abf9-4ab7-8008-05fe6d306ff3','Jack Phillips','Jack_Phillips@JackPhillips.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('b4273a6d-5310-4a18-8733-bb07ac6a8b51','Harry Bryant','Harry_Bryant@HarryBryant.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('88b00ff1-64d5-4167-baf9-6981cfb70bcb','Donald Crawford','Donald_Crawford@DonaldCrawford.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO PERSONS VALUES
	('84464576-7e3b-4c6b-81d4-ce5b1b4da3bb','Ricardo Dixon','Ricardo_Dixon@RicardoDixon.ru','d2168f04-9381-46ac-b4a1-1c7967962dfa');
INSERT INTO ORGANIZATIONS VALUES
	('9339276c-58de-4d78-b471-313d442fef9d','Организация 339','Capital St');
INSERT INTO PERSONS VALUES
	('19903d56-58b0-4078-a141-07f26c6707b5','Brittany Alexander','Brittany_Alexander@BrittanyAlexander.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('8175f745-eab4-4c56-acd9-48adba4d9bf0','Ruby Reed','Ruby_Reed@RubyReed.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('3de133f9-69ff-47f0-a04b-088614474d0c','Joshua Harris','Joshua_Harris@JoshuaHarris.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('cd0628d8-4900-4156-973b-2194705f1f76','Glenn Willis','Glenn_Willis@GlennWillis.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('b08f1142-f389-495c-9477-af663e613a1b','Manuel Williams','Manuel_Williams@ManuelWilliams.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('810c87bd-91d3-475d-bd87-e1f045ca22cc','Larry Perry','Larry_Perry@LarryPerry.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('b03978aa-a874-4e13-afb6-5fe0f188ed16','Alan Ruiz','Alan_Ruiz@AlanRuiz.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('069117b4-2148-4955-a5ff-534aa111cfeb','Edward Hamilton','Edward_Hamilton@EdwardHamilton.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('f338dfa8-fd82-4a5f-997d-d9385e4b6fbe','Ronald Black','Ronald_Black@RonaldBlack.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('d1413c49-87bd-40b2-88be-ded5733d1ae1','Miguel Sanders','Miguel_Sanders@MiguelSanders.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('4f5bc8c9-4310-487b-858b-ca399b19524e','Chris Foster','Chris_Foster@ChrisFoster.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('7409d639-a6fb-47e9-b235-d3ec45d7f1c1','John Morris','John_Morris@JohnMorris.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('6e3f6402-c22c-45a5-b3fc-e3010d18134e','Pedro Young','Pedro_Young@PedroYoung.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('329739ae-ca2f-4069-93ab-eac921acdb7a','Bruce Patterson','Bruce_Patterson@BrucePatterson.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('a4cbd469-3e10-4c61-9e3a-57fe64f83e86','Luis Anderson','Luis_Anderson@LuisAnderson.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('d3203a64-54e8-4b29-b23f-81669bb9172d','Leo Lee','Leo_Lee@LeoLee.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO PERSONS VALUES
	('67e8f445-8153-4a59-82ab-9e9ebacc9c7c','Dean Harper','Dean_Harper@DeanHarper.ru','9339276c-58de-4d78-b471-313d442fef9d');
INSERT INTO ORGANIZATIONS VALUES
	('ab5c1802-474c-4660-ad6b-feef6c495855','Организация b5c','Juniper Rd');
INSERT INTO PERSONS VALUES
	('6be20f27-ee70-4ab0-bd82-b0871cf1be51','Jill Wallace','Jill_Wallace@JillWallace.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO PERSONS VALUES
	('10ed2420-c9f5-48ab-98a0-9cc5ea80da65','Charlotte Morris','Charlotte_Morris@CharlotteMorris.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO PERSONS VALUES
	('5479cba3-732d-4162-8987-8aa7a78e3ac4','Jim Knight','Jim_Knight@JimKnight.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO PERSONS VALUES
	('b71f8e4d-c463-4934-a3aa-e17de0263683','Jose Carter','Jose_Carter@JoseCarter.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO PERSONS VALUES
	('4d0fd41a-67f3-4ccb-99f3-ac24380ecede','Eugene Green','Eugene_Green@EugeneGreen.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO PERSONS VALUES
	('a7badf83-a6b5-49e2-ba01-beaaf1b7f228','Bernard Washington','Bernard_Washington@BernardWashington.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO PERSONS VALUES
	('75c4986a-1ea7-41e6-a672-035792c519d3','Victor Jackson','Victor_Jackson@VictorJackson.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO PERSONS VALUES
	('4f0eb31c-55b9-44ca-895f-a24fccf6abf9','Jeremy Lewis','Jeremy_Lewis@JeremyLewis.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO PERSONS VALUES
	('f14cbb57-b277-4cac-b882-5cc750fb2d02','Eddie Stevens','Eddie_Stevens@EddieStevens.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO PERSONS VALUES
	('9ecd6cef-c7cf-457d-b4e0-70928422e5c7','Nathan Marshall','Nathan_Marshall@NathanMarshall.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO PERSONS VALUES
	('0ed1ad0b-b673-46d1-b94f-f6b1a904d0eb','Hector Hill','Hector_Hill@HectorHill.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO PERSONS VALUES
	('db5b9b9d-ed23-4f85-86a8-81a9dda27613','Justin Carpenter','Justin_Carpenter@JustinCarpenter.ru','ab5c1802-474c-4660-ad6b-feef6c495855');
INSERT INTO ORGANIZATIONS VALUES
	('25442201-5927-4f40-b05b-80636e96ddd7','Организация 544','Capital St');
INSERT INTO PERSONS VALUES
	('d2ae1e1c-8b5c-4f9b-8489-f8058d65693c','Kathy Price','Kathy_Price@KathyPrice.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('535704e4-007e-47d5-810c-8d6a5e5669fa','Heather Pierce','Heather_Pierce@HeatherPierce.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('4e20574f-0268-4689-9cff-0743866dd535','Marvin Ferguson','Marvin_Ferguson@MarvinFerguson.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('1346b063-6be7-49d9-8429-4853dbdddb6d','Greg Thomas','Greg_Thomas@GregThomas.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('17c27cc7-7697-4087-81a2-8754ee06f9fb','Timothy Tucker','Timothy_Tucker@TimothyTucker.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('3d32eeba-67d3-470f-98bd-26f16336e390','Derek Hill','Derek_Hill@DerekHill.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('bcf7e384-bd23-4104-90bb-c7fcc4bf51a8','Jimmy Ray','Jimmy_Ray@JimmyRay.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('e29b80bd-2507-4932-895e-2b424579d77d','Joseph Chavez','Joseph_Chavez@JosephChavez.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('4b7fef69-c016-4d90-8cb1-5721fb8737aa','Andrew Hunter','Andrew_Hunter@AndrewHunter.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('8c5f1ce3-564c-4f7a-a10c-da567eeb71af','Manuel Owens','Manuel_Owens@ManuelOwens.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('22ef5251-a120-4ed6-bcb5-f4122f7d052c','Brian Austin','Brian_Austin@BrianAustin.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('dea831f1-268c-4292-afd1-a4b8fdbd6ca9','Melvin Jenkins','Melvin_Jenkins@MelvinJenkins.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('6c58bfd4-6339-46c9-b98f-844db89c1a60','Calvin Stone','Calvin_Stone@CalvinStone.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('5612fc5b-ec26-4346-b65a-9be0366bf022','Leonard Spencer','Leonard_Spencer@LeonardSpencer.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('c179b3ed-e548-44e9-a2b4-beec1763be2f','Charlie Watson','Charlie_Watson@CharlieWatson.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('8cf9da13-e972-4b91-9990-9355f11293c2','Donald Owens','Donald_Owens@DonaldOwens.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO PERSONS VALUES
	('71852ca7-31c9-47d1-b64c-a60b9debbcd8','Charles Armstrong','Charles_Armstrong@CharlesArmstrong.ru','25442201-5927-4f40-b05b-80636e96ddd7');
INSERT INTO ORGANIZATIONS VALUES
	('cf0ec906-04e1-4784-a9d2-4dd7ebeb8e98','Организация f0e','First Ave');
INSERT INTO PERSONS VALUES
	('261a5cb4-0bd3-4e07-9700-35ed85a0b6fc','Erica Alexander','Erica_Alexander@EricaAlexander.ru','cf0ec906-04e1-4784-a9d2-4dd7ebeb8e98');
INSERT INTO PERSONS VALUES
	('926c56fd-7637-49f8-9cc0-4a1daf47754c','Amber Holmes','Amber_Holmes@AmberHolmes.ru','cf0ec906-04e1-4784-a9d2-4dd7ebeb8e98');
INSERT INTO PERSONS VALUES
	('bc535a48-e638-4271-ab69-5a1029a10dfc','Victor Peterson','Victor_Peterson@VictorPeterson.ru','cf0ec906-04e1-4784-a9d2-4dd7ebeb8e98');
INSERT INTO PERSONS VALUES
	('34eaa703-f92e-4d31-a5a9-b7f70a285325','Todd Kelly','Todd_Kelly@ToddKelly.ru','cf0ec906-04e1-4784-a9d2-4dd7ebeb8e98');
INSERT INTO PERSONS VALUES
	('a36630f3-d7a0-4b0e-abc8-f1f09ae58c01','Tim Watkins','Tim_Watkins@TimWatkins.ru','cf0ec906-04e1-4784-a9d2-4dd7ebeb8e98');
INSERT INTO PERSONS VALUES
	('a2e0e546-013f-4367-9076-49f6aeb95ddd','Samuel Henderson','Samuel_Henderson@SamuelHenderson.ru','cf0ec906-04e1-4784-a9d2-4dd7ebeb8e98');
INSERT INTO PERSONS VALUES
	('784aa5e0-d851-494d-ad94-2c7b297d0cea','Oscar West','Oscar_West@OscarWest.ru','cf0ec906-04e1-4784-a9d2-4dd7ebeb8e98');
INSERT INTO PERSONS VALUES
	('567c9580-ed48-4853-ac08-55fa57dc51b6','Vincent Pierce','Vincent_Pierce@VincentPierce.ru','cf0ec906-04e1-4784-a9d2-4dd7ebeb8e98');
INSERT INTO PERSONS VALUES
	('7dde0c11-6ee8-4bf8-b9ab-ad6bb9a32e73','Matthew Torres','Matthew_Torres@MatthewTorres.ru','cf0ec906-04e1-4784-a9d2-4dd7ebeb8e98');
INSERT INTO PERSONS VALUES
	('9d2649e8-4576-4948-bd3f-f8b3915e5a6c','Steve Kelley','Steve_Kelley@SteveKelley.ru','cf0ec906-04e1-4784-a9d2-4dd7ebeb8e98');
INSERT INTO ORGANIZATIONS VALUES
	('8e110560-8e62-4383-93d5-e7e7532709c5','Организация e11','Third Ln');
INSERT INTO PERSONS VALUES
	('dfe6dff3-6d27-4002-b6ae-9162ce0099e4','Ruby Flores','Ruby_Flores@RubyFlores.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO PERSONS VALUES
	('3c94b844-0c66-46f3-93bd-ebe83964a35b','Marilyn Berry','Marilyn_Berry@MarilynBerry.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO PERSONS VALUES
	('aa9f0d1d-c93a-4350-a833-402f50ade0b2','Mario Elliott','Mario_Elliott@MarioElliott.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO PERSONS VALUES
	('523cc679-9bd3-41dc-ab4e-d45d6a2ea2fa','William Murphy','William_Murphy@WilliamMurphy.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO PERSONS VALUES
	('7b5054f7-9b72-4576-bcf7-a3c617a7accf','Tyler Andrews','Tyler_Andrews@TylerAndrews.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO PERSONS VALUES
	('3ab5ab76-cf8e-4040-b2de-88aac7789a30','Steven Clark','Steven_Clark@StevenClark.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO PERSONS VALUES
	('89aa9a7b-e8d7-4ed5-98c6-42c247ca816c','Ronnie Lawrence','Ronnie_Lawrence@RonnieLawrence.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO PERSONS VALUES
	('88acdff8-50ce-4146-9e35-628f3c18c591','Derrick Hunt','Derrick_Hunt@DerrickHunt.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO PERSONS VALUES
	('567bf443-3400-483b-8053-2a70726bdd7d','Patrick Morales','Patrick_Morales@PatrickMorales.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO PERSONS VALUES
	('f456bc5c-3569-4c2d-b90f-4d214b70751e','Tyler Robinson','Tyler_Robinson@TylerRobinson.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO PERSONS VALUES
	('412c9412-ebfc-4376-9e7b-ab3e5e208018','Leroy Crawford','Leroy_Crawford@LeroyCrawford.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO PERSONS VALUES
	('32d5c15e-b418-4bca-a4a5-d869aa57bf7e','Alfred Carter','Alfred_Carter@AlfredCarter.ru','8e110560-8e62-4383-93d5-e7e7532709c5');
INSERT INTO ORGANIZATIONS VALUES
	('00759c5b-7940-454f-8043-b11cdf6aedfb','Организация 075','Piedmont Way');
INSERT INTO PERSONS VALUES
	('64e4c90c-f4fe-4c44-9f04-d990cb427b86','Melanie Rodriguez','Melanie_Rodriguez@MelanieRodriguez.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('66297f74-d30e-4f7e-8245-aaf9a856df00','Hazel Greene','Hazel_Greene@HazelGreene.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('ff025705-ac5d-48c6-aa05-cfc90eedfa98','Roy Kelly','Roy_Kelly@RoyKelly.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('ad164e32-c7a3-4762-ae9b-20c1c23e0d1b','Willie Hawkins','Willie_Hawkins@WillieHawkins.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('24fbda22-e9bf-4db9-bed8-a288d3ddd58f','Henry Harrison','Henry_Harrison@HenryHarrison.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('10009ba3-4087-4450-ba07-b7b3088b3192','Floyd Diaz','Floyd_Diaz@FloydDiaz.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('bf204ad1-af45-4606-89cc-8ca00e7a0c7f','Harold Hart','Harold_Hart@HaroldHart.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('435c674f-d23f-4abf-a9f3-f445d8a6a43d','Martin Martinez','Martin_Martinez@MartinMartinez.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('9d114fa8-3f96-4a60-8a1d-fdf4ed645fea','William Evans','William_Evans@WilliamEvans.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('c942a5c5-5dc0-4cd1-8681-a26dcbb862c9','Timothy Gardner','Timothy_Gardner@TimothyGardner.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('1b496013-b0e9-483e-b91b-b42cf0201c98','Shawn Ford','Shawn_Ford@ShawnFord.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('9569a5ff-4417-4da3-a500-9e7619c6c080','Jerry Ramirez','Jerry_Ramirez@JerryRamirez.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('349e06cc-1484-4725-bca6-3ee6930dc403','Robert Cook','Robert_Cook@RobertCook.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('879bfa8f-fd21-48bc-b641-3b8256ed8859','Joel Stewart','Joel_Stewart@JoelStewart.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('13c83825-a0c8-4c80-89e8-2ae4ea00d378','Marcus Marshall','Marcus_Marshall@MarcusMarshall.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('1a0a113c-063f-4a2e-8bea-6edbaf9608ac','Norman Patterson','Norman_Patterson@NormanPatterson.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('47466cd7-e80c-49f8-aeb3-09c14242b101','Ronald Rice','Ronald_Rice@RonaldRice.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO PERSONS VALUES
	('48ef1f78-9dfa-4706-b613-13efdf39f215','Shane White','Shane_White@ShaneWhite.ru','00759c5b-7940-454f-8043-b11cdf6aedfb');
INSERT INTO ORGANIZATIONS VALUES
	('922e75b6-3b39-4a1d-9c8e-92ad48fb519f','Организация 22e','Decatur Rd');
INSERT INTO PERSONS VALUES
	('8a0db56e-33b4-459b-97ec-6713e4b4e2de','Carol Gordon','Carol_Gordon@CarolGordon.ru','922e75b6-3b39-4a1d-9c8e-92ad48fb519f');
INSERT INTO PERSONS VALUES
	('0a375cf9-5b1d-444f-b2e0-e3cca54eb8f9','Christine Hamilton','Christine_Hamilton@ChristineHamilton.ru','922e75b6-3b39-4a1d-9c8e-92ad48fb519f');
INSERT INTO PERSONS VALUES
	('cdb41c23-9971-4d17-acdd-946cdaed65c4','Rick Lopez','Rick_Lopez@RickLopez.ru','922e75b6-3b39-4a1d-9c8e-92ad48fb519f');
INSERT INTO PERSONS VALUES
	('2280d46a-b9ad-4879-a694-5dc73f4d3680','Donald Fisher','Donald_Fisher@DonaldFisher.ru','922e75b6-3b39-4a1d-9c8e-92ad48fb519f');
INSERT INTO PERSONS VALUES
	('8b2dbf87-7a76-4443-9f16-3943449ccb84','Larry Palmer','Larry_Palmer@LarryPalmer.ru','922e75b6-3b39-4a1d-9c8e-92ad48fb519f');
INSERT INTO ORGANIZATIONS VALUES
	('1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979','Организация e1e','Second Ln');
INSERT INTO PERSONS VALUES
	('9ca04c15-2f5b-4586-b902-56375fecb8f1','Wanda Wilson','Wanda_Wilson@WandaWilson.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('30b61530-8660-4aa6-80c7-3a46a564e099','Annette Kelley','Annette_Kelley@AnnetteKelley.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('c2ec2a4d-c76a-4630-a6ba-ebdb16d10e4d','Dustin Watkins','Dustin_Watkins@DustinWatkins.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('256faa09-34af-4b29-938f-238140e7443f','Walter Carter','Walter_Carter@WalterCarter.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('a4ae44c3-27c4-4fa4-b695-2ea68838a44d','Nathan Fisher','Nathan_Fisher@NathanFisher.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('bb8ec34e-666b-4ea2-ba1e-b4f8f6414763','Glen Price','Glen_Price@GlenPrice.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('5baec1f0-27fa-4b4e-a0f7-46b3a35f2eb5','Ernest Austin','Ernest_Austin@ErnestAustin.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('7f02578c-da7a-4ce4-8011-5c8db465eb52','Hector Jones','Hector_Jones@HectorJones.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('8cbca46d-1975-4b38-b248-dc019c13c72d','Charles Gomez','Charles_Gomez@CharlesGomez.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('9680bf0f-fe38-4be6-88d5-16d5b6a53f2f','Randall Price','Randall_Price@RandallPrice.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('171b4840-a557-4770-a7fe-194d7b2acf8e','Brent Gordon','Brent_Gordon@BrentGordon.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('8552095e-fc7e-477e-b9d8-3cc49a2c65d8','Tommy Perez','Tommy_Perez@TommyPerez.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('c6902a84-a812-42ad-8275-5a6a364f468a','Corey Tucker','Corey_Tucker@CoreyTucker.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('47f4f121-8b33-49aa-a21d-792bce096031','Jimmy Wagner','Jimmy_Wagner@JimmyWagner.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('a711dcaa-f3fd-448d-96dc-fe5f1e6bae7a','Dennis Bennett','Dennis_Bennett@DennisBennett.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('9d41fa01-c051-444f-a89a-b4d9640a6339','Clarence Olson','Clarence_Olson@ClarenceOlson.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('a3af4343-2aa8-4719-9575-6d407dceba92','Miguel Dunn','Miguel_Dunn@MiguelDunn.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('33b42a95-19ba-4a63-af39-0dd4ff895d1a','Herbert Harrison','Herbert_Harrison@HerbertHarrison.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('b2663e4b-14db-428b-9dd7-d10768040588','Maurice Cooper','Maurice_Cooper@MauriceCooper.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO PERSONS VALUES
	('e2973a38-048b-4b34-a7b2-bce8ad5a5997','Floyd Ferguson','Floyd_Ferguson@FloydFerguson.ru','1e1e5cb0-5cc2-4b8b-a0b7-d8689f6f6979');
INSERT INTO ORGANIZATIONS VALUES
	('9e4c114a-9d26-4064-822b-2d1c5b75daa2','Организация e4c','Fowler Pkwy');
INSERT INTO PERSONS VALUES
	('9d273c7c-411f-4b56-ba2c-14220056d0f6','Lois Lane','Lois_Lane@LoisLane.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('3d4acdbc-ac8e-474b-97eb-35cc6db6d5e7','Tiffany Patterson','Tiffany_Patterson@TiffanyPatterson.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('eb7f650c-f9bd-40f1-8bc6-ce1dac5dec17','Frank Mason','Frank_Mason@FrankMason.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('b15b1d36-cd09-4fb8-b723-8fe00c134710','Alan Arnold','Alan_Arnold@AlanArnold.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('3d4134e6-a9e3-4a1f-ab99-c20d05578023','Pedro Hill','Pedro_Hill@PedroHill.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('96532533-ada6-4e44-969e-0c2b53d681c4','Shane Hamilton','Shane_Hamilton@ShaneHamilton.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('36751122-8f66-4afc-9639-1555053fa75d','Don Sanchez','Don_Sanchez@DonSanchez.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('57fb6911-149a-497a-a4f9-34145f3d9a2b','Kenneth Stewart','Kenneth_Stewart@KennethStewart.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('abefead4-43d6-48aa-bef0-d06c4ae722de','Jay Harris','Jay_Harris@JayHarris.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('f691e043-4603-422e-9d02-848db7687b5f','Justin Holmes','Justin_Holmes@JustinHolmes.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('ffbd4dcc-564a-46cc-aff6-4b962d482c9c','Chris Olson','Chris_Olson@ChrisOlson.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('8777bd5c-54eb-4231-89b8-125af9566ce8','Herbert Stevens','Herbert_Stevens@HerbertStevens.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('44a8c555-4c76-4dba-8c40-77b60ab6bf96','Luis Wells','Luis_Wells@LuisWells.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('567e10df-0e7b-4df2-9fa4-651929b2599d','Ralph Martinez','Ralph_Martinez@RalphMartinez.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('670689ba-b825-448f-bb87-9b224b3eb71d','Roger Jordan','Roger_Jordan@RogerJordan.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('15010108-0639-4f3c-960e-47df42000d01','Tom Wilson','Tom_Wilson@TomWilson.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('746e9c43-2521-4267-8e96-c7b741c12961','Gerald Allen','Gerald_Allen@GeraldAllen.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('14628975-5e28-4de6-8e4e-0acae5a316b9','Luis Ferguson','Luis_Ferguson@LuisFerguson.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('a17ca3f1-95dc-436f-932e-e58a740d2f6e','Roger Clark','Roger_Clark@RogerClark.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('27d94e76-b8f6-4846-a7f6-5e88f52cf9b8','Lee Reynolds','Lee_Reynolds@LeeReynolds.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO PERSONS VALUES
	('bbf7a53a-cfa4-4495-9f39-8a2d07d02b31','Lee Jordan','Lee_Jordan@LeeJordan.ru','9e4c114a-9d26-4064-822b-2d1c5b75daa2');
INSERT INTO ORGANIZATIONS VALUES
	('635e9fed-96f8-4792-aa48-64b0261ddc91','Организация 35e','Fourteenth Blvd');
INSERT INTO PERSONS VALUES
	('43a31a66-7e76-442b-999e-323f48ae455b','Wendy Porter','Wendy_Porter@WendyPorter.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('bd5a0d0f-2ebd-458b-be96-b325b073bc7a','Tammy Shaw','Tammy_Shaw@TammyShaw.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('76ec9f97-7c92-4bb0-95e0-0cfc9652fe7e','Vernon Hughes','Vernon_Hughes@VernonHughes.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('e2d2052f-a3a3-4ff0-91b0-e5708d89eb88','Randall Baker','Randall_Baker@RandallBaker.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('4a109318-f8a1-4cae-9cb0-6a674af3d672','Glen Martinez','Glen_Martinez@GlenMartinez.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('ba86a050-6584-4cbf-a2d5-ca8f0a57f00f','Nicholas Griffin','Nicholas_Griffin@NicholasGriffin.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('054684a1-5dc5-471a-9aed-33ab68b7a2b3','Glenn Henderson','Glenn_Henderson@GlennHenderson.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('067e6e3b-4d0a-4295-900e-eb2d21437a28','Marcus Freeman','Marcus_Freeman@MarcusFreeman.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('80233b9f-8cee-4da5-a1ee-470df518fc7d','Alvin Jackson','Alvin_Jackson@AlvinJackson.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('b505b3ac-d6df-46b2-8a0e-cecd601d5641','Shane Parker','Shane_Parker@ShaneParker.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('5465b2c1-0cf4-42da-bab3-694120e85b2b','Tim Long','Tim_Long@TimLong.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('50376591-147e-4825-a8d5-45c7ef758af6','Albert Henry','Albert_Henry@AlbertHenry.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO PERSONS VALUES
	('24ecc356-e846-4004-b2f7-6c53ef3e3672','Tommy Foster','Tommy_Foster@TommyFoster.ru','635e9fed-96f8-4792-aa48-64b0261ddc91');
INSERT INTO ORGANIZATIONS VALUES
	('4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559','Организация a11','Central Ave');
INSERT INTO PERSONS VALUES
	('3a7bc2b8-d870-4448-a8d0-93e10e5bb14c','Jane Butler','Jane_Butler@JaneButler.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('2242873a-2fed-413a-8dcc-ca2b5babcba1','Katherine Dunn','Katherine_Dunn@KatherineDunn.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('9a2a6999-e000-4610-82f0-4b5d5ea7f7cf','Scott Gray','Scott_Gray@ScottGray.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('9a9f09e4-9b60-4fb6-9168-89b7d4330113','Randall Carter','Randall_Carter@RandallCarter.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('40cdf1a2-e164-4d1c-8be1-2d7cacbd8d19','Dustin Reynolds','Dustin_Reynolds@DustinReynolds.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('96fb162d-9256-4161-85d9-207d9e18af92','Peter Smith','Peter_Smith@PeterSmith.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('a3a1d662-7e5b-4136-94de-3c48b380ec6a','Brian Henry','Brian_Henry@BrianHenry.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('1fa55ec5-3834-48dd-9525-bd1d8b2ca899','Floyd Miller','Floyd_Miller@FloydMiller.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('9d5ad945-ebc7-4d38-ba16-7c1ca829fb65','Danny Gomez','Danny_Gomez@DannyGomez.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('a804bfb3-4405-404a-9c3e-cac1cac0828a','Luis Armstrong','Luis_Armstrong@LuisArmstrong.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('f26922ff-f662-4030-92de-cc107707b20d','Bernard Mcdonald','Bernard_Mcdonald@BernardMcdonald.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('7e519c58-827d-47ae-9349-e07e6f810c99','Patrick Stevens','Patrick_Stevens@PatrickStevens.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('c3ff84f7-fdbc-4476-9fd1-e8d9b0f7a3b3','David Woods','David_Woods@DavidWoods.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('0d8492a3-4ecf-408a-9d93-255da5b94125','Frederick Allen','Frederick_Allen@FrederickAllen.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('71b30f61-a933-4ad8-b1ba-cf876c6127c7','Leo Johnson','Leo_Johnson@LeoJohnson.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('58e7bfc4-72f4-4695-8afd-80e89f1d0bf4','Rick Duncan','Rick_Duncan@RickDuncan.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO PERSONS VALUES
	('fbe4bd06-d362-4969-98ed-7109989e2159','Harold Shaw','Harold_Shaw@HaroldShaw.ru','4a11e9e8-b9c7-4e84-8a70-1e3d26a5f559');
INSERT INTO ORGANIZATIONS VALUES
	('a0e03308-2c10-4b3b-b588-713a1a947407','Организация 0e0','Capital Blvd');
INSERT INTO PERSONS VALUES
	('757875cd-f89d-4bf7-9cca-df8599fe7188','Samantha Gibson','Samantha_Gibson@SamanthaGibson.ru','a0e03308-2c10-4b3b-b588-713a1a947407');
INSERT INTO PERSONS VALUES
	('25ee122e-3db5-4881-807d-e715f49020b1','Erin Matthews','Erin_Matthews@ErinMatthews.ru','a0e03308-2c10-4b3b-b588-713a1a947407');
INSERT INTO PERSONS VALUES
	('52362c5c-2fc9-4acb-a9de-4a1b9d4c6309','Shane Roberts','Shane_Roberts@ShaneRoberts.ru','a0e03308-2c10-4b3b-b588-713a1a947407');
INSERT INTO PERSONS VALUES
	('cdae6a9e-7cb5-464a-99fc-52ff22214f3f','Glen Jordan','Glen_Jordan@GlenJordan.ru','a0e03308-2c10-4b3b-b588-713a1a947407');
INSERT INTO PERSONS VALUES
	('9a69be2f-2a12-4c2b-9c6b-fed802e0d044','Roberto Williams','Roberto_Williams@RobertoWilliams.ru','a0e03308-2c10-4b3b-b588-713a1a947407');
INSERT INTO PERSONS VALUES
	('cbec1bef-8792-41b1-970f-877f71432274','Dustin Powell','Dustin_Powell@DustinPowell.ru','a0e03308-2c10-4b3b-b588-713a1a947407');
INSERT INTO ORGANIZATIONS VALUES
	('08e7dbf1-a8b1-480e-9451-644b47e6d1ae','Организация 8e7','Third Pkwy');
INSERT INTO PERSONS VALUES
	('5884434e-ff66-4931-9fea-4ffcbf54308b','Rebecca Parker','Rebecca_Parker@RebeccaParker.ru','08e7dbf1-a8b1-480e-9451-644b47e6d1ae');
INSERT INTO PERSONS VALUES
	('91039d4f-9607-4f4a-a9d4-9a8c4ffd7407','Angela Cunningham','Angela_Cunningham@AngelaCunningham.ru','08e7dbf1-a8b1-480e-9451-644b47e6d1ae');
INSERT INTO PERSONS VALUES
	('3c58fb5f-bc27-4766-8c22-b24b92cfa6f4','Daniel Long','Daniel_Long@DanielLong.ru','08e7dbf1-a8b1-480e-9451-644b47e6d1ae');
INSERT INTO PERSONS VALUES
	('6ed69527-458f-4ae6-9251-ea3840c3e868','Gerald Ramos','Gerald_Ramos@GeraldRamos.ru','08e7dbf1-a8b1-480e-9451-644b47e6d1ae');
INSERT INTO PERSONS VALUES
	('0027906c-c8b0-40c9-b449-ba6f60606b5e','Theodore Palmer','Theodore_Palmer@TheodorePalmer.ru','08e7dbf1-a8b1-480e-9451-644b47e6d1ae');
INSERT INTO PERSONS VALUES
	('fb302b18-b5cb-444b-95db-9e55b9f8c957','Michael Cook','Michael_Cook@MichaelCook.ru','08e7dbf1-a8b1-480e-9451-644b47e6d1ae');
INSERT INTO PERSONS VALUES
	('ad5bd85a-b1c6-48bd-a627-60f645d72229','Jeffrey Hart','Jeffrey_Hart@JeffreyHart.ru','08e7dbf1-a8b1-480e-9451-644b47e6d1ae');
INSERT INTO ORGANIZATIONS VALUES
	('cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8','Организация c72','Juniper Ln');
INSERT INTO PERSONS VALUES
	('6f701742-75c5-4e7f-81ac-b70180558da9','Sylvia Lewis','Sylvia_Lewis@SylviaLewis.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('e54de4f8-b3f1-4b81-897e-194d70071f1a','Crystal Wallace','Crystal_Wallace@CrystalWallace.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('cfc00279-92e7-4802-b8b3-48164bc60f80','Scott Burns','Scott_Burns@ScottBurns.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('2cbbbb4a-e42b-46b3-8f1d-f3025b599211','Leroy Woods','Leroy_Woods@LeroyWoods.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('555d681f-c7c0-445c-8c39-1dd7e2669fc2','Shawn Hughes','Shawn_Hughes@ShawnHughes.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('c8a706dc-5af0-4422-8a5d-90ccb287b757','Dennis Gordon','Dennis_Gordon@DennisGordon.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('4067acc6-9087-4287-afd4-862daf0301bc','Jorge Spencer','Jorge_Spencer@JorgeSpencer.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('09a01154-d345-43c3-8c69-84fd8e0bb652','Roger Morris','Roger_Morris@RogerMorris.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('a2dacfd8-17d3-41db-a2ce-b2f7080ed350','Dean Elliott','Dean_Elliott@DeanElliott.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('df1ee2ec-51d2-4dde-8bce-86e8bc4d6ede','Daniel Hunt','Daniel_Hunt@DanielHunt.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('9f9c493d-5e81-4eea-a845-6a99d27f1ce7','Raymond Alexander','Raymond_Alexander@RaymondAlexander.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('d1a626ba-ebcd-4aa5-a39d-1d22c9f544af','Jeremy Rivera','Jeremy_Rivera@JeremyRivera.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('0f84f4f5-04de-4717-ad12-2290b2e877c7','Randy Jones','Randy_Jones@RandyJones.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('baf52b50-db4f-499b-bb1a-0e2bdd01b3e4','Michael Peterson','Michael_Peterson@MichaelPeterson.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('00711127-91b5-4835-a4fb-909c54b235f4','Russell Powell','Russell_Powell@RussellPowell.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('030e7d3d-d0f3-4f23-b679-9f4447d2a941','Gary Lee','Gary_Lee@GaryLee.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('da8485b0-592c-401b-a208-d3a20d863a06','Tyler Hamilton','Tyler_Hamilton@TylerHamilton.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('2e968143-e8a7-480f-9024-ca8468a610b0','Troy Porter','Troy_Porter@TroyPorter.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('bc4532db-8686-48dc-af66-2dfa46217d2a','Pedro Murphy','Pedro_Murphy@PedroMurphy.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('f4220038-13a5-4560-8145-063f1044d793','Barry Kennedy','Barry_Kennedy@BarryKennedy.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('baa2e88f-f583-4a35-9458-ef288a5bd992','Derek Armstrong','Derek_Armstrong@DerekArmstrong.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('5ad1c055-700d-4b74-aa9d-c35cdbb269a6','Manuel Mcdonald','Manuel_Mcdonald@ManuelMcdonald.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('7c380e5d-b2d1-4d9d-94b9-cbc63fe40f3f','Ernest Burns','Ernest_Burns@ErnestBurns.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('8c917332-25c3-497c-b1ab-6047adf1202f','Dustin Sanchez','Dustin_Sanchez@DustinSanchez.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('01c2a94c-d2db-4448-9e4b-a7cfe68704be','Bernard Bennett','Bernard_Bennett@BernardBennett.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('72ba8d82-2293-4eee-a18f-f0db0640328f','Daniel Rice','Daniel_Rice@DanielRice.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('acdf7e28-1209-4908-b0db-8070d761f31a','Lloyd Alexander','Lloyd_Alexander@LloydAlexander.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('4f77569b-5b1f-40ad-896f-99efc5d9c08b','Martin Wallace','Martin_Wallace@MartinWallace.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('f69f0634-f5ef-4587-815c-21e9673e2407','Lloyd Snyder','Lloyd_Snyder@LloydSnyder.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('5d3dc346-1c2d-4407-810d-af5893be1975','Terry Lopez','Terry_Lopez@TerryLopez.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO PERSONS VALUES
	('6bef29d4-0ced-48cb-b3fa-54d1bd5ac1da','Alvin Garcia','Alvin_Garcia@AlvinGarcia.ru','cc72a50f-b6e4-4b5a-b91b-69ca2c2a28c8');
INSERT INTO ORGANIZATIONS VALUES
	('1da73877-a9b3-469d-b16d-1aaa0a3f59bb','Организация da7','Piedmont St');
INSERT INTO PERSONS VALUES
	('706d4a12-59a7-43ae-b811-f3ef0b6a3078','Clara Bennett','Clara_Bennett@ClaraBennett.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('2a27e875-dddc-44f1-a325-6a720e100130','Robin Cole','Robin_Cole@RobinCole.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('dd77f5ca-4315-472c-a127-d0ce08b42945','Joel Peterson','Joel_Peterson@JoelPeterson.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('3bc8bea2-dd6f-4491-bd0c-16b63282ac22','Leroy Rogers','Leroy_Rogers@LeroyRogers.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('e3d01f1c-b2a8-4458-be0b-c4ad68b823ea','Keith Gonzales','Keith_Gonzales@KeithGonzales.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('48a10b75-b795-495d-a016-b73bac0d8577','Charlie Jackson','Charlie_Jackson@CharlieJackson.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('855e82c0-9d0e-494c-8026-52bfca53e1ca','Michael Hunt','Michael_Hunt@MichaelHunt.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('5c9b2439-cbca-4b15-ac65-5a5f3f17f8ee','Russell Rogers','Russell_Rogers@RussellRogers.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('7d159ed3-f52c-46d9-a6ee-af825cc317c0','Micheal Powell','Micheal_Powell@MichealPowell.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('66884a27-cf30-4cbd-9cad-6f45fccd2030','Zachary Garcia','Zachary_Garcia@ZacharyGarcia.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('6a200f40-3aa5-48a2-bfd0-b7afcfae2c6c','Justin King','Justin_King@JustinKing.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('24bc41ca-f95a-4ee5-9554-2bd4db2e19e4','Ray Graham','Ray_Graham@RayGraham.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('d18c17f8-e2ee-4289-a2ff-f1c4cdaf822b','Richard Hayes','Richard_Hayes@RichardHayes.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('54584a46-48f4-4be6-a94f-c77557d22408','Todd Watson','Todd_Watson@ToddWatson.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('7578e899-d85d-4599-a8c5-d3d3b2f88b7b','Ricardo Mills','Ricardo_Mills@RicardoMills.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('996697f3-de52-4e75-9b9b-6464c0bbcef9','Willie Chavez','Willie_Chavez@WillieChavez.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('54275fae-e244-424b-9d90-1d943965db1d','Ronnie Perez','Ronnie_Perez@RonniePerez.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('f9befc10-fa3c-46e9-82ef-7124aafc28c8','Joshua Payne','Joshua_Payne@JoshuaPayne.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO PERSONS VALUES
	('9458d7af-9336-49b0-9c76-aab9265af3e7','Roberto West','Roberto_West@RobertoWest.ru','1da73877-a9b3-469d-b16d-1aaa0a3f59bb');
INSERT INTO ORGANIZATIONS VALUES
	('196b0d72-a3e6-4507-bcae-bfed8978d924','Организация 96b','Mitchell Rd');
INSERT INTO PERSONS VALUES
	('3242cafb-b592-4b56-bf2b-ad9f1746a22a','Lori Bennett','Lori_Bennett@LoriBennett.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('3f297425-a27e-4b7b-90ca-fdf1cece7829','Crystal Miller','Crystal_Miller@CrystalMiller.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('8298f8d6-c76e-4e53-9ec2-c5747c87ab5b','Lee Ramos','Lee_Ramos@LeeRamos.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('26e330fb-209f-4fcd-aa5b-4c55af0576c0','Greg Cooper','Greg_Cooper@GregCooper.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('e1e63625-e1c5-4d3d-8d97-a510eb744363','Ryan Patterson','Ryan_Patterson@RyanPatterson.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('0d7cb09d-5d20-4cbd-b111-a5126cac372f','Lee Mills','Lee_Mills@LeeMills.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('ea3fd9be-c22d-4ec7-af3c-67273438702f','Peter Coleman','Peter_Coleman@PeterColeman.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('b5896738-bc23-430a-bad1-a6bf175b7c8b','Zachary Johnson','Zachary_Johnson@ZacharyJohnson.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('37c9806f-ddee-4ccd-8c9e-3cb553651bba','Ray Adams','Ray_Adams@RayAdams.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('c894ef29-4c14-4f16-9a95-296e15fbdb21','Pedro Thompson','Pedro_Thompson@PedroThompson.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('3e21e15d-370f-4969-98ef-308517821504','Rodney Cooper','Rodney_Cooper@RodneyCooper.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('8857771b-db6f-45d7-9acd-76196a8459d6','Sam Taylor','Sam_Taylor@SamTaylor.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('61672c0a-dd7b-4bb0-b389-f6cd40218341','Fred Ward','Fred_Ward@FredWard.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('b656668b-c6c7-48e1-a1e7-9654671441ea','Shawn Robertson','Shawn_Robertson@ShawnRobertson.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('8802316a-f1fd-4ed5-9948-52e6df94e523','Walter Mcdonald','Walter_Mcdonald@WalterMcdonald.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO PERSONS VALUES
	('8945b796-2412-4b02-9e33-6a9de9fc8c7f','Timothy Hunt','Timothy_Hunt@TimothyHunt.ru','196b0d72-a3e6-4507-bcae-bfed8978d924');
INSERT INTO ORGANIZATIONS VALUES
	('36a8148c-5200-4c0e-a1eb-121fbb2a7bae','Организация 6a8','Currier Cir');
INSERT INTO PERSONS VALUES
	('12d49e70-b628-4b31-9a3b-b3391fe4505c','Robin Ferguson','Robin_Ferguson@RobinFerguson.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('419c091e-ccbb-44ac-ba94-26f1c0a67959','Alma Perry','Alma_Perry@AlmaPerry.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('dcca2d93-84f5-4df2-8d53-e7c3390fb4b4','Glenn Ward','Glenn_Ward@GlennWard.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('ac8178df-7690-4087-a06b-4da4a8c969c7','Joel Boyd','Joel_Boyd@JoelBoyd.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('88362aeb-7b10-437c-9f8a-3b190e400e4d','Bradley Russell','Bradley_Russell@BradleyRussell.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('21873f9d-4f90-42b1-a7ce-ca10b95d944b','Frederick Diaz','Frederick_Diaz@FrederickDiaz.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('a8d69f14-9f84-4eb0-b47d-1e8579b51f2e','Dennis Hill','Dennis_Hill@DennisHill.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('b8c12909-980f-482c-896d-44f7638274c5','Carl Gonzalez','Carl_Gonzalez@CarlGonzalez.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('848f1b92-a368-49c9-88e3-aa8d75ec7477','Miguel Brooks','Miguel_Brooks@MiguelBrooks.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('3a38dbd0-ebe0-4790-9d21-fe21a86af982','James Brown','James_Brown@JamesBrown.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('e03dc885-5bff-4868-85c0-1852ed07e2fa','Alvin Rivera','Alvin_Rivera@AlvinRivera.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('3f951944-efd8-4a3e-9d97-7f8ff5d91d63','Jay Jones','Jay_Jones@JayJones.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('749ceef3-540d-4287-acbc-2f8a8fdcab32','Charlie Phillips','Charlie_Phillips@CharliePhillips.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('764b73c0-76d5-4d45-86b3-9031181d86f9','William Hernandez','William_Hernandez@WilliamHernandez.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO PERSONS VALUES
	('3484e757-b4b7-4f4b-876b-ab2ed71c1ca2','Glen Evans','Glen_Evans@GlenEvans.ru','36a8148c-5200-4c0e-a1eb-121fbb2a7bae');
INSERT INTO ORGANIZATIONS VALUES
	('e57efca8-20d8-467f-8fca-77a57db9998a','Организация 57e','Edgewood Cir');
INSERT INTO PERSONS VALUES
	('6b16135a-d7de-4737-bc79-59074f595d8b','Erica Robertson','Erica_Robertson@EricaRobertson.ru','e57efca8-20d8-467f-8fca-77a57db9998a');
INSERT INTO PERSONS VALUES
	('914fed0b-e914-43d7-92df-76e555e7ce5d','Elizabeth Perry','Elizabeth_Perry@ElizabethPerry.ru','e57efca8-20d8-467f-8fca-77a57db9998a');
INSERT INTO PERSONS VALUES
	('35be9549-710d-468d-b5cc-a9331675f6fd','Ralph Gonzales','Ralph_Gonzales@RalphGonzales.ru','e57efca8-20d8-467f-8fca-77a57db9998a');
INSERT INTO PERSONS VALUES
	('fcd2892e-1001-4cca-96c6-cee96fedccc5','Charles Cole','Charles_Cole@CharlesCole.ru','e57efca8-20d8-467f-8fca-77a57db9998a');
INSERT INTO ORGANIZATIONS VALUES
	('cf78f3a4-32ee-4705-9674-b3449e0d9370','Организация f78','Tenth Pkwy');
INSERT INTO PERSONS VALUES
	('c40fd453-d343-42bb-ba61-e48e91a775ee','Bertha Henry','Bertha_Henry@BerthaHenry.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('8a9b421d-dfe7-4bb4-be8d-296448db6db6','Lillian Holmes','Lillian_Holmes@LillianHolmes.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('bca2ad24-a95a-4e1a-9cc6-5110fae9b92f','Ray Wells','Ray_Wells@RayWells.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('bcd1910f-a259-4e28-b423-5a2cfcb61441','Miguel Reed','Miguel_Reed@MiguelReed.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('28377caf-0b23-4ca2-bf35-89c6f4b62e37','Jack James','Jack_James@JackJames.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('15e2e538-46c4-45d8-ba6f-69b7f2f78ce8','Ramon Armstrong','Ramon_Armstrong@RamonArmstrong.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('e6d53f91-800f-4426-ae8a-9e03d67e08e7','Gene King','Gene_King@GeneKing.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('c0db8066-1cb5-4e47-840b-9ec6a103a6a7','Glenn Howard','Glenn_Howard@GlennHoward.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('206a6a12-9070-453a-bee0-9039fa8479b3','Ramon Reed','Ramon_Reed@RamonReed.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('6a307f78-c5c5-4a6d-8ff2-13e45db3e0f8','James Gonzales','James_Gonzales@JamesGonzales.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('74115499-8293-4adf-8f31-fda014aebe79','Keith Boyd','Keith_Boyd@KeithBoyd.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('b0f86da4-ece2-4e60-ae8b-6193233ab8aa','Greg Porter','Greg_Porter@GregPorter.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('ea75a6ac-db7d-4c74-9c27-06475f81c381','George Butler','George_Butler@GeorgeButler.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('9e2ab3df-c0a9-4342-8341-b597962dfd74','Larry Peters','Larry_Peters@LarryPeters.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('ef66351f-7bbe-4e2a-b27c-0a96643957f5','Joseph Hicks','Joseph_Hicks@JosephHicks.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('e102aa05-6b70-4c2e-899f-05693f332c6f','Frederick Harrison','Frederick_Harrison@FrederickHarrison.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('df35ee2d-0355-4f8b-a38b-874914847cb2','Leonard Moore','Leonard_Moore@LeonardMoore.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('a61de909-e241-4fef-9138-f7df70d4d027','Ronn Hill','Ronnie_Hill@RonnieHill.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('9887db6c-c754-40d7-9993-548516e74329','Shawn Hill','Shawn_Hill@ShawnHill.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('dabf815d-f83a-42a3-814c-a1c1e0f3ebbe','Joshua Sanchez','Joshua_Sanchez@JoshuaSanchez.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('7198083a-6167-4642-a2d6-5ae59131a7b2','Miguel Rogers','Miguel_Rogers@MiguelRogers.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('396c8b78-cf2e-4659-acdb-f0f589fe1fdd','Brandon Scott','Brandon_Scott@BrandonScott.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('6d92147e-5eb7-44a0-816c-69bf47f57bb6','Juan Tucker','Juan_Tucker@JuanTucker.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('d1999adb-9449-4cc1-9cb0-72da726474bc','Nathan Cox','Nathan_Cox@NathanCox.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('2d695998-9cee-47bb-a3e9-489b72109bb7','Alexander Wagner','Alexander_Wagner@AlexanderWagner.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('6f5f8615-4279-4a96-bc55-f077af46d164','Fred Sullivan','Fred_Sullivan@FredSullivan.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('26482865-25c1-4324-97ba-9445e0301d2b','Jeffrey Torres','Jeffrey_Torres@JeffreyTorres.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('1b09da8c-ceb7-4818-bf4f-28a503c7468f','Brent Gonzalez','Brent_Gonzalez@BrentGonzalez.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('74fee64e-da8e-4284-ba0a-1f19638022bb','Francis Hawkin','Francis_Hawkins@FrancisHawkins.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('9d04baf5-1a83-4f8c-8160-2f28cea54873','Leroy Adams','Leroy_Adams@LeroyAdams.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO PERSONS VALUES
	('98c6bb5a-0d05-453c-9bcb-049ab8a86860','Daniel Lopez','Daniel_Lopez@DanielLopez.ru','cf78f3a4-32ee-4705-9674-b3449e0d9370');
INSERT INTO ORGANIZATIONS VALUES
	('d1a48cef-5035-4512-8dd3-0455c81344b4','Организация 1a4','Mitchell Way');
INSERT INTO PERSONS VALUES
	('a3a0f85e-29bd-479c-bc2e-57d42ce3aea6','Samantha Sanchez','Samantha_Sanchez@SamanthaSanchez.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('241b393f-c9ef-4f5f-a4dd-be7baf6eb731','Denise West','Denise_West@DeniseWest.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('cd104d2c-55bb-41d1-9bb1-f0baa7edf90d','Jay Foster','Jay_Foster@JayFoster.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('00e3c2fa-1f17-4309-b0da-f2fb33d9345f','Donald Barnes','Donald_Barnes@DonaldBarnes.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('58b05710-c1a2-441d-a329-6a0acdf24fad','Pedro Wallace','Pedro_Wallace@PedroWallace.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('37b59c55-bab7-4053-9a6b-ba1a91abaedc','Ricardo Sims','Ricardo_Sims@RicardoSims.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('11366659-0aae-4950-aac8-b06621c74c9d','Charles Miller','Charles_Miller@CharlesMiller.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('d59f79d8-1e65-41d6-b52e-52cb0dd7e17f','Nicholas Morales','Nicholas_Morales@NicholasMorales.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('ff5db9b9-8d3a-436a-ab50-10496513bd0d','Donald Gardner','Donald_Gardner@DonaldGardner.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('cdf09829-0f91-4659-b51b-8b971562d08c','Adam Long','Adam_Long@AdamLong.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('b1453853-2a1e-4d9c-9ca1-92f790163c47','Ray Russell','Ray_Russell@RayRussell.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('5240c093-250d-47cd-92fd-774bfd0ce26b','Jeffery Foster','Jeffery_Foster@JefferyFoster.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('2e44f4de-1828-4374-bf5b-5e6415e6b196','Alfred Ward','Alfred_Ward@AlfredWard.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('77e3e800-6cbf-4ebf-a4a2-6d5e3bbe7411','Kevin Watkins','Kevin_Watkins@KevinWatkins.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('3f78eaf1-33b9-41c6-b1d0-64a6cb0439dc','Norman Miller','Norman_Miller@NormanMiller.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('db677ed7-4db3-4849-8f67-ebfb0d552e3b','Bradley Roberts','Bradley_Roberts@BradleyRoberts.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('03cc510b-8201-4dc8-b4ab-2f15d02869be','Bradley Myers','Bradley_Myers@BradleyMyers.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('4397451d-ec4d-4b2e-91ca-c81a9ea24d24','Ramon Sullivan','Ramon_Sullivan@RamonSullivan.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('3ec2e6fd-7eb7-429c-bf4d-ac745ba08eb5','Clifford Franklin','Clifford_Franklin@CliffordFranklin.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('01c6ca9c-d651-4b9a-a693-dd61c238210d','Bryan Wells','Bryan_Wells@BryanWells.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('6363f48c-0884-4c29-b4b2-8d682b068db4','Billy Henderson','Billy_Henderson@BillyHenderson.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('4835414f-b557-4ca3-88b4-114c0f576fcd','James Harrison','James_Harrison@JamesHarrison.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO PERSONS VALUES
	('73f6524b-0553-4277-bdb3-dcbfb6ad3765','Marvin Boyd','Marvin_Boyd@MarvinBoyd.ru','d1a48cef-5035-4512-8dd3-0455c81344b4');
INSERT INTO ORGANIZATIONS VALUES
	('23d0ef2f-b20e-4270-9a48-f11d33cf0472','Организация 3d0','Williams St');
INSERT INTO PERSONS VALUES
	('6f7b3099-4684-4fd9-b878-ee00ce0b90da','Marilyn Jones','Marilyn_Jones@MarilynJones.ru','23d0ef2f-b20e-4270-9a48-f11d33cf0472');
INSERT INTO PERSONS VALUES
	('9241c50b-bdcb-4edf-8e0d-e0f881982f5e','Denise Bell','Denise_Bell@DeniseBell.ru','23d0ef2f-b20e-4270-9a48-f11d33cf0472');
INSERT INTO PERSONS VALUES
	('2b607f34-26ed-4927-9543-b2de42560105','Russell Hall','Russell_Hall@RussellHall.ru','23d0ef2f-b20e-4270-9a48-f11d33cf0472');
INSERT INTO PERSONS VALUES
	('d8f2ac3b-e2b4-4240-a0d3-b8dff221bac8','Victor James','Victor_James@VictorJames.ru','23d0ef2f-b20e-4270-9a48-f11d33cf0472');
INSERT INTO PERSONS VALUES
	('2ffc56ae-468b-463c-8d96-142ad5f810b4','Sean Bryant','Sean_Bryant@SeanBryant.ru','23d0ef2f-b20e-4270-9a48-f11d33cf0472');
INSERT INTO PERSONS VALUES
	('5dd803ae-c6fa-4b88-a00c-fc5df811160e','Craig Wood','Craig_Wood@CraigWood.ru','23d0ef2f-b20e-4270-9a48-f11d33cf0472');
INSERT INTO PERSONS VALUES
	('eae999e8-e3ab-4f75-a8cf-a40710b4a6db','Eddie Murray','Eddie_Murray@EddieMurray.ru','23d0ef2f-b20e-4270-9a48-f11d33cf0472');
INSERT INTO PERSONS VALUES
	('7f38b856-3e0f-408a-af82-0041d01a8930','Tim Campbell','Tim_Campbell@TimCampbell.ru','23d0ef2f-b20e-4270-9a48-f11d33cf0472');
INSERT INTO PERSONS VALUES
	('a4b51968-e463-4763-a999-1e5a52874fba','Jesse Perkins','Jesse_Perkins@JessePerkins.ru','23d0ef2f-b20e-4270-9a48-f11d33cf0472');
INSERT INTO PERSONS VALUES
	('29dbca31-18e9-4c48-96c2-808df5dbcff7','Barry Stone','Barry_Stone@BarryStone.ru','23d0ef2f-b20e-4270-9a48-f11d33cf0472');
INSERT INTO PERSONS VALUES
	('8b371469-e8d7-4400-a66d-803cce48498c','Michael Shaw','Michael_Shaw@MichaelShaw.ru','23d0ef2f-b20e-4270-9a48-f11d33cf0472');
INSERT INTO ORGANIZATIONS VALUES
	('86100dd4-e9dd-47f7-9a72-ab7eb9977964','Организация 610','Decatur Cir');
INSERT INTO PERSONS VALUES
	('c5fc0ff6-c3ad-4d18-8ed5-8f7706d39067','Rebecca Sanders','Rebecca_Sanders@RebeccaSanders.ru','86100dd4-e9dd-47f7-9a72-ab7eb9977964');
INSERT INTO PERSONS VALUES
	('d5a057e2-c8ca-4d1f-884f-b359874f4c18','Diane Mcdonald','Diane_Mcdonald@DianeMcdonald.ru','86100dd4-e9dd-47f7-9a72-ab7eb9977964');
INSERT INTO PERSONS VALUES
	('e74fa494-0b5a-4ee3-818b-099435ee692c','Peter Porter','Peter_Porter@PeterPorter.ru','86100dd4-e9dd-47f7-9a72-ab7eb9977964');
INSERT INTO PERSONS VALUES
	('900112de-54db-4c15-b4b9-73814e001188','Gordon Alexander','Gordon_Alexander@GordonAlexander.ru','86100dd4-e9dd-47f7-9a72-ab7eb9977964');
INSERT INTO PERSONS VALUES
	('c4dcba63-9bb4-4a36-ac99-35116cd7966a','Derek Phillips','Derek_Phillips@DerekPhillips.ru','86100dd4-e9dd-47f7-9a72-ab7eb9977964');
INSERT INTO PERSONS VALUES
	('5cb82b38-28cc-41d1-9215-92c5b9fca44d','Glen Sullivan','Glen_Sullivan@GlenSullivan.ru','86100dd4-e9dd-47f7-9a72-ab7eb9977964');
INSERT INTO PERSONS VALUES
	('37835642-2052-4f72-ba0c-6a97ea5c4569','Glenn Ferguson','Glenn_Ferguson@GlennFerguson.ru','86100dd4-e9dd-47f7-9a72-ab7eb9977964');
INSERT INTO PERSONS VALUES
	('560bf484-72cb-4bdf-9f7c-9240e93ff817','Joshua Long','Joshua_Long@JoshuaLong.ru','86100dd4-e9dd-47f7-9a72-ab7eb9977964');
INSERT INTO PERSONS VALUES
	('513dc4d1-43d9-4e83-867f-170731794a3d','Bryan Owens','Bryan_Owens@BryanOwens.ru','86100dd4-e9dd-47f7-9a72-ab7eb9977964');
INSERT INTO PERSONS VALUES
	('34827f3c-bfee-4186-a9f7-848ad5224df3','Todd Hawkins','Todd_Hawkins@ToddHawkins.ru','86100dd4-e9dd-47f7-9a72-ab7eb9977964');
INSERT INTO PERSONS VALUES
	('11523771-a4c3-4661-b49d-2df597602355','Mark Lawrence','Mark_Lawrence@MarkLawrence.ru','86100dd4-e9dd-47f7-9a72-ab7eb9977964');
INSERT INTO ORGANIZATIONS VALUES
	('5b39815f-f714-4af0-b253-18d45cae775c','Организация b39','Third Ln');
INSERT INTO PERSONS VALUES
	('63b882b3-677b-44bc-9b54-f2d9ff65e990','Kathleen Ferguson','Kathleen_Ferguson@KathleenFerguson.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('81ecdeef-5572-4196-b1ed-196146639930','Jamie Bailey','Jamie_Bailey@JamieBailey.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('722e0145-fd8d-4956-82ff-aca7a91f2ee1','Kevin Stevens','Kevin_Stevens@KevinStevens.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('9b704fd9-7a9b-47e8-8f3d-53be5425c261','Brandon Pierce','Brandon_Pierce@BrandonPierce.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('1f59173d-4e7f-4943-92bf-1c9f582c9681','Albert Barnes','Albert_Barnes@AlbertBarnes.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('cd121432-9a83-484a-b015-e077dea28bd5','Jim Nichols','Jim_Nichols@JimNichols.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('46603663-f126-45f3-8867-e7121a7341a0','Henry Olson','Henry_Olson@HenryOlson.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('990065da-891c-40e6-a3ea-31aea3898204','Gregory Brooks','Gregory_Brooks@GregoryBrooks.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('e8cb941e-cdcd-4985-959e-d85baf2a2b91','Calvin Torres','Calvin_Torres@CalvinTorres.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('84abbe3f-c8e3-4687-af74-2bf6de14dd3b','Micheal Fisher','Micheal_Fisher@MichealFisher.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('cea6f48b-172a-44d7-96a1-490531edd5c1','Ryan Jordan','Ryan_Jordan@RyanJordan.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('2bb224b8-fd6c-436d-9c93-3e2989ee0e49','Andrew Daniels','Andrew_Daniels@AndrewDaniels.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('7b7b4d4b-18df-4fd8-ae2d-abd6472af41c','Charles Dixon','Charles_Dixon@CharlesDixon.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('e73001ce-21fa-492e-8492-e4934ef030ff','Jerry Powell','Jerry_Powell@JerryPowell.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('ed22ffd2-24b9-45cf-9bf8-438297a4f45e','Ricardo Carroll','Ricardo_Carroll@RicardoCarroll.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('cad828f0-785f-4bf6-aef0-27b73b0b4324','Anthony Willis','Anthony_Willis@AnthonyWillis.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('4a10f5d3-417a-4f32-b19a-7db13447a509','Francis Matthews','Francis_Matthews@FrancisMatthews.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('c83566e1-9fc5-481d-a60b-027060ae7524','Jack Griffin','Jack_Griffin@JackGriffin.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('4692044b-4612-4874-914e-581b14fcf3dc','Marvin Jackson','Marvin_Jackson@MarvinJackson.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('41e847ce-14e1-4f73-b430-0b8434b27e81','Jon Evans','Jon_Evans@JonEvans.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('3895de24-f229-49a4-9f70-d552c152ee09','Barry Howard','Barry_Howard@BarryHoward.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('71b4088a-e5f1-432e-ad84-d5cd46d3c2e7','Timothy Marshall','Timothy_Marshall@TimothyMarshall.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('d5a3c3bb-2881-4071-966e-6040e643e53e','Phillip Carroll','Phillip_Carroll@PhillipCarroll.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('cc5a8a1c-ba63-4f35-ae16-ee89ac6c264c','Roy Turner','Roy_Turner@RoyTurner.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('845ce886-ca9e-4d32-893f-a1f1a4cc6d1a','Luis Cook','Luis_Cook@LuisCook.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('be91a02a-eeaa-481a-aa30-db7dc154385b','Ricky Lawson','Ricky_Lawson@RickyLawson.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('f04d44f5-1ef0-459b-90c4-f9cba1b3f776','Marcus Spencer','Marcus_Spencer@MarcusSpencer.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('76e578d6-cab4-45e5-94fe-5f4d355937e0','Chad Stone','Chad_Stone@ChadStone.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('86ecfa66-2cd2-42c6-a72b-0675897e88d0','Barry Payne','Barry_Payne@BarryPayne.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('4e875745-a2d5-47de-8bbe-5a748eed0453','Melvin Shaw','Melvin_Shaw@MelvinShaw.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('8bebc009-4fca-418d-bc5b-cc19a0532fa8','Russell Gordon','Russell_Gordon@RussellGordon.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('d2c4589d-75dd-4212-bcf5-c9d2c001d453','Scott Wallace','Scott_Wallace@ScottWallace.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('f0f2492f-4dae-4d08-bb3d-343ca309cab8','Steve Watkins','Steve_Watkins@SteveWatkins.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('c4763787-2fa5-45c1-b616-1facc4a8d138','Brian Rice','Brian_Rice@BrianRice.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('0d3c20e5-bec0-4e0c-9753-51bc9e34795d','Scott Palmer','Scott_Palmer@ScottPalmer.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('2b3760df-c8ec-4fdb-b60f-37948c18e8f5','Alex Duncan','Alex_Duncan@AlexDuncan.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('ed97c5d6-3202-42cb-94b7-06760fc9398b','Mario Henry','Mario_Henry@MarioHenry.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO PERSONS VALUES
	('b30b3705-4312-4557-8f6b-cf34df1ff850','Stanley Daniels','Stanley_Daniels@StanleyDaniels.ru','5b39815f-f714-4af0-b253-18d45cae775c');
INSERT INTO ORGANIZATIONS VALUES
	('1fb824fe-b97a-427e-9989-f8912ed60589','Организация fb8','Olympic Cir');
INSERT INTO PERSONS VALUES
	('017776c4-6442-4a47-ad70-0de097afc6f2','Beatrice Armstrong','Beatrice_Armstrong@BeatriceArmstrong.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('2394679a-b69f-4f78-a1d3-e92bc8805cff','Laura Fisher','Laura_Fisher@LauraFisher.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('28917708-10e8-49c4-9209-05f6bf6c9ae4','Ronald Powell','Ronald_Powell@RonaldPowell.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('2900468d-a766-452d-8d52-2dd6489625d9','Christopher Rose','Christopher_Rose@ChristopherRose.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('c015cfc1-f917-4b58-9213-745f86f87e9e','Richard Thomas','Richard_Thomas@RichardThomas.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('2de08d89-2f50-4649-bcb2-12f10358b082','Todd Simmons','Todd_Simmons@ToddSimmons.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('65b628b9-176e-4ac8-8fde-3b971a6009ac','Melvin Reyes','Melvin_Reyes@MelvinReyes.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('af5b3f45-aa4e-49d6-b6d0-de43cbcd52f7','Billy Webb','Billy_Webb@BillyWebb.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('3933fd62-2490-442e-8454-eea71b5068f8','Darrell Gonzalez','Darrell_Gonzalez@DarrellGonzalez.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('bedcaad7-e74d-42fc-af29-4daaf88751e5','Tom Warren','Tom_Warren@TomWarren.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('8a615acd-1fac-4915-8065-369862677330','Hector Fox','Hector_Fox@HectorFox.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('773f2b1c-b586-4ae1-85b9-8dea12ba484d','Juan Perkins','Juan_Perkins@JuanPerkins.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('89ea5861-9b24-4fe4-9332-7a62f11b8099','Jeff Green','Jeff_Green@JeffGreen.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('486876d0-d0df-4c82-887c-f2c00caaa6f9','Jerry Perkins','Jerry_Perkins@JerryPerkins.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('0b4457c2-fd13-40a5-a1a1-0d6ea4ab61d5','Fred Jackson','Fred_Jackson@FredJackson.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('36ec285e-7676-4bb4-ab12-f431ed5e7c90','Alexander Burns','Alexander_Burns@AlexanderBurns.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('03e8eb74-f607-431a-b39d-26ca1f16a4e4','Larry Rodriguez','Larry_Rodriguez@LarryRodriguez.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('11e002ea-c0e9-4cd5-a257-f32d41354427','Tom Morrison','Tom_Morris@TomMorris.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('2e6ea733-ebb3-4ba9-9616-9cc4149806c5','Jonathan Dixon','Jonathan_Dixon@JonathanDixon.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('99f0b8c8-a798-4fff-9951-adae81f9c733','Norman Myers','Norman_Myers@NormanMyers.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('2d1a5f95-cef3-4b7e-9274-014cbcc58459','Theodore Phillips','Theodore_Phillips@TheodorePhillips.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('87573d2b-5224-44ca-af80-5f8fed632004','Kevin Murray','Kevin_Murray@KevinMurray.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('af1d9e00-70e3-49d2-b175-1e76950ec2cd','Jack Brooks','Jack_Brooks@JackBrooks.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('8499434d-cba6-4fd5-a499-21147e107d56','Randall Fisher','Randall_Fisher@RandallFisher.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('8b346630-7bfc-4b0a-b4c5-f0568d51f471','Peter Arnold','Peter_Arnold@PeterArnold.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('db5c9a33-6077-4488-9c19-0b2d252da58a','Michael Carter','Michael_Carter@MichaelCarter.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('f7bf6d6b-a5b5-41a3-9bb2-83e7b466a5ed','Chris Gonzalez','Chris_Gonzalez@ChrisGonzalez.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO PERSONS VALUES
	('f98673c5-ced0-4c1e-a44e-5a66a860944f','Philip Carroll','Philip_Carroll@PhilipCarroll.ru','1fb824fe-b97a-427e-9989-f8912ed60589');
INSERT INTO ORGANIZATIONS VALUES
	('0b85f292-8efa-41a3-9bd6-4e0b19651f93','Организация b85','Spring Cir');
INSERT INTO PERSONS VALUES
	('1c08bb18-461e-41e6-839e-eb1871915eb9','Rachel Flores','Rachel_Flores@RachelFlores.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('af43e09d-d391-4093-a831-e52e7b138d9b','Jennifer Nichols','Jennifer_Nichols@JenniferNichols.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('a75b1ea8-3d78-43cd-a2a1-bd9aeaabcbef','Antonio Reynolds','Antonio_Reynolds@AntonioReynolds.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('ea6daceb-d862-46b3-a305-7b0968cf0079','Harry Jackson','Harry_Jackson@HarryJackson.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('aaee896e-49c8-4b71-8606-53ef114553a8','Michael Willis','Michael_Willis@MichaelWillis.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('335b5f93-47a8-4e77-af7e-84c3d0ff776b','Gilbert Rose','Gilbert_Rose@GilbertRose.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('2e4d4fb5-d393-4f31-b89b-294e9053faa2','Vincent Wagner','Vincent_Wagner@VincentWagner.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('a24ce565-61b7-4475-b610-00d90367c4db','Jay Hall','Jay_Hall@JayHall.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('cb274406-c705-4ac6-9676-c7c5cbbf1f00','Benjamin Myers','Benjamin_Myers@BenjaminMyers.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('eb8290e8-e0e5-4526-84ca-c96cafc425cc','Francisco Long','Francisco_Long@FranciscoLong.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('eb9db8d6-850d-4778-ac5c-b23f7d964980','Joel Hayes','Joel_Hayes@JoelHayes.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('aa5f63b7-b7ab-4da5-ab22-47534c57fae3','Eric Austin','Eric_Austin@EricAustin.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('52187a4c-af6a-4692-b9df-f589d4b0eff5','Jay Owens','Jay_Owens@JayOwens.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('73c23e41-02f9-4aaa-a53f-f56834e49bf5','Matthew Henry','Matthew_Henry@MatthewHenry.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO PERSONS VALUES
	('a76010cb-658b-49b0-ae41-24d81792404c','Willie Ford','Willie_Ford@WillieFord.ru','0b85f292-8efa-41a3-9bd6-4e0b19651f93');
INSERT INTO ORGANIZATIONS VALUES
	('3b05cf8e-5a46-40c8-bd16-32dcc5c097b4','Организация b05','Main Ave');
INSERT INTO PERSONS VALUES
	('1bc83c37-2793-4b48-82d9-10d0d3deb2b6','Gladys Henry','Gladys_Henry@GladysHenry.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('4954a13a-713c-41a5-833c-666002a19266','Emily Knight','Emily_Knight@EmilyKnight.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('6e719dff-8912-4532-be59-49dc527b69f7','Andrew Cox','Andrew_Cox@AndrewCox.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('c8e7d2f8-91be-4789-8c32-a66887aadfa8','Harold Lawrence','Harold_Lawrence@HaroldLawrence.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('2c5f66b7-23ee-4eb9-a2f3-38bbc3e61db8','Jesus Hudson','Jesus_Hudson@JesusHudson.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('d729c079-648f-4da5-87d1-015cdbef12a8','Jack Payne','Jack_Payne@JackPayne.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('9ba45d62-7f5e-450a-bf09-f4b0d1de903e','Ronnie Lawson','Ronnie_Lawson@RonnieLawson.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('203aee6c-4aaa-4c06-bb7d-e61b85662dec','Russell Crawford','Russell_Crawford@RussellCrawford.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('55351a82-5cdf-4d32-bc04-343ebb50ae69','Lee Morgan','Lee_Morgan@LeeMorgan.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('7b0cfd13-f608-43cd-ba43-eccb83a6ad19','Jonathan Coleman','Jonathan_Coleman@JonathanColeman.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('f4fb57d1-ed50-49c2-8b06-866aefd82d15','Chris Martin','Chris_Martin@ChrisMartin.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('92408de1-a96e-4b6e-ae6c-3a9d1d06cd77','Thomas Hunt','Thomas_Hunt@ThomasHunt.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('17b3df88-11e3-4fa3-af08-95f40c96772c','Jesus Olson','Jesus_Olson@JesusOlson.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('02908757-7498-4894-b034-aa84b2892ea2','Jonathan Hunter','Jonathan_Hunter@JonathanHunter.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('b92aa389-186b-4aa5-85cb-cb2ea48eff4a','Herbert Marshall','Herbert_Marshall@HerbertMarshall.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('22ecf514-4f5f-41b8-8f28-becdc56b7399','Harold Simpson','Harold_Simpson@HaroldSimpson.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('0b125633-9c51-42a0-b98c-7efb1a1a5f2f','Sam Allen','Sam_Allen@SamAllen.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('9b385b53-ee7d-48ec-855b-370e50c41a5a','Ralph Carpenter','Ralph_Carpenter@RalphCarpenter.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('25715784-cb6b-4831-92a9-48cabaf231ec','Leo Freeman','Leo_Freeman@LeoFreeman.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('eea558c3-5f6e-4769-9ea5-b3b2112a1be2','Vincent Willis','Vincent_Willis@VincentWillis.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('a060f573-5178-44f3-88eb-ebd6aeadb380','Jose Graham','Jose_Graham@JoseGraham.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('f31bf40c-92e6-4547-9901-cfb5b076b03b','Brandon Hawkins','Brandon_Hawkins@BrandonHawkins.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('dbf46625-6b74-45fa-9f8c-d9a6b80954a3','Albert Walker','Albert_Walker@AlbertWalker.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('f61741d0-5249-4ce7-8db1-3202a66f2be4','Vernon Jordan','Vernon_Jordan@VernonJordan.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('76946301-79a8-4490-9123-390c234ad513','Steven Moore','Steven_Moore@StevenMoore.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('75ef3dd1-c805-4980-a77c-0ed4e047d604','Jack Peterson','Jack_Peterson@JackPeterson.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('6345e8b0-8d67-4b6a-9334-fa5d0a98b98a','Melvin Clark','Melvin_Clark@MelvinClark.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
INSERT INTO PERSONS VALUES
	('f91b6167-5c7e-47e7-877f-16c3f27ac456','Henry Nichols','Henry_Nichols@HenryNichols.ru','3b05cf8e-5a46-40c8-bd16-32dcc5c097b4');
