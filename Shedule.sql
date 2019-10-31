CREATE DATABASE SHEDULE;

CREATE TABLE SPECIALITY(N_SPECIALITY INT PRIMARY KEY, NAME_OF_SPECIALITY CHAR(10), FACULTY CHAR(10));
CREATE TABLE STUDY_GROUP(N_GROUP INT PRIMARY KEY, N_SPECIALITY INT);
CREATE TABLE SUBJECTS(NAME_OF_SUBJECT CHAR(20) PRIMARY KEY);
CREATE TABLE SPECIALITY_SUBJECTS(N_SPECIALITY INT, NAME_OF_SUBJECT CHAR(20), NUMBER_OF_HOURS INT, PRIMARY KEY(N_SPECIALITY, NAME_OF_SUBJECT));
CREATE TABLE TEACHER(SURNAME CHAR(20), NAME CHAR(20), DEGREE CHAR(20), DEPARTAMENT CHAR(20), PRIMARY KEY(SURNAME, NAME));
CREATE TABLE SHEDULE(N_GROUP INT, DAY CHAR(10), NAME_OF_SUBJECT CHAR(10), N_PARA INT, TEACHER_SURNAME CHAR(20), TEACHER_NAME CHAR(20), N_BUILDING INT, N_AUDIENCE INT, PRIMARY KEY(N_GROUP, DAY, N_PARA));
CREATE TABLE TIME_OF_PARA(N_PARA INT PRIMARY KEY, TIME_OF_PARA_BEGINING CHAR(10), TIME_OF_PARA_END CHAR(10));
CREATE TABLE AUDIENCE(N_BUILDING INT, N_AUDIENCE INT, PRIMARY KEY(N_BUILDING, N_AUDIENCE));

DROP TABLE SPECIALITY;
DROP TABLE STUDY_GROUP;
DROP TABLE SUBJECTS;
DROP TABLE SPECIALITY_SUBJECTS;
DROP TABLE TEACHER;
DROP TABLE SHEDULE;
DROP TABLE TIME_OF_PARA;
DROP TABLE AUDIENCE;

SELECT * FROM SPECIALITY;
SELECT * FROM STUDY_GROUP;
SELECT * FROM SUBJECTS;
SELECT * FROM SPECIALITY_SUBJECTS;
SELECT * FROM TEACHER;
SELECT * FROM SHEDULE;
SELECT * FROM TIME_OF_PARA;
SELECT * FROM AUDIENCE;

ALTER TABLE STUDY_GROUP ADD CONSTRAINT FK_STGR_SPEC FOREIGN KEY (N_SPECIALITY) REFERENCES SPECIALITY(N_SPECIALITY);
ALTER TABLE SPECIALITY_SUBJECTS ADD CONSTRAINT FK_SPSUB_SPEC FOREIGN KEY (N_SPECIALITY) REFERENCES SPECIALITY(N_SPECIALITY);
ALTER TABLE SPECIALITY_SUBJECTS ADD CONSTRAINT FK_SPSUB_SUB FOREIGN KEY (NAME_OF_SUBJECT) REFERENCES SUBJECTS(NAME_OF_SUBJECT);
ALTER TABLE SHEDULE ADD CONSTRAINT FK_SHED_STGR FOREIGN KEY (N_GROUP) REFERENCES STUDY_GROUP(N_GROUP);
ALTER TABLE SHEDULE ADD CONSTRAINT FK_SHED_TEACH FOREIGN KEY (TEACHER_SURNAME, TEACHER_NAME) REFERENCES TEACHER(SURNAME, NAME);
ALTER TABLE SHEDULE ADD CONSTRAINT FK_SHED_TOP FOREIGN KEY (N_PARA) REFERENCES TIME_OF_PARA(N_PARA);
ALTER TABLE SHEDULE ADD CONSTRAINT FK_SHED_AUD FOREIGN KEY (N_BUILDING, N_AUDIENCE) REFERENCES AUDIENCE(N_BUILDING, N_AUDIENCE);

ALTER TABLE STUDY_GROUP DROP FK_STGR_SPEC;
ALTER TABLE SPECIALITY_SUBJECTS DROP FK_SPSUB_SPEC;
ALTER TABLE SPECIALITY_SUBJECTS DROP FK_SPSUB_SUB;
ALTER TABLE SHEDULE DROP FK_SHED_STGR;
ALTER TABLE SHEDULE DROP FK_SHED_TEACH;
ALTER TABLE SHEDULE DROP FK_SHED_TOP;
ALTER TABLE SHEDULE DROP FK_SHED_AUD;

INSERT INTO SPECIALITY
VALUES(211, 'ISIT(BM)', 'FKP');

DELETE FROM SPECIALITY;

INSERT INTO SUBJECTS
VALUES('MATH'),
('OAiP'),
('PHILOSOPHY');

DELETE FROM SUBJECTS;

INSERT INTO SPECIALITY_SUBJECTS
VALUES(211, 'MATH', 300),
(211, 'OAiP', 130),
(211, 'PHILOSOPHY', 75);

DELETE FROM SPECIALITY_SUBJECTS;

INSERT INTO STUDY_GROUP
VALUES(714301, 211),
(714302, 211),
(714303, 211);

DELETE FROM STUDY_GROUP;

INSERT INTO TEACHER
VALUES('PERSON1', 'PERSON1', 'DEGREE1', 'DEPARTMENT1'),
('PERSON2', 'PERSON2', 'DEGREE1', 'DEPARTMENT2'),
('PERSON3', 'PERSON3', 'DEGREE1', 'DEPARTMENT1'),
('PERSON4', 'PERSON4', 'DEGREE2', 'DEPARTMENT3');

DELETE FROM TEACHER;

INSERT INTO SHEDULE
VALUES(714303, 'MONDAY', 'MATH', 1, 'PERSON1','PERSON1', 1, 411),
(714303, 'MONDAY', 'OAiP', 2, 'PERSON2', 'PERSON2', 1, 411),
(714303, 'TUESDAY', 'OAiP', 1, 'PERSON2', 'PERSON2', 3, 209),
(714302, 'MONDAY', 'MATH', 1, 'PERSON3', 'PERSON3', 1, 409),
(714301, 'MONDAY', 'OAiP', 3, 'PERSON2', 'PERSON2', 5, 316),
(714303, 'MONDAY', 'PHILOSOPHY', 3, 'PERSON4', 'PERSON4', 2, 517),
(714302, 'MONDAY', 'PHILOSOPHY', 2, 'PERSON4', 'PERSON4', 2, 517),
(714301, 'MONDAY', 'PHILOSOPHY', 1, 'PERSON4', 'PERSON4', 2, 517);

DELETE FROM SHEDULE;

INSERT INTO AUDIENCE
VALUES (1, 411),
(1, 409),
(2, 517),
(3, 209),
(5, 316);

INSERT INTO TIME_OF_PARA
VALUES(1, '8:00', '9:35'),
(2, '9:45', '11:20'),
(3, '11:40', '13:15'),
(4, '13:25', '15:00');

DELETE FROM TIME_OF_PARA;

//РАСПИСАНИЕ НА ДЕНЬ ДЛЯ ГРУППЫ

SELECT S.DAY, S.NAME_OF_SUBJECT, S.N_AUDIENCE, S.N_BUILDING, S.TEACHER_SURNAME, S.TEACHER_NAME, T.TIME_OF_PARA_BEGINING, T.TIME_OF_PARA_END
FROM SHEDULE S INNER JOIN TIME_OF_PARA T ON S.N_PARA=T.N_PARA
WHERE S.N_GROUP=714303
ORDER BY S.DAY;

//СПИСОК ДИСЦИПЛИН НА ВЕСЬ КУРС ДЛЯ СПЕЦИАЛЬНОСТИ

SELECT DISTINCT SPSUB.NAME_OF_SUBJECT, SPSUB.NUMBER_OF_HOURS
FROM SPECIALITY_SUBJECTS SPSUB INNER JOIN SPECIALITY SP ON SPSUB.N_SPECIALITY=SP.N_SPECIALITY
WHERE SP.NAME_OF_SPECIALITY='ISIT(BM)'